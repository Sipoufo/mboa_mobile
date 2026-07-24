import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'router/app_router.dart';

/// App Mboa Pro root.
class MboaProApp extends StatefulWidget {
  const MboaProApp({super.key});

  @override
  State<MboaProApp> createState() => _MboaProAppState();
}

class _MboaProAppState extends State<MboaProApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mboa Pro',
      debugShowCheckedModeBanner: false,
      theme: MboaTheme.light(MboaColors.proSeed),
      darkTheme: MboaTheme.dark(MboaColors.proSeed),
      routerConfig: _router.config(),
    );
  }
}
