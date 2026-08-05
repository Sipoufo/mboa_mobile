import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

void main() {
  group('PushType.parse', () {
    test('recognises the payment types that close the M13 loop', () {
      expect(PushType.parse('PAYMENT_CONFIRMED'), PushType.paymentConfirmed);
      expect(PushType.parse('subscription_activated'), PushType.paymentConfirmed);
    });

    test('is tolerant of casing and vocabulary', () {
      expect(PushType.parse('new_message'), PushType.message);
      expect(PushType.parse('CHAT'), PushType.message);
      expect(PushType.parse('annonce_published'), PushType.annonce);
      expect(PushType.parse('LISTING_EXPIRED'), PushType.annonce);
      expect(PushType.parse('visit_scheduled'), PushType.visit);
      expect(PushType.parse('KYC_APPROVED'), PushType.kyc);
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
