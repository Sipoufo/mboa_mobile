import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';

/// Which URL the map ends up loading.
///
/// `MAP_STYLE_URL` exists for the move to self-hosted tiles (Doc 13 §8), but
/// the first thing anyone does with it is paste a style URL out of MapTiler's
/// catalogue — where the key lives on a different page. That URL is answered
/// with 403 and the map stays blank, so it is completed here.
void main() {
  const key = 'test-key';

  test('no override — MapTiler streets, with the key', () {
    final url = Environment.resolveStyleUrl(override: '', key: key);

    expect(url, contains('api.maptiler.com'));
    expect(url, endsWith('key=$key'));
  });

  test('a MapTiler override missing its key gets one', () {
    final url = Environment.resolveStyleUrl(
      override: 'https://api.maptiler.com/maps/streets-v4/style.json',
      key: key,
    );

    expect(url, 'https://api.maptiler.com/maps/streets-v4/style.json?key=$key');
  });

  test('an override that already carries a key is left alone', () {
    const override =
        'https://api.maptiler.com/maps/streets-v4/style.json?key=another';
    expect(Environment.resolveStyleUrl(override: override, key: key), override);
  });

  test('a query string that is not a key gets the key appended, not replaced',
      () {
    final url = Environment.resolveStyleUrl(
      override: 'https://api.maptiler.com/maps/x/style.json?lang=fr',
      key: key,
    );

    expect(url, endsWith('?lang=fr&key=$key'));
  });

  test('a style hosted somewhere else is used untouched', () {
    // A self-hosted PMTiles style has no MapTiler key to add, and appending
    // one would leak it to whoever serves that style.
    const override = 'https://tiles.mboa.cm/styles/mboa/style.json';
    expect(Environment.resolveStyleUrl(override: override, key: key), override);
  });
}
