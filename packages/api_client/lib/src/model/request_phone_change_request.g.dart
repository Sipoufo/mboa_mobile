// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_phone_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RequestPhoneChangeRequest extends RequestPhoneChangeRequest {
  @override
  final String newPhoneNumber;

  factory _$RequestPhoneChangeRequest([
    void Function(RequestPhoneChangeRequestBuilder)? updates,
  ]) => (RequestPhoneChangeRequestBuilder()..update(updates))._build();

  _$RequestPhoneChangeRequest._({required this.newPhoneNumber}) : super._();
  @override
  RequestPhoneChangeRequest rebuild(
    void Function(RequestPhoneChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RequestPhoneChangeRequestBuilder toBuilder() =>
      RequestPhoneChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestPhoneChangeRequest &&
        newPhoneNumber == other.newPhoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPhoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RequestPhoneChangeRequest',
    )..add('newPhoneNumber', newPhoneNumber)).toString();
  }
}

class RequestPhoneChangeRequestBuilder
    implements
        Builder<RequestPhoneChangeRequest, RequestPhoneChangeRequestBuilder> {
  _$RequestPhoneChangeRequest? _$v;

  String? _newPhoneNumber;
  String? get newPhoneNumber => _$this._newPhoneNumber;
  set newPhoneNumber(String? newPhoneNumber) =>
      _$this._newPhoneNumber = newPhoneNumber;

  RequestPhoneChangeRequestBuilder() {
    RequestPhoneChangeRequest._defaults(this);
  }

  RequestPhoneChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPhoneNumber = $v.newPhoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestPhoneChangeRequest other) {
    _$v = other as _$RequestPhoneChangeRequest;
  }

  @override
  void update(void Function(RequestPhoneChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestPhoneChangeRequest build() => _build();

  _$RequestPhoneChangeRequest _build() {
    final _$result =
        _$v ??
        _$RequestPhoneChangeRequest._(
          newPhoneNumber: BuiltValueNullFieldError.checkNotNull(
            newPhoneNumber,
            r'RequestPhoneChangeRequest',
            'newPhoneNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
