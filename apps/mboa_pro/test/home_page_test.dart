import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/home/ui/home_page.dart';

void main() {
  testWidgets('HomePage renders the Pro landing content', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Mboa Pro'), findsOneWidget);
    expect(find.textContaining('squelette'), findsOneWidget);
  });
}
