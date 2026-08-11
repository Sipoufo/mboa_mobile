import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/annonces/models/amenity.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';

/// Doc 10's "Équipements (checklist)", a closed enum so M04 can filter on it.
void main() {
  test('reads the amenities off a listing', () {
    final annonce = Annonce.fromResponse(
      AnnonceResponse((b) => b
        ..id = 'a1'
        ..title = 'Studio'
        ..amenities = SetBuilder<AnnonceResponseAmenitiesEnum>({
          AnnonceResponseAmenitiesEnum.WIFI,
          AnnonceResponseAmenitiesEnum.PARKING,
        })),
    );

    expect(annonce.amenities, containsAll([Amenity.wifi, Amenity.parking]));
  });

  test('a listing with none reads as empty, not null', () {
    final annonce = Annonce.fromResponse(
      AnnonceResponse((b) => b
        ..id = 'a1'
        ..title = 'Studio'),
    );

    expect(annonce.amenities, isEmpty);
  });

  test('editing carries the amenities into the draft', () {
    const annonce = Annonce(
      id: 'a1',
      title: 'Studio',
      status: AnnonceStatus.published,
      propertyType: PropertyType.studio,
      amenities: [Amenity.generator, Amenity.hotWater],
    );

    final draft = AnnonceDraft.fromAnnonce(annonce);

    expect(draft.amenities, [Amenity.generator, Amenity.hotWater]);
  });

  test('props cover amenities, so ticking one is not dropped', () {
    // A change that only touches the checklist must still redraw the screen.
    const a = Annonce(
      id: 'a1',
      title: 'Studio',
      status: AnnonceStatus.published,
      propertyType: PropertyType.studio,
    );

    expect(a, isNot(const Annonce(
      id: 'a1',
      title: 'Studio',
      status: AnnonceStatus.published,
      propertyType: PropertyType.studio,
      amenities: [Amenity.wifi],
    )));

    const draft = AnnonceDraft(kind: AnnonceKind.single);
    expect(draft, isNot(draft.copyWith(amenities: const [Amenity.wifi])));
  });
}
