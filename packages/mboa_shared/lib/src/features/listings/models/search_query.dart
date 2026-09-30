import 'package:equatable/equatable.dart';

import 'property_type.dart';
import 'rental_period.dart';

/// What the tenant is looking for (CDC M04).
///
/// RM-M04-01 — **the city is the only mandatory criterion**; everything else is
/// optional and cumulative. The API leaves `cityId` optional, so that rule is
/// the app's to hold: [isValid] is what the screen gates the search on.
///
/// Serialisable both ways, because RM-M04-02 has the last search restored on
/// the next launch.
class SearchQuery extends Equatable {
  const SearchQuery({
    this.cityId,
    this.cityName,
    this.districtIds = const [],
    this.propertyTypes = const [],
    this.rentalPeriods = const [],
    this.rentMin,
    this.rentMax,
    this.roomsMin,
    this.surfaceMin,
    this.surfaceMax,
    this.furnished,
    this.availableNow,
  });

  final String? cityId;

  /// Carried so the bar can show "Douala" without re-reading the catalogue —
  /// a name is not a filter, it is what the tenant typed.
  final String? cityName;

  final List<String> districtIds;
  final List<PropertyType> propertyTypes;
  final List<RentalPeriod> rentalPeriods;
  final int? rentMin;
  final int? rentMax;
  final int? roomsMin;
  final int? surfaceMin;
  final int? surfaceMax;

  /// Null means "peu importe" — the toggle has three states, not two.
  final bool? furnished;
  final bool? availableNow;

  bool get isValid => cityId != null && cityId!.isNotEmpty;

  /// How many optional criteria are on, for the badge on the filters button.
  int get activeFilterCount => [
        districtIds.isNotEmpty,
        propertyTypes.isNotEmpty,
        rentalPeriods.isNotEmpty,
        rentMin != null,
        rentMax != null,
        roomsMin != null,
        surfaceMin != null,
        surfaceMax != null,
        furnished != null,
        availableNow != null,
      ].where((on) => on).length;

  SearchQuery copyWith({
    String? cityId,
    String? cityName,
    List<String>? districtIds,
    List<PropertyType>? propertyTypes,
    List<RentalPeriod>? rentalPeriods,
    int? rentMin,
    int? rentMax,
    int? roomsMin,
    int? surfaceMin,
    int? surfaceMax,
    bool? furnished,
    bool? availableNow,
    bool clearRent = false,
    bool clearRooms = false,
    bool clearSurface = false,
    bool clearFurnished = false,
    bool clearAvailableNow = false,
  }) =>
      SearchQuery(
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
        districtIds: districtIds ?? this.districtIds,
        propertyTypes: propertyTypes ?? this.propertyTypes,
        rentalPeriods: rentalPeriods ?? this.rentalPeriods,
        rentMin: clearRent ? null : (rentMin ?? this.rentMin),
        rentMax: clearRent ? null : (rentMax ?? this.rentMax),
        roomsMin: clearRooms ? null : (roomsMin ?? this.roomsMin),
        surfaceMin: clearSurface ? null : (surfaceMin ?? this.surfaceMin),
        surfaceMax: clearSurface ? null : (surfaceMax ?? this.surfaceMax),
        furnished: clearFurnished ? null : (furnished ?? this.furnished),
        availableNow:
            clearAvailableNow ? null : (availableNow ?? this.availableNow),
      );

  /// Keeps the city, drops the rest — what "réinitialiser les filtres" means.
  SearchQuery clearedFilters() =>
      SearchQuery(cityId: cityId, cityName: cityName);

  Map<String, dynamic> toJson() => {
        'cityId': cityId,
        'cityName': cityName,
        'districtIds': districtIds,
        'propertyTypes': propertyTypes.map((t) => t.name).toList(),
        'rentalPeriods': rentalPeriods.map((p) => p.name).toList(),
        'rentMin': rentMin,
        'rentMax': rentMax,
        'roomsMin': roomsMin,
        'surfaceMin': surfaceMin,
        'surfaceMax': surfaceMax,
        'furnished': furnished,
        'availableNow': availableNow,
      };

  /// Tolerant on purpose: a cached query written by an older build must not
  /// crash the launch it is restored into (RM-M04-02).
  static SearchQuery fromJson(Map<String, dynamic> json) => SearchQuery(
        cityId: json['cityId'] as String?,
        cityName: json['cityName'] as String?,
        districtIds: json['districtIds'] is List
            ? (json['districtIds'] as List).whereType<String>().toList()
            : const [],
        propertyTypes: _enums(json['propertyTypes'], PropertyType.values),
        rentalPeriods: _enums(json['rentalPeriods'], RentalPeriod.values),
        rentMin: json['rentMin'] as int?,
        rentMax: json['rentMax'] as int?,
        roomsMin: json['roomsMin'] as int?,
        surfaceMin: json['surfaceMin'] as int?,
        surfaceMax: json['surfaceMax'] as int?,
        furnished: json['furnished'] as bool?,
        availableNow: json['availableNow'] as bool?,
      );

  /// A field whose shape changed between builds degrades to "no filter"
  /// rather than discarding the whole restored query (RM-M04-02).
  static List<T> _enums<T extends Enum>(Object? raw, List<T> values) {
    final names =
        raw is List ? raw.whereType<String>() : const <String>[];
    return [
      for (final name in names) ?values.where((v) => v.name == name).firstOrNull,
    ];
  }

  @override
  List<Object?> get props => [
        cityId,
        cityName,
        districtIds,
        propertyTypes,
        rentalPeriods,
        rentMin,
        rentMax,
        roomsMin,
        surfaceMin,
        surfaceMax,
        furnished,
        availableNow,
      ];
}
