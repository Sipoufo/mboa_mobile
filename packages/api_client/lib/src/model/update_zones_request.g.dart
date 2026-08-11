// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_zones_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateZonesRequest extends UpdateZonesRequest {
  @override
  final BuiltList<String> cityIds;
  @override
  final BuiltList<String> districtIds;

  factory _$UpdateZonesRequest([
    void Function(UpdateZonesRequestBuilder)? updates,
  ]) => (UpdateZonesRequestBuilder()..update(updates))._build();

  _$UpdateZonesRequest._({required this.cityIds, required this.districtIds})
    : super._();
  @override
  UpdateZonesRequest rebuild(
    void Function(UpdateZonesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateZonesRequestBuilder toBuilder() =>
      UpdateZonesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateZonesRequest &&
        cityIds == other.cityIds &&
        districtIds == other.districtIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cityIds.hashCode);
    _$hash = $jc(_$hash, districtIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateZonesRequest')
          ..add('cityIds', cityIds)
          ..add('districtIds', districtIds))
        .toString();
  }
}

class UpdateZonesRequestBuilder
    implements Builder<UpdateZonesRequest, UpdateZonesRequestBuilder> {
  _$UpdateZonesRequest? _$v;

  ListBuilder<String>? _cityIds;
  ListBuilder<String> get cityIds => _$this._cityIds ??= ListBuilder<String>();
  set cityIds(ListBuilder<String>? cityIds) => _$this._cityIds = cityIds;

  ListBuilder<String>? _districtIds;
  ListBuilder<String> get districtIds =>
      _$this._districtIds ??= ListBuilder<String>();
  set districtIds(ListBuilder<String>? districtIds) =>
      _$this._districtIds = districtIds;

  UpdateZonesRequestBuilder() {
    UpdateZonesRequest._defaults(this);
  }

  UpdateZonesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cityIds = $v.cityIds.toBuilder();
      _districtIds = $v.districtIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateZonesRequest other) {
    _$v = other as _$UpdateZonesRequest;
  }

  @override
  void update(void Function(UpdateZonesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateZonesRequest build() => _build();

  _$UpdateZonesRequest _build() {
    _$UpdateZonesRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateZonesRequest._(
            cityIds: cityIds.build(),
            districtIds: districtIds.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cityIds';
        cityIds.build();
        _$failedField = 'districtIds';
        districtIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateZonesRequest',
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
