// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_search_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SavedSearchResponse extends SavedSearchResponse {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final SearchCriteria? criteria;
  @override
  final bool? alertsEnabled;
  @override
  final int? newMatchCount;
  @override
  final DateTime? lastViewedAt;
  @override
  final DateTime? lastAlertAt;
  @override
  final DateTime? createdAt;

  factory _$SavedSearchResponse([
    void Function(SavedSearchResponseBuilder)? updates,
  ]) => (SavedSearchResponseBuilder()..update(updates))._build();

  _$SavedSearchResponse._({
    this.id,
    this.name,
    this.criteria,
    this.alertsEnabled,
    this.newMatchCount,
    this.lastViewedAt,
    this.lastAlertAt,
    this.createdAt,
  }) : super._();
  @override
  SavedSearchResponse rebuild(
    void Function(SavedSearchResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SavedSearchResponseBuilder toBuilder() =>
      SavedSearchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SavedSearchResponse &&
        id == other.id &&
        name == other.name &&
        criteria == other.criteria &&
        alertsEnabled == other.alertsEnabled &&
        newMatchCount == other.newMatchCount &&
        lastViewedAt == other.lastViewedAt &&
        lastAlertAt == other.lastAlertAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, criteria.hashCode);
    _$hash = $jc(_$hash, alertsEnabled.hashCode);
    _$hash = $jc(_$hash, newMatchCount.hashCode);
    _$hash = $jc(_$hash, lastViewedAt.hashCode);
    _$hash = $jc(_$hash, lastAlertAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SavedSearchResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('criteria', criteria)
          ..add('alertsEnabled', alertsEnabled)
          ..add('newMatchCount', newMatchCount)
          ..add('lastViewedAt', lastViewedAt)
          ..add('lastAlertAt', lastAlertAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SavedSearchResponseBuilder
    implements Builder<SavedSearchResponse, SavedSearchResponseBuilder> {
  _$SavedSearchResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  SearchCriteriaBuilder? _criteria;
  SearchCriteriaBuilder get criteria =>
      _$this._criteria ??= SearchCriteriaBuilder();
  set criteria(SearchCriteriaBuilder? criteria) => _$this._criteria = criteria;

  bool? _alertsEnabled;
  bool? get alertsEnabled => _$this._alertsEnabled;
  set alertsEnabled(bool? alertsEnabled) =>
      _$this._alertsEnabled = alertsEnabled;

  int? _newMatchCount;
  int? get newMatchCount => _$this._newMatchCount;
  set newMatchCount(int? newMatchCount) =>
      _$this._newMatchCount = newMatchCount;

  DateTime? _lastViewedAt;
  DateTime? get lastViewedAt => _$this._lastViewedAt;
  set lastViewedAt(DateTime? lastViewedAt) =>
      _$this._lastViewedAt = lastViewedAt;

  DateTime? _lastAlertAt;
  DateTime? get lastAlertAt => _$this._lastAlertAt;
  set lastAlertAt(DateTime? lastAlertAt) => _$this._lastAlertAt = lastAlertAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  SavedSearchResponseBuilder() {
    SavedSearchResponse._defaults(this);
  }

  SavedSearchResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _criteria = $v.criteria?.toBuilder();
      _alertsEnabled = $v.alertsEnabled;
      _newMatchCount = $v.newMatchCount;
      _lastViewedAt = $v.lastViewedAt;
      _lastAlertAt = $v.lastAlertAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SavedSearchResponse other) {
    _$v = other as _$SavedSearchResponse;
  }

  @override
  void update(void Function(SavedSearchResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SavedSearchResponse build() => _build();

  _$SavedSearchResponse _build() {
    _$SavedSearchResponse _$result;
    try {
      _$result =
          _$v ??
          _$SavedSearchResponse._(
            id: id,
            name: name,
            criteria: _criteria?.build(),
            alertsEnabled: alertsEnabled,
            newMatchCount: newMatchCount,
            lastViewedAt: lastViewedAt,
            lastAlertAt: lastAlertAt,
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'criteria';
        _criteria?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SavedSearchResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
