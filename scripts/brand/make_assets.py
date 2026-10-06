#!/usr/bin/env python3
"""Generate the native brand assets of both apps from Brandbook v2.

There is no SVG rasteriser on the build machines, and the monogram happens to
be a single closed polygon of straight segments — so it is drawn here directly:
a scanline fill with 4x supersampling for the diagonal roof edges, written out
as a PNG with `zlib` and `struct`. No dependencies, no install step.

It produces, for `mboa_user` and `mboa_pro`:

  * the Android adaptive-icon foregrounds (the white M on transparent);
  * the launch screens — Vert Forêt with the monogram as a watermark, iOS and
    Android, light and dark.

The centred logotype on the launch screen is *not* drawn here: the brand ships
it as a PNG (`png/mboa-logotype-blanc-2400.png`) and its bowls are arcs, which
this rasteriser does not do. It is downscaled with `sips` instead.

Run it again after any change to the monogram; the path below is copied
verbatim from `mboa-monogramme-*.svg`.

    python3 scripts/brand/make_assets.py [path/to/logo-v2]
"""
import os
import struct
import subprocess
import sys
import zlib

# The path of mboa-monogramme-*.svg, viewBox "0 -2 104 102".
PATH = [(0, 100), (0, 28), (33, -2), (52, 60), (71, -2), (104, 28), (104, 100),
        (84, 100), (84, 20.42), (59.61, 100), (44.39, 100), (20, 20.42), (20, 100)]
VB = (0, -2, 104, 102)

FOREST = (26, 92, 69)        # #1A5C45 — Vert Forêt
FOREST_DARK = (15, 56, 41)   # #0F3829 — the dark-mode ground
CORAL = (232, 115, 90)       # #E8735A — Corail Chaud
INK = (26, 26, 26)           # #1A1A1A — Quasi-Noir

# One ground per environment, all three from the palette.
#
# Not a "DEV" ribbon like some apps use: at 60pt the band's text is about
# eight pixels tall and unreadable, and rendering type would mean carrying a
# font rasteriser for six letters. The ground is legible at every size, and
# the word itself lives in the app's name, where it is always readable.
FLAVOR_GROUNDS = {
    'production': FOREST,
    'staging': CORAL,
    'dev': INK,
}

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
APPS = ('mboa_user', 'mboa_pro')


def _fill(width, height, scale, off_x, off_y, ss):
    """Coverage mask of the monogram, supersampled `ss` times per axis."""
    vb_x, vb_y, _, _ = VB
    pts = [(x * scale + off_x, y * scale + off_y) for x, y in PATH]
    rows = []
    for py in range(height * ss):
        yc = py + 0.5
        xs = []
        for i in range(len(pts)):
            x1, y1 = pts[i]
            x2, y2 = pts[(i + 1) % len(pts)]
            if (y1 <= yc < y2) or (y2 <= yc < y1):
                xs.append(x1 + (yc - y1) * (x2 - x1) / (y2 - y1))
        xs.sort()
        row = bytearray(width * ss)
        for a, b in zip(xs[0::2], xs[1::2]):
            for px in range(max(0, int(a)), min(width * ss, int(b) + 2)):
                if a <= px + 0.5 < b:
                    row[px] = 1
        rows.append(row)
    return rows


def monogram(width, height, *, glyph, rgb, alpha=255, ground=None,
             centre=(0.5, 0.5), ss=4):
    """RGBA bytes: the monogram over `ground`, or transparent when ground is None.

    `glyph` is the fraction of the shorter side the mark covers; `centre` is
    where its middle sits, in fractions of the canvas.
    """
    vb_x, vb_y, vb_w, vb_h = VB
    scale = (min(width, height) * glyph) / max(vb_w, vb_h)
    off_x = width * centre[0] - (vb_w * scale) / 2 - vb_x * scale
    off_y = height * centre[1] - (vb_h * scale) / 2 - vb_y * scale
    mask = _fill(width, height, scale * ss, off_x * ss, off_y * ss, ss)

    out = bytearray()
    for y in range(height):
        out += b'\x00'
        for x in range(width):
            hits = sum(mask[y * ss + dy][x * ss + dx]
                       for dy in range(ss) for dx in range(ss))
            cov = hits / (ss * ss)
            a = cov * (alpha / 255)
            if ground is None:
                out += bytes((*rgb, round(255 * a)))
            else:
                out += bytes(tuple(round(g + (c - g) * a)
                                   for g, c in zip(ground, rgb)) + (255,))
    return bytes(out)


def _stamp(px, rotate=0.0, ss=3):
    """Alpha mask (rows of floats 0..1) of one monogram filling `px` square.

    Rendered once per size and angle, then blitted — scanline filling fifty
    marks straight into a 1200x2400 canvas at supersample would be tens of
    millions of cells per mark.
    """
    import math
    vb_x, vb_y, vb_w, vb_h = VB
    n = px * ss
    scale = n / max(vb_w, vb_h)
    cx, cy = n / 2, n / 2
    cos_a, sin_a = math.cos(rotate), math.sin(rotate)
    pts = []
    for x, y in PATH:
        dx = (x - vb_x) * scale - vb_w * scale / 2
        dy = (y - vb_y) * scale - vb_h * scale / 2
        pts.append((cx + dx * cos_a - dy * sin_a, cy + dx * sin_a + dy * cos_a))

    rows = []
    for py in range(n):
        yc = py + 0.5
        xs = []
        for i in range(len(pts)):
            x1, y1 = pts[i]
            x2, y2 = pts[(i + 1) % len(pts)]
            if (y1 <= yc < y2) or (y2 <= yc < y1):
                xs.append(x1 + (yc - y1) * (x2 - x1) / (y2 - y1))
        xs.sort()
        row = bytearray(n)
        for a, b in zip(xs[0::2], xs[1::2]):
            for sx in range(max(0, int(a)), min(n, int(b) + 2)):
                if a <= sx + 0.5 < b:
                    row[sx] = 1
        rows.append(row)

    out = []
    for y in range(px):
        out.append([sum(rows[y * ss + dy][x * ss + dx]
                        for dy in range(ss) for dx in range(ss)) / (ss * ss)
                    for x in range(px)])
    return out


def pattern(width, height, ground, *, rgb=(255, 255, 255), seed=7):
    """RGBA bytes: `ground`, strewn with small monograms.

    A field of small marks rather than one large one. A single big M reads as
    a cropped logo — a second logo competing with the one in the middle — while
    a scatter reads as what it is: a texture the brand is made of.

    Deterministic: the same seed gives the same wallpaper on every machine, so
    regenerating does not churn the assets.
    """
    import math
    import random

    rnd = random.Random(seed)
    buf = [[list(ground) for _ in range(width)] for _ in range(height)]

    stamps = {}
    step = width // 4
    for row in range(-1, height // step + 2):
        for col in range(-1, 5):
            px = rnd.choice((28, 38, 48, 60))
            angle = rnd.choice((-0.18, 0.0, 0.18))
            alpha = rnd.uniform(0.05, 0.11)
            key = (px, angle)
            if key not in stamps:
                stamps[key] = _stamp(px, angle)
            mask = stamps[key]

            # A jittered grid: regular enough to feel woven, irregular enough
            # not to read as a checkerboard.
            ox = int(col * step + rnd.uniform(-0.3, 0.3) * step)
            oy = int(row * step + rnd.uniform(-0.3, 0.3) * step)
            for y in range(px):
                ty = oy + y
                if not 0 <= ty < height:
                    continue
                for x in range(px):
                    tx = ox + x
                    if not 0 <= tx < width:
                        continue
                    a = mask[y][x] * alpha
                    if a <= 0:
                        continue
                    px_out = buf[ty][tx]
                    for i in range(3):
                        px_out[i] = round(px_out[i] + (rgb[i] - px_out[i]) * a)

    out = bytearray()
    for y in range(height):
        out += b'\x00'
        for x in range(width):
            out += bytes((*buf[y][x], 255))
    return bytes(out)


def png(width, height, raw):
    def chunk(tag, data):
        body = tag + data
        return struct.pack('>I', len(data)) + body + struct.pack('>I', zlib.crc32(body))

    return (b'\x89PNG\r\n\x1a\n'
            + chunk(b'IHDR', struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0))
            + chunk(b'IDAT', zlib.compress(raw, 9))
            + chunk(b'IEND', b''))


def write(path, width, height, raw):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'wb') as f:
        f.write(png(width, height, raw))


def app_icons():
    """The square app icon, one per environment, for both stores."""
    import json
    for app in APPS:
        ios_root = f'{ROOT}/apps/{app}/ios/Runner/Assets.xcassets'
        meta = json.load(open(f'{ios_root}/AppIcon.appiconset/Contents.json'))
        wanted = {}
        for image in meta['images']:
            name = image.get('filename')
            if not name:
                continue
            side = float(image['size'].split('x')[0]) * int(image['scale'].rstrip('x'))
            wanted[name] = max(wanted.get(name, 0), round(side))

        for flavor, ground in FLAVOR_GROUNDS.items():
            suffix = '' if flavor == 'production' else flavor.capitalize()
            out_set = f'{ios_root}/AppIcon{suffix}.appiconset'
            os.makedirs(out_set, exist_ok=True)
            with open(f'{out_set}/Contents.json', 'w') as f:
                json.dump(meta, f, indent=2)
            for name, px in sorted(wanted.items()):
                # 0.45: the monogram's own proportion inside the brand's
                # 1024 master, kept so every size matches the supplied icon.
                write(f'{out_set}/{name}', px, px,
                      monogram(px, px, glyph=0.45, rgb=(255, 255, 255), ground=ground))

            res = f'{ROOT}/apps/{app}/android/app/src'
            where = 'main' if flavor == 'production' else flavor
            for dens, px in (('mdpi', 48), ('hdpi', 72), ('xhdpi', 96),
                             ('xxhdpi', 144), ('xxxhdpi', 192)):
                write(f'{res}/{where}/res/mipmap-{dens}/ic_launcher.png', px, px,
                      monogram(px, px, glyph=0.45, rgb=(255, 255, 255), ground=ground))


def adaptive_foregrounds():
    """The Android adaptive icon's foreground: white M, inside the safe zone."""
    for app in APPS:
        for dens, px in (('mdpi', 108), ('hdpi', 162), ('xhdpi', 216),
                         ('xxhdpi', 324), ('xxxhdpi', 432)):
            out = f'{ROOT}/apps/{app}/android/app/src/main/res/mipmap-{dens}/ic_launcher_foreground.png'
            # 0.52: a mask may crop 33% of the canvas, so the mark stays well
            # inside the 66% safe zone with room for the gables.
            write(out, px, px, monogram(px, px, glyph=0.52, rgb=(255, 255, 255)))


def launch_backgrounds():
    """Vert Forêt strewn with small monograms — the brand's own wallpaper.

    Written both into the native launch screens and into `mboa_ui`, so the
    OS-level splash and the Flutter one that replaces it are the same picture
    and the hand-off is invisible.
    """
    light = pattern(600, 1200, FOREST)
    dark = pattern(600, 1200, FOREST_DARK)

    shared = f'{ROOT}/packages/mboa_ui/assets/images/illustrations/brand_pattern.png'
    write(shared, 600, 1200, light)

    for app in APPS:
        res = f'{ROOT}/apps/{app}/android/app/src/main/res'
        ios = f'{ROOT}/apps/{app}/ios/Runner/Assets.xcassets/LaunchBackground.imageset'
        splash = f'{ROOT}/apps/{app}/assets/splash'
        for raw, names in (
            (light, [f'{res}/drawable/background.png',
                     f'{res}/drawable-v21/background.png',
                     f'{ios}/background.png',
                     f'{splash}/splash_background.png']),
            (dark, [f'{res}/drawable-night/background.png',
                    f'{res}/drawable-night-v21/background.png',
                    f'{ios}/darkbackground.png',
                    f'{splash}/splash_background_dark.png']),
        ):
            for name in names:
                write(name, 600, 1200, raw)


def launch_logos(src_dir):
    """The white logotype, centred. Downscaled from the brand's own PNG."""
    src = f'{src_dir}/png/mboa-logotype-blanc-2400.png'
    if not os.path.exists(src):
        print(f'! missing {src} — skipping the centred logotype', file=sys.stderr)
        return
    for app in APPS:
        res = f'{ROOT}/apps/{app}/android/app/src/main/res'
        ios = f'{ROOT}/apps/{app}/ios/Runner/Assets.xcassets/LaunchImage.imageset'
        # 160pt wide, which clears the 80px brandbook minimum several times over.
        for path, px in (
            # The source flutter_native_splash regenerates everything from.
            (f'{ROOT}/apps/{app}/assets/splash/splash_logo.png', 640),
            (f'{res}/drawable-mdpi/splash.png', 160),
            (f'{res}/drawable-hdpi/splash.png', 240),
            (f'{res}/drawable-xhdpi/splash.png', 320),
            (f'{res}/drawable-xxhdpi/splash.png', 480),
            (f'{res}/drawable-xxxhdpi/splash.png', 640),
            (f'{ios}/LaunchImage.png', 160),
            (f'{ios}/LaunchImage@2x.png', 320),
            (f'{ios}/LaunchImage@3x.png', 480),
        ):
            os.makedirs(os.path.dirname(path), exist_ok=True)
            subprocess.run(['sips', '--resampleWidth', str(px), src, '--out', path],
                           check=True, capture_output=True)
            # Dark mode keeps the same white logotype; only the ground changes.
            for dark in (path.replace('/drawable-', '/drawable-night-'),
                         path.replace('LaunchImage', 'LaunchImageDark')):
                if dark != path and os.path.isdir(os.path.dirname(dark)):
                    subprocess.run(['cp', path, dark], check=True)


if __name__ == '__main__':
    logo_dir = sys.argv[1] if len(sys.argv) > 1 else os.path.expanduser(
        '~/Documents/Claude/Projects/MyHome/assets 2/logo-v2')
    app_icons()
    adaptive_foregrounds()
    launch_backgrounds()
    launch_logos(logo_dir)
    print('brand assets written for', ', '.join(APPS))
