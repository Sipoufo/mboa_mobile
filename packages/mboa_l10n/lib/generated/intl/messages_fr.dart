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

  static String m0(phone) => "Code reçu sur ${phone}";

  static String m1(word) => "Tapez « ${word} » pour confirmer";

  static String m2(reason) => "Motif : ${reason}";

  static String m3(phone) => "Code envoyé au ${phone}";

  static String m4(seconds) => "Renvoyer dans ${seconds}s";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
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
    "changePhoneNewCodeLabel": m0,
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
    "deleteAccountConfirmLabel": m1,
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
    "homeProWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa Pro 👋",
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
    "kycRejectionReason": m2,
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
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("Code à 6 chiffres"),
    "otpCodeSentTo": m3,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Code invalide. Réessayez.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez pas reçu le code ?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Renvoyer le code"),
    "otpResendIn": m4,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Vérification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Valider"),
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
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Inscription",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Connexion"),
  };
}
