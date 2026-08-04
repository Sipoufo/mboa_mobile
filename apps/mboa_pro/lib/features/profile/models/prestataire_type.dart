import 'package:mboa_core/mboa_core.dart';

/// Business type of a prestataire (CDC M02). Domain enum so the UI/bloc never
/// touch the generated API enums — the repository maps both directions.
enum PrestataireType {
  particulier,
  agence,
  promoteur;

  /// Maps to the generated update-request enum.
  UpdatePrestataireProfileRequestTypeEnum get updateValue => switch (this) {
        PrestataireType.particulier => UpdatePrestataireProfileRequestTypeEnum.PARTICULIER,
        PrestataireType.agence => UpdatePrestataireProfileRequestTypeEnum.AGENCE,
        PrestataireType.promoteur => UpdatePrestataireProfileRequestTypeEnum.PROMOTEUR,
      };

  /// Maps from the generated profile-response enum.
  static PrestataireType? fromResponse(PrestataireProfileResponseTypeEnum? value) => switch (value) {
        PrestataireProfileResponseTypeEnum.PARTICULIER => PrestataireType.particulier,
        PrestataireProfileResponseTypeEnum.AGENCE => PrestataireType.agence,
        PrestataireProfileResponseTypeEnum.PROMOTEUR => PrestataireType.promoteur,
        _ => null,
      };
}
