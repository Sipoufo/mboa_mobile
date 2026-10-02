import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why a listing offers no slot in the next seven days (CE-M07-01).
///
/// The reason is the point of the endpoint: without it the app could only say
/// "contact the prestataire", while the true answer is usually that nobody has
/// declared their hours yet (RM-M15-01) — which the prestataire can fix.
enum NoSlotReason {
  /// No visitor has declared any availability.
  noAvailability,

  /// Every day in the window is blocked.
  allDaysBlocked,

  /// Everything declared is already taken.
  fullyBooked,

  /// A reason this build does not know. Treated as "nothing free".
  unknown;

  static NoSlotReason fromResponse(VisitorSlotsReasonEnum? value) =>
      switch (value) {
        VisitorSlotsReasonEnum.AGENT_NO_AVAILABILITY =>
          NoSlotReason.noAvailability,
        VisitorSlotsReasonEnum.ALL_DAYS_BLOCKED => NoSlotReason.allDaysBlocked,
        VisitorSlotsReasonEnum.FULLY_BOOKED => NoSlotReason.fullyBooked,
        _ => NoSlotReason.unknown,
      };
}

/// What happens to a booking once it is made.
///
/// Both modes are booked **on a published time** — RM-M15-06 describes "a slot
/// proposed to an owner who confirms by hand", and `BookVisiteRequest` requires
/// `startsAt` either way. The difference is only what comes next, and therefore
/// only what the screen says: a slot is taken, or a slot is asked for.
enum BookingMode {
  /// Taking the slot schedules the visit.
  slots,

  /// Taking the slot asks for it; the visitor confirms by hand (RM-M15-06) and
  /// the visit starts as `REQUESTED` rather than `SCHEDULED`.
  onRequest;

  static BookingMode fromResponse(VisitorSlotsModeEnum? value) =>
      value == VisitorSlotsModeEnum.ON_REQUEST
          ? BookingMode.onRequest
          : BookingMode.slots;
}

/// One free time, as the server offers it.
///
/// Not `BookableSlot`: the generated client already owns that name, and two
/// classes with one name in the same file is a rename waiting to go wrong.
class VisitSlot extends Equatable {
  const VisitSlot({required this.startsAt, this.endsAt});

  final DateTime startsAt;
  final DateTime? endsAt;

  static VisitSlot? fromResponse(BookableSlot response) {
    final startsAt = response.startsAt;
    if (startsAt == null) return null;
    return VisitSlot(
      startsAt: startsAt.toLocal(),
      endsAt: response.endsAt?.toLocal(),
    );
  }

  @override
  List<Object?> get props => [startsAt, endsAt];
}

/// Someone who can show this property, and when (RM-M07-01).
///
/// Either an assigned agent or the prestataire visiting their own property
/// (RM-M11-10) — the tenant chooses between them, so what distinguishes them
/// on screen is their record: visits done, average rating.
class BookableVisitor extends Equatable {
  const BookableVisitor({
    required this.accountId,
    required this.kind,
    this.displayName,
    this.photoObjectKey,
    this.completedVisitCount = 0,
    this.averageRating,
    this.ratingCount = 0,
    this.mode = BookingMode.slots,
    this.slots = const [],
    this.reason,
  });

  final String accountId;
  final VisitorKind kind;
  final String? displayName;
  final String? photoObjectKey;
  final int completedVisitCount;
  final double? averageRating;
  final int ratingCount;
  final BookingMode mode;
  final List<VisitSlot> slots;

  /// Set only when [slots] is empty — why (CE-M07-01).
  final NoSlotReason? reason;

  String? get photoUrl => BaseProfile.mediaUrl(photoObjectKey);

  bool get hasRating => averageRating != null && ratingCount > 0;

  /// Bookable now — there is a time to take. A visitor with none is not a
  /// choice the tenant can make, whatever their mode; their [reason] is what
  /// the screen says instead (CE-M07-01).
  bool get isBookable => slots.isNotEmpty;

  static BookableVisitor? fromResponse(VisitorSlots response) {
    final accountId = response.visitorAccountId;
    if (accountId == null) return null;

    final slots = (response.slots?.toList() ?? const <BookableSlot>[])
        .map(VisitSlot.fromResponse)
        .nonNulls
        .toList()
      // The endpoint's order is not part of its contract, and a time list that
      // is not chronological is unreadable.
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));

    return BookableVisitor(
      accountId: accountId,
      kind: switch (response.visitorKind) {
        VisitorSlotsVisitorKindEnum.OWNER => VisitorKind.owner,
        VisitorSlotsVisitorKindEnum.AGENT => VisitorKind.agent,
        _ => VisitorKind.unknown,
      },
      displayName: response.displayName,
      photoObjectKey: response.photoObjectKey,
      completedVisitCount: response.completedVisitCount ?? 0,
      averageRating: response.averageRating,
      ratingCount: response.ratingCount ?? 0,
      mode: BookingMode.fromResponse(response.mode),
      slots: slots,
      reason: slots.isEmpty ? NoSlotReason.fromResponse(response.reason) : null,
    );
  }

  @override
  List<Object?> get props => [
        accountId,
        kind,
        displayName,
        photoObjectKey,
        completedVisitCount,
        averageRating,
        ratingCount,
        mode,
        slots,
        reason,
      ];
}
