import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// What the tenant is declaring, before it is sent (RM-M30-03) — kept out of
/// the widget so the rules are tested, not eyeballed:
///
///  * rent covers **consecutive** open échéances (§29.1), picked as a range
///    on the échéances the space offers (the next 12 at most);
///  * the amount starts at what is left to pay on them, and stays the
///    tenant's to change — a partial payment is a smaller amount on one;
///  * CE-M30-02: zero, or more than ten times what is due, asks once more.
///
/// The deposit and an invoice (slice E) name no échéance: what is due is
/// fixed when the form opens.
class DeclarationForm extends Equatable {
  const DeclarationForm({
    required this.kind,
    this.options = const [],
    this.start,
    this.end,
    this.amount,
    this.fixedDue = 0,
    this.invoiceId,
    this.paidOn,
    this.method,
    this.reference = '',
    this.note = '',
    this.proofKeys = const [],
  });

  /// The rent form, on the open échéances of a window, [preselected] if a row
  /// was tapped (the oldest open one otherwise).
  factory DeclarationForm.rent(List<RentDue> schedule, {RentDue? preselected, required DateTime today}) {
    final options = [for (final due in schedule) if (due.status.isOpen) due];
    final at = preselected == null ? 0 : options.indexWhere((d) => d.index == preselected.index);
    final first = at < 0 ? 0 : at;
    return DeclarationForm(
      kind: DeclarationKind.rent,
      options: options,
      start: options.isEmpty ? null : first,
      end: options.isEmpty ? null : first,
      paidOn: _day(today),
    )._withSuggestedAmount();
  }

  factory DeclarationForm.deposit(RentDeposit deposit, {required DateTime today}) {
    final due = (deposit.amount - deposit.confirmedTotal).clamp(0, deposit.amount);
    return DeclarationForm(kind: DeclarationKind.deposit, fixedDue: due, amount: due, paidOn: _day(today));
  }

  /// An invoice declared paid, starting at what is left of it — [left] is
  /// the screen's (the amount less what was already confirmed).
  factory DeclarationForm.invoice(HomeInvoice invoice, {required int left, required DateTime today}) {
    final due = left.clamp(0, invoice.amount);
    return DeclarationForm(
      kind: DeclarationKind.invoice,
      invoiceId: invoice.id,
      fixedDue: due,
      amount: due,
      paidOn: _day(today),
    );
  }

  /// At most three proofs per declaration (§29, `PROOF_LIMIT`).
  static const int maxProofs = 3;

  final DeclarationKind kind;

  /// The open échéances one may declare for, oldest first.
  final List<RentDue> options;

  /// The chosen range, as positions in [options].
  final int? start;
  final int? end;

  final int? amount;

  /// What is due on the deposit or the invoice.
  final int fixedDue;

  /// Set when [kind] is [DeclarationKind.invoice].
  final String? invoiceId;
  final DateTime? paidOn;
  final RentPaymentMethod? method;
  final String reference;
  final String note;
  final List<String> proofKeys;

  List<RentDue> get selected =>
      start == null || end == null ? const [] : options.sublist(start!, end! + 1);

  /// What is left to pay on what is chosen.
  int get due => kind == DeclarationKind.rent ? selected.fold(0, (sum, d) => sum + d.remaining) : fixedDue;

  bool isSelected(RentDue due) => selected.any((d) => d.index == due.index);

  /// Picking an échéance: the first pick, a neighbour that grows the range,
  /// an end that shrinks it — or, anywhere else, a fresh range on it.
  DeclarationForm toggle(RentDue due) {
    final at = options.indexWhere((d) => d.index == due.index);
    if (at < 0) return this;
    final (s, e) = (start, end);
    // Neighbours by the échéances' own numbers, not by their places in the
    // list: with 4 already declared, 3 and 5 sit side by side here but do
    // not follow each other, and the server would refuse them.
    bool follows(int a, int b) => options[b].index == options[a].index + 1;
    final (int ns, int ne) = switch ((s, e)) {
      (final s?, final e?) when at == s - 1 && follows(at, s) => (at, e),
      (final s?, final e?) when at == e + 1 && follows(e, at) => (s, at),
      (final s?, final e?) when at == s && s < e => (s + 1, e),
      (final s?, final e?) when at == e && s < e => (s, e - 1),
      _ => (at, at),
    };
    return copyWith(start: ns, end: ne)._withSuggestedAmount();
  }

  bool get hasProofRoom => proofKeys.length < maxProofs;

  /// CE-M30-02 — zero, or more than ten times what is due: asked once more.
  bool get looksUnusual {
    final value = amount ?? 0;
    return value == 0 || (due > 0 && value > due * 10);
  }

  /// Ready to send — the server refuses an amount of zero or less.
  bool get isComplete =>
      (amount ?? 0) > 0 &&
      paidOn != null &&
      method != null &&
      (kind != DeclarationKind.rent || selected.isNotEmpty);

  DeclarationDraft toDraft() => DeclarationDraft(
        kind: kind,
        dueIndexes: [for (final d in selected) d.index],
        amount: amount ?? 0,
        paidOn: paidOn!,
        method: method!,
        reference: reference,
        note: note,
        proofKeys: proofKeys,
      );

  DeclarationForm _withSuggestedAmount() => copyWith(amount: due);

  DeclarationForm copyWith({
    int? start,
    int? end,
    int? amount,
    bool clearAmount = false,
    DateTime? paidOn,
    RentPaymentMethod? method,
    String? reference,
    String? note,
    List<String>? proofKeys,
  }) =>
      DeclarationForm(
        kind: kind,
        options: options,
        start: start ?? this.start,
        end: end ?? this.end,
        amount: clearAmount ? null : (amount ?? this.amount),
        fixedDue: fixedDue,
        invoiceId: invoiceId,
        paidOn: paidOn ?? this.paidOn,
        method: method ?? this.method,
        reference: reference ?? this.reference,
        note: note ?? this.note,
        proofKeys: proofKeys ?? this.proofKeys,
      );

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  List<Object?> get props =>
      [kind, options, start, end, amount, fixedDue, invoiceId, paidOn, method, reference, note, proofKeys];
}
