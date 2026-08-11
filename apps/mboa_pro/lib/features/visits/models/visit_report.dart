import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// Does the property match its listing? (CDC M16 — "conformité annonce".)
enum ListingConformity {
  oui,
  partiellement,
  non;

  SubmitVisiteReportRequestListingConformityEnum get asRequest =>
      switch (this) {
        ListingConformity.oui =>
          SubmitVisiteReportRequestListingConformityEnum.OUI,
        ListingConformity.partiellement =>
          SubmitVisiteReportRequestListingConformityEnum.PARTIELLEMENT,
        ListingConformity.non =>
          SubmitVisiteReportRequestListingConformityEnum.NON,
      };
}

/// The report the agent files after the visit (CDC M16).
///
/// **Three photos minimum**, matching the listing rule — a report is evidence,
/// and one blurred picture is not. The submit button reads [isValid] rather
/// than the server rejecting a half-filled form after an upload.
class VisitReportDraft extends Equatable {
  const VisitReportDraft({
    this.overallCondition,
    this.conformity,
    this.comment,
    this.photoKeys = const [],
  });

  static const int minPhotos = 3;
  static const int maxPhotos = 10;
  static const int minCondition = 1;
  static const int maxCondition = 5;

  /// General state of the property, 1–5.
  final int? overallCondition;
  final ListingConformity? conformity;
  final String? comment;
  final List<String> photoKeys;

  bool get hasEnoughPhotos => photoKeys.length >= minPhotos;

  bool get canAddPhoto => photoKeys.length < maxPhotos;

  bool get isValid =>
      overallCondition != null && conformity != null && hasEnoughPhotos;

  /// How many more photos are needed, for the copy that says so.
  int get missingPhotos =>
      hasEnoughPhotos ? 0 : minPhotos - photoKeys.length;

  VisitReportDraft copyWith({
    int? overallCondition,
    ListingConformity? conformity,
    String? comment,
    List<String>? photoKeys,
  }) =>
      VisitReportDraft(
        overallCondition: overallCondition ?? this.overallCondition,
        conformity: conformity ?? this.conformity,
        comment: comment ?? this.comment,
        photoKeys: photoKeys ?? this.photoKeys,
      );

  SubmitVisiteReportRequest toRequest() => SubmitVisiteReportRequest((b) => b
    ..overallCondition = overallCondition
    ..listingConformity = conformity?.asRequest
    ..comment = comment
    ..photoKeys = ListBuilder<String>(photoKeys));

  @override
  List<Object?> get props => [overallCondition, conformity, comment, photoKeys];
}
