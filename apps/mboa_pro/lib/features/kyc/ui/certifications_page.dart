import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';

import 'package:mboa_shared/mboa_shared.dart';

import '../logic/kyc_cubit.dart';
import 'certifications_view.dart';

/// Route adapter for the Certifications (KYC) screen. Shares the singleton
/// [KycCubit] so the ID-document screen sees the same capture draft.
@RoutePage()
class CertificationsPage extends StatelessWidget {
  const CertificationsPage({super.key, this.accountRole = AccountRole.user});

  final AccountRole accountRole;

  @override
  Widget build(BuildContext context) => BlocProvider<KycCubit>.value(
        value: getIt<KycCubit>()..load(),
        child: CertificationsView(accountRole: accountRole),
      );
}
