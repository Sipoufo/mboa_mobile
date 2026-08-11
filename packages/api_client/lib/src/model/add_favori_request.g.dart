// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favori_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddFavoriRequest extends AddFavoriRequest {
  @override
  final String annonceId;

  factory _$AddFavoriRequest([
    void Function(AddFavoriRequestBuilder)? updates,
  ]) => (AddFavoriRequestBuilder()..update(updates))._build();

  _$AddFavoriRequest._({required this.annonceId}) : super._();
  @override
  AddFavoriRequest rebuild(void Function(AddFavoriRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddFavoriRequestBuilder toBuilder() =>
      AddFavoriRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddFavoriRequest && annonceId == other.annonceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annonceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AddFavoriRequest',
    )..add('annonceId', annonceId)).toString();
  }
}

class AddFavoriRequestBuilder
    implements Builder<AddFavoriRequest, AddFavoriRequestBuilder> {
  _$AddFavoriRequest? _$v;

  String? _annonceId;
  String? get annonceId => _$this._annonceId;
  set annonceId(String? annonceId) => _$this._annonceId = annonceId;

  AddFavoriRequestBuilder() {
    AddFavoriRequest._defaults(this);
  }

  AddFavoriRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _annonceId = $v.annonceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddFavoriRequest other) {
    _$v = other as _$AddFavoriRequest;
  }

  @override
  void update(void Function(AddFavoriRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddFavoriRequest build() => _build();

  _$AddFavoriRequest _build() {
    final _$result =
        _$v ??
        _$AddFavoriRequest._(
          annonceId: BuiltValueNullFieldError.checkNotNull(
            annonceId,
            r'AddFavoriRequest',
            'annonceId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
