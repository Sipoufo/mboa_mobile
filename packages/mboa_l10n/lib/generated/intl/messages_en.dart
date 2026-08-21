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

  static String m14(city) => "Detected city: ${city}";

  static String m15(min) => "Add images (${min} photos minimum)";

  static String m16(price, period) => "${price} XAF / ${period}";

  static String m17(price) => "${price} XAF / month";

  static String m18(count) =>
      "${Intl.plural(count, one: '1 room', other: '${count} rooms')}";

  static String m19(value) => "${value} m²";

  static String m20(count) => "${count} published";

  static String m21(count) =>
      "${Intl.plural(count, one: '1 unit', other: '${count} units')}";

  static String m22(phone) => "Code sent to ${phone}";

  static String m23(word) => "Type “${word}” to confirm";

  static String m24(tier) => "Included in ${tier}";

  static String m25(reason) => "Reason: ${reason}";

  static String m26(count) => "${count} unit(s)";

  static String m27(phone) => "Code sent to ${phone}";

  static String m28(seconds) => "Resend in ${seconds}s";

  static String m29(tier) => "Your ${tier} plan is active.";

  static String m30(ref) => "Reference: ${ref}";

  static String m31(price) => "${price} FCFA / month";

  static String m32(count) =>
      "${Intl.plural(count, one: '1 residence unit', other: '${count} residence units')}";

  static String m33(tier) =>
      "Limit reached. Upgrade to ${tier} to publish more listings.";

  static String m34(min) => "Add at least ${min} photos to publish.";

  static String m35(query) => "No unit matches “${query}”.";

  static String m36(count) =>
      "${Intl.plural(count, zero: 'No active listing', one: '1 active listing', other: '${count} active listings')}";

  static String m37(date) => "Valid until ${date}";

  static String m38(time) => "Confirmed at ${time}";

  static String m39(distance) =>
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
    "annonceFormAddress": MessageLookupByLibrary.simpleMessage("Exact address"),
    "annonceFormCityDetected": m14,
    "annonceFormCityNotDetected": MessageLookupByLibrary.simpleMessage(
      "City not detected. Pick it manually.",
    ),
    "annonceFormCurrency": MessageLookupByLibrary.simpleMessage("XAF"),
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
      "The rent as you collect it, and how often: daily, weekly, monthly, quarterly or yearly. The platform derives a monthly equivalent used only to compare listings with each other — never billed, never carried into the Mboa Contract.",
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
    "annonceFormPhotosHint": m15,
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
    "annoncePeriodMonth": MessageLookupByLibrary.simpleMessage("month"),
    "annoncePeriodQuarter": MessageLookupByLibrary.simpleMessage("quarter"),
    "annoncePeriodWeek": MessageLookupByLibrary.simpleMessage("week"),
    "annoncePeriodYear": MessageLookupByLibrary.simpleMessage("year"),
    "annoncePricePerPeriod": m16,
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
    "annoncesPerMonth": m17,
    "annoncesRooms": m18,
    "annoncesSingleTitle": MessageLookupByLibrary.simpleMessage(
      "Single properties",
    ),
    "annoncesSurface": m19,
    "annoncesTabArchived": MessageLookupByLibrary.simpleMessage("Archived"),
    "annoncesTabAvailable": MessageLookupByLibrary.simpleMessage("Available"),
    "annoncesTabOccupied": MessageLookupByLibrary.simpleMessage("Occupied"),
    "annoncesUnitsPublished": m20,
    "annoncesUnitsSummary": m21,
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
    "changePhoneNewCodeLabel": m22,
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
      "Something went wrong. Please try again.",
    ),
    "commonErrorTitle": MessageLookupByLibrary.simpleMessage("Oops"),
    "commonNo": MessageLookupByLibrary.simpleMessage("No"),
    "commonOr": MessageLookupByLibrary.simpleMessage("Or"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "commonYes": MessageLookupByLibrary.simpleMessage("Yes"),
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
    "deleteAccountConfirmLabel": m23,
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
    "homeStatsLockedHint": m24,
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
    "kycRejectionReason": m25,
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
      "Upload failed. Please try again.",
    ),
    "kycVerso": MessageLookupByLibrary.simpleMessage("Back"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "loadingDialog_content": MessageLookupByLibrary.simpleMessage(
      "Please wait...",
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
      "Couldn’t send the code. Please try again.",
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
    "menuGreeting": MessageLookupByLibrary.simpleMessage("Hello !!"),
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
    "missionsUnits": m26,
    "missionsWithdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "navFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navManager": MessageLookupByLibrary.simpleMessage("Manager"),
    "navMenu": MessageLookupByLibrary.simpleMessage("Menu"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("6-digit code"),
    "otpCodeSentTo": m27,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Invalid code. Please try again.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive the code?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Resend code"),
    "otpResendIn": m28,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Verification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Confirm"),
    "paymentAwaitingBody": MessageLookupByLibrary.simpleMessage(
      "Approve the payment request on your phone (USSD or the Mobile Money app). This screen updates on its own.",
    ),
    "paymentAwaitingTitle": MessageLookupByLibrary.simpleMessage(
      "Finish on your phone",
    ),
    "paymentConfirmedBody": m29,
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
    "paymentReference": m30,
    "paymentRetry": MessageLookupByLibrary.simpleMessage("Retry payment"),
    "plansChoose": MessageLookupByLibrary.simpleMessage("Choose"),
    "plansCurrent": MessageLookupByLibrary.simpleMessage("Current plan"),
    "plansDowngradeNote": MessageLookupByLibrary.simpleMessage(
      "Moving to a lower plan takes effect next cycle.",
    ),
    "plansPriceFree": MessageLookupByLibrary.simpleMessage("Free"),
    "plansPriceMonthly": m31,
    "plansResidenceAllowance": m32,
    "plansTitle": MessageLookupByLibrary.simpleMessage("Plans"),
    "profileDisplayName": MessageLookupByLibrary.simpleMessage("Display name"),
    "profileFirstName": MessageLookupByLibrary.simpleMessage("First name"),
    "profileLastName": MessageLookupByLibrary.simpleMessage("Last name"),
    "profileLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn’t load your profile.",
    ),
    "profileLocation": MessageLookupByLibrary.simpleMessage("Location"),
    "profileMainCity": MessageLookupByLibrary.simpleMessage("Main city"),
    "profilePhotoUpdated": MessageLookupByLibrary.simpleMessage(
      "Photo updated",
    ),
    "profileSave": MessageLookupByLibrary.simpleMessage("Save"),
    "profileSaved": MessageLookupByLibrary.simpleMessage("Profile updated"),
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
    "publishBlockedLimitBody": m33,
    "publishBlockedLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Limit reached",
    ),
    "publishBlockedPhotosBody": m34,
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
    "residenceUnitStatus": MessageLookupByLibrary.simpleMessage("Status"),
    "residenceUnitsPending": MessageLookupByLibrary.simpleMessage(
      "Editing a unit is coming soon.",
    ),
    "residenceUnitsSearchEmpty": m35,
    "residenceUnitsSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search for a unit",
    ),
    "residenceUnitsTitle": MessageLookupByLibrary.simpleMessage("Units"),
    "residencesTitle": MessageLookupByLibrary.simpleMessage("Residences"),
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
    "subscriptionListingLimit": m36,
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
    "subscriptionRenewsOn": m37,
    "subscriptionTitle": MessageLookupByLibrary.simpleMessage(
      "My subscription",
    ),
    "subscriptionUnknown": MessageLookupByLibrary.simpleMessage(
      "Couldn’t verify your subscription. Free plan applied in the meantime.",
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
    "visitsEmptyPast": MessageLookupByLibrary.simpleMessage("No past visit"),
    "visitsEmptyToday": MessageLookupByLibrary.simpleMessage("No visit today"),
    "visitsEmptyUpcoming": MessageLookupByLibrary.simpleMessage(
      "No visit scheduled",
    ),
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
    "visitsOwner": MessageLookupByLibrary.simpleMessage("Owner"),
    "visitsPhoneCopied": MessageLookupByLibrary.simpleMessage("Number copied"),
    "visitsPresenceClient": MessageLookupByLibrary.simpleMessage("Tenant"),
    "visitsPresenceConfirmedAt": m38,
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
    "visitsTooFarBody": m39,
    "visitsTooFarConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm anyway",
    ),
    "visitsTooFarHint": MessageLookupByLibrary.simpleMessage(
      "e.g. GPS is off, I am at the gate",
    ),
    "visitsTooFarTitle": MessageLookupByLibrary.simpleMessage(
      "You seem far from the property",
    ),
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Registration",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Login"),
  };
}
