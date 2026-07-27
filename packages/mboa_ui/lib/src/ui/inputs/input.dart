import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeney/src/core/i18n/l10n.dart';
import 'package:zeney/src/core/theme/dimens.dart';
import 'package:zeney/src/shared/foundation/extensions/context_extensions.dart';

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
    final Color effectiveBorderColor = borderColor ?? context.zeneyColorScheme.black100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text.rich(
            TextSpan(
              text: labelText!,
              style: context.zeneyTextTheme.textBase.copyWith(
                fontWeight: FontWeight.w700,
                color: context.zeneyColorScheme.black500,
              ),
              children: [
                if (labelSuffix != null) ...[
                  TextSpan(
                    text: ' ($labelSuffix)',
                    style: context.zeneyTextTheme.textXs.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
                if (optional) ...[
                  TextSpan(
                    text: ' ${I18n.of(context).formInput_optional_suffix}',
                    style: context.zeneyTextTheme.textBase.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: Dimens.minSpacing),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.radius),
          child: TextFormField(
            onTap: onTap,
            autofillHints: autofillHints,
            inputFormatters: inputFormatters,
            controller: controller,
            obscureText: isPassword,
            cursorColor: cursorColor ?? context.zeneyColorScheme.black500,
            readOnly: readOnly,
            focusNode: focusNode,
            maxLength: maxLength,
            style: style ?? context.zeneyTextTheme.textBase.copyWith(fontWeight: FontWeight.w500),
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
                  context.zeneyTextTheme.textSm.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.zeneyColorScheme.black300,
                  ),
              counter: showCounter ? null : const SizedBox(),
              filled: filled,
              errorMaxLines: 2,
              fillColor: fillColor ?? context.colorScheme.surface,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabled: enabled,
              contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: 18),
              errorBorder: _getInputBorder(color: context.zeneyColorScheme.red600),
              enabledBorder: _getInputBorder(color: effectiveBorderColor),
              border: _getInputBorder(color: effectiveBorderColor),
              focusedErrorBorder: _getInputBorder(color: context.zeneyColorScheme.red600),
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
