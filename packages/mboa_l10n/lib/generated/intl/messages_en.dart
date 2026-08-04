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

  static String m2(phone) => "Code sent to ${phone}";

  static String m3(word) => "Type “${word}” to confirm";

  static String m4(reason) => "Reason: ${reason}";

  static String m5(phone) => "Code sent to ${phone}";

  static String m6(seconds) => "Resend in ${seconds}s";

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
    "changePhoneNewCodeLabel": m2,
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
    "deleteAccountConfirmLabel": m3,
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
    "exitAppBody": MessageLookupByLibrary.simpleMessage(
      "Press back again to exit.",
    ),
    "exitAppTitle": MessageLookupByLibrary.simpleMessage("Leave the app?"),
    "homeProWelcome": MessageLookupByLibrary.simpleMessage(
      "Welcome to Mboa Pro 👋",
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
    "kycRejectionReason": m4,
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
    "navFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navManager": MessageLookupByLibrary.simpleMessage("Manager"),
    "navMenu": MessageLookupByLibrary.simpleMessage("Menu"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("6-digit code"),
    "otpCodeSentTo": m5,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Invalid code. Please try again.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive the code?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Resend code"),
    "otpResendIn": m6,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Verification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Confirm"),
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
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Registration",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Login"),
  };
}
