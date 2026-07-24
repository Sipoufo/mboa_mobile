import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Placeholder landing screen for App Mboa Pro. Provider/agent feature modules
/// (visit reports, listings management, geolocation check…) plug in here.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mboa Pro')),
      body: const Center(child: Text('App Mboa Pro — squelette prêt.')),
    );
  }
}
