import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/inbox_bloc.dart';

/// The bell, and how many notifications are unread (§38). Asks for the count
/// each time it is built anew — on each return to the home screen.
class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key, required this.bloc, required this.onPressed, this.builder});

  /// The session's one instance, passed in: the home screens that carry the
  /// bell do not all sit under a provider of it.
  final InboxBloc bloc;
  final VoidCallback onPressed;

  /// The button around the icon, as the screen draws its own; a plain
  /// [IconButton] otherwise.
  final Widget Function(BuildContext context, Widget icon, VoidCallback onPressed)? builder;

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(const InboxUnreadCountRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<InboxBloc, InboxState>(
      bloc: widget.bloc,
      buildWhen: (previous, current) => previous.unread != current.unread,
      builder: (context, state) {
        final icon = Badge(
          isLabelVisible: state.unread > 0,
          backgroundColor: colors.action,
          label: Text(state.unread > 99 ? '99+' : '${state.unread}'),
          child: Icon(LucideIcons.bell, color: colors.primary, size: Dimens.iconMd),
        );
        return Semantics(
          label: l10n.notificationsBellLabel(state.unread),
          button: true,
          excludeSemantics: true,
          child: widget.builder?.call(context, icon, widget.onPressed) ??
              IconButton(tooltip: l10n.menuNotifications, onPressed: widget.onPressed, icon: icon),
        );
      },
    );
  }
}
