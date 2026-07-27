import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboa_ui/mboa_ui.dart';

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
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final VoidCallback? onTap;
  final bool optional;
  final bool showCounter;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? focusedBorderColor;

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
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor = borderColor ?? context.mboaColors.primaryDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text.rich(
            TextSpan(
              text: labelText!,
              style: context.mboaText.label.copyWith(
                fontWeight: FontWeight.w700,
                color: context.mboaColors.primaryDark,
              ),
              children: [
                if (labelSuffix != null) ...[
                  TextSpan(
                    text: ' ($labelSuffix)',
                    style: context.mboaText.label.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: Dimens.spacingXs),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.radius),
          child: TextFormField(
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
              hintStyle:
                  hintStyle ??
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
              contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: 18),
              errorBorder: _getInputBorder(color: context.mboaColors.error),
              enabledBorder: _getInputBorder(color: effectiveBorderColor),
              border: _getInputBorder(color: effectiveBorderColor),
              focusedErrorBorder: _getInputBorder(color: context.mboaColors.error),
              focusedBorder: _getInputBorder(color: focusedBorderColor ?? context.colorScheme.primary),
            ),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }

  InputBorder _getInputBorder({required Color color}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimens.radius),
    borderSide: BorderSide(color: color, width: 1),
  );
}
