import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/home_contacts_bloc.dart';

/// « Contacts », the space's third daily-life tile (CDC M30 lot 3,
/// RM-M30-13): who to call about the home — the caretaker, the plumber —
/// as the landlord shares them.
@RoutePage()
class HomeContactsPage extends StatelessWidget implements AutoRouteWrapper {
  const HomeContactsPage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeContactsBloc>(
        create: (_) => getIt<HomeContactsBloc>(param1: contractId)..add(const HomeContactsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const HomeContactsView();
}

/// The list under its bloc — public so it can be pumped with a mock one.
class HomeContactsView extends StatelessWidget {
  const HomeContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.contactsUsefulTitle)),
      body: BlocBuilder<HomeContactsBloc, HomeContactsState>(
        builder: (context, state) => switch (state) {
          HomeContactsLoading() => const Center(child: Loader()),
          HomeContactsFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<HomeContactsBloc>().add(const HomeContactsRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          HomeContactsReady(:final items, :final isOffline) => RefreshIndicator(
              onRefresh: () async => context.read<HomeContactsBloc>().add(const HomeContactsRequested()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (isOffline) ...[
                    Text(l10n.myHomeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  if (items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                      child: Text(
                        l10n.contactsEmptyTenant,
                        textAlign: TextAlign.center,
                        style: context.mboaText.body.copyWith(color: colors.textSecondary),
                      ),
                    )
                  else
                    for (final contact in items) ContactCard(contact: contact, onCall: () => _call(contact.phone)),
                ],
              ),
            ),
        },
      ),
    );
  }

  /// The phone's own dialler — nothing goes through Mboa.
  static Future<void> _call(String phone) => launchUrl(Uri(scheme: 'tel', path: phone));
}

/// A contact: who, what for, the number — and, for the tenant, « Appeler ».
class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact, this.onCall});

  final UsefulContact contact;
  final VoidCallback? onCall;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMd),
          child: Row(
            children: [
              MboaAvatar(initials: contact.name.isEmpty ? '?' : contact.name[0].toUpperCase(), size: 44),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.name, style: context.mboaText.label.copyWith(color: colors.ink)),
                    Text(contact.role, style: context.mboaText.caption.copyWith(color: colors.primary)),
                    Text(contact.phone, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  ],
                ),
              ),
              if (onCall != null)
                IconButton.filled(
                  tooltip: l10n.contactsCall,
                  onPressed: onCall,
                  icon: const Icon(LucideIcons.phone),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
