import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// A unit the landlord may assign on accepting a request on a residence
/// (RM-M29-16): the residence's published units on the request's rental
/// period, the one asked for first — the server's list.
class UnitChoice extends Equatable {
  const UnitChoice({
    required this.annonceId,
    this.title,
    this.propertyType = PropertyType.apartment,
    this.price = 0,
    this.rentalPeriod = RentalPeriod.fallback,
  });

  final String annonceId;
  final String? title;
  final PropertyType propertyType;
  final int price;
  final RentalPeriod rentalPeriod;

  static UnitChoice fromResponse(AssignableUnit response) => UnitChoice(
        annonceId: response.annonceId ?? '',
        title: response.title,
        propertyType: PropertyType.fromWire(response.propertyType?.name),
        price: response.price ?? 0,
        rentalPeriod: RentalPeriod.fromWire(response.rentalPeriod?.name),
      );

  @override
  List<Object?> get props => [annonceId, title, propertyType, price, rentalPeriod];
}
