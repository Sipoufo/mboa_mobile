// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_email_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmEmailChangeRequest extends ConfirmEmailChangeRequest {
  @override
  final String newEmail;
  @override
  final String? oldCode;
  @override
  final String newCode;

  factory _$ConfirmEmailChangeRequest([
    void Function(ConfirmEmailChangeRequestBuilder)? updates,
  ]) => (ConfirmEmailChangeRequestBuilder()..update(updates))._build();

  _$ConfirmEmailChangeRequest._({
    required this.newEmail,
    this.oldCode,
    required this.newCode,
  }) : super._();
  @override
  ConfirmEmailChangeRequest rebuild(
    void Function(ConfirmEmailChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfirmEmailChangeRequestBuilder toBuilder() =>
      ConfirmEmailChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmEmailChangeRequest &&
        newEmail == other.newEmail &&
        oldCode == other.oldCode &&
        newCode == other.newCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newEmail.hashCode);
    _$hash = $jc(_$hash, oldCode.hashCode);
    _$hash = $jc(_$hash, newCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfirmEmailChangeRequest')
          ..add('newEmail', newEmail)
          ..add('oldCode', oldCode)
          ..add('newCode', newCode))
        .toString();
  }
}

class ConfirmEmailChangeRequestBuilder
    implements
        Builder<ConfirmEmailChangeRequest, ConfirmEmailChangeRequestBuilder> {
  _$ConfirmEmailChangeRequest? _$v;

  String? _newEmail;
  String? get newEmail => _$this._newEmail;
  set newEmail(String? newEmail) => _$this._newEmail = newEmail;

  String? _oldCode;
  String? get oldCode => _$this._oldCode;
  set oldCode(String? oldCode) => _$this._oldCode = oldCode;

  String? _newCode;
  String? get newCode => _$this._newCode;
  set newCode(String? newCode) => _$this._newCode = newCode;

  ConfirmEmailChangeRequestBuilder() {
    ConfirmEmailChangeRequest._defaults(this);
  }

  ConfirmEmailChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newEmail = $v.newEmail;
      _oldCode = $v.oldCode;
      _newCode = $v.newCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmEmailChangeRequest other) {
    _$v = other as _$ConfirmEmailChangeRequest;
  }

  @override
  void update(void Function(ConfirmEmailChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmEmailChangeRequest build() => _build();

  _$ConfirmEmailChangeRequest _build() {
    final _$result =
        _$v ??
        _$ConfirmEmailChangeRequest._(
          newEmail: BuiltValueNullFieldError.checkNotNull(
            newEmail,
            r'ConfirmEmailChangeRequest',
            'newEmail',
          ),
          oldCode: oldCode,
          newCode: BuiltValueNullFieldError.checkNotNull(
            newCode,
            r'ConfirmEmailChangeRequest',
            'newCode',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
