// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParticipantSummary extends ParticipantSummary {
  @override
  final String? accountId;
  @override
  final String? displayName;
  @override
  final String? photoObjectKey;

  factory _$ParticipantSummary([
    void Function(ParticipantSummaryBuilder)? updates,
  ]) => (ParticipantSummaryBuilder()..update(updates))._build();

  _$ParticipantSummary._({
    this.accountId,
    this.displayName,
    this.photoObjectKey,
  }) : super._();
  @override
  ParticipantSummary rebuild(
    void Function(ParticipantSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParticipantSummaryBuilder toBuilder() =>
      ParticipantSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParticipantSummary &&
        accountId == other.accountId &&
        displayName == other.displayName &&
        photoObjectKey == other.photoObjectKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoObjectKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParticipantSummary')
          ..add('accountId', accountId)
          ..add('displayName', displayName)
          ..add('photoObjectKey', photoObjectKey))
        .toString();
  }
}

class ParticipantSummaryBuilder
    implements Builder<ParticipantSummary, ParticipantSummaryBuilder> {
  _$ParticipantSummary? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoObjectKey;
  String? get photoObjectKey => _$this._photoObjectKey;
  set photoObjectKey(String? photoObjectKey) =>
      _$this._photoObjectKey = photoObjectKey;

  ParticipantSummaryBuilder() {
    ParticipantSummary._defaults(this);
  }

  ParticipantSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _displayName = $v.displayName;
      _photoObjectKey = $v.photoObjectKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParticipantSummary other) {
    _$v = other as _$ParticipantSummary;
  }

  @override
  void update(void Function(ParticipantSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParticipantSummary build() => _build();

  _$ParticipantSummary _build() {
    final _$result =
        _$v ??
        _$ParticipantSummary._(
          accountId: accountId,
          displayName: displayName,
          photoObjectKey: photoObjectKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
