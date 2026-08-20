// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_review.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PropertyReviewTypeEnum _$propertyReviewTypeEnum_VISIT =
    const PropertyReviewTypeEnum._('VISIT');
const PropertyReviewTypeEnum _$propertyReviewTypeEnum_RESIDENT =
    const PropertyReviewTypeEnum._('RESIDENT');
const PropertyReviewTypeEnum _$propertyReviewTypeEnum_unknownDefaultOpenApi =
    const PropertyReviewTypeEnum._('unknownDefaultOpenApi');

PropertyReviewTypeEnum _$propertyReviewTypeEnumValueOf(String name) {
  switch (name) {
    case 'VISIT':
      return _$propertyReviewTypeEnum_VISIT;
    case 'RESIDENT':
      return _$propertyReviewTypeEnum_RESIDENT;
    case 'unknownDefaultOpenApi':
      return _$propertyReviewTypeEnum_unknownDefaultOpenApi;
    default:
      return _$propertyReviewTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PropertyReviewTypeEnum> _$propertyReviewTypeEnumValues =
    BuiltSet<PropertyReviewTypeEnum>(const <PropertyReviewTypeEnum>[
      _$propertyReviewTypeEnum_VISIT,
      _$propertyReviewTypeEnum_RESIDENT,
      _$propertyReviewTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<PropertyReviewTypeEnum> _$propertyReviewTypeEnumSerializer =
    _$PropertyReviewTypeEnumSerializer();

class _$PropertyReviewTypeEnumSerializer
    implements PrimitiveSerializer<PropertyReviewTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'VISIT': 'VISIT',
    'RESIDENT': 'RESIDENT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'VISIT': 'VISIT',
    'RESIDENT': 'RESIDENT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PropertyReviewTypeEnum];
  @override
  final String wireName = 'PropertyReviewTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    PropertyReviewTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PropertyReviewTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PropertyReviewTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PropertyReview extends PropertyReview {
  @override
  final PropertyReviewTypeEnum? type;
  @override
  final String? id;
  @override
  final String? annonceId;
  @override
  final String? authorName;
  @override
  final int? rating;
  @override
  final String? comment;
  @override
  final BuiltList<String>? pros;
  @override
  final BuiltList<String>? cons;
  @override
  final BuiltList<String>? photoKeys;
  @override
  final int? perceivedCondition;
  @override
  final int? residenceMonths;
  @override
  final DateTime? publishedAt;
  @override
  final DateTime? editedAt;
  @override
  final BuiltList<Reply>? replies;

  factory _$PropertyReview([void Function(PropertyReviewBuilder)? updates]) =>
      (PropertyReviewBuilder()..update(updates))._build();

  _$PropertyReview._({
    this.type,
    this.id,
    this.annonceId,
    this.authorName,
    this.rating,
    this.comment,
    this.pros,
    this.cons,
    this.photoKeys,
    this.perceivedCondition,
    this.residenceMonths,
    this.publishedAt,
    this.editedAt,
    this.replies,
  }) : super._();
  @override
  PropertyReview rebuild(void Function(PropertyReviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PropertyReviewBuilder toBuilder() => PropertyReviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PropertyReview &&
        type == other.type &&
        id == other.id &&
        annonceId == other.annonceId &&
        authorName == other.authorName &&
        rating == other.rating &&
        comment == other.comment &&
        pros == other.pros &&
        cons == other.cons &&
        photoKeys == other.photoKeys &&
        perceivedCondition == other.perceivedCondition &&
        residenceMonths == other.residenceMonths &&
        publishedAt == other.publishedAt &&
        editedAt == other.editedAt &&
        replies == other.replies;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jc(_$hash, authorName.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, pros.hashCode);
    _$hash = $jc(_$hash, cons.hashCode);
    _$hash = $jc(_$hash, photoKeys.hashCode);
    _$hash = $jc(_$hash, perceivedCondition.hashCode);
    _$hash = $jc(_$hash, residenceMonths.hashCode);
    _$hash = $jc(_$hash, publishedAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, replies.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PropertyReview')
          ..add('type', type)
          ..add('id', id)
          ..add('annonceId', annonceId)
          ..add('authorName', authorName)
          ..add('rating', rating)
          ..add('comment', comment)
          ..add('pros', pros)
          ..add('cons', cons)
          ..add('photoKeys', photoKeys)
          ..add('perceivedCondition', perceivedCondition)
          ..add('residenceMonths', residenceMonths)
          ..add('publishedAt', publishedAt)
          ..add('editedAt', editedAt)
          ..add('replies', replies))
        .toString();
  }
}

class PropertyReviewBuilder
    implements Builder<PropertyReview, PropertyReviewBuilder> {
  _$PropertyReview? _$v;

  PropertyReviewTypeEnum? _type;
  PropertyReviewTypeEnum? get type => _$this._type;
  set type(PropertyReviewTypeEnum? type) => _$this._type = type;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  String? _authorName;
  String? get authorName => _$this._authorName;
  set authorName(String? authorName) => _$this._authorName = authorName;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ListBuilder<String>? _pros;
  ListBuilder<String> get pros => _$this._pros ??= ListBuilder<String>();
  set pros(ListBuilder<String>? pros) => _$this._pros = pros;

  ListBuilder<String>? _cons;
  ListBuilder<String> get cons => _$this._cons ??= ListBuilder<String>();
  set cons(ListBuilder<String>? cons) => _$this._cons = cons;

  ListBuilder<String>? _photoKeys;
  ListBuilder<String> get photoKeys =>
      _$this._photoKeys ??= ListBuilder<String>();
  set photoKeys(ListBuilder<String>? photoKeys) =>
      _$this._photoKeys = photoKeys;

  int? _perceivedCondition;
  int? get perceivedCondition => _$this._perceivedCondition;
  set perceivedCondition(int? perceivedCondition) =>
      _$this._perceivedCondition = perceivedCondition;

  int? _residenceMonths;
  int? get residenceMonths => _$this._residenceMonths;
  set residenceMonths(int? residenceMonths) =>
      _$this._residenceMonths = residenceMonths;

  DateTime? _publishedAt;
  DateTime? get publishedAt => _$this._publishedAt;
  set publishedAt(DateTime? publishedAt) => _$this._publishedAt = publishedAt;

  DateTime? _editedAt;
  DateTime? get editedAt => _$this._editedAt;
  set editedAt(DateTime? editedAt) => _$this._editedAt = editedAt;

  ListBuilder<Reply>? _replies;
  ListBuilder<Reply> get replies => _$this._replies ??= ListBuilder<Reply>();
  set replies(ListBuilder<Reply>? replies) => _$this._replies = replies;

  PropertyReviewBuilder() {
    PropertyReview._defaults(this);
  }

  PropertyReviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _id = $v.id;
      _annonceId = $v.annonceId;
      _authorName = $v.authorName;
      _rating = $v.rating;
      _comment = $v.comment;
      _pros = $v.pros?.toBuilder();
      _cons = $v.cons?.toBuilder();
      _photoKeys = $v.photoKeys?.toBuilder();
      _perceivedCondition = $v.perceivedCondition;
      _residenceMonths = $v.residenceMonths;
      _publishedAt = $v.publishedAt;
      _editedAt = $v.editedAt;
      _replies = $v.replies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PropertyReview other) {
    _$v = other as _$PropertyReview;
  }

  @override
  void update(void Function(PropertyReviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PropertyReview build() => _build();

  _$PropertyReview _build() {
    _$PropertyReview _$result;
    try {
      _$result =
          _$v ??
          _$PropertyReview._(
            type: type,
            id: id,
            annonceId: annonceId,
            authorName: authorName,
            rating: rating,
            comment: comment,
            pros: _pros?.build(),
            cons: _cons?.build(),
            photoKeys: _photoKeys?.build(),
            perceivedCondition: perceivedCondition,
            residenceMonths: residenceMonths,
            publishedAt: publishedAt,
            editedAt: editedAt,
            replies: _replies?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pros';
        _pros?.build();
        _$failedField = 'cons';
        _cons?.build();
        _$failedField = 'photoKeys';
        _photoKeys?.build();

        _$failedField = 'replies';
        _replies?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PropertyReview',
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
