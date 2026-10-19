// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminate_contract_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TerminateContractRequest extends TerminateContractRequest {
  @override
  final Date effectiveDate;
  @override
  final String reason;
  @override
  final bool? mutual;

  factory _$TerminateContractRequest([
    void Function(TerminateContractRequestBuilder)? updates,
  ]) => (TerminateContractRequestBuilder()..update(updates))._build();

  _$TerminateContractRequest._({
    required this.effectiveDate,
    required this.reason,
    this.mutual,
  }) : super._();
  @override
  TerminateContractRequest rebuild(
    void Function(TerminateContractRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TerminateContractRequestBuilder toBuilder() =>
      TerminateContractRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TerminateContractRequest &&
        effectiveDate == other.effectiveDate &&
        reason == other.reason &&
        mutual == other.mutual;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, effectiveDate.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, mutual.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TerminateContractRequest')
          ..add('effectiveDate', effectiveDate)
          ..add('reason', reason)
          ..add('mutual', mutual))
        .toString();
  }
}

class TerminateContractRequestBuilder
    implements
        Builder<TerminateContractRequest, TerminateContractRequestBuilder> {
  _$TerminateContractRequest? _$v;

  Date? _effectiveDate;
  Date? get effectiveDate => _$this._effectiveDate;
  set effectiveDate(Date? effectiveDate) =>
      _$this._effectiveDate = effectiveDate;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  bool? _mutual;
  bool? get mutual => _$this._mutual;
  set mutual(bool? mutual) => _$this._mutual = mutual;

  TerminateContractRequestBuilder() {
    TerminateContractRequest._defaults(this);
  }

  TerminateContractRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _effectiveDate = $v.effectiveDate;
      _reason = $v.reason;
      _mutual = $v.mutual;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TerminateContractRequest other) {
    _$v = other as _$TerminateContractRequest;
  }

  @override
  void update(void Function(TerminateContractRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TerminateContractRequest build() => _build();

  _$TerminateContractRequest _build() {
    final _$result =
        _$v ??
        _$TerminateContractRequest._(
          effectiveDate: BuiltValueNullFieldError.checkNotNull(
            effectiveDate,
            r'TerminateContractRequest',
            'effectiveDate',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'TerminateContractRequest',
            'reason',
          ),
          mutual: mutual,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
