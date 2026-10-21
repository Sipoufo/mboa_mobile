import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The founder's inbox timeline: items by day, newest day first, the date on
/// the left and a dotted line down to the next day. An item without a date
/// goes last.
///
/// Shared by the inboxes (M29 requests, M30 declared payments) so they read
/// as one family.
class DayTimeline<T> extends StatelessWidget {
  const DayTimeline({super.key, required this.items, required this.dayOf, required this.itemBuilder});

  final List<T> items;
  final DateTime? Function(T item) dayOf;
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final days = _byDay();
    return Column(
      children: [
        for (final (index, day) in days.indexed)
          _Day(
            day: day.$1,
            last: index == days.length - 1,
            children: [for (final item in day.$2) itemBuilder(item)],
          ),
      ],
    );
  }

  List<(DateTime?, List<T>)> _byDay() {
    final days = <DateTime?, List<T>>{};
    for (final item in items) {
      final at = dayOf(item);
      days.putIfAbsent(at == null ? null : DateTime(at.year, at.month, at.day), () => []).add(item);
    }
    final keys = days.keys.toList()..sort((a, b) => a == null ? 1 : (b == null ? -1 : b.compareTo(a)));
    return [for (final k in keys) (k, days[k]!)];
  }
}

/// One day of the timeline: the date, the dotted line, the day's items.
class _Day extends StatelessWidget {
  const _Day({required this.day, required this.children, required this.last});

  final DateTime? day;
  final List<Widget> children;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final day = this.day;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                if (day != null) ...[
                  Text(DateFormat.d(locale).format(day), style: context.mboaText.h2.copyWith(color: colors.primaryDark)),
                  Text(
                    DateFormat.MMM(locale).format(day),
                    style: context.mboaText.caption.copyWith(color: colors.primaryDark),
                  ),
                ],
                const SizedBox(height: Dimens.spacingXs),
                if (!last) Expanded(child: CustomPaint(painter: _DottedLine(colors.primaryDark.withValues(alpha: 0.5)))),
              ],
            ),
          ),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              children: [
                ...children,
                if (!last) const SizedBox(height: Dimens.spacingSm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedLine extends CustomPainter {
  const _DottedLine(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    for (var y = 2.0; y < size.height; y += 6) {
      canvas.drawLine(Offset(size.width / 2, y), Offset(size.width / 2, y + 2.5), paint);
    }
  }

  @override
  bool shouldRepaint(_DottedLine old) => old.color != color;
}
