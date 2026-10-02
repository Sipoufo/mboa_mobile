import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// The tenant's threads (CDC M12).
///
/// Needs an account, like favourites: the list itself would be empty for a
/// visitor, and an empty list reads as a broken screen rather than as an
/// invitation.
@RoutePage()
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
    if (getIt<SessionSnapshot>().hasSession) {
      context.read<ConversationsBloc>().add(const ConversationsLoadRequested());
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        // Same reason as the favourites tab: the shell is not rebuilt by a
        // sign-in, so the session has to be listened to rather than read once.
        listenable: getIt<SessionSnapshot>(),
        builder: (context, _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.messagingTitle)),
      body: !getIt<SessionSnapshot>().hasSession
          ? _SignInPrompt()
          : ConversationsView(
              // RM-M12-01 — the tenant has the first word, and it is said from
              // a listing's fiche.
              emptyBody: l10n.messagingEmptyTenant,
              onOpen: (conversation) => context.router.push(
                ThreadRoute(conversation: conversation),
              ),
            ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.messageSquare,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.messagingEmptyTitle,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.messagingEmptyTenant,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacingLg),
            Button.primary(
              title: l10n.accountSignIn,
              onPressed: () => context.router.root.push(LoginRoute()),
            ),
          ],
        ),
      ),
    );
  }
}

/// One thread. The view is shared; this route supplies the app's uploader and
/// the conversation to open.
@RoutePage()
class ThreadPage extends StatelessWidget implements AutoRouteWrapper {
  const ThreadPage({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ThreadBloc>(
        create: (_) =>
            getIt<ThreadBloc>()..add(ThreadRequested(conversation)),
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
            // RM-M12-02 — which property this thread is about.
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
