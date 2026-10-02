// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mboa_score_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MboaScoreResponse extends MboaScoreResponse {
  @override
  final int? score;
  @override
  final int? maxScore;
  @override
  final BuiltList<ScoreSignal>? signals;

  factory _$MboaScoreResponse([
    void Function(MboaScoreResponseBuilder)? updates,
  ]) => (MboaScoreResponseBuilder()..update(updates))._build();

  _$MboaScoreResponse._({this.score, this.maxScore, this.signals}) : super._();
  @override
  MboaScoreResponse rebuild(void Function(MboaScoreResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MboaScoreResponseBuilder toBuilder() =>
      MboaScoreResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MboaScoreResponse &&
        score == other.score &&
        maxScore == other.maxScore &&
        signals == other.signals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, signals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MboaScoreResponse')
          ..add('score', score)
          ..add('maxScore', maxScore)
          ..add('signals', signals))
        .toString();
  }
}

class MboaScoreResponseBuilder
    implements Builder<MboaScoreResponse, MboaScoreResponseBuilder> {
  _$MboaScoreResponse? _$v;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _maxScore;
  int? get maxScore => _$this._maxScore;
  set maxScore(int? maxScore) => _$this._maxScore = maxScore;

  ListBuilder<ScoreSignal>? _signals;
  ListBuilder<ScoreSignal> get signals =>
      _$this._signals ??= ListBuilder<ScoreSignal>();
  set signals(ListBuilder<ScoreSignal>? signals) => _$this._signals = signals;

  MboaScoreResponseBuilder() {
    MboaScoreResponse._defaults(this);
  }

  MboaScoreResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score;
      _maxScore = $v.maxScore;
      _signals = $v.signals?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MboaScoreResponse other) {
    _$v = other as _$MboaScoreResponse;
  }

  @override
  void update(void Function(MboaScoreResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MboaScoreResponse build() => _build();

  _$MboaScoreResponse _build() {
    _$MboaScoreResponse _$result;
    try {
      _$result =
          _$v ??
          _$MboaScoreResponse._(
            score: score,
            maxScore: maxScore,
            signals: _signals?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'signals';
        _signals?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MboaScoreResponse',
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
