import 'package:flutter/widgets.dart';
import 'package:phone_numbers_parser/metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import 'country_names.g.dart';

/// A country a phone number belongs to (§40 A): App Mboa is not for Cameroon
/// alone. Its dial code, number lengths and validation come from Google's
/// libphonenumber metadata (the phone_numbers_parser package), its name in
/// French and English from Unicode CLDR — both bundled, so the sign-in works
/// offline and asks no third party.
@immutable
class MboaCountry {
  const MboaCountry(this.iso);

  final IsoCode iso;

  static const cameroon = MboaCountry(IsoCode.CM);

  /// Offered first: Central Africa, Cameroon leading.
  static const centralAfrica = [
    cameroon,
    MboaCountry(IsoCode.GA),
    MboaCountry(IsoCode.CG),
    MboaCountry(IsoCode.TD),
    MboaCountry(IsoCode.CF),
    MboaCountry(IsoCode.GQ),
  ];

  /// Every country with a dial code and a name.
  static final List<MboaCountry> all = [
    for (final iso in IsoCode.values)
      if (metadataByIsoCode.containsKey(iso) && countryNames.containsKey(iso.name)) MboaCountry(iso),
  ];

  String get code => iso.name;

  /// « +237 ».
  String get dialCode => '+${metadataByIsoCode[iso]!.countryCode}';

  /// In the reader's language: French, or English otherwise.
  String name(Locale locale) {
    final names = countryNames[code];
    if (names == null) return code;
    return locale.languageCode == 'fr' ? names.fr : names.en;
  }

  /// The flag, from the code's two letters (regional indicators).
  String get flag => String.fromCharCodes(code.codeUnits.map((unit) => unit - 0x41 + 0x1F1E6));

  /// The longest national number here, to cap what can be typed.
  int get maxDigits {
    final lengths = metadataLengthsByIsoCode[iso];
    final all = [...?lengths?.mobile, ...?lengths?.fixedLine, ...?lengths?.general];
    return all.isEmpty ? 15 : all.reduce((a, b) => a > b ? a : b);
  }

  /// A mobile number as written here, for a hint: « 671234567 ».
  String? get example {
    final mobile = metadataExamplesByIsoCode[iso]?.mobile;
    return (mobile == null || mobile.isEmpty) ? null : mobile;
  }

  /// [national] as the server takes it (E.164: « +237690000000 »), or null
  /// when it is not a number of this country.
  String? e164(String national) {
    final digits = national.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    try {
      final number = PhoneNumber.parse(digits, destinationCountry: iso);
      return number.isValid() ? number.international : null;
    } on Object {
      return null;
    }
  }

  bool accepts(String national) => e164(national) != null;

  @override
  bool operator ==(Object other) => other is MboaCountry && other.iso == iso;

  @override
  int get hashCode => iso.hashCode;
}
