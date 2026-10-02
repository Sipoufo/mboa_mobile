// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_mboa_score_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminMboaScoreResponse extends AdminMboaScoreResponse {
  @override
  final MboaScoreResponse? score;
  @override
  final BuiltList<ScoreAdjustmentResponse>? adjustments;

  factory _$AdminMboaScoreResponse([
    void Function(AdminMboaScoreResponseBuilder)? updates,
  ]) => (AdminMboaScoreResponseBuilder()..update(updates))._build();

  _$AdminMboaScoreResponse._({this.score, this.adjustments}) : super._();
  @override
  AdminMboaScoreResponse rebuild(
    void Function(AdminMboaScoreResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminMboaScoreResponseBuilder toBuilder() =>
      AdminMboaScoreResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminMboaScoreResponse &&
        score == other.score &&
        adjustments == other.adjustments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, adjustments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminMboaScoreResponse')
          ..add('score', score)
          ..add('adjustments', adjustments))
        .toString();
  }
}

class AdminMboaScoreResponseBuilder
    implements Builder<AdminMboaScoreResponse, AdminMboaScoreResponseBuilder> {
  _$AdminMboaScoreResponse? _$v;

  MboaScoreResponseBuilder? _score;
  MboaScoreResponseBuilder get score =>
      _$this._score ??= MboaScoreResponseBuilder();
  set score(MboaScoreResponseBuilder? score) => _$this._score = score;

  ListBuilder<ScoreAdjustmentResponse>? _adjustments;
  ListBuilder<ScoreAdjustmentResponse> get adjustments =>
      _$this._adjustments ??= ListBuilder<ScoreAdjustmentResponse>();
  set adjustments(ListBuilder<ScoreAdjustmentResponse>? adjustments) =>
      _$this._adjustments = adjustments;

  AdminMboaScoreResponseBuilder() {
    AdminMboaScoreResponse._defaults(this);
  }

  AdminMboaScoreResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score?.toBuilder();
      _adjustments = $v.adjustments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminMboaScoreResponse other) {
    _$v = other as _$AdminMboaScoreResponse;
  }

  @override
  void update(void Function(AdminMboaScoreResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminMboaScoreResponse build() => _build();

  _$AdminMboaScoreResponse _build() {
    _$AdminMboaScoreResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdminMboaScoreResponse._(
            score: _score?.build(),
            adjustments: _adjustments?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'score';
        _score?.build();
        _$failedField = 'adjustments';
        _adjustments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminMboaScoreResponse',
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
