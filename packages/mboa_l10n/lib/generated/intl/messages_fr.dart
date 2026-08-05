// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(tier) =>
      "Cette donnée est incluse dans l’abonnement ${tier}.";

  static String m1(tier) => "Passer à ${tier}";

  static String m2(phone) => "Code reçu sur ${phone}";

  static String m3(word) => "Tapez « ${word} » pour confirmer";

  static String m4(tier) => "Inclus dans ${tier}";

  static String m5(reason) => "Motif : ${reason}";

  static String m6(phone) => "Code envoyé au ${phone}";

  static String m7(seconds) => "Renvoyer dans ${seconds}s";

  static String m8(tier) => "Votre formule ${tier} est active.";

  static String m9(ref) => "Référence : ${ref}";

  static String m10(price) => "${price} FCFA / mois";

  static String m11(count) =>
      "${Intl.plural(count, one: '1 unité de résidence', other: '${count} unités de résidence')}";

  static String m12(count) =>
      "${Intl.plural(count, zero: 'Aucune annonce active', one: '1 annonce active', other: '${count} annonces actives')}";

  static String m13(date) => "Valable jusqu’au ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessComingSoonBody": MessageLookupByLibrary.simpleMessage(
      "Cette fonctionnalité arrive prochainement. Nous vous préviendrons dès qu’elle sera prête.",
    ),
    "accessComingSoonTitle": MessageLookupByLibrary.simpleMessage(
      "Bientôt disponible",
    ),
    "accessKycPendingBody": MessageLookupByLibrary.simpleMessage(
      "Vos documents sont en cours d’examen. Cette fonctionnalité s’activera dès validation.",
    ),
    "accessKycPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification en cours",
    ),
    "accessKycRequiredBody": MessageLookupByLibrary.simpleMessage(
      "Complétez vos certifications pour accéder à cette fonctionnalité.",
    ),
    "accessKycRequiredCta": MessageLookupByLibrary.simpleMessage(
      "Compléter mes certifications",
    ),
    "accessKycRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification requise",
    ),
    "accessRestrictedTitle": MessageLookupByLibrary.simpleMessage(
      "Accès restreint",
    ),
    "accessRoleRequiredBody": MessageLookupByLibrary.simpleMessage(
      "Cette fonctionnalité est réservée aux comptes prestataires.",
    ),
    "accessRoleRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Non disponible pour ce compte",
    ),
    "accessTierRequiredBody": m0,
    "accessTierRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Réservé aux abonnés",
    ),
    "accessUpgradeCta": m1,
    "appName": MessageLookupByLibrary.simpleMessage("Mboa"),
    "appNamePro": MessageLookupByLibrary.simpleMessage("Mboa Pro"),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("nom@exemple.com"),
    "authEmailInvalid": MessageLookupByLibrary.simpleMessage("E-mail invalide"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authLoginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "E-mail ou mot de passe incorrect.",
    ),
    "authLogout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "authOtpResent": MessageLookupByLibrary.simpleMessage(
      "Un nouveau code a été envoyé.",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Votre mot de passe",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "authPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Mot de passe requis",
    ),
    "changePasswordButton": MessageLookupByLibrary.simpleMessage(
      "Mettre à jour",
    ),
    "changePasswordConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirmer le nouveau mot de passe",
    ),
    "changePasswordCurrent": MessageLookupByLibrary.simpleMessage(
      "Mot de passe actuel",
    ),
    "changePasswordError": MessageLookupByLibrary.simpleMessage(
      "Impossible de changer le mot de passe. Vérifiez votre mot de passe actuel.",
    ),
    "changePasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas",
    ),
    "changePasswordNew": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "changePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Mot de passe mis à jour",
    ),
    "changePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirmer le changement",
    ),
    "changePhoneNewCodeLabel": m2,
    "changePhoneOldCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code reçu sur l’ancien numéro",
    ),
    "changePhoneSuccess": MessageLookupByLibrary.simpleMessage(
      "Numéro mis à jour",
    ),
    "cityPickerEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucune ville trouvée",
    ),
    "cityPickerSearchHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une ville",
    ),
    "cityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Choisir une ville",
    ),
    "commonComingSoon": MessageLookupByLibrary.simpleMessage(
      "Bientôt disponible",
    ),
    "commonError": MessageLookupByLibrary.simpleMessage(
      "Une erreur est survenue. Réessayez.",
    ),
    "commonErrorTitle": MessageLookupByLibrary.simpleMessage("Oups"),
    "commonOr": MessageLookupByLibrary.simpleMessage("Ou"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "deleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Supprimer définitivement",
    ),
    "deleteAccountConfirmLabel": m3,
    "deleteAccountConfirmWord": MessageLookupByLibrary.simpleMessage(
      "SUPPRIMER",
    ),
    "deleteAccountLink": MessageLookupByLibrary.simpleMessage(
      "Supprimer mon compte",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Supprimer le compte",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Cette action est définitive. Vos données personnelles seront supprimées et vous perdrez l’accès à votre compte.",
    ),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Editer le Profil",
    ),
    "exitAppBody": MessageLookupByLibrary.simpleMessage(
      "Appuyez de nouveau pour quitter.",
    ),
    "exitAppTitle": MessageLookupByLibrary.simpleMessage(
      "Quitter l’application ?",
    ),
    "homeCtaAgentsAction": MessageLookupByLibrary.simpleMessage(
      "Gérer mes agents",
    ),
    "homeCtaAgentsBody": MessageLookupByLibrary.simpleMessage(
      "Créez des agents à qui déléguer la gestion partielle ou complète de vos biens",
    ),
    "homeCtaAgentsTitle": MessageLookupByLibrary.simpleMessage("Mes agents"),
    "homeCtaBiensAction": MessageLookupByLibrary.simpleMessage(
      "Gérer mes biens",
    ),
    "homeCtaBiensBody": MessageLookupByLibrary.simpleMessage(
      "Enregistrez vos biens, et gérez ces derniers plus facilement à l’aide de plusieurs options de management",
    ),
    "homeCtaBiensTitle": MessageLookupByLibrary.simpleMessage("Mes biens"),
    "homeCtaPortefeuilleAction": MessageLookupByLibrary.simpleMessage(
      "Gérer mes transactions",
    ),
    "homeCtaPortefeuilleBody": MessageLookupByLibrary.simpleMessage(
      "Gérez vos transactions financières en rapport avec vos biens immobiliers depuis l’application",
    ),
    "homeCtaPortefeuilleTitle": MessageLookupByLibrary.simpleMessage(
      "Portefeuille",
    ),
    "homeEmptyBiens": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez encore enregistré aucun bien.",
    ),
    "homeLocationEmpty": MessageLookupByLibrary.simpleMessage("--/--"),
    "homeLocationLabel": MessageLookupByLibrary.simpleMessage("Localisation"),
    "homeOfflineBanner": MessageLookupByLibrary.simpleMessage(
      "Données hors ligne",
    ),
    "homeProWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa Pro 👋",
    ),
    "homeStatsBiens": MessageLookupByLibrary.simpleMessage("Biens"),
    "homeStatsContacts": MessageLookupByLibrary.simpleMessage("Contacts"),
    "homeStatsContracts": MessageLookupByLibrary.simpleMessage("Contrats"),
    "homeStatsConversion": MessageLookupByLibrary.simpleMessage("Conversion"),
    "homeStatsLockedHint": m4,
    "homeStatsPublished": MessageLookupByLibrary.simpleMessage("Publiés"),
    "homeStatsRank": MessageLookupByLibrary.simpleMessage("Position"),
    "homeStatsRented": MessageLookupByLibrary.simpleMessage("Loués"),
    "homeStatsReserved": MessageLookupByLibrary.simpleMessage("Réservés"),
    "homeStatsTitle": MessageLookupByLibrary.simpleMessage(
      "Statistiques Globales",
    ),
    "homeStatsUnavailable": MessageLookupByLibrary.simpleMessage("Bientôt"),
    "homeStatsUnavailableHint": MessageLookupByLibrary.simpleMessage(
      "Ces mesures s’activeront dès que le backend les exposera.",
    ),
    "homeStatsViews": MessageLookupByLibrary.simpleMessage("Vues"),
    "homeStatsVisits": MessageLookupByLibrary.simpleMessage("Visites"),
    "homeTitle": MessageLookupByLibrary.simpleMessage(
      "Gérez vos biens\nà travers l’application",
    ),
    "homeUserWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa 👋",
    ),
    "kycAccountAgent": MessageLookupByLibrary.simpleMessage("Compte Agent"),
    "kycAccountPrestataire": MessageLookupByLibrary.simpleMessage(
      "Compte Prestataire",
    ),
    "kycAccountStandard": MessageLookupByLibrary.simpleMessage(
      "Compte Standard",
    ),
    "kycAdded": MessageLookupByLibrary.simpleMessage("Ajouté"),
    "kycDocCni": MessageLookupByLibrary.simpleMessage("Carte d’identité"),
    "kycDocPassport": MessageLookupByLibrary.simpleMessage("Passeport"),
    "kycDocRecepisse": MessageLookupByLibrary.simpleMessage("Recépissé"),
    "kycDocResidence": MessageLookupByLibrary.simpleMessage(
      "Permis de residence",
    ),
    "kycDone": MessageLookupByLibrary.simpleMessage("Terminé"),
    "kycIdDocumentPrompt": MessageLookupByLibrary.simpleMessage(
      "Choisissez le type de document que vous souhaitez utiliser pour vérifier votre identité",
    ),
    "kycImport": MessageLookupByLibrary.simpleMessage("Importer"),
    "kycItemAddress": MessageLookupByLibrary.simpleMessage("Adresse"),
    "kycItemIdDocument": MessageLookupByLibrary.simpleMessage("ID Document"),
    "kycItemNui": MessageLookupByLibrary.simpleMessage("NUI"),
    "kycItemSelfie": MessageLookupByLibrary.simpleMessage("Selfie"),
    "kycRecto": MessageLookupByLibrary.simpleMessage("Recto"),
    "kycRejectionReason": m5,
    "kycStatusApproved": MessageLookupByLibrary.simpleMessage("Vérifié"),
    "kycStatusNotSubmitted": MessageLookupByLibrary.simpleMessage(
      "Informations requises",
    ),
    "kycStatusPending": MessageLookupByLibrary.simpleMessage(
      "Informations en attente",
    ),
    "kycStatusRejected": MessageLookupByLibrary.simpleMessage("Refusé"),
    "kycSubmit": MessageLookupByLibrary.simpleMessage("Soumettre"),
    "kycSubmitted": MessageLookupByLibrary.simpleMessage("Documents soumis"),
    "kycTabIdentification": MessageLookupByLibrary.simpleMessage(
      "Identification",
    ),
    "kycTabStatut": MessageLookupByLibrary.simpleMessage("Statut"),
    "kycTakePhoto": MessageLookupByLibrary.simpleMessage("Prendre une photo"),
    "kycUploadError": MessageLookupByLibrary.simpleMessage(
      "Échec de l’envoi. Réessayez.",
    ),
    "kycVerso": MessageLookupByLibrary.simpleMessage("Verso"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "loadingDialog_content": MessageLookupByLibrary.simpleMessage(
      "Veuillez patienter...",
    ),
    "loginContinueWithApple": MessageLookupByLibrary.simpleMessage(
      "Continuer avec Apple",
    ),
    "loginContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continuer avec Google",
    ),
    "loginEnterPhone": MessageLookupByLibrary.simpleMessage(
      "Entrez votre numéro de téléphone",
    ),
    "loginNoAccountQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez pas de compte ?",
    ),
    "loginOtpSendError": MessageLookupByLibrary.simpleMessage(
      "Impossible d’envoyer le code. Réessayez.",
    ),
    "loginPhoneHint": MessageLookupByLibrary.simpleMessage("+237 6XX XX XX XX"),
    "loginPhoneHintLocal": MessageLookupByLibrary.simpleMessage(
      "6 XX XX XX XX",
    ),
    "loginPhoneInvalid": MessageLookupByLibrary.simpleMessage(
      "Numéro invalide",
    ),
    "loginPhoneLabel": MessageLookupByLibrary.simpleMessage("Téléphone"),
    "loginRequestCode": MessageLookupByLibrary.simpleMessage(
      "Recevoir le code",
    ),
    "loginSignUpAction": MessageLookupByLibrary.simpleMessage("Inscrivez-vous"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "mediaImport": MessageLookupByLibrary.simpleMessage("Importer"),
    "mediaTakePhoto": MessageLookupByLibrary.simpleMessage("Prendre une photo"),
    "menuBookmarks": MessageLookupByLibrary.simpleMessage("Signets"),
    "menuClose": MessageLookupByLibrary.simpleMessage("Fermer le menu"),
    "menuExplore": MessageLookupByLibrary.simpleMessage("Explorer"),
    "menuGreeting": MessageLookupByLibrary.simpleMessage("Hello !!"),
    "menuMessages": MessageLookupByLibrary.simpleMessage("Message"),
    "menuNotifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "menuOther": MessageLookupByLibrary.simpleMessage("Autres"),
    "menuProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "menuQuit": MessageLookupByLibrary.simpleMessage("Quitter"),
    "menuSearch": MessageLookupByLibrary.simpleMessage("Recherche"),
    "navFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "navHome": MessageLookupByLibrary.simpleMessage("Accueil"),
    "navManager": MessageLookupByLibrary.simpleMessage("Gestionnaire"),
    "navMenu": MessageLookupByLibrary.simpleMessage("Menu"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("Code à 6 chiffres"),
    "otpCodeSentTo": m6,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Code invalide. Réessayez.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez pas reçu le code ?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Renvoyer le code"),
    "otpResendIn": m7,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Vérification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Valider"),
    "paymentAwaitingBody": MessageLookupByLibrary.simpleMessage(
      "Validez la demande de paiement reçue sur votre mobile (USSD ou application Mobile Money). Cet écran se met à jour automatiquement.",
    ),
    "paymentAwaitingTitle": MessageLookupByLibrary.simpleMessage(
      "Finalisez sur votre téléphone",
    ),
    "paymentConfirmedBody": m8,
    "paymentConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement confirmé",
    ),
    "paymentDone": MessageLookupByLibrary.simpleMessage("Terminé"),
    "paymentFailedBody": MessageLookupByLibrary.simpleMessage(
      "La transaction n’a pas abouti. Aucun montant n’a été débité.",
    ),
    "paymentFailedTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement échoué",
    ),
    "paymentInitiating": MessageLookupByLibrary.simpleMessage(
      "Initialisation du paiement…",
    ),
    "paymentMethodMtn": MessageLookupByLibrary.simpleMessage(
      "MTN Mobile Money",
    ),
    "paymentMethodOrange": MessageLookupByLibrary.simpleMessage("Orange Money"),
    "paymentMethodTitle": MessageLookupByLibrary.simpleMessage(
      "Mode de paiement",
    ),
    "paymentPendingBody": MessageLookupByLibrary.simpleMessage(
      "Nous n’avons pas encore reçu la confirmation. Elle peut prendre quelques minutes — vous recevrez une notification dès que votre formule sera active.",
    ),
    "paymentPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement en attente",
    ),
    "paymentReference": m9,
    "paymentRetry": MessageLookupByLibrary.simpleMessage(
      "Réessayer le paiement",
    ),
    "plansChoose": MessageLookupByLibrary.simpleMessage("Choisir"),
    "plansCurrent": MessageLookupByLibrary.simpleMessage("Formule actuelle"),
    "plansDowngradeNote": MessageLookupByLibrary.simpleMessage(
      "Un passage à une formule inférieure prend effet au prochain cycle.",
    ),
    "plansPriceFree": MessageLookupByLibrary.simpleMessage("Gratuit"),
    "plansPriceMonthly": m10,
    "plansResidenceAllowance": m11,
    "plansTitle": MessageLookupByLibrary.simpleMessage("Formules"),
    "profileDisplayName": MessageLookupByLibrary.simpleMessage("Nom affiché"),
    "profileFirstName": MessageLookupByLibrary.simpleMessage("Prénom"),
    "profileLastName": MessageLookupByLibrary.simpleMessage("Nom"),
    "profileLoadError": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger le profil.",
    ),
    "profileLocation": MessageLookupByLibrary.simpleMessage("Localisation"),
    "profileMainCity": MessageLookupByLibrary.simpleMessage("Ville principale"),
    "profilePhotoUpdated": MessageLookupByLibrary.simpleMessage(
      "Photo mise à jour",
    ),
    "profileSave": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "profileSaved": MessageLookupByLibrary.simpleMessage("Profil mis à jour"),
    "profileType": MessageLookupByLibrary.simpleMessage("Type"),
    "profileTypeAgence": MessageLookupByLibrary.simpleMessage("Agence"),
    "profileTypeParticulier": MessageLookupByLibrary.simpleMessage(
      "Particulier",
    ),
    "profileTypePromoteur": MessageLookupByLibrary.simpleMessage("Promoteur"),
    "registerButton": MessageLookupByLibrary.simpleMessage("S’inscrire"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Inscription impossible. Vérifiez vos informations.",
    ),
    "registerHaveAccountQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ?",
    ),
    "registerRoleAgent": MessageLookupByLibrary.simpleMessage("Agent"),
    "registerRoleLabel": MessageLookupByLibrary.simpleMessage("Je suis"),
    "registerRolePrestataire": MessageLookupByLibrary.simpleMessage(
      "Prestataire",
    ),
    "registerSignInAction": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Créer un compte"),
    "settingsCertificationsBody": MessageLookupByLibrary.simpleMessage(
      "Pièces d’identifications et tout autres vérifications requises",
    ),
    "settingsCertificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Certifications",
    ),
    "settingsChangePassword": MessageLookupByLibrary.simpleMessage(
      "Changer de mot passe",
    ),
    "settingsChangePhone": MessageLookupByLibrary.simpleMessage(
      "Changer de numéro",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Langue"),
    "settingsLogout": MessageLookupByLibrary.simpleMessage("Déconnexion"),
    "settingsMenuTitle": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "settingsProfileCard": MessageLookupByLibrary.simpleMessage("Profil"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Profil"),
    "subscriptionChangePlan": MessageLookupByLibrary.simpleMessage(
      "Changer de formule",
    ),
    "subscriptionCurrentPlan": MessageLookupByLibrary.simpleMessage(
      "Formule actuelle",
    ),
    "subscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Votre abonnement a expiré",
    ),
    "subscriptionListingLimit": m12,
    "subscriptionListingLimitUnlimited": MessageLookupByLibrary.simpleMessage(
      "Annonces illimitées",
    ),
    "subscriptionNoExpiry": MessageLookupByLibrary.simpleMessage(
      "Sans expiration",
    ),
    "subscriptionNoReceipts": MessageLookupByLibrary.simpleMessage(
      "Aucun paiement enregistré sur cet appareil.",
    ),
    "subscriptionReceiptOpen": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le reçu",
    ),
    "subscriptionReceipts": MessageLookupByLibrary.simpleMessage("Mes reçus"),
    "subscriptionReceiptsLocalHint": MessageLookupByLibrary.simpleMessage(
      "Les reçus sont liés à cet appareil pour le moment.",
    ),
    "subscriptionRenewsOn": m13,
    "subscriptionTitle": MessageLookupByLibrary.simpleMessage("Mon abonnement"),
    "subscriptionUnknown": MessageLookupByLibrary.simpleMessage(
      "Impossible de vérifier votre abonnement. Formule Gratuit appliquée en attendant.",
    ),
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Inscription",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Connexion"),
  };
}
