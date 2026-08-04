import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

class StackedLoaderView extends StatefulWidget {
  const StackedLoaderView({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingText,
    this.barrierColor = Colors.black54,
    this.animationDuration = const Duration(milliseconds: 150),
    this.customLoader,
    this.loadingTextStyle,
  });

  /// Whether to show the loading overlay
  final bool isLoading;

  /// The child widget that will be displayed behind the loading overlay
  final Widget child;

  /// Optional custom loading text. If null, uses the default localized text
  final String? loadingText;

  /// Color of the barrier behind the loading dialog
  final Color barrierColor;

  /// Duration of the show/hide animation
  final Duration animationDuration;

  /// Optional custom loader widget. If null, uses the default CircularProgressIndicator
  final Widget? customLoader;

  /// Optional custom text style for the loading text
  final TextStyle? loadingTextStyle;

  @override
  State<StackedLoaderView> createState() => _StackedLoaderViewState();
}

class _StackedLoaderViewState extends State<StackedLoaderView> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    if (widget.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    }
  }

  @override
  void didUpdateWidget(StackedLoaderView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
      } else {
        _hideOverlay();
      }
    } else if (widget.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry?.markNeedsBuild();
      });
    }
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: ModalBarrier(dismissible: false, color: widget.barrierColor),
          ),
          Center(
            child: _LoaderWidget(
              loadingText: widget.loadingText,
              customLoader: widget.customLoader,
              loadingTextStyle: widget.loadingTextStyle,
            ),
          ),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(absorbing: widget.isLoading, child: widget.child);
  }
}

@immutable
class _LoaderWidget extends StatelessWidget {
  const _LoaderWidget({
    this.loadingText,
    this.customLoader,
    this.loadingTextStyle,
  });

  final String? loadingText;
  final Widget? customLoader;
  final TextStyle? loadingTextStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
        decoration: BoxDecoration(
          color: context.mboaColors.surface,
          borderRadius: BorderRadius.circular(Dimens.radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: Dimens.spacing,
                children: [
                  customLoader ?? const Loader(),
                  Flexible(
                    child: Text(
                      loadingText ?? I18n.of(context).loadingDialog_content,
                      style:
                          loadingTextStyle ??
                          context.mboaText.body.copyWith(
                            color: context.mboaColors.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
