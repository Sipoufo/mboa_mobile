// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AssignmentItemTypeEnum _$assignmentItemTypeEnum_LISTING =
    const AssignmentItemTypeEnum._('LISTING');
const AssignmentItemTypeEnum _$assignmentItemTypeEnum_RESIDENCE =
    const AssignmentItemTypeEnum._('RESIDENCE');
const AssignmentItemTypeEnum _$assignmentItemTypeEnum_unknownDefaultOpenApi =
    const AssignmentItemTypeEnum._('unknownDefaultOpenApi');

AssignmentItemTypeEnum _$assignmentItemTypeEnumValueOf(String name) {
  switch (name) {
    case 'LISTING':
      return _$assignmentItemTypeEnum_LISTING;
    case 'RESIDENCE':
      return _$assignmentItemTypeEnum_RESIDENCE;
    case 'unknownDefaultOpenApi':
      return _$assignmentItemTypeEnum_unknownDefaultOpenApi;
    default:
      return _$assignmentItemTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AssignmentItemTypeEnum> _$assignmentItemTypeEnumValues =
    BuiltSet<AssignmentItemTypeEnum>(const <AssignmentItemTypeEnum>[
      _$assignmentItemTypeEnum_LISTING,
      _$assignmentItemTypeEnum_RESIDENCE,
      _$assignmentItemTypeEnum_unknownDefaultOpenApi,
    ]);

Serializer<AssignmentItemTypeEnum> _$assignmentItemTypeEnumSerializer =
    _$AssignmentItemTypeEnumSerializer();

class _$AssignmentItemTypeEnumSerializer
    implements PrimitiveSerializer<AssignmentItemTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LISTING': 'LISTING',
    'RESIDENCE': 'RESIDENCE',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LISTING': 'LISTING',
    'RESIDENCE': 'RESIDENCE',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AssignmentItemTypeEnum];
  @override
  final String wireName = 'AssignmentItemTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AssignmentItemTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AssignmentItemTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AssignmentItemTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AssignmentItem extends AssignmentItem {
  @override
  final AssignmentItemTypeEnum? type;
  @override
  final AssignmentResponse? assignment;
  @override
  final ResidenceAssignmentSummary? residence;

  factory _$AssignmentItem([void Function(AssignmentItemBuilder)? updates]) =>
      (AssignmentItemBuilder()..update(updates))._build();

  _$AssignmentItem._({this.type, this.assignment, this.residence}) : super._();
  @override
  AssignmentItem rebuild(void Function(AssignmentItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignmentItemBuilder toBuilder() => AssignmentItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignmentItem &&
        type == other.type &&
        assignment == other.assignment &&
        residence == other.residence;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, assignment.hashCode);
    _$hash = $jc(_$hash, residence.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignmentItem')
          ..add('type', type)
          ..add('assignment', assignment)
          ..add('residence', residence))
        .toString();
  }
}

class AssignmentItemBuilder
    implements Builder<AssignmentItem, AssignmentItemBuilder> {
  _$AssignmentItem? _$v;

  AssignmentItemTypeEnum? _type;
  AssignmentItemTypeEnum? get type => _$this._type;
  set type(AssignmentItemTypeEnum? type) => _$this._type = type;

  AssignmentResponseBuilder? _assignment;
  AssignmentResponseBuilder get assignment =>
      _$this._assignment ??= AssignmentResponseBuilder();
  set assignment(AssignmentResponseBuilder? assignment) =>
      _$this._assignment = assignment;

  ResidenceAssignmentSummaryBuilder? _residence;
  ResidenceAssignmentSummaryBuilder get residence =>
      _$this._residence ??= ResidenceAssignmentSummaryBuilder();
  set residence(ResidenceAssignmentSummaryBuilder? residence) =>
      _$this._residence = residence;

  AssignmentItemBuilder() {
    AssignmentItem._defaults(this);
  }

  AssignmentItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _assignment = $v.assignment?.toBuilder();
      _residence = $v.residence?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignmentItem other) {
    _$v = other as _$AssignmentItem;
  }

  @override
  void update(void Function(AssignmentItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignmentItem build() => _build();

  _$AssignmentItem _build() {
    _$AssignmentItem _$result;
    try {
      _$result =
          _$v ??
          _$AssignmentItem._(
            type: type,
            assignment: _assignment?.build(),
            residence: _residence?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignment';
        _assignment?.build();
        _$failedField = 'residence';
        _residence?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AssignmentItem',
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
