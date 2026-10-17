import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

void main() {
  group('PushType.parse', () {
    test('reads every published PushTarget value', () {
      expect(PushType.parse('PAYMENT_CONFIRMED'), PushType.paymentConfirmed);
      expect(PushType.parse('MESSAGE'), PushType.message);
      expect(PushType.parse('ANNONCE'), PushType.annonce);
      expect(PushType.parse('VISIT'), PushType.visit);
      expect(PushType.parse('KYC'), PushType.kyc);
      expect(PushType.parse('CONTRACT'), PushType.contract);
      expect(PushType.parse('RESIDENCE'), PushType.residence);
      expect(PushType.parse('SAVED_SEARCH'), PushType.savedSearch);
    });

    test('is tolerant of casing and whitespace, not of vocabulary', () {
      expect(PushType.parse(' visit '), PushType.visit);
      expect(PushType.parse('contract'), PushType.contract);
      // Matched exactly: a value that merely contains a known one is unknown,
      // not silently routed somewhere it does not belong.
      expect(PushType.parse('VISIT_SCHEDULED'), PushType.unknown);
      expect(PushType.parse('LISTING_EXPIRED'), PushType.unknown);
    });

    test('falls back to unknown rather than throwing', () {
      // The payload contract is unagreed — an unexpected type must degrade,
      // not break notifications entirely.
      expect(PushType.parse(null), PushType.unknown);
      expect(PushType.parse(''), PushType.unknown);
      expect(PushType.parse('something_new'), PushType.unknown);
    });
  });

  group('PushMessage.fromData', () {
    test('reads the entity id under any of the likely spellings', () {
      expect(
        PushMessage.fromData({'type': 'annonce', 'entityId': 'a-1'}).entityId,
        'a-1',
      );
      expect(
        PushMessage.fromData({'type': 'annonce', 'entity_id': 'a-2'}).entityId,
        'a-2',
      );
      expect(PushMessage.fromData({'type': 'annonce', 'id': 'a-3'}).entityId, 'a-3');
    });

    test('stringifies non-string values and keeps the raw map', () {
      final message = PushMessage.fromData({'type': 'visit', 'count': 3});

      expect(message.raw['count'], '3');
      expect(message.type, PushType.visit);
    });

    test('drops null values instead of writing "null" strings', () {
      final message = PushMessage.fromData({'type': 'kyc', 'entityId': null});

      expect(message.raw.containsKey('entityId'), isFalse);
      expect(message.entityId, isNull);
    });

    test('carries the notification title and body through', () {
      final message = PushMessage.fromData(
        const {'type': 'payment'},
        title: 'Paiement confirmé',
        body: 'Votre formule Pro est active.',
      );

      expect(message.title, 'Paiement confirmé');
      expect(message.body, 'Votre formule Pro est active.');
    });

    test('survives an empty payload', () {
      final message = PushMessage.fromData(const {});

      expect(message.type, PushType.unknown);
      expect(message.entityId, isNull);
    });
  });
}
