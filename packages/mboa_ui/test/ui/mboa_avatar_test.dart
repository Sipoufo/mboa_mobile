import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The initials while there is no photo.
///
/// They were set at the profile's heading size whatever the avatar's: in a
/// list row's 36 px square, « JM » ran past the edges and was cropped.
void main() {
  Future<double> initialsSize(WidgetTester tester, double size) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: MboaTheme.light(),
        home: Center(child: MboaAvatar(initials: 'JM', size: size)),
      ),
    );
    return tester.widget<Text>(find.text('JM')).style!.fontSize!;
  }

  testWidgets('a small avatar shrinks them to fit', (tester) async {
    final size = await initialsSize(tester, 36);

    expect(size, lessThanOrEqualTo(36 * 0.4));
    expect(tester.getSize(find.text('JM')).width, lessThan(36));
  });

  testWidgets('a profile-sized avatar keeps the heading size', (tester) async {
    final size = await initialsSize(tester, 96);
    final heading = tester.element(find.text('JM')).mboaText.h1.fontSize;

    expect(heading, isNotNull);
    expect(size, heading);
  });
}
