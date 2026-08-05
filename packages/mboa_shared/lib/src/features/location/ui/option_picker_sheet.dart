import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/city_option.dart';

/// A searchable single-choice sheet over an already-loaded list.
///
/// The city picker fetches its own data; districts are fetched by the caller
/// (they depend on the chosen city), so this takes the options directly.
Future<CityOption?> showOptionPicker(
  BuildContext context, {
  required String title,
  required List<CityOption> options,
}) {
  return showModalBottomSheet<CityOption>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.mboaColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
    ),
    builder: (context) => _OptionPickerSheet(title: title, options: options),
  );
}

class _OptionPickerSheet extends StatefulWidget {
  const _OptionPickerSheet({required this.title, required this.options});

  final String title;
  final List<CityOption> options;

  @override
  State<_OptionPickerSheet> createState() => _OptionPickerSheetState();
}

class _OptionPickerSheetState extends State<_OptionPickerSheet> {
  late List<CityOption> _visible = widget.options;

  void _filter(String query) {
    final needle = query.trim().toLowerCase();
    setState(() {
      _visible = needle.isEmpty
          ? widget.options
          : widget.options
              .where((o) => o.name.toLowerCase().contains(needle))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, controller) => Padding(
        padding: const EdgeInsets.all(Dimens.spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: context.mboaText.h3),
            const SizedBox(height: Dimens.spacingMd),
            TextField(
              onChanged: _filter,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: Dimens.spacingSm),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: _visible.length,
                itemBuilder: (context, index) {
                  final option = _visible[index];
                  return ListTile(
                    title: Text(option.name),
                    onTap: () => Navigator.of(context).pop(option),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
