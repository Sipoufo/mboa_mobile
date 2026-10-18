import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// What the tenant chose in the sheet.
typedef SaveSearchChoice = ({String? name, bool alertsEnabled});

/// Asks for an optional name and whether to be alerted (N-01), before a
/// search is saved. Null when dismissed.
///
/// The name may stay empty: the server then builds one from the filters
/// ("Appartement · Akwa · ≤ 500 000 FCFA").
Future<SaveSearchChoice?> showSaveSearchSheet(BuildContext context) => showModalBottomSheet<SaveSearchChoice>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      builder: (_) => const SaveSearchSheet(),
    );

class SaveSearchSheet extends StatefulWidget {
  const SaveSearchSheet({super.key});

  @override
  State<SaveSearchSheet> createState() => _SaveSearchSheetState();
}

/// Form state only — what is typed before anything is sent.
class _SaveSearchSheetState extends State<SaveSearchSheet> {
  final _name = TextEditingController();
  bool _alerts = true;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.screenMargin,
        Dimens.spacingLg,
        Dimens.screenMargin,
        Dimens.spacingLg + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.saveSearchTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
          const SizedBox(height: Dimens.spacing),
          TextField(
            controller: _name,
            maxLength: 60,
            decoration: InputDecoration(
              labelText: l10n.savedSearchNameLabel,
              hintText: l10n.savedSearchNameHint,
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _alerts,
            title: Text(l10n.savedSearchAlerts, style: context.mboaText.body),
            subtitle: Text(
              l10n.saveSearchAlertsHelp,
              style: context.mboaText.caption.copyWith(color: colors.textSecondary),
            ),
            onChanged: (on) => setState(() => _alerts = on),
          ),
          const SizedBox(height: Dimens.spacing),
          Button.primary(
            title: l10n.saveSearchConfirm,
            onPressed: () {
              final name = _name.text.trim();
              Navigator.of(context).pop<SaveSearchChoice>((name: name.isEmpty ? null : name, alertsEnabled: _alerts));
            },
          ),
        ],
      ),
    );
  }
}
