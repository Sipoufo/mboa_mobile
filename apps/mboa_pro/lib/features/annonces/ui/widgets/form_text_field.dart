import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// [Input] with an owned controller.
///
/// The design-system [Input] takes a controller, which would mean threading one
/// per field through a bloc-driven form. This owns it instead, seeding from the
/// draft once — the bloc stays the source of truth without the widget fighting
/// the cursor on every keystroke.
class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
  });

  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final int maxLines;

  /// Set for multi-line fields so the box opens at its full height rather
  /// than growing from a single line as you type.
  final int? minLines;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: _controller,
      labelText: widget.label,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      variant: InputVariant.underline,
      onChanged: widget.onChanged,
    );
  }
}
