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
    """Vert Forêt, with the monogram set large and low as a watermark.

    The watermark is 10% white rather than the 40% a flat background would
    take: it sits under a white logotype, and at 40% the two marks compete —
    the eye reads two logos instead of one on a textured ground.
    """
    for app in APPS:
        res = f'{ROOT}/apps/{app}/android/app/src/main/res'
        ios = f'{ROOT}/apps/{app}/ios/Runner/Assets.xcassets/LaunchBackground.imageset'
        for ground, names in ((FOREST, [f'{res}/drawable/background.png',
                                        f'{res}/drawable-v21/background.png',
                                        f'{ios}/background.png']),
                              (FOREST_DARK, [f'{res}/drawable-night/background.png',
                                             f'{res}/drawable-night-v21/background.png',
                                             f'{ios}/darkbackground.png'])):
            # Drawn at 1:2, near a phone's own ratio, because the background
            # is stretched to fill: one large shape survives that distortion,
            # a repeating pattern would not.
            raw = monogram(600, 1200, glyph=1.1, rgb=(255, 255, 255), alpha=26,
                           ground=ground, centre=(0.80, 0.17))
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
    adaptive_foregrounds()
    launch_backgrounds()
    launch_logos(logo_dir)
    print('brand assets written for', ', '.join(APPS))
