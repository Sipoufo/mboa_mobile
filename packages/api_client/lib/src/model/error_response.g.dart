// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ErrorResponse extends ErrorResponse {
  @override
  final DateTime? timestamp;
  @override
  final int? status;
  @override
  final String? error;
  @override
  final String? message;
  @override
  final String? path;
  @override
  final BuiltList<FieldError>? fields;

  factory _$ErrorResponse([void Function(ErrorResponseBuilder)? updates]) =>
      (ErrorResponseBuilder()..update(updates))._build();

  _$ErrorResponse._({
    this.timestamp,
    this.status,
    this.error,
    this.message,
    this.path,
    this.fields,
  }) : super._();
  @override
  ErrorResponse rebuild(void Function(ErrorResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorResponseBuilder toBuilder() => ErrorResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorResponse &&
        timestamp == other.timestamp &&
        status == other.status &&
        error == other.error &&
        message == other.message &&
        path == other.path &&
        fields == other.fields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, fields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorResponse')
          ..add('timestamp', timestamp)
          ..add('status', status)
          ..add('error', error)
          ..add('message', message)
          ..add('path', path)
          ..add('fields', fields))
        .toString();
  }
}

class ErrorResponseBuilder
    implements Builder<ErrorResponse, ErrorResponseBuilder> {
  _$ErrorResponse? _$v;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  ListBuilder<FieldError>? _fields;
  ListBuilder<FieldError> get fields =>
      _$this._fields ??= ListBuilder<FieldError>();
  set fields(ListBuilder<FieldError>? fields) => _$this._fields = fields;

  ErrorResponseBuilder() {
    ErrorResponse._defaults(this);
  }

  ErrorResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _timestamp = $v.timestamp;
      _status = $v.status;
      _error = $v.error;
      _message = $v.message;
      _path = $v.path;
      _fields = $v.fields?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorResponse other) {
    _$v = other as _$ErrorResponse;
  }

  @override
  void update(void Function(ErrorResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorResponse build() => _build();

  _$ErrorResponse _build() {
    _$ErrorResponse _$result;
    try {
      _$result =
          _$v ??
          _$ErrorResponse._(
            timestamp: timestamp,
            status: status,
            error: error,
            message: message,
            path: path,
            fields: _fields?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fields';
        _fields?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ErrorResponse',
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
