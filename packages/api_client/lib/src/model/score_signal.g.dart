// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_signal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ScoreSignalCodeEnum _$scoreSignalCodeEnum_PROFILE_COMPLETE =
    const ScoreSignalCodeEnum._('PROFILE_COMPLETE');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_IDENTITY_VERIFIED =
    const ScoreSignalCodeEnum._('IDENTITY_VERIFIED');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_ACCOUNT_SENIORITY =
    const ScoreSignalCodeEnum._('ACCOUNT_SENIORITY');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_SIGNED_CONTRACTS =
    const ScoreSignalCodeEnum._('SIGNED_CONTRACTS');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_PROVIDER_RATING =
    const ScoreSignalCodeEnum._('PROVIDER_RATING');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_VALIDATED_REPORTS =
    const ScoreSignalCodeEnum._('VALIDATED_REPORTS');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_ADMIN_ADJUSTMENT =
    const ScoreSignalCodeEnum._('ADMIN_ADJUSTMENT');
const ScoreSignalCodeEnum _$scoreSignalCodeEnum_unknownDefaultOpenApi =
    const ScoreSignalCodeEnum._('unknownDefaultOpenApi');

ScoreSignalCodeEnum _$scoreSignalCodeEnumValueOf(String name) {
  switch (name) {
    case 'PROFILE_COMPLETE':
      return _$scoreSignalCodeEnum_PROFILE_COMPLETE;
    case 'IDENTITY_VERIFIED':
      return _$scoreSignalCodeEnum_IDENTITY_VERIFIED;
    case 'ACCOUNT_SENIORITY':
      return _$scoreSignalCodeEnum_ACCOUNT_SENIORITY;
    case 'SIGNED_CONTRACTS':
      return _$scoreSignalCodeEnum_SIGNED_CONTRACTS;
    case 'PROVIDER_RATING':
      return _$scoreSignalCodeEnum_PROVIDER_RATING;
    case 'VALIDATED_REPORTS':
      return _$scoreSignalCodeEnum_VALIDATED_REPORTS;
    case 'ADMIN_ADJUSTMENT':
      return _$scoreSignalCodeEnum_ADMIN_ADJUSTMENT;
    case 'unknownDefaultOpenApi':
      return _$scoreSignalCodeEnum_unknownDefaultOpenApi;
    default:
      return _$scoreSignalCodeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ScoreSignalCodeEnum> _$scoreSignalCodeEnumValues =
    BuiltSet<ScoreSignalCodeEnum>(const <ScoreSignalCodeEnum>[
      _$scoreSignalCodeEnum_PROFILE_COMPLETE,
      _$scoreSignalCodeEnum_IDENTITY_VERIFIED,
      _$scoreSignalCodeEnum_ACCOUNT_SENIORITY,
      _$scoreSignalCodeEnum_SIGNED_CONTRACTS,
      _$scoreSignalCodeEnum_PROVIDER_RATING,
      _$scoreSignalCodeEnum_VALIDATED_REPORTS,
      _$scoreSignalCodeEnum_ADMIN_ADJUSTMENT,
      _$scoreSignalCodeEnum_unknownDefaultOpenApi,
    ]);

Serializer<ScoreSignalCodeEnum> _$scoreSignalCodeEnumSerializer =
    _$ScoreSignalCodeEnumSerializer();

class _$ScoreSignalCodeEnumSerializer
    implements PrimitiveSerializer<ScoreSignalCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PROFILE_COMPLETE': 'PROFILE_COMPLETE',
    'IDENTITY_VERIFIED': 'IDENTITY_VERIFIED',
    'ACCOUNT_SENIORITY': 'ACCOUNT_SENIORITY',
    'SIGNED_CONTRACTS': 'SIGNED_CONTRACTS',
    'PROVIDER_RATING': 'PROVIDER_RATING',
    'VALIDATED_REPORTS': 'VALIDATED_REPORTS',
    'ADMIN_ADJUSTMENT': 'ADMIN_ADJUSTMENT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PROFILE_COMPLETE': 'PROFILE_COMPLETE',
    'IDENTITY_VERIFIED': 'IDENTITY_VERIFIED',
    'ACCOUNT_SENIORITY': 'ACCOUNT_SENIORITY',
    'SIGNED_CONTRACTS': 'SIGNED_CONTRACTS',
    'PROVIDER_RATING': 'PROVIDER_RATING',
    'VALIDATED_REPORTS': 'VALIDATED_REPORTS',
    'ADMIN_ADJUSTMENT': 'ADMIN_ADJUSTMENT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ScoreSignalCodeEnum];
  @override
  final String wireName = 'ScoreSignalCodeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ScoreSignalCodeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ScoreSignalCodeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ScoreSignalCodeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ScoreSignal extends ScoreSignal {
  @override
  final ScoreSignalCodeEnum? code;
  @override
  final int? points;
  @override
  final int? maxPoints;
  @override
  final int? count;
  @override
  final bool? available;

  factory _$ScoreSignal([void Function(ScoreSignalBuilder)? updates]) =>
      (ScoreSignalBuilder()..update(updates))._build();

  _$ScoreSignal._({
    this.code,
    this.points,
    this.maxPoints,
    this.count,
    this.available,
  }) : super._();
  @override
  ScoreSignal rebuild(void Function(ScoreSignalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoreSignalBuilder toBuilder() => ScoreSignalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreSignal &&
        code == other.code &&
        points == other.points &&
        maxPoints == other.maxPoints &&
        count == other.count &&
        available == other.available;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, points.hashCode);
    _$hash = $jc(_$hash, maxPoints.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoreSignal')
          ..add('code', code)
          ..add('points', points)
          ..add('maxPoints', maxPoints)
          ..add('count', count)
          ..add('available', available))
        .toString();
  }
}

class ScoreSignalBuilder implements Builder<ScoreSignal, ScoreSignalBuilder> {
  _$ScoreSignal? _$v;

  ScoreSignalCodeEnum? _code;
  ScoreSignalCodeEnum? get code => _$this._code;
  set code(ScoreSignalCodeEnum? code) => _$this._code = code;

  int? _points;
  int? get points => _$this._points;
  set points(int? points) => _$this._points = points;

  int? _maxPoints;
  int? get maxPoints => _$this._maxPoints;
  set maxPoints(int? maxPoints) => _$this._maxPoints = maxPoints;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _available;
  bool? get available => _$this._available;
  set available(bool? available) => _$this._available = available;

  ScoreSignalBuilder() {
    ScoreSignal._defaults(this);
  }

  ScoreSignalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _points = $v.points;
      _maxPoints = $v.maxPoints;
      _count = $v.count;
      _available = $v.available;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoreSignal other) {
    _$v = other as _$ScoreSignal;
  }

  @override
  void update(void Function(ScoreSignalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoreSignal build() => _build();

  _$ScoreSignal _build() {
    final _$result =
        _$v ??
        _$ScoreSignal._(
          code: code,
          points: points,
          maxPoints: maxPoints,
          count: count,
          available: available,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
