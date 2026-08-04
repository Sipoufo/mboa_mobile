// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_phone_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmPhoneChangeRequest extends ConfirmPhoneChangeRequest {
  @override
  final String newPhoneNumber;
  @override
  final String oldCode;
  @override
  final String newCode;

  factory _$ConfirmPhoneChangeRequest([
    void Function(ConfirmPhoneChangeRequestBuilder)? updates,
  ]) => (ConfirmPhoneChangeRequestBuilder()..update(updates))._build();

  _$ConfirmPhoneChangeRequest._({
    required this.newPhoneNumber,
    required this.oldCode,
    required this.newCode,
  }) : super._();
  @override
  ConfirmPhoneChangeRequest rebuild(
    void Function(ConfirmPhoneChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfirmPhoneChangeRequestBuilder toBuilder() =>
      ConfirmPhoneChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmPhoneChangeRequest &&
        newPhoneNumber == other.newPhoneNumber &&
        oldCode == other.oldCode &&
        newCode == other.newCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPhoneNumber.hashCode);
    _$hash = $jc(_$hash, oldCode.hashCode);
    _$hash = $jc(_$hash, newCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfirmPhoneChangeRequest')
          ..add('newPhoneNumber', newPhoneNumber)
          ..add('oldCode', oldCode)
          ..add('newCode', newCode))
        .toString();
  }
}

class ConfirmPhoneChangeRequestBuilder
    implements
        Builder<ConfirmPhoneChangeRequest, ConfirmPhoneChangeRequestBuilder> {
  _$ConfirmPhoneChangeRequest? _$v;

  String? _newPhoneNumber;
  String? get newPhoneNumber => _$this._newPhoneNumber;
  set newPhoneNumber(String? newPhoneNumber) =>
      _$this._newPhoneNumber = newPhoneNumber;

  String? _oldCode;
  String? get oldCode => _$this._oldCode;
  set oldCode(String? oldCode) => _$this._oldCode = oldCode;

  String? _newCode;
  String? get newCode => _$this._newCode;
  set newCode(String? newCode) => _$this._newCode = newCode;

  ConfirmPhoneChangeRequestBuilder() {
    ConfirmPhoneChangeRequest._defaults(this);
  }

  ConfirmPhoneChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPhoneNumber = $v.newPhoneNumber;
      _oldCode = $v.oldCode;
      _newCode = $v.newCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmPhoneChangeRequest other) {
    _$v = other as _$ConfirmPhoneChangeRequest;
  }

  @override
  void update(void Function(ConfirmPhoneChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmPhoneChangeRequest build() => _build();

  _$ConfirmPhoneChangeRequest _build() {
    final _$result =
        _$v ??
        _$ConfirmPhoneChangeRequest._(
          newPhoneNumber: BuiltValueNullFieldError.checkNotNull(
            newPhoneNumber,
            r'ConfirmPhoneChangeRequest',
            'newPhoneNumber',
          ),
          oldCode: BuiltValueNullFieldError.checkNotNull(
            oldCode,
            r'ConfirmPhoneChangeRequest',
            'oldCode',
          ),
          newCode: BuiltValueNullFieldError.checkNotNull(
            newCode,
            r'ConfirmPhoneChangeRequest',
            'newCode',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
