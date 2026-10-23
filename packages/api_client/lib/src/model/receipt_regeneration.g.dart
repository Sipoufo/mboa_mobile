// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_regeneration.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReceiptRegeneration extends ReceiptRegeneration {
  @override
  final String? receiptId;
  @override
  final bool? ready;

  factory _$ReceiptRegeneration([
    void Function(ReceiptRegenerationBuilder)? updates,
  ]) => (ReceiptRegenerationBuilder()..update(updates))._build();

  _$ReceiptRegeneration._({this.receiptId, this.ready}) : super._();
  @override
  ReceiptRegeneration rebuild(
    void Function(ReceiptRegenerationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReceiptRegenerationBuilder toBuilder() =>
      ReceiptRegenerationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReceiptRegeneration &&
        receiptId == other.receiptId &&
        ready == other.ready;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, receiptId.hashCode);
    _$hash = $jc(_$hash, ready.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReceiptRegeneration')
          ..add('receiptId', receiptId)
          ..add('ready', ready))
        .toString();
  }
}

class ReceiptRegenerationBuilder
    implements Builder<ReceiptRegeneration, ReceiptRegenerationBuilder> {
  _$ReceiptRegeneration? _$v;

  String? _receiptId;
  String? get receiptId => _$this._receiptId;
  set receiptId(String? receiptId) => _$this._receiptId = receiptId;

  bool? _ready;
  bool? get ready => _$this._ready;
  set ready(bool? ready) => _$this._ready = ready;

  ReceiptRegenerationBuilder() {
    ReceiptRegeneration._defaults(this);
  }

  ReceiptRegenerationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiptId = $v.receiptId;
      _ready = $v.ready;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReceiptRegeneration other) {
    _$v = other as _$ReceiptRegeneration;
  }

  @override
  void update(void Function(ReceiptRegenerationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReceiptRegeneration build() => _build();

  _$ReceiptRegeneration _build() {
    final _$result =
        _$v ?? _$ReceiptRegeneration._(receiptId: receiptId, ready: ready);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
