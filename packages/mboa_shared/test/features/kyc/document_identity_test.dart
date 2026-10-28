import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// §39 B — what the document says, checked as the server checks it.
void main() {
  final today = DateTime(2026, 10, 28, 15, 30);
  final valid = DocumentIdentity(
    type: KycDocType.cni,
    number: 'CM1234567',
    issuedOn: DateTime(2020, 3, 1),
    expiresOn: DateTime(2035, 3, 1),
    issuedAt: 'Douala',
  );

  test('complete and in force', () {
    expect(valid.problemOn(today), isNull);
  });

  test('a field left empty is not yet sendable', () {
    expect(valid.copyWith(number: '  ').problemOn(today), DocumentIdentityProblem.incomplete);
    expect(valid.copyWith(issuedAt: '').problemOn(today), DocumentIdentityProblem.incomplete);
    expect(const DocumentIdentity().problemOn(today), DocumentIdentityProblem.incomplete);
  });

  test('INVALID_ISSUE_DATE — issued today is fine, tomorrow is not', () {
    expect(valid.copyWith(issuedOn: DateTime(2026, 10, 28)).problemOn(today), isNull);
    expect(valid.copyWith(issuedOn: DateTime(2026, 10, 29)).problemOn(today), DocumentIdentityProblem.issuedInFuture);
  });

  test('ID_DOCUMENT_EXPIRED — expiring today is already expired', () {
    expect(valid.copyWith(expiresOn: DateTime(2026, 10, 28)).problemOn(today), DocumentIdentityProblem.expired);
    expect(valid.copyWith(expiresOn: DateTime(2026, 10, 29)).problemOn(today), isNull);
  });

  test('a passport goes without a back; a CNI does not', () {
    final cni = KycDraft(selfieKey: 's', idFrontKey: 'f', identity: valid);
    expect(cni.documentDoneOn(today), isFalse);
    expect(cni.withKey(KycSlot.idBack, 'b').documentDoneOn(today), isTrue);

    final passport = cni.withKey(KycSlot.idBack, 'b').withDocType(KycDocType.passport);
    expect(passport.idBackKey, isNull, reason: 'the back photographed for the CNI goes');
    expect(passport.documentDoneOn(today), isTrue);
  });

  test('the selfie is still needed to submit', () {
    final draft = KycDraft(idFrontKey: 'f', idBackKey: 'b', identity: valid);
    expect(draft.isCompleteOn(today), isFalse);
    expect(draft.withKey(KycSlot.selfie, 's').isCompleteOn(today), isTrue);
  });
}
