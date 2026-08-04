import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Route adapter around the shared [ChangePhoneView].
@RoutePage()
class ChangePhonePage extends StatelessWidget {
  const ChangePhonePage({super.key});

  @override
  Widget build(BuildContext context) => const ChangePhoneView();
}
