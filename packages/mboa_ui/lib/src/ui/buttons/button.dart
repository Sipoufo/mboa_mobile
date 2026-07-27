import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

enum ButtonType { primary, onSurface, secondary, custom, outline }

class Button extends StatelessWidget {
  const Button._({
    super.key,
    required this.title,
    this.onPressed,
    required this.type,
    this.icon,
    this.iconAlignment = IconAlignment.end,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.isLoading = false,
    this.isCenter = false,
    this.borderRadius,
    this.height,
  });

  factory Button.primary({
    Key? key,
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    IconAlignment iconAlignment = IconAlignment.end,
    TextStyle? textStyle,
    bool isLoading = false,
    bool isCenter = false,
    double? height,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      onPressed: onPressed,
      type: ButtonType.primary,
      iconAlignment: iconAlignment,
      textStyle: textStyle,
      isLoading: isLoading,
      isCenter: isCenter,
      height: height,
    );
  }

  factory Button.secondary({
    Key? key,
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    IconAlignment iconAlignment = IconAlignment.end,
    TextStyle? textStyle,
    bool isLoading = false,
    bool isCenter = false,
    double? height,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      onPressed: onPressed,
      type: ButtonType.secondary,
      iconAlignment: iconAlignment,
      textStyle: textStyle,
      isLoading: isLoading,
      isCenter: isCenter,
      height: height,
    );
  }

  factory Button.custom({
    Key? key,
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    IconAlignment iconAlignment = IconAlignment.end,
    TextStyle? textStyle,
    BorderRadiusGeometry? borderRadius,
    bool isLoading = false,
    bool isCenter = false,
    double? height,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      onPressed: onPressed,
      type: ButtonType.custom,
      iconAlignment: iconAlignment,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textStyle: textStyle,
      isLoading: isLoading,
      isCenter: isCenter,
      borderRadius: borderRadius,
      height: height,
    );
  }

  factory Button.outline({
    Key? key,
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    IconAlignment iconAlignment = IconAlignment.end,
    TextStyle? textStyle,
    bool isLoading = false,
    bool isCenter = false,
    double? height,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      onPressed: onPressed,
      type: ButtonType.outline,
      iconAlignment: iconAlignment,
      textStyle: textStyle,
      isLoading: isLoading,
      isCenter: isCenter,
      height: height,
    );
  }

  factory Button.onSurface({
    Key? key,
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    IconAlignment iconAlignment = IconAlignment.end,
    TextStyle? textStyle,
    bool isLoading = false,
    double? height,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      onPressed: onPressed,
      type: ButtonType.onSurface,
      iconAlignment: iconAlignment,
      textStyle: textStyle,
      isLoading: isLoading,
      height: height,
    );
  }

  final String title;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconAlignment iconAlignment;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isCenter;
  final BorderRadiusGeometry? borderRadius;
  final double? height;

  Color _getTextColor(BuildContext context) {
    return switch (type) {
      ButtonType.primary || ButtonType.secondary => context.mboaColors.surface,
      ButtonType.onSurface => context.mboaColors.primary,
      ButtonType.custom || ButtonType.outline => textColor ?? context.mboaColors.primary,
    };
  }

  Color _getBackgroundColor(BuildContext context) {
    return switch (type) {
      ButtonType.onSurface => context.mboaColors.surface,
      ButtonType.primary => context.mboaColors.primary,
      ButtonType.custom => backgroundColor ?? Colors.transparent,
      ButtonType.secondary => context.mboaColors.primaryLight,
      ButtonType.outline => Colors.transparent,
    };
  }

  BorderSide _getBorderSide(BuildContext context) {
    return switch (type) {
      ButtonType.outline => BorderSide(color: context.mboaColors.primary, width: 1),
      _ => BorderSide.none,
    };
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      alignment: icon == null ? Alignment.center : null,
      iconAlignment: iconAlignment,
      padding: icon != null ? const EdgeInsets.symmetric(horizontal: Dimens.spacing) : null,
      fixedSize: Size.fromHeight(height ?? Dimens.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(Dimens.radius),
        side: _getBorderSide(context),
      ),
      backgroundColor: _getBackgroundColor(context),
    );
  }

  Widget _buildLabel(BuildContext context) {
    final defaultStyle = context.mboaText.label.copyWith(
      fontWeight: FontWeight.w700,
      color: _getTextColor(context),
    );

    return Text(title, style: textStyle != null ? defaultStyle.merge(textStyle) : defaultStyle);
  }

  @override
  Widget build(BuildContext context) {
    final label = _buildLabel(context);
    final style = _getButtonStyle(context);

    return SizedBox(
      width: double.infinity,
      child: icon == null
          ? ElevatedButton(onPressed: onPressed, style: style, child: label)
          : ElevatedButton(
              onPressed: onPressed,
              style: style,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Dimens.spacingSm,
                children: iconAlignment == IconAlignment.start
                    ? [icon!, Flexible(child: label)]
                    : [Expanded(flex: isCenter ? 0 : 1, child: label), icon!],
              ),
            ),
    );
  }
}
