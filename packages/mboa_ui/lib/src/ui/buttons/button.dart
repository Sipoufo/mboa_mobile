import 'package:flutter/material.dart';
import 'package:zeney/src/core/theme/dimens.dart';
import 'package:zeney/src/shared/ui/feedback/loader.dart';
import 'package:zeney/src/shared/foundation/extensions/context_extensions.dart';

enum ButtonType { primary, onSurface, secondary, custom, outline }

class Button extends StatelessWidget {
  const Button._({
    super.key,
    required this.title,
    this.onPressed,
    required this.type,
    this.icon,
    this.iconAligment = IconAlignment.end,
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
    IconAlignment iconAligment = IconAlignment.end,
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
      iconAligment: iconAligment,
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
    IconAlignment iconAligment = IconAlignment.end,
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
      iconAligment: iconAligment,
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
    IconAlignment iconAligment = IconAlignment.end,
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
      iconAligment: iconAligment,
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
    IconAlignment iconAligment = IconAlignment.end,
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
      iconAligment: iconAligment,
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
    IconAlignment iconAligment = IconAlignment.end,
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
      iconAligment: iconAligment,
      textStyle: textStyle,
      isLoading: isLoading,
      height: height,
    );
  }

  final String title;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconAlignment iconAligment;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isCenter;
  final BorderRadiusGeometry? borderRadius;
  final double? height;

  Color _getTextColor(BuildContext context) {
    return switch (type) {
      ButtonType.primary || ButtonType.secondary => context.zeneyColorScheme.foreground,
      ButtonType.onSurface => context.zeneyColorScheme.black500,
      ButtonType.custom || ButtonType.outline => textColor ?? Colors.black,
    };
  }

  Color _getBackgroundColor(BuildContext context) {
    return switch (type) {
      ButtonType.onSurface => context.zeneyColorScheme.foreground,
      ButtonType.primary => context.zeneyColorScheme.blue500,
      ButtonType.custom => backgroundColor ?? Colors.transparent,
      ButtonType.secondary => context.zeneyColorScheme.black500,
      ButtonType.outline => Colors.transparent,
    };
  }

  BorderSide _getBorderSide(BuildContext context) {
    return switch (type) {
      ButtonType.outline => BorderSide(color: context.zeneyColorScheme.black100, width: 1),
      _ => BorderSide.none,
    };
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      alignment: icon == null ? Alignment.center : null,
      iconAlignment: iconAligment,
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
    final defaultStyle = context.zeneyTextTheme.textBase.copyWith(
      fontWeight: FontWeight.w700,
      color: _getTextColor(context),
    );

    return Text(title, style: textStyle != null ? defaultStyle.merge(textStyle) : defaultStyle);
  }

  @override
  Widget build(BuildContext context) {
    final label = _buildLabel(context);
    final style = _getButtonStyle(context);
    final loadingIndicator = Loader.sm();

    return SizedBox(
      width: double.infinity,
      child: isLoading
          ? ElevatedButton(
              onPressed: null,
              style: style,
              child: loadingIndicator,
            )
          : icon == null
          ? ElevatedButton(onPressed: onPressed, style: style, child: label)
          : ElevatedButton(
              onPressed: onPressed,
              style: style,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Dimens.halfSpacing,
                children: iconAligment == IconAlignment.start
                    ? [icon!, Flexible(child: label)]
                    : [Expanded(flex: isCenter ? 0 : 1, child: label), icon!],
              ),
            ),
    );
  }
}
