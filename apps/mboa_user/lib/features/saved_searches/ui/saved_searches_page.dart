import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/saved_searches_bloc.dart';
import '../models/saved_search.dart';

/// "Recherches sauvegardées" (RM-M04-07): up to three, each with what is new
/// since it was last opened and its own N-01 switch.
@RoutePage()
class SavedSearchesPage extends StatefulWidget implements AutoRouteWrapper {
  const SavedSearchesPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<SavedSearchesBloc>.value(value: getIt<SavedSearchesBloc>(), child: this);

  @override
  State<SavedSearchesPage> createState() => _SavedSearchesPageState();
}

class _SavedSearchesPageState extends State<SavedSearchesPage> {
  @override
  void initState() {
    super.initState();
    // Fresh counts: N-01 may have found something since the list was read.
    context.read<SavedSearchesBloc>().add(const SavedSearchesRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.savedSearchesTitle)),
      body: BlocConsumer<SavedSearchesBloc, SavedSearchesState>(
        // A save's outcome is the search screen's to say; this one says what
        // went wrong with a change made here.
        listenWhen: (prev, curr) =>
            curr is SavedSearchesReady &&
            curr.outcome == SavedSearchOutcome.failed &&
            !(prev is SavedSearchesReady && prev.isSaving),
        listener: (context, _) => MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.savedSearchChangeFailed,
        ),
        builder: (context, state) => switch (state) {
          SavedSearchesInitial() || SavedSearchesLoading() => const Center(child: Loader()),
          SavedSearchesFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<SavedSearchesBloc>().add(const SavedSearchesRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final SavedSearchesReady ready => SavedSearchesList(state: ready),
        },
      ),
    );
  }
}

/// The list itself, public so it can be pumped with a mock bloc.
class SavedSearchesList extends StatelessWidget {
  const SavedSearchesList({super.key, required this.state});

  final SavedSearchesReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListView(
      padding: const EdgeInsets.all(Dimens.screenMargin),
      children: [
        if (state.isOffline) ...[
          _Note(icon: LucideIcons.wifiOff, text: l10n.savedSearchesOffline, tone: colors.warning),
          const SizedBox(height: Dimens.spacing),
        ],
        Text(
          l10n.savedSearchesCount(state.searches.length, SavedSearchesReady.limit),
          style: context.mboaText.label.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingMd),
        if (state.searches.isEmpty)
          _Note(icon: LucideIcons.bookmark, text: l10n.savedSearchesEmpty, tone: colors.textTertiary)
        else
          for (final search in state.searches)
            _SavedSearchCard(
              search: search,
              enabled: !state.isOffline && state.busyId == null,
            ),
        const SizedBox(height: Dimens.spacing),
        // The server keeps a search's filters as saved; changing them is
        // saving another one.
        _Note(icon: LucideIcons.info, text: l10n.savedSearchesFiltersFixed, tone: colors.textTertiary),
      ],
    );
  }
}

class _SavedSearchCard extends StatelessWidget {
  const _SavedSearchCard({required this.search, required this.enabled});

  final SavedSearch search;

  /// Offline, or another change in flight: read, not changed.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<SavedSearchesBloc>();

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        boxShadow: MboaShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.push(SavedSearchResultsRoute(id: search.id, name: search.name)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.spacing, Dimens.spacingSm, 0, Dimens.spacingSm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      search.name,
                      style: context.mboaText.h3.copyWith(color: colors.ink),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<_Action>(
                    enabled: enabled,
                    tooltip: l10n.annoncesActionMore,
                    icon: Icon(LucideIcons.ellipsisVertical, color: colors.primary),
                    onSelected: (action) => switch (action) {
                      _Action.rename => _rename(context, bloc),
                      _Action.delete => _delete(context, bloc),
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: _Action.rename, child: Text(l10n.savedSearchRename)),
                      PopupMenuItem(
                        value: _Action.delete,
                        child: Text(l10n.savedSearchDelete, style: TextStyle(color: colors.error)),
                      ),
                    ],
                  ),
                ],
              ),
              Wrap(
                spacing: Dimens.spacingSm,
                runSpacing: Dimens.spacingXs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (search.newMatchCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.action.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(Dimens.radiusFull),
                      ),
                      child: Text(
                        l10n.savedSearchNewCount(search.newMatchCount),
                        style: context.mboaText.caption.copyWith(color: colors.action),
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.savedSearchAlerts,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  ),
                  Switch(
                    value: search.alertsEnabled,
                    onChanged: enabled
                        ? (on) => bloc.add(SavedSearchAlertsToggled(search.id, enabled: on))
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _rename(BuildContext context, SavedSearchesBloc bloc) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => _RenameDialog(initial: search.name),
    );
    if (name != null && name.trim().isNotEmpty) bloc.add(SavedSearchRenamed(search.id, name));
  }

  Future<void> _delete(BuildContext context, SavedSearchesBloc bloc) async {
    final l10n = I18n.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.savedSearchDeleteTitle),
        content: Text(l10n.savedSearchDeleteBody(search.name)),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.commonCancel)),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.savedSearchDelete, style: TextStyle(color: context.mboaColors.error)),
          ),
        ],
      ),
    );
    if (confirmed ?? false) bloc.add(SavedSearchDeleted(search.id));
  }
}

enum _Action { rename, delete }

/// A name, 1 to 60 characters — the server refuses a blank one.
class _RenameDialog extends StatefulWidget {
  const _RenameDialog({required this.initial});

  final String initial;

  @override
  State<_RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<_RenameDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return AlertDialog(
      title: Text(l10n.savedSearchRename),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 60,
        decoration: InputDecoration(hintText: l10n.savedSearchNameHint),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, _) => TextButton(
            onPressed: value.text.trim().isEmpty ? null : () => Navigator.of(context).pop(value.text.trim()),
            child: Text(l10n.savedSearchRenameConfirm),
          ),
        ),
      ],
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.text, required this.tone});

  final IconData icon;
  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: Dimens.iconSm, color: tone),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(
          child: Text(
            text,
            style: context.mboaText.caption.copyWith(color: context.mboaColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
