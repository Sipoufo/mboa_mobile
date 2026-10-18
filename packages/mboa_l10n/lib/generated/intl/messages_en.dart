// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(tier) => "This metric is included in the ${tier} plan.";

  static String m1(tier) => "Upgrade to ${tier}";

  static String m2(count) => "${count} slot(s) per week";

  static String m3(date) => "Member since ${date}";

  static String m4(count) => "${count} reviews";

  static String m5(count) => "${count} reviews";

  static String m6(minutes) => "${minutes} min";

  static String m7(count) => "${count} area(s)";

  static String m8(name) => "Assign ${name}?";

  static String m9(name) => "An offer has been sent to ${name}";

  static String m10(count) =>
      "${count} unit(s) already had an agent and were skipped.";

  static String m11(count) => "${count} properties";

  static String m12(count) => "${count} unit(s)";

  static String m13(count) => "${count} visits completed";

  static String m14(count) =>
      "${Intl.plural(count, zero: 'Expires today', one: 'Expires tomorrow', other: 'Expires in ${count} days')}";

  static String m15(city) => "Detected city: ${city}";

  static String m16(min) => "Add images (${min} photos minimum)";

  static String m17(price, period) => "${price} FCFA / ${period}";

  static String m18(price) => "${price} FCFA / month";

  static String m19(count) =>
      "${Intl.plural(count, one: '1 room', other: '${count} rooms')}";

  static String m20(value) => "${value} m²";

  static String m21(count) => "${count} published";

  static String m22(count) =>
      "${Intl.plural(count, one: '1 unit', other: '${count} units')}";

  static String m23(phone) => "Code sent to ${phone}";

  static String m24(count, period) => "${count} ${period}";

  static String m25(word) => "Type ${word} to confirm";

  static String m26(word) => "Type “${word}” to confirm";

  static String m27(tier) => "Included in ${tier}";

  static String m28(reason) => "Reason: ${reason}";

  static String m29(count) => "${count} photos";

  static String m30(count, average) => "${average} · ${count} reviews";

  static String m31(date) => "Edited on ${date}";

  static String m32(count) => "${count} months living there";

  static String m33(count) => "${count} unit(s)";

  static String m34(phone) => "Code sent to ${phone}";

  static String m35(seconds) => "Resend in ${seconds}s";

  static String m36(tier) => "All good. Your ${tier} plan is active.";

  static String m37(ref) => "Reference: ${ref}";

  static String m38(price) => "${price} FCFA / month";

  static String m39(count) =>
      "${Intl.plural(count, one: '1 residence unit', other: '${count} residence units')}";

  static String m40(tier) =>
      "Limit reached. Upgrade to ${tier} to publish more listings.";

  static String m41(min) => "Add at least ${min} photos to publish.";

  static String m42(count) =>
      "${Intl.plural(count, one: '${count} day living there', other: '${count} days living there')}";

  static String m43(count) =>
      "${Intl.plural(count, one: '${count} month living there', other: '${count} months living there')}";

  static String m44(count) =>
      "${Intl.plural(count, one: '${count} quarter living there', other: '${count} quarters living there')}";

  static String m45(count) =>
      "${Intl.plural(count, one: '${count} week living there', other: '${count} weeks living there')}";

  static String m46(count) =>
      "${Intl.plural(count, one: '${count} year living there', other: '${count} years living there')}";

  static String m47(count) =>
      "${Intl.plural(count, one: '1 unit available', other: '${count} units available')}";

  static String m48(query) => "No unit matches “${query}”.";

  static String m49(value) => "Perceived condition: ${value}/5";

  static String m50(value) => "Condition as seen: ${value}/5";

  static String m51(date) => "Published on ${date}";

  static String m52(price) => "From ${price}";

  static String m53(count) =>
      "${Intl.plural(count, one: '1 unit available', other: '${count} units available')}";

  static String m54(count) =>
      "${Intl.plural(count, zero: 'No property', one: '1 property', other: '${count} properties')}";

  static String m55(count) => "${count}+";

  static String m56(count) =>
      "${Intl.plural(count, zero: 'No active listing', one: '1 active listing', other: '${count} active listings')}";

  static String m57(date) => "Valid until ${date}";

  static String m58(count) =>
      "${Intl.plural(count, zero: 'No visits', one: '1 visit', other: '${count} visits')}";

  static String m59(from, to) => "${from} to ${to}";

  static String m60(time) => "Confirmed at ${time}";

  static String m61(distance) =>
      "You are about ${distance} m away. Explain why you are confirming your presence from there.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessComingSoonBody": MessageLookupByLibrary.simpleMessage(
      "This feature is on its way. We’ll let you know as soon as it’s ready.",
    ),
    "accessComingSoonTitle": MessageLookupByLibrary.simpleMessage(
      "Coming soon",
    ),
    "accessKycPendingBody": MessageLookupByLibrary.simpleMessage(
      "Your documents are under review. This feature unlocks once they’re approved.",
    ),
    "accessKycPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Verification in progress",
    ),
    "accessKycRequiredBody": MessageLookupByLibrary.simpleMessage(
      "Complete your certifications to unlock this feature.",
    ),
    "accessKycRequiredCta": MessageLookupByLibrary.simpleMessage(
      "Complete my certifications",
    ),
    "accessKycRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Verification required",
    ),
    "accessRestrictedTitle": MessageLookupByLibrary.simpleMessage(
      "Access restricted",
    ),
    "accessRoleRequiredBody": MessageLookupByLibrary.simpleMessage(
      "This feature is reserved for provider accounts.",
    ),
    "accessRoleRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Not available for this account",
    ),
    "accessTierRequiredBody": m0,
    "accessTierRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Subscribers only",
    ),
    "accessUpgradeCta": m1,
    "accountGuestBody": MessageLookupByLibrary.simpleMessage(
      "Searching is free. An account is for contacting a provider, booking a visit and saving favourites.",
    ),
    "accountGuestTitle": MessageLookupByLibrary.simpleMessage(
      "Create your Mboa account",
    ),
    "accountSignIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "agentAcceptingOff": MessageLookupByLibrary.simpleMessage(
      "You will not receive new assignments. Visits already scheduled still stand.",
    ),
    "agentAcceptingOn": MessageLookupByLibrary.simpleMessage(
      "You can receive new assignments.",
    ),
    "agentAcceptingTitle": MessageLookupByLibrary.simpleMessage(
      "I take on missions",
    ),
    "agentAddSlot": MessageLookupByLibrary.simpleMessage("Add a slot"),
    "agentAvailabilityHelp": MessageLookupByLibrary.simpleMessage(
      "Set your usual hours. Bookable slots are derived from them, minus your blocked days and visits already scheduled.",
    ),
    "agentAvailabilitySubtitle": m2,
    "agentAvailabilityTitle": MessageLookupByLibrary.simpleMessage(
      "My availability",
    ),
    "agentBlockDay": MessageLookupByLibrary.simpleMessage("Block a day"),
    "agentDaysOffHelp": MessageLookupByLibrary.simpleMessage(
      "Blocking a day cancels the visits already scheduled on it.",
    ),
    "agentDaysOffNone": MessageLookupByLibrary.simpleMessage("No blocked days"),
    "agentDaysOffTitle": MessageLookupByLibrary.simpleMessage("Blocked days"),
    "agentDetailMemberSince": m3,
    "agentDetailNoProperties": MessageLookupByLibrary.simpleMessage(
      "No properties handled yet",
    ),
    "agentDetailPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting a response",
    ),
    "agentDetailProperties": MessageLookupByLibrary.simpleMessage(
      "Properties handled",
    ),
    "agentDetailTitle": MessageLookupByLibrary.simpleMessage("Agent profile"),
    "agentDetailUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profile unavailable",
    ),
    "agentDetailWholeCity": MessageLookupByLibrary.simpleMessage(
      "The whole city",
    ),
    "agentDetailZones": MessageLookupByLibrary.simpleMessage("Working areas"),
    "agentIncompleteBody": MessageLookupByLibrary.simpleMessage(
      "Add your name, a photo and at least one zone to receive missions.",
    ),
    "agentIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Profile incomplete",
    ),
    "agentNavMissions": MessageLookupByLibrary.simpleMessage("My missions"),
    "agentNavProfile": MessageLookupByLibrary.simpleMessage("My profile"),
    "agentNavVisits": MessageLookupByLibrary.simpleMessage("My visits"),
    "agentNoSlots": MessageLookupByLibrary.simpleMessage("No slots set"),
    "agentProfileTitle": MessageLookupByLibrary.simpleMessage(
      "My agent profile",
    ),
    "agentRatingCount": m4,
    "agentRatingNone": MessageLookupByLibrary.simpleMessage("Not rated yet"),
    "agentSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Could not save. Try again.",
    ),
    "agentSaved": MessageLookupByLibrary.simpleMessage("Changes saved"),
    "agentSlotOverlap": MessageLookupByLibrary.simpleMessage(
      "That slot overlaps another one.",
    ),
    "agentStatsNoRating": MessageLookupByLibrary.simpleMessage("Not rated yet"),
    "agentStatsRating": MessageLookupByLibrary.simpleMessage("Average rating"),
    "agentStatsRatingCount": m5,
    "agentStatsVisits": MessageLookupByLibrary.simpleMessage(
      "Visits completed",
    ),
    "agentStatusActive": MessageLookupByLibrary.simpleMessage("Active"),
    "agentStatusDeleted": MessageLookupByLibrary.simpleMessage(
      "Account closed",
    ),
    "agentStatusPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting approval",
    ),
    "agentStatusSuspended": MessageLookupByLibrary.simpleMessage("Suspended"),
    "agentStatusUnknown": MessageLookupByLibrary.simpleMessage(
      "Status unknown",
    ),
    "agentVisitDuration": MessageLookupByLibrary.simpleMessage("Visit length"),
    "agentVisitDurationValue": m6,
    "agentZonesEmptyError": MessageLookupByLibrary.simpleMessage(
      "Pick at least one city or district.",
    ),
    "agentZonesHelp": MessageLookupByLibrary.simpleMessage(
      "Pick a whole city, or only certain districts. You will only be offered properties inside your areas.",
    ),
    "agentZonesNone": MessageLookupByLibrary.simpleMessage("No areas"),
    "agentZonesSubtitle": m7,
    "agentZonesTitle": MessageLookupByLibrary.simpleMessage("My working areas"),
    "agentZonesWholeCity": MessageLookupByLibrary.simpleMessage(
      "The whole city",
    ),
    "agentsAcceptWarning": MessageLookupByLibrary.simpleMessage(
      "Several agents can cover the same property: accepting this application does not turn the others down.",
    ),
    "agentsActionFailed": MessageLookupByLibrary.simpleMessage(
      "That action isn\'t possible right now.",
    ),
    "agentsAddAgent": MessageLookupByLibrary.simpleMessage("Add an agent"),
    "agentsAddAgentBody": MessageLookupByLibrary.simpleMessage(
      "Active agents whose area covers this property.",
    ),
    "agentsApplicationAccept": MessageLookupByLibrary.simpleMessage("Accept"),
    "agentsApplicationDecline": MessageLookupByLibrary.simpleMessage("Decline"),
    "agentsApplicationsTitle": MessageLookupByLibrary.simpleMessage(
      "Applications",
    ),
    "agentsAssignAction": MessageLookupByLibrary.simpleMessage("Assign"),
    "agentsAssignConfirmBody": MessageLookupByLibrary.simpleMessage(
      "They will receive an offer and can accept or decline it.",
    ),
    "agentsAssignConfirmTitle": m8,
    "agentsAssignEmpty": MessageLookupByLibrary.simpleMessage(
      "No agent available in this area.",
    ),
    "agentsAssignTitle": MessageLookupByLibrary.simpleMessage("List"),
    "agentsAwaitingResponse": MessageLookupByLibrary.simpleMessage(
      "Awaiting a response",
    ),
    "agentsCurrentTitle": MessageLookupByLibrary.simpleMessage(
      "Assigned agent",
    ),
    "agentsMineEmpty": MessageLookupByLibrary.simpleMessage(
      "No agent assigned",
    ),
    "agentsMineEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Assign an agent to a property so tenants can schedule a visit.",
    ),
    "agentsMineTitle": MessageLookupByLibrary.simpleMessage("My agents"),
    "agentsOfferSent": m9,
    "agentsOfferSentBody": MessageLookupByLibrary.simpleMessage(
      "You will be notified of their response.",
    ),
    "agentsOfferSentTitle": MessageLookupByLibrary.simpleMessage(
      "Agent assignment",
    ),
    "agentsOfferSkipped": m10,
    "agentsOwnerVisitsBody": MessageLookupByLibrary.simpleMessage(
      "You will appear among the visitors offered for this property. Each request reaches you so you can confirm a time.",
    ),
    "agentsOwnerVisitsElsewhere": MessageLookupByLibrary.simpleMessage(
      "Your own visits are set on the property\'s page.",
    ),
    "agentsOwnerVisitsTitle": MessageLookupByLibrary.simpleMessage(
      "I show this property myself",
    ),
    "agentsPickPropertyBody": MessageLookupByLibrary.simpleMessage(
      "An agent is assigned to a specific property.",
    ),
    "agentsPickPropertyEmpty": MessageLookupByLibrary.simpleMessage(
      "No property available for assignment.",
    ),
    "agentsPickPropertyNone": MessageLookupByLibrary.simpleMessage(
      "No published property",
    ),
    "agentsPickPropertyNoneBody": MessageLookupByLibrary.simpleMessage(
      "An agent can only be assigned to a published property. Publish a listing or a residence unit to continue.",
    ),
    "agentsPickPropertyTitle": MessageLookupByLibrary.simpleMessage(
      "Choose a property",
    ),
    "agentsPoolBody": MessageLookupByLibrary.simpleMessage(
      "Several agents can cover the same property. The tenant then chooses who shows them around.",
    ),
    "agentsPoolEmpty": MessageLookupByLibrary.simpleMessage(
      "No agent assigned yet.",
    ),
    "agentsPoolTitle": MessageLookupByLibrary.simpleMessage("Assigned agents"),
    "agentsPropertyCount": m11,
    "agentsUnitsCovered": m12,
    "agentsVisitCount": m13,
    "agentsWithdraw": MessageLookupByLibrary.simpleMessage("Remove assignment"),
    "agentsWithdrawConfirm": MessageLookupByLibrary.simpleMessage(
      "Visits already scheduled will be cancelled.",
    ),
    "agentsWithdrawUnavailable": MessageLookupByLibrary.simpleMessage(
      "Removing one agent is not possible yet while several are assigned to this property.",
    ),
    "amenityAirConditioning": MessageLookupByLibrary.simpleMessage(
      "Air conditioning",
    ),
    "amenityGenerator": MessageLookupByLibrary.simpleMessage("Generator"),
    "amenityHotWater": MessageLookupByLibrary.simpleMessage("Hot water"),
    "amenityParking": MessageLookupByLibrary.simpleMessage("Parking"),
    "amenitySecurityGuard": MessageLookupByLibrary.simpleMessage(
      "Security guard",
    ),
    "amenityWifi": MessageLookupByLibrary.simpleMessage("Wi-Fi"),
    "annonceActionArchive": MessageLookupByLibrary.simpleMessage("Archive"),
    "annonceActionDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "annonceActionFailed": MessageLookupByLibrary.simpleMessage(
      "That action isn’t possible right now.",
    ),
    "annonceActionMarkRented": MessageLookupByLibrary.simpleMessage(
      "Mark rented",
    ),
    "annonceActionPublish": MessageLookupByLibrary.simpleMessage("Publish"),
    "annonceActionReserve": MessageLookupByLibrary.simpleMessage(
      "Mark reserved",
    ),
    "annonceActionUnarchive": MessageLookupByLibrary.simpleMessage("Unarchive"),
    "annonceCardExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "annonceCardPlanLimit": MessageLookupByLibrary.simpleMessage("Plan limit"),
    "annonceDeleteConfirmBody": MessageLookupByLibrary.simpleMessage(
      "This is permanent. The property will be removed from your portfolio.",
    ),
    "annonceDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Delete this property?",
    ),
    "annonceDetailAgents": MessageLookupByLibrary.simpleMessage(
      "Assigned agents",
    ),
    "annonceDetailAmenities": MessageLookupByLibrary.simpleMessage("Amenities"),
    "annonceDetailCharges": MessageLookupByLibrary.simpleMessage("Charges"),
    "annonceDetailChargesExtra": MessageLookupByLibrary.simpleMessage("On top"),
    "annonceDetailChargesIncluded": MessageLookupByLibrary.simpleMessage(
      "Included",
    ),
    "annonceDetailFacts": MessageLookupByLibrary.simpleMessage(
      "Characteristics",
    ),
    "annonceDetailHistory": MessageLookupByLibrary.simpleMessage("History"),
    "annonceDetailNoInfo": MessageLookupByLibrary.simpleMessage(
      "No information\navailable right now",
    ),
    "annonceDetailOccupant": MessageLookupByLibrary.simpleMessage("Occupant"),
    "annonceDetailStats": MessageLookupByLibrary.simpleMessage("Statistics"),
    "annonceDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Property details",
    ),
    "annonceDetailUnitOfResidence": MessageLookupByLibrary.simpleMessage(
      "Unit of a residence",
    ),
    "annonceDetailVisits": MessageLookupByLibrary.simpleMessage("Visits"),
    "annonceExpiredBody": MessageLookupByLibrary.simpleMessage(
      "On the Free plan a listing stays online for 30 days. Unarchive it, then publish it: it gets another 30 days.",
    ),
    "annonceExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Expired after 30 days",
    ),
    "annonceExpiresBody": MessageLookupByLibrary.simpleMessage(
      "On the Free plan a listing stays online for 30 days. A paid plan keeps it online with no limit.",
    ),
    "annonceExpiresIn": m14,
    "annonceFormAddress": MessageLookupByLibrary.simpleMessage("Exact address"),
    "annonceFormCityDetected": m15,
    "annonceFormCityNotDetected": MessageLookupByLibrary.simpleMessage(
      "City not detected. Pick it manually.",
    ),
    "annonceFormCurrency": MessageLookupByLibrary.simpleMessage("FCFA"),
    "annonceFormDetectingCity": MessageLookupByLibrary.simpleMessage(
      "Detecting your city…",
    ),
    "annonceFormErrorIncomplete": MessageLookupByLibrary.simpleMessage(
      "Fill in the required fields.",
    ),
    "annonceFormErrorPhoto": MessageLookupByLibrary.simpleMessage(
      "Photo wasn’t uploaded, try again.",
    ),
    "annonceFormErrorSave": MessageLookupByLibrary.simpleMessage(
      "Couldn’t save. Try again.",
    ),
    "annonceFormFieldAmenities": MessageLookupByLibrary.simpleMessage(
      "Amenities",
    ),
    "annonceFormFieldAvailability": MessageLookupByLibrary.simpleMessage(
      "Availability",
    ),
    "annonceFormFieldBathrooms": MessageLookupByLibrary.simpleMessage(
      "Bathrooms",
    ),
    "annonceFormFieldBathrooms2": MessageLookupByLibrary.simpleMessage(
      "Bathrooms",
    ),
    "annonceFormFieldCharges": MessageLookupByLibrary.simpleMessage(
      "Charges included",
    ),
    "annonceFormFieldChargesAmount": MessageLookupByLibrary.simpleMessage(
      "Charges amount",
    ),
    "annonceFormFieldDescription": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "annonceFormFieldDistrict": MessageLookupByLibrary.simpleMessage(
      "District",
    ),
    "annonceFormFieldFurnished": MessageLookupByLibrary.simpleMessage(
      "Furnished",
    ),
    "annonceFormFieldLocation": MessageLookupByLibrary.simpleMessage(
      "Location",
    ),
    "annonceFormFieldName": MessageLookupByLibrary.simpleMessage("Name"),
    "annonceFormFieldPeriod": MessageLookupByLibrary.simpleMessage(
      "Rental period",
    ),
    "annonceFormFieldPrice": MessageLookupByLibrary.simpleMessage("Price"),
    "annonceFormFieldRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
    "annonceFormFieldSurface": MessageLookupByLibrary.simpleMessage(
      "Dimensions",
    ),
    "annonceFormFieldTitle": MessageLookupByLibrary.simpleMessage("Title"),
    "annonceFormFieldType": MessageLookupByLibrary.simpleMessage("Type"),
    "annonceFormHelpAmenities": MessageLookupByLibrary.simpleMessage(
      "Optional. Tick what the property offers — tenants use these to compare listings.",
    ),
    "annonceFormHelpAvailability": MessageLookupByLibrary.simpleMessage(
      "Required. Tenants can filter on immediate availability.",
    ),
    "annonceFormHelpCharges": MessageLookupByLibrary.simpleMessage(
      "Optional. Say whether water and electricity are included in the rent, and how much they cost if they are not.",
    ),
    "annonceFormHelpDescription": MessageLookupByLibrary.simpleMessage(
      "Optional, 1,500 characters maximum.",
    ),
    "annonceFormHelpKind": MessageLookupByLibrary.simpleMessage(
      "A Multiple Property groups several units sharing one address and set of characteristics: a building, a compound, a hotel, a serviced residence. Units are created in groups up front — none can be added afterwards.",
    ),
    "annonceFormHelpLocation": MessageLookupByLibrary.simpleMessage(
      "The city and district are visible to tenants. The exact address never is: it appears only in the signed Mboa Contract.",
    ),
    "annonceFormHelpOptionalFilters": MessageLookupByLibrary.simpleMessage(
      "Optional, but tenants filter their search on these — a listing without them comes up less often.",
    ),
    "annonceFormHelpPhotos": MessageLookupByLibrary.simpleMessage(
      "3 photos minimum, 15 maximum. They are compressed automatically before upload. Changing the photos on a published listing re-triggers validation of the “Verified photos” badge.",
    ),
    "annonceFormHelpPrice": MessageLookupByLibrary.simpleMessage(
      "The rent as you collect it, and how often: daily, weekly, monthly, quarterly or yearly. Mboa derives a monthly equivalent used only to compare listings with each other — never billed, never carried into the Mboa Contract.",
    ),
    "annonceFormHelpPropertyType": MessageLookupByLibrary.simpleMessage(
      "Apartment, studio, villa, room, office or commercial space. Tenants filter their search on this.",
    ),
    "annonceFormKindLabel": MessageLookupByLibrary.simpleMessage(
      "Listing type",
    ),
    "annonceFormKindMultiple": MessageLookupByLibrary.simpleMessage(
      "Residence",
    ),
    "annonceFormKindSingle": MessageLookupByLibrary.simpleMessage(
      "Single property",
    ),
    "annonceFormLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn’t load this property.",
    ),
    "annonceFormLocating": MessageLookupByLibrary.simpleMessage(
      "Getting your location…",
    ),
    "annonceFormLocationDenied": MessageLookupByLibrary.simpleMessage(
      "Allow location access to record where the property is.",
    ),
    "annonceFormLocationHint": MessageLookupByLibrary.simpleMessage(
      "The saved position is your phone’s. Stand at the property, or correct the address.",
    ),
    "annonceFormNoDistricts": MessageLookupByLibrary.simpleMessage(
      "No district available for this city.",
    ),
    "annonceFormPhotosHint": m16,
    "annonceFormPhotosLabel": MessageLookupByLibrary.simpleMessage("Photos"),
    "annonceFormPickDistrict": MessageLookupByLibrary.simpleMessage(
      "Choose the district",
    ),
    "annonceFormSave": MessageLookupByLibrary.simpleMessage("Save"),
    "annonceFormSavedDraft": MessageLookupByLibrary.simpleMessage(
      "Saved as a draft.",
    ),
    "annonceFormTitleEdit": MessageLookupByLibrary.simpleMessage(
      "Edit property",
    ),
    "annonceFormTitleNew": MessageLookupByLibrary.simpleMessage(
      "Add a property",
    ),
    "annonceFormUnitCount": MessageLookupByLibrary.simpleMessage("Count"),
    "annonceFormUnitPrefix": MessageLookupByLibrary.simpleMessage(
      "Prefix (e.g. Room)",
    ),
    "annonceFormUnitSquareMetres": MessageLookupByLibrary.simpleMessage("m²"),
    "annonceFormUnitsAdd": MessageLookupByLibrary.simpleMessage(
      "Add a unit group",
    ),
    "annonceFormUnitsTitle": MessageLookupByLibrary.simpleMessage("Units"),
    "annoncePeriodDay": MessageLookupByLibrary.simpleMessage("day"),
    "annoncePeriodDayInline": MessageLookupByLibrary.simpleMessage("day"),
    "annoncePeriodMonth": MessageLookupByLibrary.simpleMessage("month"),
    "annoncePeriodMonthInline": MessageLookupByLibrary.simpleMessage("month"),
    "annoncePeriodQuarter": MessageLookupByLibrary.simpleMessage("quarter"),
    "annoncePeriodQuarterInline": MessageLookupByLibrary.simpleMessage(
      "quarter",
    ),
    "annoncePeriodWeek": MessageLookupByLibrary.simpleMessage("week"),
    "annoncePeriodWeekInline": MessageLookupByLibrary.simpleMessage("week"),
    "annoncePeriodYear": MessageLookupByLibrary.simpleMessage("year"),
    "annoncePeriodYearInline": MessageLookupByLibrary.simpleMessage("year"),
    "annoncePlanLimitBody": MessageLookupByLibrary.simpleMessage(
      "Your plan ended and this listing was over the Free limit. Upgrade to a paid plan, or archive another listing to make room for it.",
    ),
    "annoncePlanLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Archived: Free plan limit",
    ),
    "annoncePricePerPeriod": m17,
    "annonceSeePlans": MessageLookupByLibrary.simpleMessage("See plans"),
    "annonceStatusArchived": MessageLookupByLibrary.simpleMessage("Archived"),
    "annonceStatusDraft": MessageLookupByLibrary.simpleMessage("Draft"),
    "annonceStatusPublished": MessageLookupByLibrary.simpleMessage("Available"),
    "annonceStatusRented": MessageLookupByLibrary.simpleMessage("Rented"),
    "annonceStatusReserved": MessageLookupByLibrary.simpleMessage("Reserved"),
    "annoncesActionEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "annoncesActionHistory": MessageLookupByLibrary.simpleMessage("History"),
    "annoncesActionMore": MessageLookupByLibrary.simpleMessage("More actions"),
    "annoncesEmptyArchived": MessageLookupByLibrary.simpleMessage(
      "No archived property.",
    ),
    "annoncesEmptyAvailable": MessageLookupByLibrary.simpleMessage(
      "No available property. Tap + to register one.",
    ),
    "annoncesEmptyOccupied": MessageLookupByLibrary.simpleMessage(
      "No occupied property.",
    ),
    "annoncesMultipleTitle": MessageLookupByLibrary.simpleMessage("Residences"),
    "annoncesPerMonth": m18,
    "annoncesRooms": m19,
    "annoncesSingleTitle": MessageLookupByLibrary.simpleMessage(
      "Single properties",
    ),
    "annoncesSurface": m20,
    "annoncesTabArchived": MessageLookupByLibrary.simpleMessage("Archived"),
    "annoncesTabAvailable": MessageLookupByLibrary.simpleMessage("Available"),
    "annoncesTabOccupied": MessageLookupByLibrary.simpleMessage("Occupied"),
    "annoncesUnitsPublished": m21,
    "annoncesUnitsSummary": m22,
    "appName": MessageLookupByLibrary.simpleMessage("Mboa"),
    "appNamePro": MessageLookupByLibrary.simpleMessage("Mboa Pro"),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("name@example.com"),
    "authEmailInvalid": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
    "authLoginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "authLogout": MessageLookupByLibrary.simpleMessage("Log out"),
    "authOtpResent": MessageLookupByLibrary.simpleMessage(
      "A new code has been sent.",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage("Your password"),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "authPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Password required",
    ),
    "badgeRecertified": MessageLookupByLibrary.simpleMessage("Recertified"),
    "badgeTrustedProvider": MessageLookupByLibrary.simpleMessage(
      "Trusted provider",
    ),
    "badgeVerifiedIdentity": MessageLookupByLibrary.simpleMessage(
      "Verified identity",
    ),
    "badgeVerifiedPhotos": MessageLookupByLibrary.simpleMessage(
      "Verified photos",
    ),
    "changePasswordButton": MessageLookupByLibrary.simpleMessage("Update"),
    "changePasswordConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm new password",
    ),
    "changePasswordCurrent": MessageLookupByLibrary.simpleMessage(
      "Current password",
    ),
    "changePasswordError": MessageLookupByLibrary.simpleMessage(
      "Couldn’t change the password. Check your current password.",
    ),
    "changePasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords don’t match",
    ),
    "changePasswordNew": MessageLookupByLibrary.simpleMessage("New password"),
    "changePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password updated",
    ),
    "changePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm change",
    ),
    "changePhoneNewCodeLabel": m23,
    "changePhoneOldCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code sent to your old number",
    ),
    "changePhoneSuccess": MessageLookupByLibrary.simpleMessage(
      "Number updated",
    ),
    "cityPickerEmpty": MessageLookupByLibrary.simpleMessage("No city found"),
    "cityPickerSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search a city",
    ),
    "cityPickerTitle": MessageLookupByLibrary.simpleMessage("Choose a city"),
    "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonComingSoon": MessageLookupByLibrary.simpleMessage("Coming soon"),
    "commonError": MessageLookupByLibrary.simpleMessage(
      "That didn’t work. Try again.",
    ),
    "commonErrorTitle": MessageLookupByLibrary.simpleMessage("Oops"),
    "commonNo": MessageLookupByLibrary.simpleMessage("No"),
    "commonOr": MessageLookupByLibrary.simpleMessage("Or"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "commonYes": MessageLookupByLibrary.simpleMessage("Yes"),
    "contractAccept": MessageLookupByLibrary.simpleMessage("Accept the terms"),
    "contractActionDone": MessageLookupByLibrary.simpleMessage(
      "Contract updated",
    ),
    "contractActionFailed": MessageLookupByLibrary.simpleMessage(
      "Action not possible right now.",
    ),
    "contractAmend": MessageLookupByLibrary.simpleMessage("Amend the terms"),
    "contractAwaitingBoth": MessageLookupByLibrary.simpleMessage(
      "Waiting on both signatures",
    ),
    "contractAwaitingNobody": MessageLookupByLibrary.simpleMessage(
      "Nothing to do",
    ),
    "contractAwaitingTenant": MessageLookupByLibrary.simpleMessage(
      "Waiting on the tenant",
    ),
    "contractAwaitingYou": MessageLookupByLibrary.simpleMessage(
      "Waiting on you",
    ),
    "contractCancel": MessageLookupByLibrary.simpleMessage(
      "Cancel the contract",
    ),
    "contractCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "The contract will be cancelled for both parties. This cannot be undone.",
    ),
    "contractChangeAnswer": MessageLookupByLibrary.simpleMessage("Answer"),
    "contractChangeAnswerHelp": MessageLookupByLibrary.simpleMessage(
      "Answer even if you change nothing: a reasoned refusal is an answer and stays in the file.",
    ),
    "contractChangeAnswerSend": MessageLookupByLibrary.simpleMessage(
      "Send the answer",
    ),
    "contractChangeAnswered": MessageLookupByLibrary.simpleMessage(
      "Objection answered",
    ),
    "contractChangePending": MessageLookupByLibrary.simpleMessage(
      "Objection awaiting your answer",
    ),
    "contractChangeWithdrawn": MessageLookupByLibrary.simpleMessage(
      "Objection withdrawn",
    ),
    "contractChangesTitle": MessageLookupByLibrary.simpleMessage(
      "Requested changes",
    ),
    "contractContest": MessageLookupByLibrary.simpleMessage("Request a change"),
    "contractContestHelp": MessageLookupByLibrary.simpleMessage(
      "Say what does not work. The landlord has to answer, even if nothing moves.",
    ),
    "contractContestHint": MessageLookupByLibrary.simpleMessage(
      "What is wrong, and why.",
    ),
    "contractContestSend": MessageLookupByLibrary.simpleMessage(
      "Send the objection",
    ),
    "contractCreate": MessageLookupByLibrary.simpleMessage(
      "Draw up an Mboa contract",
    ),
    "contractDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Mboa contract",
    ),
    "contractDurationValue": m24,
    "contractFormSave": MessageLookupByLibrary.simpleMessage(
      "Create the contract",
    ),
    "contractFormTenantHelp": MessageLookupByLibrary.simpleMessage(
      "If they have no Mboa account yet, an SMS invitation is sent and the contract is drawn up once they have joined.",
    ),
    "contractFormTenantPhone": MessageLookupByLibrary.simpleMessage(
      "Tenant\'s number",
    ),
    "contractFormTenantTitle": MessageLookupByLibrary.simpleMessage("Tenant"),
    "contractFormTitleAmend": MessageLookupByLibrary.simpleMessage(
      "Amend the terms",
    ),
    "contractFormTitleNew": MessageLookupByLibrary.simpleMessage(
      "Draw up an Mboa contract",
    ),
    "contractLocked": MessageLookupByLibrary.simpleMessage(
      "Locked: no change is possible, not even by an administrator.",
    ),
    "contractPartiesTitle": MessageLookupByLibrary.simpleMessage("Parties"),
    "contractPartyAgent": MessageLookupByLibrary.simpleMessage(
      "Agent who ran the visit",
    ),
    "contractPartyPrestataire": MessageLookupByLibrary.simpleMessage(
      "Landlord",
    ),
    "contractPartyTenant": MessageLookupByLibrary.simpleMessage("Tenant"),
    "contractPdf": MessageLookupByLibrary.simpleMessage("Download the PDF"),
    "contractPdfCopied": MessageLookupByLibrary.simpleMessage(
      "PDF link copied",
    ),
    "contractSaved": MessageLookupByLibrary.simpleMessage("Contract saved"),
    "contractSend": MessageLookupByLibrary.simpleMessage("Send to the tenant"),
    "contractSign": MessageLookupByLibrary.simpleMessage("Sign"),
    "contractSignPrompt": m25,
    "contractSignWarning": MessageLookupByLibrary.simpleMessage(
      "Once both signatures are in, the contract is final: no change is possible.",
    ),
    "contractSignWord": MessageLookupByLibrary.simpleMessage("SIGN"),
    "contractSignatureMine": MessageLookupByLibrary.simpleMessage(
      "Your signature",
    ),
    "contractSignatureOther": MessageLookupByLibrary.simpleMessage(
      "The tenant\'s signature",
    ),
    "contractSignaturesTitle": MessageLookupByLibrary.simpleMessage(
      "Signatures",
    ),
    "contractSignedByYou": MessageLookupByLibrary.simpleMessage(
      "You have signed",
    ),
    "contractStatusAccepted": MessageLookupByLibrary.simpleMessage("Accepted"),
    "contractStatusCancelled": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "contractStatusChangesRequested": MessageLookupByLibrary.simpleMessage(
      "Changes requested",
    ),
    "contractStatusDraft": MessageLookupByLibrary.simpleMessage("Draft"),
    "contractStatusSent": MessageLookupByLibrary.simpleMessage("Sent"),
    "contractStatusSigned": MessageLookupByLibrary.simpleMessage("Signed"),
    "contractTenantInvited": MessageLookupByLibrary.simpleMessage(
      "This tenant has no Mboa account yet. An invitation has been sent; draw the contract up again once they have joined.",
    ),
    "contractTenantPending": MessageLookupByLibrary.simpleMessage(
      "Tenant to be confirmed",
    ),
    "contractTermCharges": MessageLookupByLibrary.simpleMessage("Charges"),
    "contractTermDeposit": MessageLookupByLibrary.simpleMessage("Deposit"),
    "contractTermDuration": MessageLookupByLibrary.simpleMessage("Duration"),
    "contractTermEnd": MessageLookupByLibrary.simpleMessage("End of tenancy"),
    "contractTermPeriod": MessageLookupByLibrary.simpleMessage("Period"),
    "contractTermPrice": MessageLookupByLibrary.simpleMessage("Rent"),
    "contractTermStart": MessageLookupByLibrary.simpleMessage("Start date"),
    "contractTermTacit": MessageLookupByLibrary.simpleMessage("Tacit renewal"),
    "contractTermsTitle": MessageLookupByLibrary.simpleMessage("Terms"),
    "contractsEmptyBody": MessageLookupByLibrary.simpleMessage(
      "A Contrat Mboa always starts from a property. Open the listing to draw one up.",
    ),
    "contractsEmptyFiltered": MessageLookupByLibrary.simpleMessage(
      "No contract in this view.",
    ),
    "contractsEmptyTenantBody": MessageLookupByLibrary.simpleMessage(
      "Your Mboa Contracts appear here as soon as a landlord sends you one.",
    ),
    "contractsEmptyTitle": MessageLookupByLibrary.simpleMessage("No contract"),
    "contractsFilterAll": MessageLookupByLibrary.simpleMessage("All"),
    "contractsFilterMine": MessageLookupByLibrary.simpleMessage("Your move"),
    "contractsTitle": MessageLookupByLibrary.simpleMessage("Mboa contracts"),
    "dayFriday": MessageLookupByLibrary.simpleMessage("Friday"),
    "dayMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "daySaturday": MessageLookupByLibrary.simpleMessage("Saturday"),
    "daySunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "dayThursday": MessageLookupByLibrary.simpleMessage("Thursday"),
    "dayTuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
    "dayWednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
    "deleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Delete permanently",
    ),
    "deleteAccountConfirmLabel": m26,
    "deleteAccountConfirmWord": MessageLookupByLibrary.simpleMessage("DELETE"),
    "deleteAccountLink": MessageLookupByLibrary.simpleMessage(
      "Delete my account",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Delete account",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "This is permanent. Your personal data will be deleted and you will lose access to your account.",
    ),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "errorAccessDenied": MessageLookupByLibrary.simpleMessage(
      "Your account isn’t allowed to do that.",
    ),
    "errorConstraintViolation": MessageLookupByLibrary.simpleMessage(
      "A concurrent write failed. Try again.",
    ),
    "errorInsufficientPhotos": MessageLookupByLibrary.simpleMessage(
      "Add at least 3 photos to publish.",
    ),
    "errorInvalidTransition": MessageLookupByLibrary.simpleMessage(
      "That status change isn’t possible for this property.",
    ),
    "errorKycRequired": MessageLookupByLibrary.simpleMessage(
      "Your certifications must be approved before this action.",
    ),
    "errorListingLimit": MessageLookupByLibrary.simpleMessage(
      "You’ve reached your plan’s active-listing limit.",
    ),
    "errorProfileIncomplete": MessageLookupByLibrary.simpleMessage(
      "Complete your profile (photo, type, city) first.",
    ),
    "errorResidenceUnitLimit": MessageLookupByLibrary.simpleMessage(
      "Your plan doesn’t allow that many units. Upgrade, or reduce the unit count.",
    ),
    "errorValidation": MessageLookupByLibrary.simpleMessage(
      "Some details are invalid. Check the form.",
    ),
    "exitAppBody": MessageLookupByLibrary.simpleMessage(
      "Press back again to exit.",
    ),
    "exitAppTitle": MessageLookupByLibrary.simpleMessage("Leave the app?"),
    "favoritesAdd": MessageLookupByLibrary.simpleMessage("Save"),
    "favoritesEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Tap the heart on a property to find it here.",
    ),
    "favoritesEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No favourites",
    ),
    "favoritesLimitReached": MessageLookupByLibrary.simpleMessage(
      "You have reached 50 favourites. Remove one to add another.",
    ),
    "favoritesRemove": MessageLookupByLibrary.simpleMessage(
      "Remove from favourites",
    ),
    "favoritesSignInBody": MessageLookupByLibrary.simpleMessage(
      "Your favourites follow you from one device to the next.",
    ),
    "favoritesSignInTitle": MessageLookupByLibrary.simpleMessage(
      "Create an account to save",
    ),
    "favoritesUnavailable": MessageLookupByLibrary.simpleMessage(
      "This property is no longer available",
    ),
    "favoritesUnavailableNote": MessageLookupByLibrary.simpleMessage(
      "It stays here for 30 days, then disappears.",
    ),
    "homeCtaAgentsAction": MessageLookupByLibrary.simpleMessage(
      "Manage my agents",
    ),
    "homeCtaAgentsBody": MessageLookupByLibrary.simpleMessage(
      "Create agents to delegate partial or full management of your properties",
    ),
    "homeCtaAgentsTitle": MessageLookupByLibrary.simpleMessage("My agents"),
    "homeCtaBiensAction": MessageLookupByLibrary.simpleMessage(
      "Manage my properties",
    ),
    "homeCtaBiensBody": MessageLookupByLibrary.simpleMessage(
      "Register your properties and manage them more easily with a range of management options",
    ),
    "homeCtaBiensTitle": MessageLookupByLibrary.simpleMessage("My properties"),
    "homeCtaPortefeuilleAction": MessageLookupByLibrary.simpleMessage(
      "Manage my transactions",
    ),
    "homeCtaPortefeuilleBody": MessageLookupByLibrary.simpleMessage(
      "Manage the financial transactions tied to your properties from the app",
    ),
    "homeCtaPortefeuilleTitle": MessageLookupByLibrary.simpleMessage("Wallet"),
    "homeEmptyBiens": MessageLookupByLibrary.simpleMessage(
      "You haven’t registered any property yet.",
    ),
    "homeLocationEmpty": MessageLookupByLibrary.simpleMessage("--/--"),
    "homeLocationLabel": MessageLookupByLibrary.simpleMessage("Location"),
    "homeOfflineBanner": MessageLookupByLibrary.simpleMessage("Offline data"),
    "homeProWelcome": MessageLookupByLibrary.simpleMessage(
      "Welcome to Mboa Pro 👋",
    ),
    "homeStatsBiens": MessageLookupByLibrary.simpleMessage("Properties"),
    "homeStatsContacts": MessageLookupByLibrary.simpleMessage("Contacts"),
    "homeStatsContracts": MessageLookupByLibrary.simpleMessage("Contracts"),
    "homeStatsConversion": MessageLookupByLibrary.simpleMessage("Conversion"),
    "homeStatsLockedHint": m27,
    "homeStatsPublished": MessageLookupByLibrary.simpleMessage("Published"),
    "homeStatsRank": MessageLookupByLibrary.simpleMessage("Ranking"),
    "homeStatsRented": MessageLookupByLibrary.simpleMessage("Rented"),
    "homeStatsReserved": MessageLookupByLibrary.simpleMessage("Reserved"),
    "homeStatsTitle": MessageLookupByLibrary.simpleMessage("Global statistics"),
    "homeStatsUnavailable": MessageLookupByLibrary.simpleMessage("Soon"),
    "homeStatsUnavailableHint": MessageLookupByLibrary.simpleMessage(
      "These metrics activate as soon as the backend exposes them.",
    ),
    "homeStatsViews": MessageLookupByLibrary.simpleMessage("Views"),
    "homeStatsVisits": MessageLookupByLibrary.simpleMessage("Visits"),
    "homeTitle": MessageLookupByLibrary.simpleMessage(
      "Manage your properties\nfrom the app",
    ),
    "homeUserWelcome": MessageLookupByLibrary.simpleMessage(
      "Welcome to Mboa 👋",
    ),
    "kycAccountAgent": MessageLookupByLibrary.simpleMessage("Agent account"),
    "kycAccountPrestataire": MessageLookupByLibrary.simpleMessage(
      "Provider account",
    ),
    "kycAccountStandard": MessageLookupByLibrary.simpleMessage(
      "Standard account",
    ),
    "kycAdded": MessageLookupByLibrary.simpleMessage("Added"),
    "kycDocCni": MessageLookupByLibrary.simpleMessage("ID card"),
    "kycDocPassport": MessageLookupByLibrary.simpleMessage("Passport"),
    "kycDocRecepisse": MessageLookupByLibrary.simpleMessage("Receipt"),
    "kycDocResidence": MessageLookupByLibrary.simpleMessage("Residence permit"),
    "kycDone": MessageLookupByLibrary.simpleMessage("Done"),
    "kycIdDocumentPrompt": MessageLookupByLibrary.simpleMessage(
      "Choose the type of document you want to use to verify your identity",
    ),
    "kycImport": MessageLookupByLibrary.simpleMessage("Import"),
    "kycItemAddress": MessageLookupByLibrary.simpleMessage("Address"),
    "kycItemIdDocument": MessageLookupByLibrary.simpleMessage("ID Document"),
    "kycItemNui": MessageLookupByLibrary.simpleMessage("NUI"),
    "kycItemSelfie": MessageLookupByLibrary.simpleMessage("Selfie"),
    "kycRecto": MessageLookupByLibrary.simpleMessage("Front"),
    "kycRejectionReason": m28,
    "kycStatusApproved": MessageLookupByLibrary.simpleMessage("Verified"),
    "kycStatusNotSubmitted": MessageLookupByLibrary.simpleMessage(
      "Information required",
    ),
    "kycStatusPending": MessageLookupByLibrary.simpleMessage("Awaiting review"),
    "kycStatusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "kycSubmit": MessageLookupByLibrary.simpleMessage("Submit"),
    "kycSubmitted": MessageLookupByLibrary.simpleMessage("Documents submitted"),
    "kycTabIdentification": MessageLookupByLibrary.simpleMessage(
      "Identification",
    ),
    "kycTabStatut": MessageLookupByLibrary.simpleMessage("Status"),
    "kycTakePhoto": MessageLookupByLibrary.simpleMessage("Take a photo"),
    "kycUploadError": MessageLookupByLibrary.simpleMessage(
      "Upload failed. Try again.",
    ),
    "kycVerso": MessageLookupByLibrary.simpleMessage("Back"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "listingActionsSignIn": MessageLookupByLibrary.simpleMessage(
      "Sign in to contact the provider or book a visit.",
    ),
    "listingAmenities": MessageLookupByLibrary.simpleMessage("Amenities"),
    "listingCharacteristics": MessageLookupByLibrary.simpleMessage(
      "Characteristics",
    ),
    "listingContact": MessageLookupByLibrary.simpleMessage("Contact"),
    "listingDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "listingGoneBody": MessageLookupByLibrary.simpleMessage(
      "The listing was withdrawn or has expired. Try a new search.",
    ),
    "listingGoneTitle": MessageLookupByLibrary.simpleMessage(
      "This property is no longer available",
    ),
    "listingLocationNote": MessageLookupByLibrary.simpleMessage(
      "Approximate location: the exact address is only given on a signed contract.",
    ),
    "listingNoVisitor": MessageLookupByLibrary.simpleMessage(
      "This property does not accept visits yet.",
    ),
    "listingOffMarketBanner": MessageLookupByLibrary.simpleMessage(
      "This listing is no longer online.",
    ),
    "listingOfflineBanner": MessageLookupByLibrary.simpleMessage(
      "Offline fiche — some actions are unavailable.",
    ),
    "listingPhotosCount": m29,
    "listingPlanVisit": MessageLookupByLibrary.simpleMessage("Book a visit"),
    "listingProvider": MessageLookupByLibrary.simpleMessage("The provider"),
    "listingRatingSummary": m30,
    "listingRentedBanner": MessageLookupByLibrary.simpleMessage(
      "This property is already rented.",
    ),
    "listingReport": MessageLookupByLibrary.simpleMessage("Report"),
    "listingReservedBanner": MessageLookupByLibrary.simpleMessage(
      "This property is reserved for now.",
    ),
    "listingReviewEdited": m31,
    "listingReviewMonths": m32,
    "listingReviewResident": MessageLookupByLibrary.simpleMessage("Tenant"),
    "listingReviewVisit": MessageLookupByLibrary.simpleMessage("Visit"),
    "listingReviewsTitle": MessageLookupByLibrary.simpleMessage("Reviews"),
    "listingTitle": MessageLookupByLibrary.simpleMessage("Property details"),
    "loadingDialog_content": MessageLookupByLibrary.simpleMessage(
      "One moment…",
    ),
    "loginContinueWithApple": MessageLookupByLibrary.simpleMessage(
      "Continue with Apple",
    ),
    "loginContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "loginEnterPhone": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "loginNoAccountQuestion": MessageLookupByLibrary.simpleMessage(
      "Don’t have an account?",
    ),
    "loginOtpSendError": MessageLookupByLibrary.simpleMessage(
      "Couldn’t send the code. Try again.",
    ),
    "loginPhoneHint": MessageLookupByLibrary.simpleMessage("+237 6XX XX XX XX"),
    "loginPhoneHintLocal": MessageLookupByLibrary.simpleMessage(
      "6 XX XX XX XX",
    ),
    "loginPhoneInvalid": MessageLookupByLibrary.simpleMessage("Invalid number"),
    "loginPhoneLabel": MessageLookupByLibrary.simpleMessage("Phone"),
    "loginRequestCode": MessageLookupByLibrary.simpleMessage("Get the code"),
    "loginSignUpAction": MessageLookupByLibrary.simpleMessage("Sign up"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Sign in"),
    "mediaImport": MessageLookupByLibrary.simpleMessage("Import"),
    "mediaTakePhoto": MessageLookupByLibrary.simpleMessage("Take a photo"),
    "menuBookmarks": MessageLookupByLibrary.simpleMessage("Bookmarks"),
    "menuClose": MessageLookupByLibrary.simpleMessage("Close menu"),
    "menuExplore": MessageLookupByLibrary.simpleMessage("Explore"),
    "menuGreeting": MessageLookupByLibrary.simpleMessage("Hi"),
    "menuMessages": MessageLookupByLibrary.simpleMessage("Messages"),
    "menuNotifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "menuOther": MessageLookupByLibrary.simpleMessage("More"),
    "menuProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "menuQuit": MessageLookupByLibrary.simpleMessage("Sign out"),
    "menuSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "mesBiensAttributions": MessageLookupByLibrary.simpleMessage("Assignments"),
    "mesBiensAttributionsBody": MessageLookupByLibrary.simpleMessage(
      "Assign a unit",
    ),
    "mesBiensMultiple": MessageLookupByLibrary.simpleMessage("Residences"),
    "mesBiensPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting\nvalidation",
    ),
    "mesBiensProspections": MessageLookupByLibrary.simpleMessage("Prospecting"),
    "mesBiensProspectionsBody": MessageLookupByLibrary.simpleMessage(
      "Prospecting properties for sale",
    ),
    "mesBiensReservations": MessageLookupByLibrary.simpleMessage(
      "Reservations",
    ),
    "mesBiensReservationsBody": MessageLookupByLibrary.simpleMessage(
      "Handle reservations",
    ),
    "mesBiensSingle": MessageLookupByLibrary.simpleMessage(
      "Single\nproperties",
    ),
    "mesBiensTitle": MessageLookupByLibrary.simpleMessage("My properties"),
    "messagingAttach": MessageLookupByLibrary.simpleMessage("Attach an image"),
    "messagingAttachment": MessageLookupByLibrary.simpleMessage("Image"),
    "messagingAttachmentsMax": MessageLookupByLibrary.simpleMessage(
      "3 images maximum per message.",
    ),
    "messagingContactSent": MessageLookupByLibrary.simpleMessage(
      "Message sent to the provider",
    ),
    "messagingEmptyProvider": MessageLookupByLibrary.simpleMessage(
      "Tenants will write to you from your listings. You cannot start a conversation.",
    ),
    "messagingEmptyTenant": MessageLookupByLibrary.simpleMessage(
      "Contact a provider from a property\'s page to start a conversation.",
    ),
    "messagingEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No conversation",
    ),
    "messagingFailed": MessageLookupByLibrary.simpleMessage("Not sent"),
    "messagingHint": MessageLookupByLibrary.simpleMessage("Write a message…"),
    "messagingPending": MessageLookupByLibrary.simpleMessage(
      "Waiting for a connection",
    ),
    "messagingReadOnly": MessageLookupByLibrary.simpleMessage(
      "This listing is no longer available. The conversation stays readable.",
    ),
    "messagingSend": MessageLookupByLibrary.simpleMessage("Send"),
    "messagingTitle": MessageLookupByLibrary.simpleMessage("Messages"),
    "missionsAccept": MessageLookupByLibrary.simpleMessage("Accept"),
    "missionsActionFailed": MessageLookupByLibrary.simpleMessage(
      "That action isn\'t possible right now.",
    ),
    "missionsApplied": MessageLookupByLibrary.simpleMessage("Application sent"),
    "missionsApply": MessageLookupByLibrary.simpleMessage("Apply"),
    "missionsApplyNote": MessageLookupByLibrary.simpleMessage(
      "The owner chooses among the applicants.",
    ),
    "missionsDecline": MessageLookupByLibrary.simpleMessage("Decline"),
    "missionsEmptyMine": MessageLookupByLibrary.simpleMessage(
      "No missions in progress",
    ),
    "missionsEmptyOffers": MessageLookupByLibrary.simpleMessage(
      "No offers waiting",
    ),
    "missionsEmptyOpportunities": MessageLookupByLibrary.simpleMessage(
      "No opportunities in your areas",
    ),
    "missionsEmptyOpportunitiesBody": MessageLookupByLibrary.simpleMessage(
      "Widen your working areas to receive more offers.",
    ),
    "missionsResign": MessageLookupByLibrary.simpleMessage("Step down"),
    "missionsResignConfirm": MessageLookupByLibrary.simpleMessage(
      "Visits already scheduled will be cancelled.",
    ),
    "missionsTabMine": MessageLookupByLibrary.simpleMessage("My missions"),
    "missionsTabOffers": MessageLookupByLibrary.simpleMessage("Offers"),
    "missionsTabOpportunities": MessageLookupByLibrary.simpleMessage(
      "Opportunities",
    ),
    "missionsUnits": m33,
    "missionsWithdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "navAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "navFavorites": MessageLookupByLibrary.simpleMessage("Favourites"),
    "navFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navManager": MessageLookupByLibrary.simpleMessage("Manager"),
    "navMenu": MessageLookupByLibrary.simpleMessage("Menu"),
    "navMessages": MessageLookupByLibrary.simpleMessage("Messages"),
    "navSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "notifPrefN01": MessageLookupByLibrary.simpleMessage(
      "New listings for my searches",
    ),
    "notifPrefN02": MessageLookupByLibrary.simpleMessage(
      "New contacts on my listings",
    ),
    "notifPrefN03": MessageLookupByLibrary.simpleMessage("Confirmed visits"),
    "notifPrefN04": MessageLookupByLibrary.simpleMessage("New visit requests"),
    "notifPrefN05": MessageLookupByLibrary.simpleMessage("Cancelled visits"),
    "notifPrefN10": MessageLookupByLibrary.simpleMessage(
      "Listings about to expire",
    ),
    "notifPrefN15": MessageLookupByLibrary.simpleMessage("Agent assignments"),
    "notifPrefN18": MessageLookupByLibrary.simpleMessage(
      "Reminder to leave a review",
    ),
    "notifPrefN21": MessageLookupByLibrary.simpleMessage(
      "Replies to my reviews",
    ),
    "notifPrefN23": MessageLookupByLibrary.simpleMessage("Invoice reminders"),
    "notifPrefN25": MessageLookupByLibrary.simpleMessage("Paid invoices"),
    "notifPrefN26": MessageLookupByLibrary.simpleMessage(
      "Finance add-on ending",
    ),
    "notifPrefsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Your settings could not be loaded. Check your connection.",
    ),
    "notifPrefsMandatoryNote": MessageLookupByLibrary.simpleMessage(
      "Essential alerts (contracts, payments, moderation, badges) always stay on.",
    ),
    "notifPrefsMandatoryRefused": MessageLookupByLibrary.simpleMessage(
      "This notification cannot be turned off.",
    ),
    "notifPrefsSaveFailed": MessageLookupByLibrary.simpleMessage(
      "This setting was not saved. Try again.",
    ),
    "notifPrefsTitle": MessageLookupByLibrary.simpleMessage("Notifications"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("6-digit code"),
    "otpCodeSentTo": m34,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Invalid code. Try again.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive the code?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Resend code"),
    "otpResendIn": m35,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Verification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Confirm"),
    "paymentAwaitingBody": MessageLookupByLibrary.simpleMessage(
      "Approve the payment request on your phone (USSD or the Mobile Money app). This screen updates on its own.",
    ),
    "paymentAwaitingTitle": MessageLookupByLibrary.simpleMessage(
      "Finish on your phone",
    ),
    "paymentConfirmedBody": m36,
    "paymentConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Payment confirmed",
    ),
    "paymentDone": MessageLookupByLibrary.simpleMessage("Done"),
    "paymentFailedBody": MessageLookupByLibrary.simpleMessage(
      "The transaction didn’t go through. You haven’t been charged.",
    ),
    "paymentFailedTitle": MessageLookupByLibrary.simpleMessage(
      "Payment failed",
    ),
    "paymentInitiating": MessageLookupByLibrary.simpleMessage(
      "Starting the payment…",
    ),
    "paymentMethodMtn": MessageLookupByLibrary.simpleMessage(
      "MTN Mobile Money",
    ),
    "paymentMethodOrange": MessageLookupByLibrary.simpleMessage("Orange Money"),
    "paymentMethodTitle": MessageLookupByLibrary.simpleMessage(
      "Payment method",
    ),
    "paymentPendingBody": MessageLookupByLibrary.simpleMessage(
      "We haven’t received confirmation yet. It can take a few minutes — you’ll get a notification as soon as your plan is active.",
    ),
    "paymentPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Payment pending",
    ),
    "paymentReference": m37,
    "paymentRetry": MessageLookupByLibrary.simpleMessage("Retry payment"),
    "plansChoose": MessageLookupByLibrary.simpleMessage("Choose"),
    "plansCurrent": MessageLookupByLibrary.simpleMessage("Current plan"),
    "plansDowngradeNote": MessageLookupByLibrary.simpleMessage(
      "Moving to a lower plan takes effect next cycle.",
    ),
    "plansPriceFree": MessageLookupByLibrary.simpleMessage("Free"),
    "plansPriceMonthly": m38,
    "plansResidenceAllowance": m39,
    "plansTitle": MessageLookupByLibrary.simpleMessage("Plans"),
    "prestataireKindAgence": MessageLookupByLibrary.simpleMessage("Agency"),
    "prestataireKindParticulier": MessageLookupByLibrary.simpleMessage(
      "Individual",
    ),
    "prestataireKindPromoteur": MessageLookupByLibrary.simpleMessage(
      "Developer",
    ),
    "profileBusinessMissing": MessageLookupByLibrary.simpleMessage(
      "To be filled in",
    ),
    "profileBusinessTitle": MessageLookupByLibrary.simpleMessage("My business"),
    "profileDisplayName": MessageLookupByLibrary.simpleMessage("Display name"),
    "profileFirstName": MessageLookupByLibrary.simpleMessage("First name"),
    "profileIncompleteAction": MessageLookupByLibrary.simpleMessage("Complete"),
    "profileIncompleteBody": MessageLookupByLibrary.simpleMessage(
      "Complete your profile to publish your properties.",
    ),
    "profileIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Profile incomplete",
    ),
    "profileLastName": MessageLookupByLibrary.simpleMessage("Last name"),
    "profileLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn’t load your profile.",
    ),
    "profileLocation": MessageLookupByLibrary.simpleMessage("Location"),
    "profileMainCity": MessageLookupByLibrary.simpleMessage("Main city"),
    "profilePhotoUpdated": MessageLookupByLibrary.simpleMessage(
      "Photo updated",
    ),
    "profileRegistrationNumber": MessageLookupByLibrary.simpleMessage(
      "ID or trade register no.",
    ),
    "profileRegistrationNumberHelp": MessageLookupByLibrary.simpleMessage(
      "Printed on the Contrat Mboa, next to the tenant\'s ID.",
    ),
    "profileRegistrationNumberHint": MessageLookupByLibrary.simpleMessage(
      "e.g. RC/DLA/2024/B/1234",
    ),
    "profileSave": MessageLookupByLibrary.simpleMessage("Save"),
    "profileSaved": MessageLookupByLibrary.simpleMessage("Profile updated"),
    "profileSectionBusiness": MessageLookupByLibrary.simpleMessage("Business"),
    "profileSectionIdentity": MessageLookupByLibrary.simpleMessage("Identity"),
    "profileType": MessageLookupByLibrary.simpleMessage("Type"),
    "profileTypeAgence": MessageLookupByLibrary.simpleMessage("Agency"),
    "profileTypeParticulier": MessageLookupByLibrary.simpleMessage(
      "Individual",
    ),
    "profileTypePromoteur": MessageLookupByLibrary.simpleMessage("Promoter"),
    "propertyTypeApartment": MessageLookupByLibrary.simpleMessage("Apartment"),
    "propertyTypeCommercialSpace": MessageLookupByLibrary.simpleMessage(
      "Commercial space",
    ),
    "propertyTypeOffice": MessageLookupByLibrary.simpleMessage("Office"),
    "propertyTypeRoom": MessageLookupByLibrary.simpleMessage("Room"),
    "propertyTypeStudio": MessageLookupByLibrary.simpleMessage("Studio"),
    "propertyTypeVilla": MessageLookupByLibrary.simpleMessage("Villa"),
    "publishBlockedLimitBody": m40,
    "publishBlockedLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Limit reached",
    ),
    "publishBlockedPhotosBody": m41,
    "publishBlockedPhotosTitle": MessageLookupByLibrary.simpleMessage(
      "Missing photos",
    ),
    "publishBlockedProfileBody": MessageLookupByLibrary.simpleMessage(
      "Complete your profile (logo, type, city) before publishing.",
    ),
    "publishBlockedProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Incomplete profile",
    ),
    "registerButton": MessageLookupByLibrary.simpleMessage("Sign up"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed. Check your details.",
    ),
    "registerHaveAccountQuestion": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "registerRoleAgent": MessageLookupByLibrary.simpleMessage("Agent"),
    "registerRoleLabel": MessageLookupByLibrary.simpleMessage("I am a"),
    "registerRolePrestataire": MessageLookupByLibrary.simpleMessage("Provider"),
    "registerSignInAction": MessageLookupByLibrary.simpleMessage("Sign in"),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Create account"),
    "reportCommentHint": MessageLookupByLibrary.simpleMessage(
      "What the admin needs to know.",
    ),
    "reportCommentLabel": MessageLookupByLibrary.simpleMessage(
      "Details (optional)",
    ),
    "reportFailed": MessageLookupByLibrary.simpleMessage(
      "The report did not go through. Try again.",
    ),
    "reportReasonContent": MessageLookupByLibrary.simpleMessage(
      "Inappropriate content",
    ),
    "reportReasonFraud": MessageLookupByLibrary.simpleMessage(
      "Fraudulent listing",
    ),
    "reportReasonHarassment": MessageLookupByLibrary.simpleMessage(
      "Harassment",
    ),
    "reportReasonLabel": MessageLookupByLibrary.simpleMessage("Why?"),
    "reportReasonPrice": MessageLookupByLibrary.simpleMessage("Abnormal price"),
    "reportReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Report this review",
    ),
    "reportSend": MessageLookupByLibrary.simpleMessage("Send the report"),
    "reportSent": MessageLookupByLibrary.simpleMessage(
      "Your report has been received.",
    ),
    "reportSignInBody": MessageLookupByLibrary.simpleMessage(
      "Sign in to report content.",
    ),
    "reportTitle": MessageLookupByLibrary.simpleMessage("Report"),
    "residenceDeleteConfirmBody": MessageLookupByLibrary.simpleMessage(
      "This is permanent and removes all of its units too.",
    ),
    "residenceDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Delete this residence?",
    ),
    "residenceDetailOccupiedLabel": MessageLookupByLibrary.simpleMessage(
      "Occupied",
    ),
    "residenceDetailPublishedLabel": MessageLookupByLibrary.simpleMessage(
      "Published",
    ),
    "residenceDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Residence details",
    ),
    "residenceDetailUnitsLabel": MessageLookupByLibrary.simpleMessage("Total"),
    "residenceStayDay": m42,
    "residenceStayMonth": m43,
    "residenceStayQuarter": m44,
    "residenceStayWeek": m45,
    "residenceStayYear": m46,
    "residenceTitle": MessageLookupByLibrary.simpleMessage("Residence details"),
    "residenceUnitStatus": MessageLookupByLibrary.simpleMessage("Status"),
    "residenceUnitsAvailable": m47,
    "residenceUnitsPending": MessageLookupByLibrary.simpleMessage(
      "Editing a unit is coming soon.",
    ),
    "residenceUnitsSearchEmpty": m48,
    "residenceUnitsSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search for a unit",
    ),
    "residenceUnitsTitle": MessageLookupByLibrary.simpleMessage("Units"),
    "residencesTitle": MessageLookupByLibrary.simpleMessage("Residences"),
    "residentReplyDone": MessageLookupByLibrary.simpleMessage(
      "You have already answered this review.",
    ),
    "residentReplyHint": MessageLookupByLibrary.simpleMessage(
      "Answer this review publicly…",
    ),
    "residentReplyRule": MessageLookupByLibrary.simpleMessage(
      "Your answer is added beside the review, once. It changes neither your tenant\'s rating nor their words.",
    ),
    "residentReplySend": MessageLookupByLibrary.simpleMessage(
      "Publish my answer",
    ),
    "residentReplySent": MessageLookupByLibrary.simpleMessage(
      "Answer published",
    ),
    "residentReplyTitle": MessageLookupByLibrary.simpleMessage("Your answer"),
    "residentReviewCta": MessageLookupByLibrary.simpleMessage(
      "Leave my review",
    ),
    "residentReviewEditCta": MessageLookupByLibrary.simpleMessage(
      "Edit my review",
    ),
    "residentReviewLockedBody": MessageLookupByLibrary.simpleMessage(
      "The editing window has closed. Your review stays published on the listing.",
    ),
    "residentReviewLockedTitle": MessageLookupByLibrary.simpleMessage(
      "Review locked",
    ),
    "residentReviewNoneBody": MessageLookupByLibrary.simpleMessage(
      "Your tenant can publish their review whenever they like, for the whole tenancy.",
    ),
    "residentReviewReadTitle": MessageLookupByLibrary.simpleMessage(
      "Your tenant\'s review",
    ),
    "residentReviewSave": MessageLookupByLibrary.simpleMessage(
      "Save my corrections",
    ),
    "residentReviewSaved": MessageLookupByLibrary.simpleMessage(
      "Review updated",
    ),
    "residentReviewSeeCta": MessageLookupByLibrary.simpleMessage(
      "See the tenant\'s review",
    ),
    "residentReviewSubtitle": MessageLookupByLibrary.simpleMessage(
      "Published on the listing. You can correct it while you live there, and for 30 days after you leave.",
    ),
    "residentReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Your tenant review",
    ),
    "residentReviewWeight": MessageLookupByLibrary.simpleMessage(
      "A tenant\'s review counts three times a visitor\'s in the property\'s rating.",
    ),
    "reviewAddPoint": MessageLookupByLibrary.simpleMessage("Add"),
    "reviewAlreadyWritten": MessageLookupByLibrary.simpleMessage(
      "You have already reviewed this visit.",
    ),
    "reviewCommentHint": MessageLookupByLibrary.simpleMessage(
      "Reply to this review…",
    ),
    "reviewCommentLabel": MessageLookupByLibrary.simpleMessage("Comment"),
    "reviewCommentRule": MessageLookupByLibrary.simpleMessage(
      "Your reply is added to the review: it changes neither the tenant\'s rating nor their text.",
    ),
    "reviewCommentSend": MessageLookupByLibrary.simpleMessage(
      "Publish my reply",
    ),
    "reviewCommentSent": MessageLookupByLibrary.simpleMessage(
      "Reply published",
    ),
    "reviewCommentsEmpty": MessageLookupByLibrary.simpleMessage(
      "You have not replied to this review yet.",
    ),
    "reviewCommentsTitle": MessageLookupByLibrary.simpleMessage("Your replies"),
    "reviewCondition": m49,
    "reviewConditionLabel": MessageLookupByLibrary.simpleMessage(
      "Condition as you saw it",
    ),
    "reviewConditionValue": m50,
    "reviewCons": MessageLookupByLibrary.simpleMessage("Negatives"),
    "reviewDeletedAuthor": MessageLookupByLibrary.simpleMessage(
      "Deleted account",
    ),
    "reviewDownload": MessageLookupByLibrary.simpleMessage("Download as PDF"),
    "reviewDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "The PDF could not be generated.",
    ),
    "reviewExport": MessageLookupByLibrary.simpleMessage("Export as PDF"),
    "reviewFreeTextHint": MessageLookupByLibrary.simpleMessage(
      "What you saw, what stayed with you.",
    ),
    "reviewLocked": MessageLookupByLibrary.simpleMessage(
      "Your review is published and can no longer be changed.",
    ),
    "reviewNoneBody": MessageLookupByLibrary.simpleMessage(
      "The tenant can publish their review whenever they like. You\'ll be notified as soon as they do.",
    ),
    "reviewNoneTitle": MessageLookupByLibrary.simpleMessage("No review yet"),
    "reviewNotAllowed": MessageLookupByLibrary.simpleMessage(
      "A confirmed visit is required to review this property.",
    ),
    "reviewPhotosLabel": MessageLookupByLibrary.simpleMessage(
      "Photos taken on site",
    ),
    "reviewPhotosLimit": MessageLookupByLibrary.simpleMessage(
      "10 photos at most.",
    ),
    "reviewPointHint": MessageLookupByLibrary.simpleMessage(
      "e.g. quiet street",
    ),
    "reviewPros": MessageLookupByLibrary.simpleMessage("Positives"),
    "reviewPublish": MessageLookupByLibrary.simpleMessage("Publish my review"),
    "reviewPublished": MessageLookupByLibrary.simpleMessage("Review published"),
    "reviewPublishedOn": m51,
    "reviewRatingLabel": MessageLookupByLibrary.simpleMessage("Overall rating"),
    "reviewRatingRequired": MessageLookupByLibrary.simpleMessage(
      "The overall rating is required.",
    ),
    "reviewSeeCta": MessageLookupByLibrary.simpleMessage("See my review"),
    "reviewTitle": MessageLookupByLibrary.simpleMessage("Visit review"),
    "reviewWhatTheySaw": MessageLookupByLibrary.simpleMessage(
      "What the tenant saw",
    ),
    "reviewWriteCta": MessageLookupByLibrary.simpleMessage("Leave a review"),
    "reviewWriteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Published on the property page. You will not be able to change it.",
    ),
    "reviewWriteTitle": MessageLookupByLibrary.simpleMessage(
      "Your review of this property",
    ),
    "reviewYours": MessageLookupByLibrary.simpleMessage("Your review"),
    "searchAmenities": MessageLookupByLibrary.simpleMessage("Amenities"),
    "searchAny": MessageLookupByLibrary.simpleMessage("Any"),
    "searchApply": MessageLookupByLibrary.simpleMessage("See results"),
    "searchAvailableNow": MessageLookupByLibrary.simpleMessage("Available now"),
    "searchBadges": MessageLookupByLibrary.simpleMessage("Required badges"),
    "searchCityPrompt": MessageLookupByLibrary.simpleMessage("Choose a city"),
    "searchClearFilters": MessageLookupByLibrary.simpleMessage("Reset"),
    "searchEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Try another district, a higher rent, or another property type.",
    ),
    "searchEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Nothing here yet",
    ),
    "searchFilters": MessageLookupByLibrary.simpleMessage("Filters"),
    "searchMapApprox": MessageLookupByLibrary.simpleMessage(
      "Positions are approximate to within 200 m.",
    ),
    "searchMapNoKeyBody": MessageLookupByLibrary.simpleMessage(
      "This build has no map key. The results are still there in the list.",
    ),
    "searchMapNoKeyTitle": MessageLookupByLibrary.simpleMessage(
      "Map unavailable",
    ),
    "searchMapNoPositionBody": MessageLookupByLibrary.simpleMessage(
      "These results carry no position. They are still there in the list.",
    ),
    "searchMapNoPositionTitle": MessageLookupByLibrary.simpleMessage(
      "Nothing to place",
    ),
    "searchMapOfflineBody": MessageLookupByLibrary.simpleMessage(
      "Map tiles are not cached. Your last results are still there in the list.",
    ),
    "searchMapOfflineTitle": MessageLookupByLibrary.simpleMessage(
      "The map needs a connection",
    ),
    "searchMapStyleFailedBody": MessageLookupByLibrary.simpleMessage(
      "Check this build\'s map key. The results are still there in the list.",
    ),
    "searchMapStyleFailedTitle": MessageLookupByLibrary.simpleMessage(
      "The map could not load",
    ),
    "searchMax": MessageLookupByLibrary.simpleMessage("Max"),
    "searchMin": MessageLookupByLibrary.simpleMessage("Min"),
    "searchOfflineBanner": MessageLookupByLibrary.simpleMessage(
      "Offline results — from your last search.",
    ),
    "searchRentRange": MessageLookupByLibrary.simpleMessage("Rent (FCFA)"),
    "searchResidenceBadge": MessageLookupByLibrary.simpleMessage("Residence"),
    "searchResidenceFrom": m52,
    "searchResidenceUnits": m53,
    "searchResultCount": m54,
    "searchRoomsMin": MessageLookupByLibrary.simpleMessage("Minimum rooms"),
    "searchRoomsPlus": m55,
    "searchStaleBanner": MessageLookupByLibrary.simpleMessage(
      "Results not refreshed — the server did not answer.",
    ),
    "searchStartBody": MessageLookupByLibrary.simpleMessage(
      "Pick a city to start. Every other filter is optional.",
    ),
    "searchStartTitle": MessageLookupByLibrary.simpleMessage(
      "Where are you looking?",
    ),
    "searchSurfaceRange": MessageLookupByLibrary.simpleMessage("Surface (m²)"),
    "searchViewList": MessageLookupByLibrary.simpleMessage("List"),
    "searchViewMap": MessageLookupByLibrary.simpleMessage("Map"),
    "settingsCertificationsBody": MessageLookupByLibrary.simpleMessage(
      "Identity documents and any other required verifications",
    ),
    "settingsCertificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Certifications",
    ),
    "settingsChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change password",
    ),
    "settingsChangePhone": MessageLookupByLibrary.simpleMessage(
      "Change phone number",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "settingsLogout": MessageLookupByLibrary.simpleMessage("Log out"),
    "settingsMenuTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "settingsProfileCard": MessageLookupByLibrary.simpleMessage("Profile"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "subscriptionChangePlan": MessageLookupByLibrary.simpleMessage(
      "Change plan",
    ),
    "subscriptionCurrentPlan": MessageLookupByLibrary.simpleMessage(
      "Current plan",
    ),
    "subscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Your subscription has expired",
    ),
    "subscriptionListingLimit": m56,
    "subscriptionListingLimitUnlimited": MessageLookupByLibrary.simpleMessage(
      "Unlimited listings",
    ),
    "subscriptionNoExpiry": MessageLookupByLibrary.simpleMessage("No expiry"),
    "subscriptionNoReceipts": MessageLookupByLibrary.simpleMessage(
      "No payment recorded on this device.",
    ),
    "subscriptionReceiptOpen": MessageLookupByLibrary.simpleMessage(
      "Open receipt",
    ),
    "subscriptionReceipts": MessageLookupByLibrary.simpleMessage("My receipts"),
    "subscriptionReceiptsLocalHint": MessageLookupByLibrary.simpleMessage(
      "Receipts are tied to this device for now.",
    ),
    "subscriptionRenewsOn": m57,
    "subscriptionTitle": MessageLookupByLibrary.simpleMessage(
      "My subscription",
    ),
    "subscriptionUnknown": MessageLookupByLibrary.simpleMessage(
      "Couldn’t verify your subscription. Free plan applied in the meantime.",
    ),
    "visitAlreadyBooked": MessageLookupByLibrary.simpleMessage(
      "You already have a visit running on this property.",
    ),
    "visitAwaitingVisitor": MessageLookupByLibrary.simpleMessage(
      "The visitor still has to confirm this time. You cannot confirm on their behalf.",
    ),
    "visitBookConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm the visit",
    ),
    "visitBookDay": MessageLookupByLibrary.simpleMessage("Day"),
    "visitBookFree": MessageLookupByLibrary.simpleMessage(
      "Your first visit is free.",
    ),
    "visitBookHour": MessageLookupByLibrary.simpleMessage("Time"),
    "visitBookNoHour": MessageLookupByLibrary.simpleMessage(
      "No free time that day.",
    ),
    "visitBookNoSlotAction": MessageLookupByLibrary.simpleMessage(
      "Contact the provider",
    ),
    "visitBookSlot": MessageLookupByLibrary.simpleMessage("Pick a time"),
    "visitBookSubtitle": MessageLookupByLibrary.simpleMessage(
      "Pick a visitor and a time.",
    ),
    "visitBookTitle": MessageLookupByLibrary.simpleMessage("Book a visit"),
    "visitBookVisitor": MessageLookupByLibrary.simpleMessage(
      "Who shows you around",
    ),
    "visitBookWindow": MessageLookupByLibrary.simpleMessage("The next 7 days"),
    "visitBookedTitle": MessageLookupByLibrary.simpleMessage("Visit confirmed"),
    "visitCallHint": MessageLookupByLibrary.simpleMessage(
      "The visitor\'s number is shown until the visit ends.",
    ),
    "visitCallVisitor": MessageLookupByLibrary.simpleMessage(
      "Call the visitor",
    ),
    "visitCancel": MessageLookupByLibrary.simpleMessage("Cancel the visit"),
    "visitCancelTooLate": MessageLookupByLibrary.simpleMessage(
      "Cancelling is no longer possible: let the visitor know directly.",
    ),
    "visitCancelledAgentRemoved": MessageLookupByLibrary.simpleMessage(
      "The agent no longer handles this property.",
    ),
    "visitCancelledAgentUnavailable": MessageLookupByLibrary.simpleMessage(
      "The agent is no longer available for this visit.",
    ),
    "visitCancelledByClient": MessageLookupByLibrary.simpleMessage(
      "You cancelled this visit.",
    ),
    "visitCancelledByVisitor": MessageLookupByLibrary.simpleMessage(
      "The visitor cancelled this visit.",
    ),
    "visitCancelledListingUnavailable": MessageLookupByLibrary.simpleMessage(
      "The listing is no longer online.",
    ),
    "visitConfirmPresence": MessageLookupByLibrary.simpleMessage("I\'m here"),
    "visitDetailTitle": MessageLookupByLibrary.simpleMessage("Visit details"),
    "visitNoSlotAvailability": MessageLookupByLibrary.simpleMessage(
      "Nobody has declared hours for this property yet. Reach the provider through messages.",
    ),
    "visitNoSlotBlocked": MessageLookupByLibrary.simpleMessage(
      "Nothing available this week.",
    ),
    "visitNoSlotBooked": MessageLookupByLibrary.simpleMessage(
      "Every slot this week is taken.",
    ),
    "visitPresenceConfirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "visitPresenceExplainer": MessageLookupByLibrary.simpleMessage(
      "The visit only starts once you and the visitor have both confirmed being there.",
    ),
    "visitPresencePending": MessageLookupByLibrary.simpleMessage("Not yet"),
    "visitPresenceSection": MessageLookupByLibrary.simpleMessage(
      "On-site presence",
    ),
    "visitPresenceVisitor": MessageLookupByLibrary.simpleMessage("The visitor"),
    "visitPresenceYou": MessageLookupByLibrary.simpleMessage("You"),
    "visitProposeBounds": MessageLookupByLibrary.simpleMessage(
      "At least an hour ahead, at most 60 days.",
    ),
    "visitProposeChange": MessageLookupByLibrary.simpleMessage("Change"),
    "visitProposeHelp": MessageLookupByLibrary.simpleMessage(
      "The owner shows the place themselves: propose a time, they accept or decline it.",
    ),
    "visitProposePick": MessageLookupByLibrary.simpleMessage(
      "Choose a date and time",
    ),
    "visitProposeSend": MessageLookupByLibrary.simpleMessage(
      "Send the request",
    ),
    "visitProposeTitle": MessageLookupByLibrary.simpleMessage(
      "Propose a date and time",
    ),
    "visitRateBody": MessageLookupByLibrary.simpleMessage(
      "Optional. This rates the visitor\'s service, not the property.",
    ),
    "visitRateDone": MessageLookupByLibrary.simpleMessage(
      "Thanks for your rating.",
    ),
    "visitRateTitle": MessageLookupByLibrary.simpleMessage("Rate the visitor"),
    "visitRequestedBody": MessageLookupByLibrary.simpleMessage(
      "The owner still has to confirm the proposed time. You will get a notification.",
    ),
    "visitRequestedTitle": MessageLookupByLibrary.simpleMessage("Request sent"),
    "visitSearchAgain": MessageLookupByLibrary.simpleMessage(
      "Look for another place",
    ),
    "visitSeeListing": MessageLookupByLibrary.simpleMessage("See the property"),
    "visitSeeNextWeek": MessageLookupByLibrary.simpleMessage("See next week"),
    "visitStatusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "visitStatusCompleted": MessageLookupByLibrary.simpleMessage("Done"),
    "visitStatusNotFulfilled": MessageLookupByLibrary.simpleMessage(
      "Not fulfilled",
    ),
    "visitStatusRequested": MessageLookupByLibrary.simpleMessage(
      "Awaiting confirmation",
    ),
    "visitStatusScheduled": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "visitTimeRejected": MessageLookupByLibrary.simpleMessage(
      "That time cannot be proposed: at least an hour ahead, at most 60 days.",
    ),
    "visitVisitorAgent": MessageLookupByLibrary.simpleMessage("Mboa agent"),
    "visitVisitorOwner": MessageLookupByLibrary.simpleMessage("The owner"),
    "visitVisitorRecord": m58,
    "visitWaitingVisitor": MessageLookupByLibrary.simpleMessage(
      "You are confirmed on site. Waiting for the visitor.",
    ),
    "visitWeekNext": MessageLookupByLibrary.simpleMessage("Next week"),
    "visitWeekPrev": MessageLookupByLibrary.simpleMessage("Previous week"),
    "visitWeekRange": m59,
    "visitWithdraw": MessageLookupByLibrary.simpleMessage(
      "Withdraw my request",
    ),
    "visitsActionFailed": MessageLookupByLibrary.simpleMessage(
      "That action isn\'t possible right now.",
    ),
    "visitsAddress": MessageLookupByLibrary.simpleMessage("Exact address"),
    "visitsAddressNote": MessageLookupByLibrary.simpleMessage(
      "Visible only to you, for this visit.",
    ),
    "visitsAgendaEmptyDay": MessageLookupByLibrary.simpleMessage(
      "No visit that day.",
    ),
    "visitsAgendaNextWeek": MessageLookupByLibrary.simpleMessage("Next week"),
    "visitsAgendaPreviousWeek": MessageLookupByLibrary.simpleMessage(
      "Previous week",
    ),
    "visitsAgendaToday": MessageLookupByLibrary.simpleMessage("Today"),
    "visitsAwaitingClientBody": MessageLookupByLibrary.simpleMessage(
      "Waiting for the tenant to confirm. The visit is validated as soon as they do.",
    ),
    "visitsAwaitingClientTitle": MessageLookupByLibrary.simpleMessage(
      "Presence confirmed",
    ),
    "visitsCall": MessageLookupByLibrary.simpleMessage("Call"),
    "visitsCancel": MessageLookupByLibrary.simpleMessage("Cancel the visit"),
    "visitsCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "Possible up to 1 hour before the slot. The tenant will be notified.",
    ),
    "visitsCancelledAgentRemoved": MessageLookupByLibrary.simpleMessage(
      "Agent removed from the property",
    ),
    "visitsCancelledAgentUnavailable": MessageLookupByLibrary.simpleMessage(
      "Agent no longer available",
    ),
    "visitsCancelledByClient": MessageLookupByLibrary.simpleMessage(
      "Cancelled by the tenant",
    ),
    "visitsCancelledByVisitor": MessageLookupByLibrary.simpleMessage(
      "Cancelled by the visitor",
    ),
    "visitsCancelledListingUnavailable": MessageLookupByLibrary.simpleMessage(
      "Listing taken off the market",
    ),
    "visitsCompletedBody": MessageLookupByLibrary.simpleMessage(
      "Both presences were confirmed. The tenant can now publish their review of the property.",
    ),
    "visitsCompletedTitle": MessageLookupByLibrary.simpleMessage(
      "Visit completed",
    ),
    "visitsConfirmNotYet": MessageLookupByLibrary.simpleMessage(
      "Available on the day of the visit",
    ),
    "visitsConfirmPresence": MessageLookupByLibrary.simpleMessage(
      "Confirm I\'m here",
    ),
    "visitsConfirmPresenceHint": MessageLookupByLibrary.simpleMessage(
      "The tenant must confirm on their side for the visit to be validated.",
    ),
    "visitsContactsTitle": MessageLookupByLibrary.simpleMessage("Contacts"),
    "visitsDetailTitle": MessageLookupByLibrary.simpleMessage("Visit details"),
    "visitsEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Book a visit from any property page.",
    ),
    "visitsEmptyPast": MessageLookupByLibrary.simpleMessage("No past visit"),
    "visitsEmptyTitle": MessageLookupByLibrary.simpleMessage("No visits"),
    "visitsEmptyToday": MessageLookupByLibrary.simpleMessage("No visit today"),
    "visitsEmptyUpcoming": MessageLookupByLibrary.simpleMessage(
      "No visit scheduled",
    ),
    "visitsFilterPast": MessageLookupByLibrary.simpleMessage("Past"),
    "visitsFilterUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "visitsLocating": MessageLookupByLibrary.simpleMessage("Locating…"),
    "visitsLocationDenied": MessageLookupByLibrary.simpleMessage(
      "Allow location access to confirm your presence.",
    ),
    "visitsLocationDeniedForever": MessageLookupByLibrary.simpleMessage(
      "Location is blocked. Enable it in your phone settings.",
    ),
    "visitsLocationDisabled": MessageLookupByLibrary.simpleMessage(
      "Turn on your phone\'s location.",
    ),
    "visitsLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Could not get a position. Try again in a moment.",
    ),
    "visitsMineTitle": MessageLookupByLibrary.simpleMessage("My visits"),
    "visitsNotFulfilledBody": MessageLookupByLibrary.simpleMessage(
      "No presence was confirmed during the slot. This visit can no longer be started.",
    ),
    "visitsNotFulfilledTitle": MessageLookupByLibrary.simpleMessage(
      "Visit not fulfilled",
    ),
    "visitsOffline": MessageLookupByLibrary.simpleMessage(
      "Offline visits — what is coming, as last saved.",
    ),
    "visitsOwner": MessageLookupByLibrary.simpleMessage("Owner"),
    "visitsPast": MessageLookupByLibrary.simpleMessage("Past"),
    "visitsPhoneCopied": MessageLookupByLibrary.simpleMessage("Number copied"),
    "visitsPresenceClient": MessageLookupByLibrary.simpleMessage("Tenant"),
    "visitsPresenceConfirmedAt": m60,
    "visitsPresenceExplain": MessageLookupByLibrary.simpleMessage(
      "The visit is only validated once both presences are confirmed.",
    ),
    "visitsPresencePending": MessageLookupByLibrary.simpleMessage("Pending"),
    "visitsPresenceTitle": MessageLookupByLibrary.simpleMessage(
      "Presence confirmation",
    ),
    "visitsPresenceYou": MessageLookupByLibrary.simpleMessage("You"),
    "visitsRequestConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm the time",
    ),
    "visitsRequestDecline": MessageLookupByLibrary.simpleMessage("Turn down"),
    "visitsRequestsBody": MessageLookupByLibrary.simpleMessage(
      "A tenant proposed a time. Confirm it or turn it down — they can propose another.",
    ),
    "visitsRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Times to confirm",
    ),
    "visitsReviewCta": MessageLookupByLibrary.simpleMessage("Visit review"),
    "visitsReviewOpen": MessageLookupByLibrary.simpleMessage(
      "See the tenant\'s review",
    ),
    "visitsStatusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "visitsStatusCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "visitsStatusNotFulfilled": MessageLookupByLibrary.simpleMessage(
      "Not fulfilled",
    ),
    "visitsStatusRequested": MessageLookupByLibrary.simpleMessage("Requested"),
    "visitsStatusScheduled": MessageLookupByLibrary.simpleMessage("Scheduled"),
    "visitsTabPast": MessageLookupByLibrary.simpleMessage("Past"),
    "visitsTabToday": MessageLookupByLibrary.simpleMessage("Today"),
    "visitsTabUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "visitsTenant": MessageLookupByLibrary.simpleMessage("Tenant"),
    "visitsTitle": MessageLookupByLibrary.simpleMessage("My visits"),
    "visitsTooFarBody": m61,
    "visitsTooFarConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm anyway",
    ),
    "visitsTooFarHint": MessageLookupByLibrary.simpleMessage(
      "e.g. GPS is off, I am at the gate",
    ),
    "visitsTooFarTitle": MessageLookupByLibrary.simpleMessage(
      "You seem far from the property",
    ),
    "visitsUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "welcomeBody": MessageLookupByLibrary.simpleMessage(
      "Find, book and manage your home with confidence.",
    ),
    "welcomeHeadline": MessageLookupByLibrary.simpleMessage("Welcome home."),
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Registration",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Login"),
  };
}
