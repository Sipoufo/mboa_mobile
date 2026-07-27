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

  static String m0(phone) => "Code envoyé au ${phone}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("Mboa"),
    "appNamePro": MessageLookupByLibrary.simpleMessage("Mboa Pro"),
    "commonError": MessageLookupByLibrary.simpleMessage(
      "Une erreur est survenue. Réessayez.",
    ),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "homeProWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa Pro 👋",
    ),
    "homeUserWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa 👋",
    ),
    "loadingDialog_content": MessageLookupByLibrary.simpleMessage(
      "Veuillez patienter...",
    ),
    "loginEnterPhone": MessageLookupByLibrary.simpleMessage(
      "Entrez votre numéro de téléphone",
    ),
    "loginOtpSendError": MessageLookupByLibrary.simpleMessage(
      "Impossible d’envoyer le code. Réessayez.",
    ),
    "loginPhoneHint": MessageLookupByLibrary.simpleMessage("+237 6XX XX XX XX"),
    "loginPhoneInvalid": MessageLookupByLibrary.simpleMessage(
      "Numéro invalide",
    ),
    "loginPhoneLabel": MessageLookupByLibrary.simpleMessage("Téléphone"),
    "loginRequestCode": MessageLookupByLibrary.simpleMessage(
      "Recevoir le code",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Connexion"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("Code à 6 chiffres"),
    "otpCodeSentTo": m0,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Code invalide. Réessayez.",
    ),
    "otpTitle": MessageLookupByLibrary.simpleMessage("Vérification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Valider"),
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Inscription",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Connexion"),
  };
}
