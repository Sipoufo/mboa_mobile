// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond_to_change_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RespondToChangeRequest extends RespondToChangeRequest {
  @override
  final String body;

  factory _$RespondToChangeRequest([
    void Function(RespondToChangeRequestBuilder)? updates,
  ]) => (RespondToChangeRequestBuilder()..update(updates))._build();

  _$RespondToChangeRequest._({required this.body}) : super._();
  @override
  RespondToChangeRequest rebuild(
    void Function(RespondToChangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RespondToChangeRequestBuilder toBuilder() =>
      RespondToChangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RespondToChangeRequest && body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RespondToChangeRequest',
    )..add('body', body)).toString();
  }
}

class RespondToChangeRequestBuilder
    implements Builder<RespondToChangeRequest, RespondToChangeRequestBuilder> {
  _$RespondToChangeRequest? _$v;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  RespondToChangeRequestBuilder() {
    RespondToChangeRequest._defaults(this);
  }

  RespondToChangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RespondToChangeRequest other) {
    _$v = other as _$RespondToChangeRequest;
  }

  @override
  void update(void Function(RespondToChangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RespondToChangeRequest build() => _build();

  _$RespondToChangeRequest _build() {
    final _$result =
        _$v ??
        _$RespondToChangeRequest._(
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'RespondToChangeRequest',
            'body',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
