import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Password entry built on [Input], with a show/hide toggle. Defaults to the
/// underline auth style; pass [variant] to change it.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.validator,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.variant = InputVariant.underline,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction textInputAction;
  final InputVariant variant;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  void _toggle() => setState(() => _obscured = !_obscured);

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: widget.controller,
      enabled: widget.enabled,
      labelText: widget.labelText,
      hintText: widget.hintText,
      variant: widget.variant,
      isPassword: _obscured,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      showCounter: false,
      autofillHints: const [AutofillHints.password],
      validator: widget.validator,
      onSubmitted: widget.onSubmitted,
      suffixIcon: IconButton(
        onPressed: widget.enabled ? _toggle : null,
        icon: Icon(
          _obscured ? LucideIcons.eyeOff : LucideIcons.eye,
          size: Dimens.icon,
          color: context.mboaColors.textSecondary,
        ),
      ),
    );
  }
}
