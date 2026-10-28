import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Route adapter for the ID document capture flow (type picker → photos and
/// details). Shares the singleton [KycCubit] with the Certifications screen.
/// A prestataire or an agent may use any of the three documents.
@RoutePage()
class IdDocumentPage extends StatelessWidget {
  const IdDocumentPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<KycCubit>.value(
        value: getIt<KycCubit>(),
        child: const IdDocumentView(),
      );
}
