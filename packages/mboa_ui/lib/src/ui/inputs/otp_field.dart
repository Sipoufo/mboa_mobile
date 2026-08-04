import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Segmented one-time-code entry — a row of [length] boxes backed by a single
/// hidden text field, so the platform keyboard, paste and autofill all work
/// with no third-party dependency.
///
/// [onCompleted] fires once every box is filled.
class OtpField extends StatefulWidget {
  const OtpField({
    super.key,
    required this.controller,
    this.length = 6,
    this.enabled = true,
    this.autofocus = true,
    this.onChanged,
    this.onCompleted,
  });

  final TextEditingController controller;
  final int length;
  final bool enabled;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  void _onChanged(String value) {
    widget.onChanged?.call(value);
    if (value.length == widget.length) {
      widget.onCompleted?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) => _Boxes(
            value: widget.controller.text,
            length: widget.length,
            hasFocus: _focusNode.hasFocus,
            enabled: widget.enabled,
          ),
        ),
        // The real field sits on top, fully transparent: it captures taps
        // (to focus), keystrokes, paste and autofill, while the boxes below
        // render the value.
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              showCursor: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
              onChanged: _onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _Boxes extends StatelessWidget {
  const _Boxes({
    required this.value,
    required this.length,
    required this.hasFocus,
    required this.enabled,
  });

  final String value;
  final int length;
  final bool hasFocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Row(
      spacing: Dimens.spacingSm,
      children: List.generate(length, (index) {
        final filled = index < value.length;
        final isActive = enabled && hasFocus && index == value.length;
        final borderColor = isActive
            ? colors.primary
            : filled
                ? colors.primaryLight
                : colors.border;

        return Expanded(
          child: AspectRatio(
            aspectRatio: 0.82,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surfaceWarm,
                borderRadius: BorderRadius.circular(Dimens.radius),
                border: Border.all(
                  color: borderColor,
                  width: isActive ? 2 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  filled ? value[index] : '',
                  style: context.mboaText.h2.copyWith(color: colors.ink),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
