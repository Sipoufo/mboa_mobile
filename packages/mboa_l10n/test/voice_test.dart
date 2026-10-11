import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Brandbook v2 §07 (Voix et ton) as a test.
///
/// The editorial rules are checkable, so they are checked here rather than
/// relied on at review time. §37 says "On tutoie dans l'app et sur les
/// réseaux" without qualification, so it covers both apps; §34 reserves the
/// premium register for documents, and the PDFs are rendered by the backend,
/// so every string in these files belongs to the informal register.
///
/// Reads the ARB sources directly: they are the copy, and the generated
/// `I18n` class is only a view of them.
void main() {
  final fr = _strings('lib/l10n/intl_fr.arb');
  final en = _strings('lib/l10n/intl_en.arb');

  group('§37 — the French UI tutoies', () {
    test('no second-person-plural pronoun or possessive', () {
      // Covers "vous", "votre" and "vos" at a word boundary, in any case.
      final pronoun = RegExp(r'\b(vous|votre|vos)\b', caseSensitive: false);
      expect(_offenders(fr, pronoun), isEmpty);
    });

    test('no second-person-plural verb', () {
      // French second-person-plural endings. The -ez pattern also catches a
      // handful of ordinary words, which are listed rather than tolerated by
      // a looser pattern.
      const notVerbs = {'chez', 'assez', 'nez', 'rez'};
      final offenders = <String, String>{};
      for (final entry in fr.entries) {
        for (final match in RegExp(r'\b[\wÀ-ÿ]+ez\b').allMatches(entry.value)) {
          final word = match.group(0)!.toLowerCase();
          if (!notVerbs.contains(word)) offenders[entry.key] = word;
        }
      }
      expect(offenders, isEmpty);
    });
  });

  group('§35 — the words Mboa does not use', () {
    test('French', () {
      // Verbatim from the slide: "veuillez, prière de, utilisateur,
      // plateforme, optimal, synergies".
      for (final word in ['veuillez', 'prière de', 'utilisateur', 'plateforme', 'optimal', 'synergie']) {
        expect(
          _offenders(fr, RegExp(word, caseSensitive: false)),
          isEmpty,
          reason: '§35 bans "$word"',
        );
      }
    });

    test('English', () {
      // Verbatim: "kindly, please be advised, user, leverage, seamless,
      // ecosystem".
      for (final word in ['kindly', 'please be advised', 'user', 'leverage', 'seamless', 'ecosystem']) {
        expect(
          _offenders(en, RegExp('\\b$word', caseSensitive: false)),
          isEmpty,
          reason: '§35 bans "$word"',
        );
      }
    });
  });

  group('§35 — the copy it gives outright', () {
    test('onboarding says "Bienvenue chez toi."', () {
      expect(fr['welcomeHeadline'], 'Bienvenue chez toi.');
      expect(en['welcomeHeadline'], 'Welcome home.');
    });

    test('an empty search invites another neighbourhood', () {
      expect(fr['searchEmptyTitle'], contains('Aucun bien ici pour l\'instant'));
      expect(fr['searchEmptyBody'], contains('Essaie un autre quartier'));
    });

    test('a confirmed payment opens plainly, not with a transaction', () {
      expect(fr['paymentConfirmedBody'], startsWith('C\'est réglé.'));
    });
  });
}

/// The message strings of an ARB file, without its `@`-prefixed metadata.
Map<String, String> _strings(String path) {
  final decoded = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final entry in decoded.entries)
      if (!entry.key.startsWith('@') && entry.value is String)
        entry.key: entry.value as String,
  };
}

/// Keys whose copy matches [pattern], mapped to the copy, so a failure names
/// the string to fix instead of only counting them.
Map<String, String> _offenders(Map<String, String> strings, RegExp pattern) => {
      for (final entry in strings.entries)
        if (pattern.hasMatch(entry.value)) entry.key: entry.value,
    };
