// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_search_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaveSearchRequest extends SaveSearchRequest {
  @override
  final SearchCriteria criteria;
  @override
  final String? name;
  @override
  final bool? alertsEnabled;

  factory _$SaveSearchRequest([
    void Function(SaveSearchRequestBuilder)? updates,
  ]) => (SaveSearchRequestBuilder()..update(updates))._build();

  _$SaveSearchRequest._({required this.criteria, this.name, this.alertsEnabled})
    : super._();
  @override
  SaveSearchRequest rebuild(void Function(SaveSearchRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SaveSearchRequestBuilder toBuilder() =>
      SaveSearchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaveSearchRequest &&
        criteria == other.criteria &&
        name == other.name &&
        alertsEnabled == other.alertsEnabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, criteria.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, alertsEnabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SaveSearchRequest')
          ..add('criteria', criteria)
          ..add('name', name)
          ..add('alertsEnabled', alertsEnabled))
        .toString();
  }
}

class SaveSearchRequestBuilder
    implements Builder<SaveSearchRequest, SaveSearchRequestBuilder> {
  _$SaveSearchRequest? _$v;

  SearchCriteriaBuilder? _criteria;
  SearchCriteriaBuilder get criteria =>
      _$this._criteria ??= SearchCriteriaBuilder();
  set criteria(SearchCriteriaBuilder? criteria) => _$this._criteria = criteria;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _alertsEnabled;
  bool? get alertsEnabled => _$this._alertsEnabled;
  set alertsEnabled(bool? alertsEnabled) =>
      _$this._alertsEnabled = alertsEnabled;

  SaveSearchRequestBuilder() {
    SaveSearchRequest._defaults(this);
  }

  SaveSearchRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _criteria = $v.criteria.toBuilder();
      _name = $v.name;
      _alertsEnabled = $v.alertsEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SaveSearchRequest other) {
    _$v = other as _$SaveSearchRequest;
  }

  @override
  void update(void Function(SaveSearchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaveSearchRequest build() => _build();

  _$SaveSearchRequest _build() {
    _$SaveSearchRequest _$result;
    try {
      _$result =
          _$v ??
          _$SaveSearchRequest._(
            criteria: criteria.build(),
            name: name,
            alertsEnabled: alertsEnabled,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'criteria';
        criteria.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SaveSearchRequest',
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
