import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// The prestataire's threads (CDC M12) — "Contacts reçus".
///
/// **There is no way to start one.** RM-M12-01 gives the tenant the first word
/// and `POST /conversations` is refused to a prestataire, so the screen says so
/// in its empty state rather than offering a button that would 403.
@RoutePage()
class MessagesPage extends StatefulWidget implements AutoRouteWrapper {
  const MessagesPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<ConversationsBloc>.value(
        value: getIt<ConversationsBloc>()
          ..add(const ConversationsLoadRequested()),
        child: this,
      );

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.messagingTitle)),
      body: ConversationsView(
        emptyBody: l10n.messagingEmptyProvider,
        onOpen: (conversation) =>
            context.router.push(ThreadRoute(conversation: conversation)),
      ),
    );
  }
}

/// One thread. The view is shared with the tenant app; only the uploader and
/// the route are this app's.
@RoutePage()
class ThreadPage extends StatelessWidget implements AutoRouteWrapper {
  const ThreadPage({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ThreadBloc>(
        create: (_) => getIt<ThreadBloc>()..add(ThreadRequested(conversation)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(conversation.peerName ?? ''),
            // RM-M12-02 — which listing the tenant is asking about.
            if (conversation.annonceTitle case final title?)
              Text(
                title,
                style: context.mboaText.caption.copyWith(color: colors.primary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
      body: ThreadView(uploader: getIt<MediaUploader>()),
    );
  }
}
