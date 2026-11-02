// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RequestEmailChangeRequest extends RequestEmailChangeRequest {
  @override
  final String newEmail;

  factory _$RequestEmailChangeRequest([
    void Function(RequestEmailChangeRequestBuilder)? updates,
  ]) => (RequestEmailChangeRequestBuilder()..update(updates))._build();

  _$RequestEmailChangeRequest._({required this.newEmail}) : super._();
  @override
  RequestEmailChangeRequest rebuild(
    void Function(RequestEmailChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RequestEmailChangeRequestBuilder toBuilder() =>
      RequestEmailChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestEmailChangeRequest && newEmail == other.newEmail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newEmail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RequestEmailChangeRequest',
    )..add('newEmail', newEmail)).toString();
  }
}

class RequestEmailChangeRequestBuilder
    implements
        Builder<RequestEmailChangeRequest, RequestEmailChangeRequestBuilder> {
  _$RequestEmailChangeRequest? _$v;

  String? _newEmail;
  String? get newEmail => _$this._newEmail;
  set newEmail(String? newEmail) => _$this._newEmail = newEmail;

  RequestEmailChangeRequestBuilder() {
    RequestEmailChangeRequest._defaults(this);
  }

  RequestEmailChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newEmail = $v.newEmail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestEmailChangeRequest other) {
    _$v = other as _$RequestEmailChangeRequest;
  }

  @override
  void update(void Function(RequestEmailChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestEmailChangeRequest build() => _build();

  _$RequestEmailChangeRequest _build() {
    final _$result =
        _$v ??
        _$RequestEmailChangeRequest._(
          newEmail: BuiltValueNullFieldError.checkNotNull(
            newEmail,
            r'RequestEmailChangeRequest',
            'newEmail',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
