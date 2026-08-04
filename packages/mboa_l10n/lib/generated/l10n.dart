// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class I18n {
  I18n();

  static I18n? _current;

  static I18n get current {
    assert(
      _current != null,
      'No instance of I18n was loaded. Try to initialize the I18n delegate before accessing I18n.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I18n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I18n();
      I18n._current = instance;

      return instance;
    });
  }

  static I18n of(BuildContext context) {
    final instance = I18n.maybeOf(context);
    assert(
      instance != null,
      'No instance of I18n present in the widget tree. Did you add I18n.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static I18n? maybeOf(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  /// `Mboa`
  String get appName {
    return Intl.message('Mboa', name: 'appName', desc: '', args: []);
  }

  /// `Mboa Pro`
  String get appNamePro {
    return Intl.message('Mboa Pro', name: 'appNamePro', desc: '', args: []);
  }

  /// `Réessayer`
  String get commonRetry {
    return Intl.message('Réessayer', name: 'commonRetry', desc: '', args: []);
  }

  /// `Une erreur est survenue. Réessayez.`
  String get commonError {
    return Intl.message(
      'Une erreur est survenue. Réessayez.',
      name: 'commonError',
      desc: '',
      args: [],
    );
  }

  /// `Oups`
  String get commonErrorTitle {
    return Intl.message('Oups', name: 'commonErrorTitle', desc: '', args: []);
  }

  /// `Ou`
  String get commonOr {
    return Intl.message('Ou', name: 'commonOr', desc: '', args: []);
  }

  /// `Prendre une photo`
  String get mediaTakePhoto {
    return Intl.message(
      'Prendre une photo',
      name: 'mediaTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Importer`
  String get mediaImport {
    return Intl.message('Importer', name: 'mediaImport', desc: '', args: []);
  }

  /// `Photo mise à jour`
  String get profilePhotoUpdated {
    return Intl.message(
      'Photo mise à jour',
      name: 'profilePhotoUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Choisir une ville`
  String get cityPickerTitle {
    return Intl.message(
      'Choisir une ville',
      name: 'cityPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rechercher une ville`
  String get cityPickerSearchHint {
    return Intl.message(
      'Rechercher une ville',
      name: 'cityPickerSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Aucune ville trouvée`
  String get cityPickerEmpty {
    return Intl.message(
      'Aucune ville trouvée',
      name: 'cityPickerEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez patienter...`
  String get loadingDialog_content {
    return Intl.message(
      'Veuillez patienter...',
      name: 'loadingDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Inscription`
  String get welcome_inscriptionButton {
    return Intl.message(
      'Inscription',
      name: 'welcome_inscriptionButton',
      desc: '',
      args: [],
    );
  }

  /// `Connexion`
  String get welcome_loginButton {
    return Intl.message(
      'Connexion',
      name: 'welcome_loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get loginTitle {
    return Intl.message('Se connecter', name: 'loginTitle', desc: '', args: []);
  }

  /// `Créer un compte`
  String get registerTitle {
    return Intl.message(
      'Créer un compte',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entrez votre numéro de téléphone`
  String get loginEnterPhone {
    return Intl.message(
      'Entrez votre numéro de téléphone',
      name: 'loginEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone`
  String get loginPhoneLabel {
    return Intl.message(
      'Téléphone',
      name: 'loginPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `+237 6XX XX XX XX`
  String get loginPhoneHint {
    return Intl.message(
      '+237 6XX XX XX XX',
      name: 'loginPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `6 XX XX XX XX`
  String get loginPhoneHintLocal {
    return Intl.message(
      '6 XX XX XX XX',
      name: 'loginPhoneHintLocal',
      desc: '',
      args: [],
    );
  }

  /// `Numéro invalide`
  String get loginPhoneInvalid {
    return Intl.message(
      'Numéro invalide',
      name: 'loginPhoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Recevoir le code`
  String get loginRequestCode {
    return Intl.message(
      'Recevoir le code',
      name: 'loginRequestCode',
      desc: '',
      args: [],
    );
  }

  /// `Impossible d’envoyer le code. Réessayez.`
  String get loginOtpSendError {
    return Intl.message(
      'Impossible d’envoyer le code. Réessayez.',
      name: 'loginOtpSendError',
      desc: '',
      args: [],
    );
  }

  /// `Continuer avec Google`
  String get loginContinueWithGoogle {
    return Intl.message(
      'Continuer avec Google',
      name: 'loginContinueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continuer avec Apple`
  String get loginContinueWithApple {
    return Intl.message(
      'Continuer avec Apple',
      name: 'loginContinueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Vous n’avez pas de compte ?`
  String get loginNoAccountQuestion {
    return Intl.message(
      'Vous n’avez pas de compte ?',
      name: 'loginNoAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Inscrivez-vous`
  String get loginSignUpAction {
    return Intl.message(
      'Inscrivez-vous',
      name: 'loginSignUpAction',
      desc: '',
      args: [],
    );
  }

  /// `Vous avez déjà un compte ?`
  String get registerHaveAccountQuestion {
    return Intl.message(
      'Vous avez déjà un compte ?',
      name: 'registerHaveAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Connectez-vous`
  String get registerSignInAction {
    return Intl.message(
      'Connectez-vous',
      name: 'registerSignInAction',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get authEmailLabel {
    return Intl.message('E-mail', name: 'authEmailLabel', desc: '', args: []);
  }

  /// `nom@exemple.com`
  String get authEmailHint {
    return Intl.message(
      'nom@exemple.com',
      name: 'authEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `E-mail invalide`
  String get authEmailInvalid {
    return Intl.message(
      'E-mail invalide',
      name: 'authEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get authPasswordLabel {
    return Intl.message(
      'Mot de passe',
      name: 'authPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Votre mot de passe`
  String get authPasswordHint {
    return Intl.message(
      'Votre mot de passe',
      name: 'authPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe requis`
  String get authPasswordRequired {
    return Intl.message(
      'Mot de passe requis',
      name: 'authPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get authLoginButton {
    return Intl.message(
      'Se connecter',
      name: 'authLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `E-mail ou mot de passe incorrect.`
  String get authLoginInvalidCredentials {
    return Intl.message(
      'E-mail ou mot de passe incorrect.',
      name: 'authLoginInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Un nouveau code a été envoyé.`
  String get authOtpResent {
    return Intl.message(
      'Un nouveau code a été envoyé.',
      name: 'authOtpResent',
      desc: '',
      args: [],
    );
  }

  /// `Se déconnecter`
  String get authLogout {
    return Intl.message(
      'Se déconnecter',
      name: 'authLogout',
      desc: '',
      args: [],
    );
  }

  /// `Je suis`
  String get registerRoleLabel {
    return Intl.message(
      'Je suis',
      name: 'registerRoleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Prestataire`
  String get registerRolePrestataire {
    return Intl.message(
      'Prestataire',
      name: 'registerRolePrestataire',
      desc: '',
      args: [],
    );
  }

  /// `Agent`
  String get registerRoleAgent {
    return Intl.message('Agent', name: 'registerRoleAgent', desc: '', args: []);
  }

  /// `S’inscrire`
  String get registerButton {
    return Intl.message(
      'S’inscrire',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Inscription impossible. Vérifiez vos informations.`
  String get registerFailed {
    return Intl.message(
      'Inscription impossible. Vérifiez vos informations.',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Bientôt disponible`
  String get commonComingSoon {
    return Intl.message(
      'Bientôt disponible',
      name: 'commonComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get settingsTitle {
    return Intl.message('Profil', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Profil`
  String get settingsProfileCard {
    return Intl.message(
      'Profil',
      name: 'settingsProfileCard',
      desc: '',
      args: [],
    );
  }

  /// `Certifications`
  String get settingsCertificationsTitle {
    return Intl.message(
      'Certifications',
      name: 'settingsCertificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pièces d’identifications et tout autres vérifications requises`
  String get settingsCertificationsBody {
    return Intl.message(
      'Pièces d’identifications et tout autres vérifications requises',
      name: 'settingsCertificationsBody',
      desc: '',
      args: [],
    );
  }

  /// `Changer de mot passe`
  String get settingsChangePassword {
    return Intl.message(
      'Changer de mot passe',
      name: 'settingsChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Déconnexion`
  String get settingsLogout {
    return Intl.message(
      'Déconnexion',
      name: 'settingsLogout',
      desc: '',
      args: [],
    );
  }

  /// `Paramètres`
  String get settingsMenuTitle {
    return Intl.message(
      'Paramètres',
      name: 'settingsMenuTitle',
      desc: '',
      args: [],
    );
  }

  /// `Langue`
  String get settingsLanguage {
    return Intl.message('Langue', name: 'settingsLanguage', desc: '', args: []);
  }

  /// `Français`
  String get languageFrench {
    return Intl.message('Français', name: 'languageFrench', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `Changer de numéro`
  String get settingsChangePhone {
    return Intl.message(
      'Changer de numéro',
      name: 'settingsChangePhone',
      desc: '',
      args: [],
    );
  }

  /// `Code reçu sur l’ancien numéro`
  String get changePhoneOldCodeLabel {
    return Intl.message(
      'Code reçu sur l’ancien numéro',
      name: 'changePhoneOldCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Code reçu sur {phone}`
  String changePhoneNewCodeLabel(String phone) {
    return Intl.message(
      'Code reçu sur $phone',
      name: 'changePhoneNewCodeLabel',
      desc: '',
      args: [phone],
    );
  }

  /// `Confirmer le changement`
  String get changePhoneConfirm {
    return Intl.message(
      'Confirmer le changement',
      name: 'changePhoneConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Numéro mis à jour`
  String get changePhoneSuccess {
    return Intl.message(
      'Numéro mis à jour',
      name: 'changePhoneSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe actuel`
  String get changePasswordCurrent {
    return Intl.message(
      'Mot de passe actuel',
      name: 'changePasswordCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Nouveau mot de passe`
  String get changePasswordNew {
    return Intl.message(
      'Nouveau mot de passe',
      name: 'changePasswordNew',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer le nouveau mot de passe`
  String get changePasswordConfirm {
    return Intl.message(
      'Confirmer le nouveau mot de passe',
      name: 'changePasswordConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Les mots de passe ne correspondent pas`
  String get changePasswordMismatch {
    return Intl.message(
      'Les mots de passe ne correspondent pas',
      name: 'changePasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Mettre à jour`
  String get changePasswordButton {
    return Intl.message(
      'Mettre à jour',
      name: 'changePasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe mis à jour`
  String get changePasswordSuccess {
    return Intl.message(
      'Mot de passe mis à jour',
      name: 'changePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de changer le mot de passe. Vérifiez votre mot de passe actuel.`
  String get changePasswordError {
    return Intl.message(
      'Impossible de changer le mot de passe. Vérifiez votre mot de passe actuel.',
      name: 'changePasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer mon compte`
  String get deleteAccountLink {
    return Intl.message(
      'Supprimer mon compte',
      name: 'deleteAccountLink',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer le compte`
  String get deleteAccountTitle {
    return Intl.message(
      'Supprimer le compte',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette action est définitive. Vos données personnelles seront supprimées et vous perdrez l’accès à votre compte.`
  String get deleteAccountWarning {
    return Intl.message(
      'Cette action est définitive. Vos données personnelles seront supprimées et vous perdrez l’accès à votre compte.',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `SUPPRIMER`
  String get deleteAccountConfirmWord {
    return Intl.message(
      'SUPPRIMER',
      name: 'deleteAccountConfirmWord',
      desc: '',
      args: [],
    );
  }

  /// `Tapez « {word} » pour confirmer`
  String deleteAccountConfirmLabel(String word) {
    return Intl.message(
      'Tapez « $word » pour confirmer',
      name: 'deleteAccountConfirmLabel',
      desc: '',
      args: [word],
    );
  }

  /// `Supprimer définitivement`
  String get deleteAccountButton {
    return Intl.message(
      'Supprimer définitivement',
      name: 'deleteAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Editer le Profil`
  String get editProfileTitle {
    return Intl.message(
      'Editer le Profil',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Prénom`
  String get profileFirstName {
    return Intl.message('Prénom', name: 'profileFirstName', desc: '', args: []);
  }

  /// `Nom`
  String get profileLastName {
    return Intl.message('Nom', name: 'profileLastName', desc: '', args: []);
  }

  /// `Localisation`
  String get profileLocation {
    return Intl.message(
      'Localisation',
      name: 'profileLocation',
      desc: '',
      args: [],
    );
  }

  /// `Nom affiché`
  String get profileDisplayName {
    return Intl.message(
      'Nom affiché',
      name: 'profileDisplayName',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get profileType {
    return Intl.message('Type', name: 'profileType', desc: '', args: []);
  }

  /// `Particulier`
  String get profileTypeParticulier {
    return Intl.message(
      'Particulier',
      name: 'profileTypeParticulier',
      desc: '',
      args: [],
    );
  }

  /// `Agence`
  String get profileTypeAgence {
    return Intl.message(
      'Agence',
      name: 'profileTypeAgence',
      desc: '',
      args: [],
    );
  }

  /// `Promoteur`
  String get profileTypePromoteur {
    return Intl.message(
      'Promoteur',
      name: 'profileTypePromoteur',
      desc: '',
      args: [],
    );
  }

  /// `Ville principale`
  String get profileMainCity {
    return Intl.message(
      'Ville principale',
      name: 'profileMainCity',
      desc: '',
      args: [],
    );
  }

  /// `Enregistrer`
  String get profileSave {
    return Intl.message('Enregistrer', name: 'profileSave', desc: '', args: []);
  }

  /// `Profil mis à jour`
  String get profileSaved {
    return Intl.message(
      'Profil mis à jour',
      name: 'profileSaved',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de charger le profil.`
  String get profileLoadError {
    return Intl.message(
      'Impossible de charger le profil.',
      name: 'profileLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Statut`
  String get kycTabStatut {
    return Intl.message('Statut', name: 'kycTabStatut', desc: '', args: []);
  }

  /// `Identification`
  String get kycTabIdentification {
    return Intl.message(
      'Identification',
      name: 'kycTabIdentification',
      desc: '',
      args: [],
    );
  }

  /// `Selfie`
  String get kycItemSelfie {
    return Intl.message('Selfie', name: 'kycItemSelfie', desc: '', args: []);
  }

  /// `ID Document`
  String get kycItemIdDocument {
    return Intl.message(
      'ID Document',
      name: 'kycItemIdDocument',
      desc: '',
      args: [],
    );
  }

  /// `NUI`
  String get kycItemNui {
    return Intl.message('NUI', name: 'kycItemNui', desc: '', args: []);
  }

  /// `Adresse`
  String get kycItemAddress {
    return Intl.message('Adresse', name: 'kycItemAddress', desc: '', args: []);
  }

  /// `Compte Standard`
  String get kycAccountStandard {
    return Intl.message(
      'Compte Standard',
      name: 'kycAccountStandard',
      desc: '',
      args: [],
    );
  }

  /// `Compte Prestataire`
  String get kycAccountPrestataire {
    return Intl.message(
      'Compte Prestataire',
      name: 'kycAccountPrestataire',
      desc: '',
      args: [],
    );
  }

  /// `Compte Agent`
  String get kycAccountAgent {
    return Intl.message(
      'Compte Agent',
      name: 'kycAccountAgent',
      desc: '',
      args: [],
    );
  }

  /// `Informations requises`
  String get kycStatusNotSubmitted {
    return Intl.message(
      'Informations requises',
      name: 'kycStatusNotSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Informations en attente`
  String get kycStatusPending {
    return Intl.message(
      'Informations en attente',
      name: 'kycStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Vérifié`
  String get kycStatusApproved {
    return Intl.message(
      'Vérifié',
      name: 'kycStatusApproved',
      desc: '',
      args: [],
    );
  }

  /// `Refusé`
  String get kycStatusRejected {
    return Intl.message(
      'Refusé',
      name: 'kycStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Motif : {reason}`
  String kycRejectionReason(String reason) {
    return Intl.message(
      'Motif : $reason',
      name: 'kycRejectionReason',
      desc: '',
      args: [reason],
    );
  }

  /// `Ajouté`
  String get kycAdded {
    return Intl.message('Ajouté', name: 'kycAdded', desc: '', args: []);
  }

  /// `Soumettre`
  String get kycSubmit {
    return Intl.message('Soumettre', name: 'kycSubmit', desc: '', args: []);
  }

  /// `Documents soumis`
  String get kycSubmitted {
    return Intl.message(
      'Documents soumis',
      name: 'kycSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Échec de l’envoi. Réessayez.`
  String get kycUploadError {
    return Intl.message(
      'Échec de l’envoi. Réessayez.',
      name: 'kycUploadError',
      desc: '',
      args: [],
    );
  }

  /// `Prendre une photo`
  String get kycTakePhoto {
    return Intl.message(
      'Prendre une photo',
      name: 'kycTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Importer`
  String get kycImport {
    return Intl.message('Importer', name: 'kycImport', desc: '', args: []);
  }

  /// `Choisissez le type de document que vous souhaitez utiliser pour vérifier votre identité`
  String get kycIdDocumentPrompt {
    return Intl.message(
      'Choisissez le type de document que vous souhaitez utiliser pour vérifier votre identité',
      name: 'kycIdDocumentPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Carte d’identité`
  String get kycDocCni {
    return Intl.message(
      'Carte d’identité',
      name: 'kycDocCni',
      desc: '',
      args: [],
    );
  }

  /// `Recépissé`
  String get kycDocRecepisse {
    return Intl.message(
      'Recépissé',
      name: 'kycDocRecepisse',
      desc: '',
      args: [],
    );
  }

  /// `Passeport`
  String get kycDocPassport {
    return Intl.message(
      'Passeport',
      name: 'kycDocPassport',
      desc: '',
      args: [],
    );
  }

  /// `Permis de residence`
  String get kycDocResidence {
    return Intl.message(
      'Permis de residence',
      name: 'kycDocResidence',
      desc: '',
      args: [],
    );
  }

  /// `Recto`
  String get kycRecto {
    return Intl.message('Recto', name: 'kycRecto', desc: '', args: []);
  }

  /// `Verso`
  String get kycVerso {
    return Intl.message('Verso', name: 'kycVerso', desc: '', args: []);
  }

  /// `Terminé`
  String get kycDone {
    return Intl.message('Terminé', name: 'kycDone', desc: '', args: []);
  }

  /// `Vérification`
  String get otpTitle {
    return Intl.message('Vérification', name: 'otpTitle', desc: '', args: []);
  }

  /// `Code envoyé au {phone}`
  String otpCodeSentTo(String phone) {
    return Intl.message(
      'Code envoyé au $phone',
      name: 'otpCodeSentTo',
      desc: '',
      args: [phone],
    );
  }

  /// `Code à 6 chiffres`
  String get otpCodeLabel {
    return Intl.message(
      'Code à 6 chiffres',
      name: 'otpCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Valider`
  String get otpValidate {
    return Intl.message('Valider', name: 'otpValidate', desc: '', args: []);
  }

  /// `Code invalide. Réessayez.`
  String get otpInvalidCode {
    return Intl.message(
      'Code invalide. Réessayez.',
      name: 'otpInvalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Vous n’avez pas reçu le code ?`
  String get otpNoCodeQuestion {
    return Intl.message(
      'Vous n’avez pas reçu le code ?',
      name: 'otpNoCodeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Renvoyer le code`
  String get otpResend {
    return Intl.message(
      'Renvoyer le code',
      name: 'otpResend',
      desc: '',
      args: [],
    );
  }

  /// `Renvoyer dans {seconds}s`
  String otpResendIn(int seconds) {
    return Intl.message(
      'Renvoyer dans ${seconds}s',
      name: 'otpResendIn',
      desc: '',
      args: [seconds],
    );
  }

  /// `Bienvenue sur Mboa 👋`
  String get homeUserWelcome {
    return Intl.message(
      'Bienvenue sur Mboa 👋',
      name: 'homeUserWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Bienvenue sur Mboa Pro 👋`
  String get homeProWelcome {
    return Intl.message(
      'Bienvenue sur Mboa Pro 👋',
      name: 'homeProWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Accueil`
  String get navHome {
    return Intl.message('Accueil', name: 'navHome', desc: '', args: []);
  }

  /// `Gestionnaire`
  String get navManager {
    return Intl.message('Gestionnaire', name: 'navManager', desc: '', args: []);
  }

  /// `Finance`
  String get navFinance {
    return Intl.message('Finance', name: 'navFinance', desc: '', args: []);
  }

  /// `Menu`
  String get navMenu {
    return Intl.message('Menu', name: 'navMenu', desc: '', args: []);
  }

  /// `Hello !!`
  String get menuGreeting {
    return Intl.message('Hello !!', name: 'menuGreeting', desc: '', args: []);
  }

  /// `Profil`
  String get menuProfile {
    return Intl.message('Profil', name: 'menuProfile', desc: '', args: []);
  }

  /// `Notifications`
  String get menuNotifications {
    return Intl.message(
      'Notifications',
      name: 'menuNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get menuMessages {
    return Intl.message('Message', name: 'menuMessages', desc: '', args: []);
  }

  /// `Recherche`
  String get menuSearch {
    return Intl.message('Recherche', name: 'menuSearch', desc: '', args: []);
  }

  /// `Explorer`
  String get menuExplore {
    return Intl.message('Explorer', name: 'menuExplore', desc: '', args: []);
  }

  /// `Signets`
  String get menuBookmarks {
    return Intl.message('Signets', name: 'menuBookmarks', desc: '', args: []);
  }

  /// `Autres`
  String get menuOther {
    return Intl.message('Autres', name: 'menuOther', desc: '', args: []);
  }

  /// `Quitter`
  String get menuQuit {
    return Intl.message('Quitter', name: 'menuQuit', desc: '', args: []);
  }

  /// `Fermer le menu`
  String get menuClose {
    return Intl.message(
      'Fermer le menu',
      name: 'menuClose',
      desc: '',
      args: [],
    );
  }

  /// `Accès restreint`
  String get accessRestrictedTitle {
    return Intl.message(
      'Accès restreint',
      name: 'accessRestrictedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bientôt disponible`
  String get accessComingSoonTitle {
    return Intl.message(
      'Bientôt disponible',
      name: 'accessComingSoonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette fonctionnalité arrive prochainement. Nous vous préviendrons dès qu’elle sera prête.`
  String get accessComingSoonBody {
    return Intl.message(
      'Cette fonctionnalité arrive prochainement. Nous vous préviendrons dès qu’elle sera prête.',
      name: 'accessComingSoonBody',
      desc: '',
      args: [],
    );
  }

  /// `Vérification requise`
  String get accessKycRequiredTitle {
    return Intl.message(
      'Vérification requise',
      name: 'accessKycRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complétez vos certifications pour accéder à cette fonctionnalité.`
  String get accessKycRequiredBody {
    return Intl.message(
      'Complétez vos certifications pour accéder à cette fonctionnalité.',
      name: 'accessKycRequiredBody',
      desc: '',
      args: [],
    );
  }

  /// `Compléter mes certifications`
  String get accessKycRequiredCta {
    return Intl.message(
      'Compléter mes certifications',
      name: 'accessKycRequiredCta',
      desc: '',
      args: [],
    );
  }

  /// `Vérification en cours`
  String get accessKycPendingTitle {
    return Intl.message(
      'Vérification en cours',
      name: 'accessKycPendingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Vos documents sont en cours d’examen. Cette fonctionnalité s’activera dès validation.`
  String get accessKycPendingBody {
    return Intl.message(
      'Vos documents sont en cours d’examen. Cette fonctionnalité s’activera dès validation.',
      name: 'accessKycPendingBody',
      desc: '',
      args: [],
    );
  }

  /// `Réservé aux abonnés`
  String get accessTierRequiredTitle {
    return Intl.message(
      'Réservé aux abonnés',
      name: 'accessTierRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette donnée est incluse dans l’abonnement {tier}.`
  String accessTierRequiredBody(String tier) {
    return Intl.message(
      'Cette donnée est incluse dans l’abonnement $tier.',
      name: 'accessTierRequiredBody',
      desc: '',
      args: [tier],
    );
  }

  /// `Passer à {tier}`
  String accessUpgradeCta(String tier) {
    return Intl.message(
      'Passer à $tier',
      name: 'accessUpgradeCta',
      desc: '',
      args: [tier],
    );
  }

  /// `Non disponible pour ce compte`
  String get accessRoleRequiredTitle {
    return Intl.message(
      'Non disponible pour ce compte',
      name: 'accessRoleRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette fonctionnalité est réservée aux comptes prestataires.`
  String get accessRoleRequiredBody {
    return Intl.message(
      'Cette fonctionnalité est réservée aux comptes prestataires.',
      name: 'accessRoleRequiredBody',
      desc: '',
      args: [],
    );
  }

  /// `Quitter l’application ?`
  String get exitAppTitle {
    return Intl.message(
      'Quitter l’application ?',
      name: 'exitAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Appuyez de nouveau pour quitter.`
  String get exitAppBody {
    return Intl.message(
      'Appuyez de nouveau pour quitter.',
      name: 'exitAppBody',
      desc: '',
      args: [],
    );
  }

  /// `Gérez vos biens\nà travers l’application`
  String get homeTitle {
    return Intl.message(
      'Gérez vos biens\nà travers l’application',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Localisation`
  String get homeLocationLabel {
    return Intl.message(
      'Localisation',
      name: 'homeLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `--/--`
  String get homeLocationEmpty {
    return Intl.message('--/--', name: 'homeLocationEmpty', desc: '', args: []);
  }

  /// `Données hors ligne`
  String get homeOfflineBanner {
    return Intl.message(
      'Données hors ligne',
      name: 'homeOfflineBanner',
      desc: '',
      args: [],
    );
  }

  /// `Mes biens`
  String get homeCtaBiensTitle {
    return Intl.message(
      'Mes biens',
      name: 'homeCtaBiensTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enregistrez vos biens, et gérez ces derniers plus facilement à l’aide de plusieurs options de management`
  String get homeCtaBiensBody {
    return Intl.message(
      'Enregistrez vos biens, et gérez ces derniers plus facilement à l’aide de plusieurs options de management',
      name: 'homeCtaBiensBody',
      desc: '',
      args: [],
    );
  }

  /// `Gérer mes biens`
  String get homeCtaBiensAction {
    return Intl.message(
      'Gérer mes biens',
      name: 'homeCtaBiensAction',
      desc: '',
      args: [],
    );
  }

  /// `Portefeuille`
  String get homeCtaPortefeuilleTitle {
    return Intl.message(
      'Portefeuille',
      name: 'homeCtaPortefeuilleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gérez vos transactions financières en rapport avec vos biens immobiliers depuis l’application`
  String get homeCtaPortefeuilleBody {
    return Intl.message(
      'Gérez vos transactions financières en rapport avec vos biens immobiliers depuis l’application',
      name: 'homeCtaPortefeuilleBody',
      desc: '',
      args: [],
    );
  }

  /// `Gérer mes transactions`
  String get homeCtaPortefeuilleAction {
    return Intl.message(
      'Gérer mes transactions',
      name: 'homeCtaPortefeuilleAction',
      desc: '',
      args: [],
    );
  }

  /// `Mes agents`
  String get homeCtaAgentsTitle {
    return Intl.message(
      'Mes agents',
      name: 'homeCtaAgentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Créez des agents à qui déléguer la gestion partielle ou complète de vos biens`
  String get homeCtaAgentsBody {
    return Intl.message(
      'Créez des agents à qui déléguer la gestion partielle ou complète de vos biens',
      name: 'homeCtaAgentsBody',
      desc: '',
      args: [],
    );
  }

  /// `Gérer mes agents`
  String get homeCtaAgentsAction {
    return Intl.message(
      'Gérer mes agents',
      name: 'homeCtaAgentsAction',
      desc: '',
      args: [],
    );
  }

  /// `Statistiques Globales`
  String get homeStatsTitle {
    return Intl.message(
      'Statistiques Globales',
      name: 'homeStatsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Biens`
  String get homeStatsBiens {
    return Intl.message('Biens', name: 'homeStatsBiens', desc: '', args: []);
  }

  /// `Publiés`
  String get homeStatsPublished {
    return Intl.message(
      'Publiés',
      name: 'homeStatsPublished',
      desc: '',
      args: [],
    );
  }

  /// `Réservés`
  String get homeStatsReserved {
    return Intl.message(
      'Réservés',
      name: 'homeStatsReserved',
      desc: '',
      args: [],
    );
  }

  /// `Loués`
  String get homeStatsRented {
    return Intl.message('Loués', name: 'homeStatsRented', desc: '', args: []);
  }

  /// `Vues`
  String get homeStatsViews {
    return Intl.message('Vues', name: 'homeStatsViews', desc: '', args: []);
  }

  /// `Contacts`
  String get homeStatsContacts {
    return Intl.message(
      'Contacts',
      name: 'homeStatsContacts',
      desc: '',
      args: [],
    );
  }

  /// `Conversion`
  String get homeStatsConversion {
    return Intl.message(
      'Conversion',
      name: 'homeStatsConversion',
      desc: '',
      args: [],
    );
  }

  /// `Visites`
  String get homeStatsVisits {
    return Intl.message('Visites', name: 'homeStatsVisits', desc: '', args: []);
  }

  /// `Contrats`
  String get homeStatsContracts {
    return Intl.message(
      'Contrats',
      name: 'homeStatsContracts',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get homeStatsRank {
    return Intl.message('Position', name: 'homeStatsRank', desc: '', args: []);
  }

  /// `Bientôt`
  String get homeStatsUnavailable {
    return Intl.message(
      'Bientôt',
      name: 'homeStatsUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Ces mesures s’activeront dès que le backend les exposera.`
  String get homeStatsUnavailableHint {
    return Intl.message(
      'Ces mesures s’activeront dès que le backend les exposera.',
      name: 'homeStatsUnavailableHint',
      desc: '',
      args: [],
    );
  }

  /// `Inclus dans {tier}`
  String homeStatsLockedHint(String tier) {
    return Intl.message(
      'Inclus dans $tier',
      name: 'homeStatsLockedHint',
      desc: '',
      args: [tier],
    );
  }

  /// `Vous n’avez encore enregistré aucun bien.`
  String get homeEmptyBiens {
    return Intl.message(
      'Vous n’avez encore enregistré aucun bien.',
      name: 'homeEmptyBiens',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I18n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
