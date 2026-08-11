import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Visual treatment of an [Input]'s border.
enum InputVariant {
  /// Rounded outlined box — the design-system default.
  outlined,

  /// A single bottom rule — the auth-surface style (see the login screens).
  underline,
}

class Input extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool readOnly;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? cursorColor;
  final bool? filled;
  final bool isPassword;
  final int? minLines;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final String? labelText;
  final String? labelSuffix;

  /// When set, an info affordance sits next to the label and opens a sheet
  /// explaining the field. Only worth it where the answer is not obvious — an
  /// icon on every label becomes wallpaper and stops being read.
  final String? helpText;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final VoidCallback? onTap;
  final bool optional;
  final bool showCounter;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final InputVariant variant;

  const Input({
    super.key,
    this.focusNode,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.cursorColor,
    this.filled,
    this.isPassword = false,
    this.minLines,
    this.keyboardType,
    this.showCounter = true,
    this.fillColor,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines,
    this.textInputAction,
    this.autofillHints,
    this.onSubmitted,
    this.labelText,
    this.textCapitalization,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.optional = false,
    this.labelSuffix,
    this.padding,
    this.borderColor,
    this.focusedBorderColor,
    this.variant = InputVariant.outlined,
    this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUnderline = variant == InputVariant.underline;
    final Color effectiveBorderColor =
        borderColor ?? (isUnderline ? context.mboaColors.border : context.mboaColors.primaryDark);

    final field = TextFormField(
      onTap: onTap,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      controller: controller,
      obscureText: isPassword,
      cursorColor: cursorColor ?? context.mboaColors.primaryDark,
      readOnly: readOnly,
      focusNode: focusNode,
      maxLength: maxLength,
      style: style ?? context.mboaText.label.copyWith(fontWeight: FontWeight.w500),
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onFieldSubmitted: onSubmitted,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            context.mboaText.label.copyWith(
              fontWeight: FontWeight.w400,
              color: context.mboaColors.textTertiary,
            ),
        counter: showCounter ? null : const SizedBox(),
        filled: filled,
        errorMaxLines: 2,
        fillColor: fillColor ?? context.colorScheme.surface,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabled: enabled,
        isDense: isUnderline,
        contentPadding: padding ??
            (isUnderline
                ? const EdgeInsets.symmetric(vertical: Dimens.spacingMd)
                : const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: 18)),
        errorBorder: _getInputBorder(color: context.mboaColors.error, isUnderline: isUnderline),
        enabledBorder: _getInputBorder(color: effectiveBorderColor, isUnderline: isUnderline),
        border: _getInputBorder(color: effectiveBorderColor, isUnderline: isUnderline),
        focusedErrorBorder: _getInputBorder(color: context.mboaColors.error, isUnderline: isUnderline),
        focusedBorder: _getInputBorder(
          color: focusedBorderColor ?? context.colorScheme.primary,
          isUnderline: isUnderline,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Row(
            children: [
              Flexible(
                child: Text.rich(
                  TextSpan(
                    text: labelText!,
                    style: context.mboaText.label.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.mboaColors.textSecondary,
                    ),
                    children: [
                      if (labelSuffix != null) ...[
                        TextSpan(
                          text: ' ($labelSuffix)',
                          style: context.mboaText.label.copyWith(
                            fontWeight: FontWeight.w400,
                            color: context.mboaColors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (helpText case final help?)
                FieldHelp(label: labelText!, text: help),
            ],
          ),
          const SizedBox(height: Dimens.spacingXs),
        ],
        if (isUnderline)
          field
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.radius),
            child: field,
          ),
      ],
    );
  }

  InputBorder _getInputBorder({required Color color, required bool isUnderline}) {
    final side = BorderSide(color: color, width: 1);
    return isUnderline
        ? UnderlineInputBorder(borderSide: side)
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.radius),
            borderSide: side,
          );
  }
}
