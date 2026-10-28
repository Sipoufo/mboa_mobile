import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../../app/router/app_router.gr.dart';

/// « Vérifier mon identité » (§39 C) — optional for a tenant. Once approved,
/// their contracts carry a verified identity without typing it, and the Mboa
/// Score counts `IDENTITY_VERIFIED`. The Pro app's screens, without the NUI and
/// the address.
@RoutePage()
class IdentityPage extends StatelessWidget {
  const IdentityPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<KycCubit>.value(
        value: getIt<KycCubit>()..load(),
        child: CertificationsView(
          onOpenIdDocument: () => context.router.push(const IdentityDocumentRoute()),
        ),
      );
}

/// The document's photos and details. A tenant is offered the CNI and the
/// passport (§39 C — the server accepts the licence too; the choice is ours).
@RoutePage()
class IdentityDocumentPage extends StatelessWidget {
  const IdentityDocumentPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<KycCubit>.value(
        value: getIt<KycCubit>(),
        child: const IdDocumentView(types: [KycDocType.cni, KycDocType.passport]),
      );
}
