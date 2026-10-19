// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i32;
import 'package:flutter/material.dart' as _i33;
import 'package:mboa_shared/mboa_shared.dart' as _i34;
import 'package:mboa_user/app/router/wrappers/authenticated_wrapper.dart'
    as _i2;
import 'package:mboa_user/features/auth/ui/login_page.dart' as _i9;
import 'package:mboa_user/features/auth/ui/otp_page.dart' as _i17;
import 'package:mboa_user/features/contracts/ui/my_contract_detail_page.dart'
    as _i11;
import 'package:mboa_user/features/contracts/ui/my_contracts_page.dart' as _i12;
import 'package:mboa_user/features/contracts/ui/resident_review_page.dart'
    as _i21;
import 'package:mboa_user/features/favorites/ui/favorites_page.dart' as _i6;
import 'package:mboa_user/features/home/ui/home_page.dart' as _i7;
import 'package:mboa_user/features/listing/ui/listing_detail_page.dart' as _i8;
import 'package:mboa_user/features/listing/ui/residence_detail_page.dart'
    as _i20;
import 'package:mboa_user/features/messaging/ui/messages_page.dart' as _i10;
import 'package:mboa_user/features/profile/ui/change_phone_page.dart' as _i3;
import 'package:mboa_user/features/profile/ui/delete_account_page.dart' as _i4;
import 'package:mboa_user/features/profile/ui/edit_profile_page.dart' as _i5;
import 'package:mboa_user/features/profile/ui/notification_preferences_page.dart'
    as _i16;
import 'package:mboa_user/features/profile/ui/settings_menu_page.dart' as _i25;
import 'package:mboa_user/features/profile/ui/settings_page.dart' as _i26;
import 'package:mboa_user/features/reservations/models/reservation_draft.dart'
    as _i35;
import 'package:mboa_user/features/reservations/ui/my_reservations_page.dart'
    as _i13;
import 'package:mboa_user/features/reservations/ui/request_reservation_page.dart'
    as _i18;
import 'package:mboa_user/features/reservations/ui/reservation_detail_page.dart'
    as _i19;
import 'package:mboa_user/features/saved_searches/ui/saved_search_results_page.dart'
    as _i22;
import 'package:mboa_user/features/saved_searches/ui/saved_searches_page.dart'
    as _i23;
import 'package:mboa_user/features/search/ui/search_page.dart' as _i24;
import 'package:mboa_user/features/shell/ui/account_page.dart' as _i1;
import 'package:mboa_user/features/shell/ui/my_score_page.dart' as _i14;
import 'package:mboa_user/features/shell/ui/user_shell_page.dart' as _i28;
import 'package:mboa_user/features/splash/ui/splash_page.dart' as _i27;
import 'package:mboa_user/features/visits/ui/my_visits_page.dart' as _i15;
import 'package:mboa_user/features/visits/ui/visit_detail_page.dart' as _i29;
import 'package:mboa_user/features/visits/ui/write_review_page.dart' as _i31;
import 'package:mboa_user/features/welcome/ui/welcome_page.dart' as _i30;

/// generated route for
/// [_i1.AccountPage]
class AccountRoute extends _i32.PageRouteInfo<void> {
  const AccountRoute({List<_i32.PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i1.AccountPage());
    },
  );
}

/// generated route for
/// [_i2.AuthenticatedWrapper]
class AuthenticatedRouter extends _i32.PageRouteInfo<void> {
  const AuthenticatedRouter({List<_i32.PageRouteInfo>? children})
    : super(AuthenticatedRouter.name, initialChildren: children);

  static const String name = 'AuthenticatedRouter';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i2.AuthenticatedWrapper());
    },
  );
}

/// generated route for
/// [_i3.ChangePhonePage]
class ChangePhoneRoute extends _i32.PageRouteInfo<void> {
  const ChangePhoneRoute({List<_i32.PageRouteInfo>? children})
    : super(ChangePhoneRoute.name, initialChildren: children);

  static const String name = 'ChangePhoneRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePhonePage();
    },
  );
}

/// generated route for
/// [_i4.DeleteAccountPage]
class DeleteAccountRoute extends _i32.PageRouteInfo<void> {
  const DeleteAccountRoute({List<_i32.PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i4.DeleteAccountPage();
    },
  );
}

/// generated route for
/// [_i5.EditProfilePage]
class EditProfileRoute extends _i32.PageRouteInfo<void> {
  const EditProfileRoute({List<_i32.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i5.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i6.FavoritesPage]
class FavoritesRoute extends _i32.PageRouteInfo<void> {
  const FavoritesRoute({List<_i32.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i6.FavoritesPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i32.PageRouteInfo<void> {
  const HomeRoute({List<_i32.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.ListingDetailPage]
class ListingDetailRoute extends _i32.PageRouteInfo<ListingDetailRouteArgs> {
  ListingDetailRoute({
    _i33.Key? key,
    required String id,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ListingDetailRoute.name,
         args: ListingDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ListingDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ListingDetailRouteArgs>();
      return _i32.WrappedRoute(
        child: _i8.ListingDetailPage(key: args.key, id: args.id),
      );
    },
  );
}

class ListingDetailRouteArgs {
  const ListingDetailRouteArgs({this.key, required this.id});

  final _i33.Key? key;

  final String id;

  @override
  String toString() {
    return 'ListingDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i32.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i33.Key? key,
    _i34.AuthMode mode = _i34.AuthMode.login,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, mode: mode),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i9.LoginPage(key: args.key, mode: args.mode);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.mode = _i34.AuthMode.login});

  final _i33.Key? key;

  final _i34.AuthMode mode;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, mode: $mode}';
  }
}

/// generated route for
/// [_i10.MessagesPage]
class MessagesRoute extends _i32.PageRouteInfo<void> {
  const MessagesRoute({List<_i32.PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i10.MessagesPage();
    },
  );
}

/// generated route for
/// [_i11.MyContractDetailPage]
class MyContractDetailRoute
    extends _i32.PageRouteInfo<MyContractDetailRouteArgs> {
  MyContractDetailRoute({
    _i33.Key? key,
    required String id,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         MyContractDetailRoute.name,
         args: MyContractDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'MyContractDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyContractDetailRouteArgs>();
      return _i32.WrappedRoute(
        child: _i11.MyContractDetailPage(key: args.key, id: args.id),
      );
    },
  );
}

class MyContractDetailRouteArgs {
  const MyContractDetailRouteArgs({this.key, required this.id});

  final _i33.Key? key;

  final String id;

  @override
  String toString() {
    return 'MyContractDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i12.MyContractsPage]
class MyContractsRoute extends _i32.PageRouteInfo<void> {
  const MyContractsRoute({List<_i32.PageRouteInfo>? children})
    : super(MyContractsRoute.name, initialChildren: children);

  static const String name = 'MyContractsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i12.MyContractsPage());
    },
  );
}

/// generated route for
/// [_i13.MyReservationsPage]
class MyReservationsRoute extends _i32.PageRouteInfo<void> {
  const MyReservationsRoute({List<_i32.PageRouteInfo>? children})
    : super(MyReservationsRoute.name, initialChildren: children);

  static const String name = 'MyReservationsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i13.MyReservationsPage());
    },
  );
}

/// generated route for
/// [_i14.MyScorePage]
class MyScoreRoute extends _i32.PageRouteInfo<void> {
  const MyScoreRoute({List<_i32.PageRouteInfo>? children})
    : super(MyScoreRoute.name, initialChildren: children);

  static const String name = 'MyScoreRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i14.MyScorePage();
    },
  );
}

/// generated route for
/// [_i15.MyVisitsPage]
class MyVisitsRoute extends _i32.PageRouteInfo<void> {
  const MyVisitsRoute({List<_i32.PageRouteInfo>? children})
    : super(MyVisitsRoute.name, initialChildren: children);

  static const String name = 'MyVisitsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i15.MyVisitsPage());
    },
  );
}

/// generated route for
/// [_i16.NotificationPreferencesPage]
class NotificationPreferencesRoute extends _i32.PageRouteInfo<void> {
  const NotificationPreferencesRoute({List<_i32.PageRouteInfo>? children})
    : super(NotificationPreferencesRoute.name, initialChildren: children);

  static const String name = 'NotificationPreferencesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i16.NotificationPreferencesPage();
    },
  );
}

/// generated route for
/// [_i17.OtpPage]
class OtpRoute extends _i32.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    required _i34.OtpSession session,
    _i33.Key? key,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(session: session, key: key),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return _i17.OtpPage(session: args.session, key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({required this.session, this.key});

  final _i34.OtpSession session;

  final _i33.Key? key;

  @override
  String toString() {
    return 'OtpRouteArgs{session: $session, key: $key}';
  }
}

/// generated route for
/// [_i18.RequestReservationPage]
class RequestReservationRoute
    extends _i32.PageRouteInfo<RequestReservationRouteArgs> {
  RequestReservationRoute({
    _i33.Key? key,
    required _i35.ReservationListing listing,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         RequestReservationRoute.name,
         args: RequestReservationRouteArgs(key: key, listing: listing),
         initialChildren: children,
       );

  static const String name = 'RequestReservationRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestReservationRouteArgs>();
      return _i32.WrappedRoute(
        child: _i18.RequestReservationPage(
          key: args.key,
          listing: args.listing,
        ),
      );
    },
  );
}

class RequestReservationRouteArgs {
  const RequestReservationRouteArgs({this.key, required this.listing});

  final _i33.Key? key;

  final _i35.ReservationListing listing;

  @override
  String toString() {
    return 'RequestReservationRouteArgs{key: $key, listing: $listing}';
  }
}

/// generated route for
/// [_i19.ReservationDetailPage]
class ReservationDetailRoute
    extends _i32.PageRouteInfo<ReservationDetailRouteArgs> {
  ReservationDetailRoute({
    _i33.Key? key,
    required String id,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ReservationDetailRoute.name,
         args: ReservationDetailRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'ReservationDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ReservationDetailRouteArgs>(
        orElse: () =>
            ReservationDetailRouteArgs(id: pathParams.getString('id')),
      );
      return _i32.WrappedRoute(
        child: _i19.ReservationDetailPage(key: args.key, id: args.id),
      );
    },
  );
}

class ReservationDetailRouteArgs {
  const ReservationDetailRouteArgs({this.key, required this.id});

  final _i33.Key? key;

  final String id;

  @override
  String toString() {
    return 'ReservationDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i20.ResidenceDetailPage]
class ResidenceDetailRoute
    extends _i32.PageRouteInfo<ResidenceDetailRouteArgs> {
  ResidenceDetailRoute({
    _i33.Key? key,
    required String id,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ResidenceDetailRoute.name,
         args: ResidenceDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ResidenceDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResidenceDetailRouteArgs>();
      return _i20.ResidenceDetailPage(key: args.key, id: args.id);
    },
  );
}

class ResidenceDetailRouteArgs {
  const ResidenceDetailRouteArgs({this.key, required this.id});

  final _i33.Key? key;

  final String id;

  @override
  String toString() {
    return 'ResidenceDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i21.ResidentReviewPage]
class ResidentReviewRoute extends _i32.PageRouteInfo<ResidentReviewRouteArgs> {
  ResidentReviewRoute({
    _i33.Key? key,
    required String contractId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ResidentReviewRoute.name,
         args: ResidentReviewRouteArgs(key: key, contractId: contractId),
         initialChildren: children,
       );

  static const String name = 'ResidentReviewRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResidentReviewRouteArgs>();
      return _i32.WrappedRoute(
        child: _i21.ResidentReviewPage(
          key: args.key,
          contractId: args.contractId,
        ),
      );
    },
  );
}

class ResidentReviewRouteArgs {
  const ResidentReviewRouteArgs({this.key, required this.contractId});

  final _i33.Key? key;

  final String contractId;

  @override
  String toString() {
    return 'ResidentReviewRouteArgs{key: $key, contractId: $contractId}';
  }
}

/// generated route for
/// [_i22.SavedSearchResultsPage]
class SavedSearchResultsRoute
    extends _i32.PageRouteInfo<SavedSearchResultsRouteArgs> {
  SavedSearchResultsRoute({
    _i33.Key? key,
    required String id,
    String? name,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         SavedSearchResultsRoute.name,
         args: SavedSearchResultsRouteArgs(key: key, id: id, name: name),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'SavedSearchResultsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SavedSearchResultsRouteArgs>(
        orElse: () =>
            SavedSearchResultsRouteArgs(id: pathParams.getString('id')),
      );
      return _i32.WrappedRoute(
        child: _i22.SavedSearchResultsPage(
          key: args.key,
          id: args.id,
          name: args.name,
        ),
      );
    },
  );
}

class SavedSearchResultsRouteArgs {
  const SavedSearchResultsRouteArgs({this.key, required this.id, this.name});

  final _i33.Key? key;

  final String id;

  final String? name;

  @override
  String toString() {
    return 'SavedSearchResultsRouteArgs{key: $key, id: $id, name: $name}';
  }
}

/// generated route for
/// [_i23.SavedSearchesPage]
class SavedSearchesRoute extends _i32.PageRouteInfo<void> {
  const SavedSearchesRoute({List<_i32.PageRouteInfo>? children})
    : super(SavedSearchesRoute.name, initialChildren: children);

  static const String name = 'SavedSearchesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i23.SavedSearchesPage());
    },
  );
}

/// generated route for
/// [_i24.SearchPage]
class SearchRoute extends _i32.PageRouteInfo<void> {
  const SearchRoute({List<_i32.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i24.SearchPage());
    },
  );
}

/// generated route for
/// [_i25.SettingsMenuPage]
class SettingsMenuRoute extends _i32.PageRouteInfo<void> {
  const SettingsMenuRoute({List<_i32.PageRouteInfo>? children})
    : super(SettingsMenuRoute.name, initialChildren: children);

  static const String name = 'SettingsMenuRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i25.SettingsMenuPage();
    },
  );
}

/// generated route for
/// [_i26.SettingsPage]
class SettingsRoute extends _i32.PageRouteInfo<void> {
  const SettingsRoute({List<_i32.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i26.SettingsPage();
    },
  );
}

/// generated route for
/// [_i27.SplashPage]
class SplashRoute extends _i32.PageRouteInfo<void> {
  const SplashRoute({List<_i32.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i27.SplashPage());
    },
  );
}

/// generated route for
/// [_i10.ThreadPage]
class ThreadRoute extends _i32.PageRouteInfo<ThreadRouteArgs> {
  ThreadRoute({
    _i33.Key? key,
    required _i34.Conversation conversation,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ThreadRoute.name,
         args: ThreadRouteArgs(key: key, conversation: conversation),
         initialChildren: children,
       );

  static const String name = 'ThreadRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ThreadRouteArgs>();
      return _i32.WrappedRoute(
        child: _i10.ThreadPage(key: args.key, conversation: args.conversation),
      );
    },
  );
}

class ThreadRouteArgs {
  const ThreadRouteArgs({this.key, required this.conversation});

  final _i33.Key? key;

  final _i34.Conversation conversation;

  @override
  String toString() {
    return 'ThreadRouteArgs{key: $key, conversation: $conversation}';
  }
}

/// generated route for
/// [_i28.UserShellPage]
class UserShellRoute extends _i32.PageRouteInfo<void> {
  const UserShellRoute({List<_i32.PageRouteInfo>? children})
    : super(UserShellRoute.name, initialChildren: children);

  static const String name = 'UserShellRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return _i32.WrappedRoute(child: const _i28.UserShellPage());
    },
  );
}

/// generated route for
/// [_i29.VisitDetailPage]
class VisitDetailRoute extends _i32.PageRouteInfo<VisitDetailRouteArgs> {
  VisitDetailRoute({
    _i33.Key? key,
    required String visitId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         VisitDetailRoute.name,
         args: VisitDetailRouteArgs(key: key, visitId: visitId),
         initialChildren: children,
       );

  static const String name = 'VisitDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VisitDetailRouteArgs>();
      return _i32.WrappedRoute(
        child: _i29.VisitDetailPage(key: args.key, visitId: args.visitId),
      );
    },
  );
}

class VisitDetailRouteArgs {
  const VisitDetailRouteArgs({this.key, required this.visitId});

  final _i33.Key? key;

  final String visitId;

  @override
  String toString() {
    return 'VisitDetailRouteArgs{key: $key, visitId: $visitId}';
  }
}

/// generated route for
/// [_i30.WelcomePage]
class WelcomeRoute extends _i32.PageRouteInfo<void> {
  const WelcomeRoute({List<_i32.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i30.WelcomePage();
    },
  );
}

/// generated route for
/// [_i31.WriteReviewPage]
class WriteReviewRoute extends _i32.PageRouteInfo<WriteReviewRouteArgs> {
  WriteReviewRoute({
    _i33.Key? key,
    required String visitId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         WriteReviewRoute.name,
         args: WriteReviewRouteArgs(key: key, visitId: visitId),
         initialChildren: children,
       );

  static const String name = 'WriteReviewRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WriteReviewRouteArgs>();
      return _i32.WrappedRoute(
        child: _i31.WriteReviewPage(key: args.key, visitId: args.visitId),
      );
    },
  );
}

class WriteReviewRouteArgs {
  const WriteReviewRouteArgs({this.key, required this.visitId});

  final _i33.Key? key;

  final String visitId;

  @override
  String toString() {
    return 'WriteReviewRouteArgs{key: $key, visitId: $visitId}';
  }
}
