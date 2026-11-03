import 'package:flutter/widgets.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/push_message.dart';

/// A push that arrives with the app open — the OS draws nothing then — said
/// as a toast in its colour (§40 E): a refusal in red, an approval in green,
/// the rest neutral. Nothing to say without a title.
void showForegroundPush(BuildContext context, PushMessage message) {
  final title = message.title;
  if (title == null || title.isEmpty) return;

  switch (message.outcome) {
    case NotificationOutcome.negative:
      MboaToast.error(context: context, title: title, description: message.body);
    case NotificationOutcome.positive:
      MboaToast.success(context: context, title: title, description: message.body);
    case NotificationOutcome.none:
      MboaToast.info(context: context, title: title, description: message.body);
  }
}
