import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Severity of a [MboaToast], driving its icon and accent colour.
enum ToastType { success, error, warning, info }

/// Lightweight overlay notifications — a title + description card that slides in
/// from the top and auto-dismisses. Adapted from Zeney's toast, restyled with
/// Mboa's design tokens.
///
/// ```dart
/// MboaToast.error(context: context, title: 'Erreur', description: '…');
/// ```
abstract final class MboaToast {
  static const Duration _defaultDuration = Duration(seconds: 4);

  static void success({
    required BuildContext context,
    required String title,
    String? description,
    Duration duration = _defaultDuration,
  }) =>
      _show(context, title, description, ToastType.success, duration);

  static void error({
    required BuildContext context,
    required String title,
    String? description,
    Duration duration = _defaultDuration,
  }) =>
      _show(context, title, description, ToastType.error, duration);

  static void warning({
    required BuildContext context,
    required String title,
    String? description,
    Duration duration = _defaultDuration,
  }) =>
      _show(context, title, description, ToastType.warning, duration);

  static void info({
    required BuildContext context,
    required String title,
    String? description,
    Duration duration = _defaultDuration,
  }) =>
      _show(context, title, description, ToastType.info, duration);

  static void _show(
    BuildContext context,
    String title,
    String? description,
    ToastType type,
    Duration duration,
  ) {
    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _ToastAnimator(
        duration: duration,
        onDismiss: entry.remove,
        childBuilder: (context, onClose) => _ToastCard(
          title: title,
          description: description,
          type: type,
          onClose: onClose,
        ),
      ),
    );
    overlay.insert(entry);
  }
}

class _ToastAnimator extends StatefulWidget {
  const _ToastAnimator({
    required this.duration,
    required this.onDismiss,
    required this.childBuilder,
  });

  final Duration duration;
  final VoidCallback onDismiss;
  final Widget Function(BuildContext, VoidCallback) childBuilder;

  @override
  State<_ToastAnimator> createState() => _ToastAnimatorState();
}

class _ToastAnimatorState extends State<_ToastAnimator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<double> _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(widget.duration, _close);
  }

  void _close() {
    _timer?.cancel();
    if (mounted) _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: SlideTransition(
            position: _slide,
            child: FadeTransition(
              opacity: _fade,
              child: Material(
                color: Colors.transparent,
                child: widget.childBuilder(context, _close),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({
    required this.title,
    required this.description,
    required this.type,
    required this.onClose,
  });

  final String title;
  final String? description;
  final ToastType type;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final (icon, accent) = switch (type) {
      ToastType.success => (LucideIcons.circleCheck, colors.success),
      ToastType.error => (LucideIcons.circleX, colors.error),
      ToastType.warning => (LucideIcons.triangleAlert, colors.warning),
      ToastType.info => (LucideIcons.info, colors.info),
    };

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        boxShadow: [
          BoxShadow(
            color: colors.ink.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimens.avatar,
            height: Dimens.avatar,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Dimens.radius),
            ),
            child: Icon(icon, color: accent, size: Dimens.iconMd),
          ),
          const SizedBox(width: Dimens.spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.mboaText.label.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.ink,
                  ),
                ),
                if (description != null && description!.isNotEmpty) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    description!,
                    style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: Dimens.spacingSm),
          GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.opaque,
            child: Icon(LucideIcons.x, size: Dimens.icon, color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
