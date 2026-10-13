import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A 1–5 star picker.
///
/// Shared because both reviews a property can carry are rated the same way:
/// the visitor's report (M07bis) and the resident's (M27). Two copies of five
/// stars is how they end up disagreeing about which colour "chosen" is.
class MboaStarRating extends StatelessWidget {
  const MboaStarRating({
    super.key,
    required this.value,
    required this.onPick,
    this.label,
  });

  /// 1–5, or null / 0 when nothing has been chosen yet.
  final int? value;

  final ValueChanged<int> onPick;

  /// Announced to screen readers, which otherwise hear five identical stars.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Semantics(
      label: label,
      value: '${value ?? 0}/5',
      child: Row(
        children: [
          for (var star = 1; star <= 5; star++)
            IconButton(
              onPressed: () => onPick(star),
              padding: EdgeInsets.zero,
              // 44 is the smallest comfortable touch target, and five of them
              // still fit across a 390 px screen.
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              icon: Icon(
                LucideIcons.star,
                size: Dimens.iconMd,
                // Filled up to the choice: five outlines say nothing about
                // what was picked.
                color: (value ?? 0) >= star ? colors.warning : colors.border,
              ),
            ),
        ],
      ),
    );
  }
}

/// A free list of short points — type, add, remove.
///
/// Used for both halves of a review's bullets, the good and the bad, and by
/// both kinds of review. [isPro] only tints the chips; the sign is carried by
/// the list it sits under, so the meaning survives in greyscale.
class MboaPointEditor extends StatefulWidget {
  const MboaPointEditor({
    super.key,
    required this.values,
    required this.isPro,
    required this.onAdd,
    required this.onRemove,
    required this.hintText,
    required this.addLabel,
  });

  final List<String> values;
  final bool isPro;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  /// Passed in rather than read here: the widget lives in `mboa_ui`, which
  /// does not depend on the app's copy.
  final String hintText;
  final String addLabel;

  @override
  State<MboaPointEditor> createState() => _MboaPointEditorState();
}

class _MboaPointEditorState extends State<MboaPointEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    widget.onAdd(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.values.isNotEmpty) ...[
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final value in widget.values)
                Chip(
                  label: Text(value),
                  onDeleted: () => widget.onRemove(value),
                  deleteIcon: const Icon(LucideIcons.x, size: 14),
                  backgroundColor:
                      widget.isPro ? colors.primaryPale : colors.actionPale,
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacingSm),
        ],
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLength: 120,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  counterText: '',
                ),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            TextButton(onPressed: _add, child: Text(widget.addLabel)),
          ],
        ),
      ],
    );
  }
}
