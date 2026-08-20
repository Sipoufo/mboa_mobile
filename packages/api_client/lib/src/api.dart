//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:api_client/src/serializers.dart';
import 'package:api_client/src/auth/api_key_auth.dart';
import 'package:api_client/src/auth/basic_auth.dart';
import 'package:api_client/src/auth/bearer_auth.dart';
import 'package:api_client/src/auth/oauth.dart';
import 'package:api_client/src/api/account_api.dart';
import 'package:api_client/src/api/admin_annonces_api.dart';
import 'package:api_client/src/api/admin_contrats_api.dart';
import 'package:api_client/src/api/admin_kyc_api.dart';
import 'package:api_client/src/api/admin_modration_api.dart';
import 'package:api_client/src/api/admin_subscriptions_api.dart';
import 'package:api_client/src/api/admin_type_change_api.dart';
import 'package:api_client/src/api/admin_utilisateurs_api.dart';
import 'package:api_client/src/api/agent_api.dart';
import 'package:api_client/src/api/agent_assignations_api.dart';
import 'package:api_client/src/api/agent_candidatures_api.dart';
import 'package:api_client/src/api/agent_visites_api.dart';
import 'package:api_client/src/api/annonces_api.dart';
import 'package:api_client/src/api/assignation_agent_api.dart';
import 'package:api_client/src/api/assignation_agent_rsidence_api.dart';
import 'package:api_client/src/api/authentication_api.dart';
import 'package:api_client/src/api/avis_rsident_api.dart';
import 'package:api_client/src/api/contrats_api.dart';
import 'package:api_client/src/api/current_user_api.dart';
import 'package:api_client/src/api/favoris_api.dart';
import 'package:api_client/src/api/historique_api.dart';
import 'package:api_client/src/api/kyc_api.dart';
import 'package:api_client/src/api/locations_api.dart';
import 'package:api_client/src/api/media_api.dart';
import 'package:api_client/src/api/messagerie_api.dart';
import 'package:api_client/src/api/notification_devices_api.dart';
import 'package:api_client/src/api/password_api.dart';
import 'package:api_client/src/api/phone_change_api.dart';
import 'package:api_client/src/api/prestataire_profile_api.dart';
import 'package:api_client/src/api/prestataire_visites_api.dart';
import 'package:api_client/src/api/residences_api.dart';
import 'package:api_client/src/api/search_api.dart';
import 'package:api_client/src/api/signalements_api.dart';
import 'package:api_client/src/api/subscriptions_api.dart';
import 'package:api_client/src/api/user_profile_api.dart';
import 'package:api_client/src/api/user_settings_api.dart';
import 'package:api_client/src/api/visites_api.dart';
import 'package:api_client/src/api/visites_avis_api.dart';
import 'package:api_client/src/api/visites_prsence_api.dart';

class ApiClient {
  static const String basePath = r'https://api.mboa.cm/api/v1';

  final Dio dio;
  final Serializers serializers;

  ApiClient({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  /// Removes the OAuth token associated with the given [name].
  ///
  /// If no [OAuthInterceptor] is registered or no token exists for the given
  /// [name], this method has no effect.
  void removeOAuthToken(String name) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens.remove(name);
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  /// Removes the bearer authentication token associated with the given [name].
  ///
  /// If no [BearerAuthInterceptor] is registered or no token exists for the
  /// given [name], this method has no effect.
  void removeBearerAuth(String name) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens.remove(name);
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  /// Removes the basic authentication credentials associated with the given [name].
  ///
  /// If no [BasicAuthInterceptor] is registered or no credentials exist for the
  /// given [name], this method has no effect.
  void removeBasicAuth(String name) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo.remove(name);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Removes the API key associated with the given [name].
  ///
  /// If no [ApiKeyAuthInterceptor] is registered or no API key exists for the
  /// given [name], this method has no effect.
  void removeApiKey(String name) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys.remove(name);
    }
  }

  /// Get AccountApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AccountApi getAccountApi() {
    return AccountApi(dio, serializers);
  }

  /// Get AdminAnnoncesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminAnnoncesApi getAdminAnnoncesApi() {
    return AdminAnnoncesApi(dio, serializers);
  }

  /// Get AdminContratsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminContratsApi getAdminContratsApi() {
    return AdminContratsApi(dio, serializers);
  }

  /// Get AdminKYCApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminKYCApi getAdminKYCApi() {
    return AdminKYCApi(dio, serializers);
  }

  /// Get AdminModrationApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminModrationApi getAdminModrationApi() {
    return AdminModrationApi(dio, serializers);
  }

  /// Get AdminSubscriptionsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminSubscriptionsApi getAdminSubscriptionsApi() {
    return AdminSubscriptionsApi(dio, serializers);
  }

  /// Get AdminTypeChangeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminTypeChangeApi getAdminTypeChangeApi() {
    return AdminTypeChangeApi(dio, serializers);
  }

  /// Get AdminUtilisateursApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminUtilisateursApi getAdminUtilisateursApi() {
    return AdminUtilisateursApi(dio, serializers);
  }

  /// Get AgentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AgentApi getAgentApi() {
    return AgentApi(dio, serializers);
  }

  /// Get AgentAssignationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AgentAssignationsApi getAgentAssignationsApi() {
    return AgentAssignationsApi(dio, serializers);
  }

  /// Get AgentCandidaturesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AgentCandidaturesApi getAgentCandidaturesApi() {
    return AgentCandidaturesApi(dio, serializers);
  }

  /// Get AgentVisitesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AgentVisitesApi getAgentVisitesApi() {
    return AgentVisitesApi(dio, serializers);
  }

  /// Get AnnoncesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AnnoncesApi getAnnoncesApi() {
    return AnnoncesApi(dio, serializers);
  }

  /// Get AssignationAgentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AssignationAgentApi getAssignationAgentApi() {
    return AssignationAgentApi(dio, serializers);
  }

  /// Get AssignationAgentRsidenceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AssignationAgentRsidenceApi getAssignationAgentRsidenceApi() {
    return AssignationAgentRsidenceApi(dio, serializers);
  }

  /// Get AuthenticationApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthenticationApi getAuthenticationApi() {
    return AuthenticationApi(dio, serializers);
  }

  /// Get AvisRsidentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AvisRsidentApi getAvisRsidentApi() {
    return AvisRsidentApi(dio, serializers);
  }

  /// Get ContratsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ContratsApi getContratsApi() {
    return ContratsApi(dio, serializers);
  }

  /// Get CurrentUserApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  CurrentUserApi getCurrentUserApi() {
    return CurrentUserApi(dio, serializers);
  }

  /// Get FavorisApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FavorisApi getFavorisApi() {
    return FavorisApi(dio, serializers);
  }

  /// Get HistoriqueApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HistoriqueApi getHistoriqueApi() {
    return HistoriqueApi(dio, serializers);
  }

  /// Get KYCApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  KYCApi getKYCApi() {
    return KYCApi(dio, serializers);
  }

  /// Get LocationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  LocationsApi getLocationsApi() {
    return LocationsApi(dio, serializers);
  }

  /// Get MediaApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MediaApi getMediaApi() {
    return MediaApi(dio, serializers);
  }

  /// Get MessagerieApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MessagerieApi getMessagerieApi() {
    return MessagerieApi(dio, serializers);
  }

  /// Get NotificationDevicesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationDevicesApi getNotificationDevicesApi() {
    return NotificationDevicesApi(dio, serializers);
  }

  /// Get PasswordApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PasswordApi getPasswordApi() {
    return PasswordApi(dio, serializers);
  }

  /// Get PhoneChangeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PhoneChangeApi getPhoneChangeApi() {
    return PhoneChangeApi(dio, serializers);
  }

  /// Get PrestataireProfileApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PrestataireProfileApi getPrestataireProfileApi() {
    return PrestataireProfileApi(dio, serializers);
  }

  /// Get PrestataireVisitesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PrestataireVisitesApi getPrestataireVisitesApi() {
    return PrestataireVisitesApi(dio, serializers);
  }

  /// Get ResidencesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ResidencesApi getResidencesApi() {
    return ResidencesApi(dio, serializers);
  }

  /// Get SearchApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SearchApi getSearchApi() {
    return SearchApi(dio, serializers);
  }

  /// Get SignalementsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SignalementsApi getSignalementsApi() {
    return SignalementsApi(dio, serializers);
  }

  /// Get SubscriptionsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SubscriptionsApi getSubscriptionsApi() {
    return SubscriptionsApi(dio, serializers);
  }

  /// Get UserProfileApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UserProfileApi getUserProfileApi() {
    return UserProfileApi(dio, serializers);
  }

  /// Get UserSettingsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UserSettingsApi getUserSettingsApi() {
    return UserSettingsApi(dio, serializers);
  }

  /// Get VisitesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  VisitesApi getVisitesApi() {
    return VisitesApi(dio, serializers);
  }

  /// Get VisitesAvisApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  VisitesAvisApi getVisitesAvisApi() {
    return VisitesAvisApi(dio, serializers);
  }

  /// Get VisitesPrsenceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  VisitesPrsenceApi getVisitesPrsenceApi() {
    return VisitesPrsenceApi(dio, serializers);
  }
}
