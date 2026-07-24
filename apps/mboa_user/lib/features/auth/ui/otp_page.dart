import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// App-Mboa route adapter around the shared [OtpView]. Receives the pending
/// [OtpSession] from the login step as a route argument.
@RoutePage()
class OtpPage extends StatelessWidget {
  const OtpPage({required this.session, super.key});

  final OtpSession session;

  @override
  Widget build(BuildContext context) => OtpView(session: session);
}
