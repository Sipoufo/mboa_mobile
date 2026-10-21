// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_request_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HomeRequestStatusRequestStatusEnum
_$homeRequestStatusRequestStatusEnum_SENT =
    const HomeRequestStatusRequestStatusEnum._('SENT');
const HomeRequestStatusRequestStatusEnum
_$homeRequestStatusRequestStatusEnum_SEEN =
    const HomeRequestStatusRequestStatusEnum._('SEEN');
const HomeRequestStatusRequestStatusEnum
_$homeRequestStatusRequestStatusEnum_IN_PROGRESS =
    const HomeRequestStatusRequestStatusEnum._('IN_PROGRESS');
const HomeRequestStatusRequestStatusEnum
_$homeRequestStatusRequestStatusEnum_RESOLVED =
    const HomeRequestStatusRequestStatusEnum._('RESOLVED');
const HomeRequestStatusRequestStatusEnum
_$homeRequestStatusRequestStatusEnum_CLOSED =
    const HomeRequestStatusRequestStatusEnum._('CLOSED');
const HomeRequestStatusRequestStatusEnum
_$homeRequestStatusRequestStatusEnum_unknownDefaultOpenApi =
    const HomeRequestStatusRequestStatusEnum._('unknownDefaultOpenApi');

HomeRequestStatusRequestStatusEnum _$homeRequestStatusRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'SENT':
      return _$homeRequestStatusRequestStatusEnum_SENT;
    case 'SEEN':
      return _$homeRequestStatusRequestStatusEnum_SEEN;
    case 'IN_PROGRESS':
      return _$homeRequestStatusRequestStatusEnum_IN_PROGRESS;
    case 'RESOLVED':
      return _$homeRequestStatusRequestStatusEnum_RESOLVED;
    case 'CLOSED':
      return _$homeRequestStatusRequestStatusEnum_CLOSED;
    case 'unknownDefaultOpenApi':
      return _$homeRequestStatusRequestStatusEnum_unknownDefaultOpenApi;
    default:
      return _$homeRequestStatusRequestStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeRequestStatusRequestStatusEnum>
_$homeRequestStatusRequestStatusEnumValues =
    BuiltSet<HomeRequestStatusRequestStatusEnum>(
      const <HomeRequestStatusRequestStatusEnum>[
        _$homeRequestStatusRequestStatusEnum_SENT,
        _$homeRequestStatusRequestStatusEnum_SEEN,
        _$homeRequestStatusRequestStatusEnum_IN_PROGRESS,
        _$homeRequestStatusRequestStatusEnum_RESOLVED,
        _$homeRequestStatusRequestStatusEnum_CLOSED,
        _$homeRequestStatusRequestStatusEnum_unknownDefaultOpenApi,
      ],
    );

Serializer<HomeRequestStatusRequestStatusEnum>
_$homeRequestStatusRequestStatusEnumSerializer =
    _$HomeRequestStatusRequestStatusEnumSerializer();

class _$HomeRequestStatusRequestStatusEnumSerializer
    implements PrimitiveSerializer<HomeRequestStatusRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SENT': 'SENT',
    'SEEN': 'SEEN',
    'IN_PROGRESS': 'IN_PROGRESS',
    'RESOLVED': 'RESOLVED',
    'CLOSED': 'CLOSED',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SENT': 'SENT',
    'SEEN': 'SEEN',
    'IN_PROGRESS': 'IN_PROGRESS',
    'RESOLVED': 'RESOLVED',
    'CLOSED': 'CLOSED',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HomeRequestStatusRequestStatusEnum];
  @override
  final String wireName = 'HomeRequestStatusRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestStatusRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeRequestStatusRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeRequestStatusRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeRequestStatusRequest extends HomeRequestStatusRequest {
  @override
  final HomeRequestStatusRequestStatusEnum status;
  @override
  final String? note;

  factory _$HomeRequestStatusRequest([
    void Function(HomeRequestStatusRequestBuilder)? updates,
  ]) => (HomeRequestStatusRequestBuilder()..update(updates))._build();

  _$HomeRequestStatusRequest._({required this.status, this.note}) : super._();
  @override
  HomeRequestStatusRequest rebuild(
    void Function(HomeRequestStatusRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HomeRequestStatusRequestBuilder toBuilder() =>
      HomeRequestStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeRequestStatusRequest &&
        status == other.status &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeRequestStatusRequest')
          ..add('status', status)
          ..add('note', note))
        .toString();
  }
}

class HomeRequestStatusRequestBuilder
    implements
        Builder<HomeRequestStatusRequest, HomeRequestStatusRequestBuilder> {
  _$HomeRequestStatusRequest? _$v;

  HomeRequestStatusRequestStatusEnum? _status;
  HomeRequestStatusRequestStatusEnum? get status => _$this._status;
  set status(HomeRequestStatusRequestStatusEnum? status) =>
      _$this._status = status;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  HomeRequestStatusRequestBuilder() {
    HomeRequestStatusRequest._defaults(this);
  }

  HomeRequestStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeRequestStatusRequest other) {
    _$v = other as _$HomeRequestStatusRequest;
  }

  @override
  void update(void Function(HomeRequestStatusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeRequestStatusRequest build() => _build();

  _$HomeRequestStatusRequest _build() {
    final _$result =
        _$v ??
        _$HomeRequestStatusRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HomeRequestStatusRequest',
            'status',
          ),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
