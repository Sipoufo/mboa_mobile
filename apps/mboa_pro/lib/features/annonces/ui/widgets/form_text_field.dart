import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// [Input] with an owned controller and an optional unit suffix.
///
/// The design-system [Input] takes a controller, which would mean threading one
/// per field through a bloc-driven form. This owns it instead — the bloc stays
/// the source of truth without the widget fighting the cursor on every
/// keystroke.
class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.suffixText,
  });

  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final int maxLines;

  /// Set for multi-line fields so the box opens at its full height rather than
  /// growing from a single line as you type.
  final int? minLines;

  /// Unit shown inside the field — m², XAF. Belongs here rather than in the
  /// label so the value and its unit read together.
  final String? suffixText;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  @override
  void didUpdateWidget(FormTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Editing loads the listing *after* the first build, so the seeded value
    // arrives late. Adopt it — but only when it differs from what is on screen,
    // otherwise every keystroke would fight the controller and reset the caret.
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.initialValue,
        selection:
            TextSelection.collapsed(offset: widget.initialValue.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suffix = widget.suffixText;

    return Input(
      controller: _controller,
      labelText: widget.label,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      variant: InputVariant.underline,
      suffixIcon: suffix == null
          ? null
          // Shrink-wrapped: the suffix slot otherwise forces icon-sized width.
          : Align(
              alignment: Alignment.centerRight,
              widthFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: Dimens.spacingSm),
                child: Text(
                suffix,
                  style: context.mboaText.label.copyWith(
                    color: context.mboaColors.textSecondary,
                  ),
                ),
              ),
            ),
      onChanged: widget.onChanged,
    );
  }
}
