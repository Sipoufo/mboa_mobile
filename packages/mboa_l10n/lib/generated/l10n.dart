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

  /// `Connexion`
  String get loginTitle {
    return Intl.message('Connexion', name: 'loginTitle', desc: '', args: []);
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
