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

  static String m2(city) => "Detected city: ${city}";

  static String m3(min) => "Add images (${min} photos minimum)";

  static String m4(price) => "${price} XAF / month";

  static String m5(count) =>
      "${Intl.plural(count, one: '1 room', other: '${count} rooms')}";

  static String m6(value) => "${value} m²";

  static String m7(count) => "${count} published";

  static String m8(count) =>
      "${Intl.plural(count, one: '1 unit', other: '${count} units')}";

  static String m9(phone) => "Code sent to ${phone}";

  static String m10(word) => "Type “${word}” to confirm";

  static String m11(tier) => "Included in ${tier}";

  static String m12(reason) => "Reason: ${reason}";

  static String m13(phone) => "Code sent to ${phone}";

  static String m14(seconds) => "Resend in ${seconds}s";

  static String m15(tier) => "Your ${tier} plan is active.";

  static String m16(ref) => "Reference: ${ref}";

  static String m17(price) => "${price} FCFA / month";

  static String m18(count) =>
      "${Intl.plural(count, one: '1 residence unit', other: '${count} residence units')}";

  static String m19(tier) =>
      "Limit reached. Upgrade to ${tier} to publish more listings.";

  static String m20(min) => "Add at least ${min} photos to publish.";

  static String m21(count) =>
      "${Intl.plural(count, zero: 'No active listing', one: '1 active listing', other: '${count} active listings')}";

  static String m22(date) => "Valid until ${date}";

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
    "annonceDeleteConfirmBody": MessageLookupByLibrary.simpleMessage(
      "This is permanent. The property will be removed from your portfolio.",
    ),
    "annonceDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Delete this property?",
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
    "annonceFormAddress": MessageLookupByLibrary.simpleMessage("Exact address"),
    "annonceFormCityDetected": m2,
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
    "annonceFormFieldPrice": MessageLookupByLibrary.simpleMessage("Price"),
    "annonceFormFieldRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
    "annonceFormFieldSurface": MessageLookupByLibrary.simpleMessage(
      "Dimensions",
    ),
    "annonceFormFieldTitle": MessageLookupByLibrary.simpleMessage("Title"),
    "annonceFormFieldType": MessageLookupByLibrary.simpleMessage("Type"),
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
    "annonceFormPhotosHint": m3,
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
    "annoncesPerMonth": m4,
    "annoncesRooms": m5,
    "annoncesSingleTitle": MessageLookupByLibrary.simpleMessage(
      "Single properties",
    ),
    "annoncesSurface": m6,
    "annoncesTabArchived": MessageLookupByLibrary.simpleMessage("Archived"),
    "annoncesTabAvailable": MessageLookupByLibrary.simpleMessage("Available"),
    "annoncesTabOccupied": MessageLookupByLibrary.simpleMessage("Occupied"),
    "annoncesUnitsPublished": m7,
    "annoncesUnitsSummary": m8,
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
    "changePhoneNewCodeLabel": m9,
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
    "commonComingSoon": MessageLookupByLibrary.simpleMessage("Coming soon"),
    "commonError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "commonErrorTitle": MessageLookupByLibrary.simpleMessage("Oops"),
    "commonOr": MessageLookupByLibrary.simpleMessage("Or"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "deleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Delete permanently",
    ),
    "deleteAccountConfirmLabel": m10,
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
    "homeStatsLockedHint": m11,
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
    "kycRejectionReason": m12,
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
    "navFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navManager": MessageLookupByLibrary.simpleMessage("Manager"),
    "navMenu": MessageLookupByLibrary.simpleMessage("Menu"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("6-digit code"),
    "otpCodeSentTo": m13,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Invalid code. Please try again.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive the code?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Resend code"),
    "otpResendIn": m14,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Verification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Confirm"),
    "paymentAwaitingBody": MessageLookupByLibrary.simpleMessage(
      "Approve the payment request on your phone (USSD or the Mobile Money app). This screen updates on its own.",
    ),
    "paymentAwaitingTitle": MessageLookupByLibrary.simpleMessage(
      "Finish on your phone",
    ),
    "paymentConfirmedBody": m15,
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
    "paymentReference": m16,
    "paymentRetry": MessageLookupByLibrary.simpleMessage("Retry payment"),
    "plansChoose": MessageLookupByLibrary.simpleMessage("Choose"),
    "plansCurrent": MessageLookupByLibrary.simpleMessage("Current plan"),
    "plansDowngradeNote": MessageLookupByLibrary.simpleMessage(
      "Moving to a lower plan takes effect next cycle.",
    ),
    "plansPriceFree": MessageLookupByLibrary.simpleMessage("Free"),
    "plansPriceMonthly": m17,
    "plansResidenceAllowance": m18,
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
    "publishBlockedLimitBody": m19,
    "publishBlockedLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Limit reached",
    ),
    "publishBlockedPhotosBody": m20,
    "publishBlockedPhotosTitle": MessageLookupByLibrary.simpleMessage(
      "Missing photos",
    ),
    "publishBlockedProfileBody": MessageLookupByLibrary.simpleMessage(
      "Complete your profile (photo, type, city) before publishing.",
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
    "residenceDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Residence details",
    ),
    "residenceUnitStatus": MessageLookupByLibrary.simpleMessage("Status"),
    "residenceUnitsPending": MessageLookupByLibrary.simpleMessage(
      "Editing a unit is coming soon.",
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
    "subscriptionListingLimit": m21,
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
    "subscriptionRenewsOn": m22,
    "subscriptionTitle": MessageLookupByLibrary.simpleMessage(
      "My subscription",
    ),
    "subscriptionUnknown": MessageLookupByLibrary.simpleMessage(
      "Couldn’t verify your subscription. Free plan applied in the meantime.",
    ),
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Registration",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Login"),
  };
}
