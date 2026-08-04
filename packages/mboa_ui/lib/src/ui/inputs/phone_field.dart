import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Phone-number entry built on the shared [Input].
///
/// MVP targets Cameroon only (Douala / Yaoundé), so the dial code is fixed and
/// shown as a non-editable prefix; the field itself holds the national digits.
/// Callers compose the E.164 value with [defaultDialCode] + the field text.
class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.dialCode = defaultDialCode,
    this.enabled = true,
    this.validator,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
  });

  /// Cameroon dial code — the MVP default.
  static const String defaultDialCode = '+237';

  /// National subscriber numbers in Cameroon are 9 digits.
  static const int nationalDigits = 9;

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String dialCode;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: controller,
      enabled: enabled,
      labelText: labelText,
      hintText: hintText,
      variant: InputVariant.underline,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      showCounter: false,
      autofillHints: const [AutofillHints.telephoneNumberNational],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(nationalDigits),
      ],
      validator: validator,
      onSubmitted: onSubmitted,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: Dimens.spacingSm),
        child: Center(
          widthFactor: 1,
          child: Text(
            dialCode,
            style: context.mboaText.label.copyWith(
              fontWeight: FontWeight.w600,
              color: context.mboaColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
