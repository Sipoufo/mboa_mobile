// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_request_note_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeRequestNoteRequest extends HomeRequestNoteRequest {
  @override
  final String? note;

  factory _$HomeRequestNoteRequest([
    void Function(HomeRequestNoteRequestBuilder)? updates,
  ]) => (HomeRequestNoteRequestBuilder()..update(updates))._build();

  _$HomeRequestNoteRequest._({this.note}) : super._();
  @override
  HomeRequestNoteRequest rebuild(
    void Function(HomeRequestNoteRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HomeRequestNoteRequestBuilder toBuilder() =>
      HomeRequestNoteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeRequestNoteRequest && note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HomeRequestNoteRequest',
    )..add('note', note)).toString();
  }
}

class HomeRequestNoteRequestBuilder
    implements Builder<HomeRequestNoteRequest, HomeRequestNoteRequestBuilder> {
  _$HomeRequestNoteRequest? _$v;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  HomeRequestNoteRequestBuilder() {
    HomeRequestNoteRequest._defaults(this);
  }

  HomeRequestNoteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeRequestNoteRequest other) {
    _$v = other as _$HomeRequestNoteRequest;
  }

  @override
  void update(void Function(HomeRequestNoteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeRequestNoteRequest build() => _build();

  _$HomeRequestNoteRequest _build() {
    final _$result = _$v ?? _$HomeRequestNoteRequest._(note: note);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
