import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Phone-number entry built on the shared [Input]: the national digits, after
/// the [country]'s dial code.
///
/// §40 A — with [onCountryChanged] the dial code opens every country (the
/// sign-in, the number change); without it, it stays Cameroon's (the Pro
/// forms). Callers build the E.164 value with [MboaCountry.e164].
class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.country = MboaCountry.cameroon,
    this.onCountryChanged,
    this.enabled = true,
    this.validator,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.variant = InputVariant.underline,
  });

  /// Cameroon dial code — the MVP default.
  static const String defaultDialCode = '+237';

  /// National subscriber numbers in Cameroon are 9 digits.
  static const int nationalDigits = 9;

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  /// §40 A — whose dial code goes before the number. Cameroon unless chosen.
  final MboaCountry country;

  /// Set, the dial code opens every country to choose from; unset, it is
  /// fixed (the Pro forms, Cameroonian).
  final ValueChanged<MboaCountry>? onCountryChanged;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction textInputAction;

  /// Underlined on the auth screens; outlined inside a card.
  final InputVariant variant;

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: controller,
      enabled: enabled,
      labelText: labelText,
      hintText: hintText,
      variant: variant,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      showCounter: false,
      autofillHints: const [AutofillHints.telephoneNumberNational],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(country.maxDigits),
      ],
      validator: validator,
      onSubmitted: onSubmitted,
      prefixIcon: _Prefix(
        country: country,
        variant: variant,
        onTap: onCountryChanged == null || !enabled
            ? null
            : () async {
                final chosen = await showCountryPicker(context, selected: country);
                if (chosen != null) onCountryChanged!(chosen);
              },
      ),
    );
  }
}

/// The dial code before the number — with its flag and a chevron when it
/// opens the countries.
class _Prefix extends StatelessWidget {
  const _Prefix({required this.country, required this.variant, this.onTap});

  final MboaCountry country;
  final InputVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final code = Text(
      country.dialCode,
      style: context.mboaText.label.copyWith(fontWeight: FontWeight.w600, color: colors.textSecondary),
    );

    return Padding(
      // Inside a box the code needs the box's inset; on a rule it starts at
      // the edge.
      padding: EdgeInsets.only(
        left: variant == InputVariant.outlined ? Dimens.spacing : 0,
        right: Dimens.spacingSm,
      ),
      child: onTap == null
          ? Center(widthFactor: 1, child: code)
          : Tooltip(
              message: I18n.of(context).countryPickerOpen,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(Dimens.radiusSm),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(country.flag, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: Dimens.spacingXs),
                    code,
                    Icon(LucideIcons.chevronDown, size: Dimens.iconSm, color: colors.textSecondary),
                  ],
                ),
              ),
            ),
    );
  }
}
