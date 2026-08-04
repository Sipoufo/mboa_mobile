import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_pro/features/shell/ui/widgets/pro_bottom_nav.dart';
import 'package:mboa_ui/mboa_ui.dart';

void main() {
  const items = [
    ProBottomNavItem(icon: LucideIcons.mountain, label: 'Accueil'),
    ProBottomNavItem(icon: LucideIcons.users, label: 'Gestionnaire'),
    ProBottomNavItem(icon: LucideIcons.wallet, label: 'Finance'),
    ProBottomNavItem(icon: LucideIcons.layoutGrid, label: 'Menu'),
  ];

  Future<List<int>> pump(WidgetTester tester, {required int selected}) async {
    final taps = <int>[];
    await tester.pumpWidget(
      MaterialApp(
        theme: MboaTheme.light(),
        home: Scaffold(
          bottomNavigationBar: ProBottomNav(
            items: items,
            selectedIndex: selected,
            onTap: taps.add,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return taps;
  }

  testWidgets('renders every slot but labels only the selected one', (tester) async {
    await pump(tester, selected: 0);

    expect(find.byIcon(LucideIcons.mountain), findsOneWidget);
    expect(find.byIcon(LucideIcons.users), findsOneWidget);
    expect(find.byIcon(LucideIcons.wallet), findsOneWidget);
    expect(find.byIcon(LucideIcons.layoutGrid), findsOneWidget);

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Gestionnaire'), findsNothing);
    expect(find.text('Menu'), findsNothing);
  });

  testWidgets('moves the label when the selection changes', (tester) async {
    await pump(tester, selected: 2);

    expect(find.text('Finance'), findsOneWidget);
    expect(find.text('Accueil'), findsNothing);
  });

  testWidgets('reports the tapped index, including the menu slot', (tester) async {
    final taps = await pump(tester, selected: 0);

    await tester.tap(find.byIcon(LucideIcons.users));
    await tester.tap(find.byIcon(LucideIcons.layoutGrid));
    await tester.pump();

    expect(taps, [1, 3]);
  });

  testWidgets('labels every slot for screen readers, selected or not', (tester) async {
    await pump(tester, selected: 1);

    // Unselected slots render no visible text, so the semantics label is the
    // only thing naming them.
    final labelled = tester
        .widgetList<Semantics>(find.byType(Semantics))
        .where((s) => s.properties.button ?? false);

    expect(
      labelled.map((s) => s.properties.label),
      containsAll(items.map((i) => i.label)),
    );
    expect(
      labelled.where((s) => s.properties.selected ?? false).single.properties.label,
      'Gestionnaire',
    );
  });
}
