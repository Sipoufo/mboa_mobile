import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// "Mon Mboa Score" (RM-M09-03) — the tenant's own, read-only, with what
/// raised it and what lowered it.
@RoutePage()
class MyScorePage extends StatelessWidget {
  const MyScorePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.mboaColors.background,
        appBar: AppBar(title: Text(I18n.of(context).scoreTitle)),
        body: const MboaScoreView(source: OwnScore()),
      );
}
