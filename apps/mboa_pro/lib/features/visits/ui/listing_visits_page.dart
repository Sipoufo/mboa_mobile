import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/visits_agenda_blocs.dart';
import 'widgets/owner_visits_agenda.dart';

/// §40 D — one listing's visits, his and his agents', a week at a time.
/// Opened from the listing's detail.
@RoutePage()
class ListingVisitsPage extends StatelessWidget implements AutoRouteWrapper {
  const ListingVisitsPage({super.key, required this.annonceId, this.annonceTitle});

  final String annonceId;
  final String? annonceTitle;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ListingVisitsAgendaBloc>(
        create: (_) => getIt<ListingVisitsAgendaBloc>(param1: annonceId)..add(const AgendaRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final title = annonceTitle?.trim();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: MboaHeaderBackButton.leading(context),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.listingVisitsTitle),
            if (title != null && title.isNotEmpty)
              Text(title, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
          ],
        ),
      ),
      body: const OwnerVisitsAgenda<ListingVisitsAgendaBloc>(),
    );
  }
}
