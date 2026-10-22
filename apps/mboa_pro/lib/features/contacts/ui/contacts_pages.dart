import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../annonces/bloc/annonces_bloc.dart';
import '../../annonces/models/annonce.dart';
import '../bloc/contact_form_bloc.dart';
import '../bloc/my_contacts_bloc.dart';

/// What the form says it came to.
enum ContactFormOutcome { saved, deleted }

/// « Contacts utiles » (CDC M30 lot 3, RM-M30-13): the landlord's notes about
/// the people around his properties, and which his tenants see.
@RoutePage()
class ContactsPage extends StatelessWidget implements AutoRouteWrapper {
  const ContactsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyContactsBloc>(
        create: (_) => getIt<MyContactsBloc>()..add(const MyContactsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const ContactsView();
}

/// The list under its bloc — public so it can be pumped with a mock one.
class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  Future<void> _open(BuildContext context, [UsefulContact? contact]) async {
    final bloc = context.read<MyContactsBloc>();
    final outcome = await context.router.push<ContactFormOutcome>(ContactFormRoute(contact: contact));
    switch (outcome) {
      case ContactFormOutcome.deleted when contact != null:
        bloc.add(MyContactDeleted(contact.id));
      case ContactFormOutcome.saved:
        bloc.add(const MyContactsRequested());
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<MyContactsBloc, MyContactsState>(
      listenWhen: (_, current) => current is MyContactsReady && current.failed,
      listener: (context, _) => MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError),
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.contactsUsefulTitle)),
        body: switch (state) {
          MyContactsLoading() => const Center(child: Loader()),
          MyContactsFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<MyContactsBloc>().add(const MyContactsRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final MyContactsReady ready => RefreshIndicator(
              onRefresh: () async => context.read<MyContactsBloc>().add(const MyContactsRequested()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (ready.isOffline) ...[
                    Text(l10n.contactsOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  Text(l10n.contactsLandlordHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  const SizedBox(height: Dimens.spacing),
                  if (ready.items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                      child: Text(
                        l10n.contactsEmptyLandlord,
                        textAlign: TextAlign.center,
                        style: context.mboaText.body.copyWith(color: colors.textSecondary),
                      ),
                    ),
                  for (final contact in ready.items)
                    _ContactRow(contact: contact, onTap: ready.isOffline ? null : () => _open(context, contact)),
                  if (ready.isFull)
                    Text(l10n.contactsFull, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                ],
              ),
            ),
        },
        // One main action, while there is room and a line.
        bottomNavigationBar: state is MyContactsReady && !state.isFull && !state.isOffline
            ? Container(
                decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
                child: SafeArea(
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Button.primary(title: l10n.contactsAdd, onPressed: () => _open(context)),
                ),
              )
            : null,
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.contact, this.onTap});

  final UsefulContact contact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final sharing = switch (contact) {
      UsefulContact(shared: false) => l10n.contactsPrivate,
      UsefulContact(:final annonceIds) when annonceIds.isEmpty => l10n.contactsSharedAll,
      UsefulContact(:final annonceIds) => l10n.contactsSharedSome(annonceIds.length),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          onTap: onTap,
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
                      Text(
                        '${contact.role} · ${contact.phone}',
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                      Row(
                        children: [
                          Icon(
                            contact.shared ? LucideIcons.users : LucideIcons.lock,
                            size: 12,
                            color: contact.shared ? colors.primary : colors.textTertiary,
                          ),
                          const SizedBox(width: Dimens.spacingXs),
                          Text(
                            sharing,
                            style: context.mboaText.micro.copyWith(
                              color: contact.shared ? colors.primary : colors.textTertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Adding or changing a contact. Pops what it came to.
@RoutePage()
class ContactFormPage extends StatelessWidget implements AutoRouteWrapper {
  const ContactFormPage({super.key, this.contact});

  final UsefulContact? contact;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ContactFormBloc>(
        create: (_) => getIt<ContactFormBloc>()..add(ContactFormStarted(contact)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const ContactFormView();
}

/// The form under its bloc — public so it can be pumped with a mock one.
class ContactFormView extends StatefulWidget {
  const ContactFormView({super.key});

  @override
  State<ContactFormView> createState() => _ContactFormViewState();
}

/// Only the text controllers live here; every rule is the bloc's.
class _ContactFormViewState extends State<ContactFormView> {
  late final TextEditingController _name;
  late final TextEditingController _role;
  late final TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    final state = context.read<ContactFormBloc>().state;
    _name = TextEditingController(text: state.name);
    _role = TextEditingController(text: state.role);
    _phone = TextEditingController(text: state.nationalNumber);
    // His properties, for sharing on some: read if not yet.
    final annonces = context.read<AnnoncesBloc?>();
    if (annonces != null && annonces.state is AnnoncesInitial) annonces.add(const AnnoncesLoadRequested());
  }

  @override
  void dispose() {
    _name.dispose();
    _role.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _delete(BuildContext context) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final router = context.router;
    final choice = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
          child: ListTile(
            leading: Icon(LucideIcons.trash2, color: colors.error),
            title: Text(l10n.contactsDelete, style: context.mboaText.label.copyWith(color: colors.error)),
            onTap: () => Navigator.of(sheetContext).pop(true),
          ),
        ),
      ),
    );
    if (choice ?? false) await router.maybePop(ContactFormOutcome.deleted);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<ContactFormBloc>();
    Widget label(String text) => Padding(
          padding: const EdgeInsets.only(top: Dimens.spacingLg, bottom: Dimens.spacingSm),
          child: Text(text, style: context.mboaText.label.copyWith(color: colors.textSecondary)),
        );
    final suggestions = [
      l10n.contactsRoleCaretaker,
      l10n.contactsRoleCleaner,
      l10n.contactsRolePlumber,
      l10n.contactsRoleElectrician,
      l10n.contactsRoleSecurity,
    ];

    return BlocConsumer<ContactFormBloc, ContactFormState>(
      listenWhen: (_, current) => current.saved != null || current.refusal != null || current.failed,
      listener: (context, state) {
        if (state.saved != null) {
          context.router.maybePop(ContactFormOutcome.saved);
          return;
        }
        MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: switch (state.refusal) {
            ContactRefusal.limitReached => l10n.contactsFull,
            ContactRefusal.invalid => l10n.contactsInvalid,
            null => l10n.commonError,
          },
        );
      },
      builder: (context, state) {
        final annonces = switch (context.watch<AnnoncesBloc?>()?.state) {
          AnnoncesReady(:final items) => items,
          _ => const <Annonce>[],
        };

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            leading: const MboaHeaderBackButton(),
            title: Text(state.editing == null ? l10n.contactsAdd : l10n.contactsEdit),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingXl),
            children: [
              label(l10n.contactsName),
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => bloc.add(ContactFormChanged(name: value)),
              ),
              label(l10n.contactsRole),
              TextField(
                controller: _role,
                maxLength: 60,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) => bloc.add(ContactFormChanged(role: value)),
              ),
              Wrap(
                spacing: Dimens.spacingSm,
                runSpacing: Dimens.spacingXs,
                children: [
                  for (final role in suggestions)
                    ActionChip(
                      label: Text(role),
                      onPressed: () {
                        _role.text = role;
                        bloc.add(ContactFormChanged(role: role));
                      },
                    ),
                ],
              ),
              label(l10n.contactsPhone),
              PhoneField(
                controller: _phone,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {},
              ),
              // The field has no onChanged: its controller is read as it goes.
              _PhoneWatcher(controller: _phone, onChanged: (value) => bloc.add(ContactFormChanged(nationalNumber: value))),
              const SizedBox(height: Dimens.spacing),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: state.shared,
                title: Text(l10n.contactsShare, style: context.mboaText.label.copyWith(color: colors.ink)),
                subtitle: Text(l10n.contactsShareHint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                onChanged: (value) => bloc.add(ContactFormChanged(shared: value)),
              ),
              if (state.shared) ...[
                Wrap(
                  spacing: Dimens.spacingSm,
                  runSpacing: Dimens.spacingXs,
                  children: [
                    ChoiceChip(
                      label: Text(l10n.contactsSharedAll),
                      selected: state.annonceIds.isEmpty,
                      onSelected: (_) => bloc.add(const ContactFormChanged(annonceIds: {})),
                    ),
                    for (final annonce in annonces)
                      FilterChip(
                        label: Text(annonce.title, overflow: TextOverflow.ellipsis),
                        selected: state.annonceIds.contains(annonce.id),
                        onSelected: (on) => bloc.add(
                          ContactFormChanged(
                            annonceIds: on ? {...state.annonceIds, annonce.id} : ({...state.annonceIds}..remove(annonce.id)),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
            child: SafeArea(
              minimum: const EdgeInsets.all(Dimens.spacing),
              child: Row(
                children: [
                  Expanded(
                    child: Button.primary(
                      title: l10n.contactsSave,
                      isLoading: state.isSaving,
                      onPressed: state.isComplete && !state.isSaving ? () => bloc.add(const ContactFormSaved()) : null,
                    ),
                  ),
                  // Deleting is rare and final: behind "⋯" (Doc05 §6.1).
                  if (state.editing != null) ...[
                    const SizedBox(width: Dimens.spacingSm),
                    SizedBox.square(
                      dimension: Dimens.buttonHeight,
                      child: IconButton(
                        tooltip: l10n.listingMoreActions,
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.radius),
                            side: BorderSide(color: colors.primary),
                          ),
                        ),
                        icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                        onPressed: state.isSaving ? null : () => _delete(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Tells the bloc what the phone field holds, as it changes.
class _PhoneWatcher extends StatefulWidget {
  const _PhoneWatcher({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<_PhoneWatcher> createState() => _PhoneWatcherState();
}

class _PhoneWatcherState extends State<_PhoneWatcher> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_changed);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_changed);
    super.dispose();
  }

  void _changed() => widget.onChanged(widget.controller.text);

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
