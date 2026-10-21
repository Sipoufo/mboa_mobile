// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_request_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HomeRequestResponseTypeEnum _$homeRequestResponseTypeEnum_REMARK =
    const HomeRequestResponseTypeEnum._('REMARK');
const HomeRequestResponseTypeEnum _$homeRequestResponseTypeEnum_MAINTENANCE =
    const HomeRequestResponseTypeEnum._('MAINTENANCE');
const HomeRequestResponseTypeEnum _$homeRequestResponseTypeEnum_QUESTION =
    const HomeRequestResponseTypeEnum._('QUESTION');
const HomeRequestResponseTypeEnum
_$homeRequestResponseTypeEnum_unknownDefaultOpenApi =
    const HomeRequestResponseTypeEnum._('unknownDefaultOpenApi');

HomeRequestResponseTypeEnum _$homeRequestResponseTypeEnumValueOf(String name) {
  switch (name) {
    case 'REMARK':
      return _$homeRequestResponseTypeEnum_REMARK;
    case 'MAINTENANCE':
      return _$homeRequestResponseTypeEnum_MAINTENANCE;
    case 'QUESTION':
      return _$homeRequestResponseTypeEnum_QUESTION;
    case 'unknownDefaultOpenApi':
      return _$homeRequestResponseTypeEnum_unknownDefaultOpenApi;
    default:
      return _$homeRequestResponseTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeRequestResponseTypeEnum>
_$homeRequestResponseTypeEnumValues =
    BuiltSet<HomeRequestResponseTypeEnum>(const <HomeRequestResponseTypeEnum>[
      _$homeRequestResponseTypeEnum_REMARK,
      _$homeRequestResponseTypeEnum_MAINTENANCE,
      _$homeRequestResponseTypeEnum_QUESTION,
      _$homeRequestResponseTypeEnum_unknownDefaultOpenApi,
    ]);

const HomeRequestResponseStatusEnum _$homeRequestResponseStatusEnum_SENT =
    const HomeRequestResponseStatusEnum._('SENT');
const HomeRequestResponseStatusEnum _$homeRequestResponseStatusEnum_SEEN =
    const HomeRequestResponseStatusEnum._('SEEN');
const HomeRequestResponseStatusEnum
_$homeRequestResponseStatusEnum_IN_PROGRESS =
    const HomeRequestResponseStatusEnum._('IN_PROGRESS');
const HomeRequestResponseStatusEnum _$homeRequestResponseStatusEnum_RESOLVED =
    const HomeRequestResponseStatusEnum._('RESOLVED');
const HomeRequestResponseStatusEnum _$homeRequestResponseStatusEnum_CLOSED =
    const HomeRequestResponseStatusEnum._('CLOSED');
const HomeRequestResponseStatusEnum
_$homeRequestResponseStatusEnum_unknownDefaultOpenApi =
    const HomeRequestResponseStatusEnum._('unknownDefaultOpenApi');

HomeRequestResponseStatusEnum _$homeRequestResponseStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'SENT':
      return _$homeRequestResponseStatusEnum_SENT;
    case 'SEEN':
      return _$homeRequestResponseStatusEnum_SEEN;
    case 'IN_PROGRESS':
      return _$homeRequestResponseStatusEnum_IN_PROGRESS;
    case 'RESOLVED':
      return _$homeRequestResponseStatusEnum_RESOLVED;
    case 'CLOSED':
      return _$homeRequestResponseStatusEnum_CLOSED;
    case 'unknownDefaultOpenApi':
      return _$homeRequestResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$homeRequestResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HomeRequestResponseStatusEnum>
_$homeRequestResponseStatusEnumValues = BuiltSet<HomeRequestResponseStatusEnum>(
  const <HomeRequestResponseStatusEnum>[
    _$homeRequestResponseStatusEnum_SENT,
    _$homeRequestResponseStatusEnum_SEEN,
    _$homeRequestResponseStatusEnum_IN_PROGRESS,
    _$homeRequestResponseStatusEnum_RESOLVED,
    _$homeRequestResponseStatusEnum_CLOSED,
    _$homeRequestResponseStatusEnum_unknownDefaultOpenApi,
  ],
);

Serializer<HomeRequestResponseTypeEnum>
_$homeRequestResponseTypeEnumSerializer =
    _$HomeRequestResponseTypeEnumSerializer();
Serializer<HomeRequestResponseStatusEnum>
_$homeRequestResponseStatusEnumSerializer =
    _$HomeRequestResponseStatusEnumSerializer();

class _$HomeRequestResponseTypeEnumSerializer
    implements PrimitiveSerializer<HomeRequestResponseTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'REMARK': 'REMARK',
    'MAINTENANCE': 'MAINTENANCE',
    'QUESTION': 'QUESTION',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'REMARK': 'REMARK',
    'MAINTENANCE': 'MAINTENANCE',
    'QUESTION': 'QUESTION',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HomeRequestResponseTypeEnum];
  @override
  final String wireName = 'HomeRequestResponseTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestResponseTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeRequestResponseTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeRequestResponseTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeRequestResponseStatusEnumSerializer
    implements PrimitiveSerializer<HomeRequestResponseStatusEnum> {
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
  final Iterable<Type> types = const <Type>[HomeRequestResponseStatusEnum];
  @override
  final String wireName = 'HomeRequestResponseStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HomeRequestResponseStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HomeRequestResponseStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HomeRequestResponseStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HomeRequestResponse extends HomeRequestResponse {
  @override
  final String? id;
  @override
  final String? contractId;
  @override
  final String? annonceId;
  @override
  final String? annonceTitle;
  @override
  final ParticipantSummary? tenant;
  @override
  final String? conversationId;
  @override
  final HomeRequestResponseTypeEnum? type;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final HomeRequestResponseStatusEnum? status;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final BuiltList<String>? photoUrls;
  @override
  final BuiltList<HomeRequestEventResponse>? history;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final bool? canStart;
  @override
  final bool? canResolve;
  @override
  final bool? canClose;
  @override
  final bool? canReopen;

  factory _$HomeRequestResponse([
    void Function(HomeRequestResponseBuilder)? updates,
  ]) => (HomeRequestResponseBuilder()..update(updates))._build();

  _$HomeRequestResponse._({
    this.id,
    this.contractId,
    this.annonceId,
    this.annonceTitle,
    this.tenant,
    this.conversationId,
    this.type,
    this.title,
    this.description,
    this.status,
    this.photoKeys,
    this.photoUrls,
    this.history,
    this.createdAt,
    this.updatedAt,
    this.canStart,
    this.canResolve,
    this.canClose,
    this.canReopen,
  }) : super._();
  @override
  HomeRequestResponse rebuild(
    void Function(HomeRequestResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HomeRequestResponseBuilder toBuilder() =>
      HomeRequestResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeRequestResponse &&
        id == other.id &&
        contractId == other.contractId &&
        annonceId == other.annonceId &&
        annonceTitle == other.annonceTitle &&
        tenant == other.tenant &&
        conversationId == other.conversationId &&
        type == other.type &&
        title == other.title &&
        description == other.description &&
        status == other.status &&
        photoKeys == other.photoKeys &&
        photoUrls == other.photoUrls &&
        history == other.history &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        canStart == other.canStart &&
        canResolve == other.canResolve &&
        canClose == other.canClose &&
        canReopen == other.canReopen;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, contractId.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, annonceTitle.hashCode);
    _$hash = $jc(_$hash, tenant.hashCode);
    _$hash = $jc(_$hash, conversationId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, photoUrls.hashCode);
    _$hash = $jc(_$hash, history.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, canStart.hashCode);
    _$hash = $jc(_$hash, canResolve.hashCode);
    _$hash = $jc(_$hash, canClose.hashCode);
    _$hash = $jc(_$hash, canReopen.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeRequestResponse')
          ..add('id', id)
          ..add('contractId', contractId)
          ..add('annonceId', annonceId)
          ..add('annonceTitle', annonceTitle)
          ..add('tenant', tenant)
          ..add('conversationId', conversationId)
          ..add('type', type)
          ..add('title', title)
          ..add('description', description)
          ..add('status', status)
          ..add('photoKeys', photoKeys)
          ..add('photoUrls', photoUrls)
          ..add('history', history)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('canStart', canStart)
          ..add('canResolve', canResolve)
          ..add('canClose', canClose)
          ..add('canReopen', canReopen))
        .toString();
  }
}

class HomeRequestResponseBuilder
    implements Builder<HomeRequestResponse, HomeRequestResponseBuilder> {
  _$HomeRequestResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _contractId;
  String? get contractId => _$this._contractId;
  set contractId(String? contractId) => _$this._contractId = contractId;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _annonceTitle;
  String? get annonceTitle => _$this._annonceTitle;
  set annonceTitle(String? annonceTitle) => _$this._annonceTitle = annonceTitle;

  ParticipantSummaryBuilder? _tenant;
  ParticipantSummaryBuilder get tenant =>
      _$this._tenant ??= ParticipantSummaryBuilder();
  set tenant(ParticipantSummaryBuilder? tenant) => _$this._tenant = tenant;

  String? _conversationId;
  String? get conversationId => _$this._conversationId;
  set conversationId(String? conversationId) =>
      _$this._conversationId = conversationId;

  HomeRequestResponseTypeEnum? _type;
  HomeRequestResponseTypeEnum? get type => _$this._type;
  set type(HomeRequestResponseTypeEnum? type) => _$this._type = type;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  HomeRequestResponseStatusEnum? _status;
  HomeRequestResponseStatusEnum? get status => _$this._status;
  set status(HomeRequestResponseStatusEnum? status) => _$this._status = status;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  ListBuilder<String>? _photoUrls;
  ListBuilder<String> get photoUrls =>
      _$this._photoUrls ??= ListBuilder<String>();
  set photoUrls(ListBuilder<String>? photoUrls) =>
      _$this._photoUrls = photoUrls;

  ListBuilder<HomeRequestEventResponse>? _history;
  ListBuilder<HomeRequestEventResponse> get history =>
      _$this._history ??= ListBuilder<HomeRequestEventResponse>();
  set history(ListBuilder<HomeRequestEventResponse>? history) =>
      _$this._history = history;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  bool? _canStart;
  bool? get canStart => _$this._canStart;
  set canStart(bool? canStart) => _$this._canStart = canStart;

  bool? _canResolve;
  bool? get canResolve => _$this._canResolve;
  set canResolve(bool? canResolve) => _$this._canResolve = canResolve;

  bool? _canClose;
  bool? get canClose => _$this._canClose;
  set canClose(bool? canClose) => _$this._canClose = canClose;

  bool? _canReopen;
  bool? get canReopen => _$this._canReopen;
  set canReopen(bool? canReopen) => _$this._canReopen = canReopen;

  HomeRequestResponseBuilder() {
    HomeRequestResponse._defaults(this);
  }

  HomeRequestResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _contractId = $v.contractId;
      _annonceId = $v.annonceId;
      _annonceTitle = $v.annonceTitle;
      _tenant = $v.tenant?.toBuilder();
      _conversationId = $v.conversationId;
      _type = $v.type;
      _title = $v.title;
      _description = $v.description;
      _status = $v.status;
      _photoKeys = $v.photoKeys?.toBuilder();
      _photoUrls = $v.photoUrls?.toBuilder();
      _history = $v.history?.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _canStart = $v.canStart;
      _canResolve = $v.canResolve;
      _canClose = $v.canClose;
      _canReopen = $v.canReopen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeRequestResponse other) {
    _$v = other as _$HomeRequestResponse;
  }

  @override
  void update(void Function(HomeRequestResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeRequestResponse build() => _build();

  _$HomeRequestResponse _build() {
    _$HomeRequestResponse _$result;
    try {
      _$result =
          _$v ??
          _$HomeRequestResponse._(
            id: id,
            contractId: contractId,
            annonceId: annonceId,
            annonceTitle: annonceTitle,
            tenant: _tenant?.build(),
            conversationId: conversationId,
            type: type,
            title: title,
            description: description,
            status: status,
            photoKeys: _photoKeys?.build(),
            photoUrls: _photoUrls?.build(),
            history: _history?.build(),
            createdAt: createdAt,
            updatedAt: updatedAt,
            canStart: canStart,
            canResolve: canResolve,
            canClose: canClose,
            canReopen: canReopen,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tenant';
        _tenant?.build();

        _$failedField = 'photoKeys';
        _photoKeys?.build();
        _$failedField = 'photoUrls';
        _photoUrls?.build();
        _$failedField = 'history';
        _history?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HomeRequestResponse',
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
