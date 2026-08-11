// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(tier) =>
      "Cette donnée est incluse dans l’abonnement ${tier}.";

  static String m1(tier) => "Passer à ${tier}";

  static String m2(count) => "${count} créneau(x) par semaine";

  static String m3(date) => "Membre depuis ${date}";

  static String m4(count) => "${count} avis";

  static String m5(count) => "${count} avis";

  static String m6(minutes) => "${minutes} min";

  static String m7(count) => "${count} zone(s)";

  static String m8(name) => "Assigner ${name} ?";

  static String m9(name) => "Une proposition a été envoyée à ${name}";

  static String m10(count) =>
      "${count} unité(s) avaient déjà un agent et ont été ignorées.";

  static String m11(count) => "${count} biens";

  static String m12(count) => "${count} unité(s)";

  static String m13(count) => "${count} visites réalisées";

  static String m14(city) => "Ville détectée : ${city}";

  static String m15(min) => "Ajouter des images (${min} photos minimum)";

  static String m16(price, period) => "${price} XAF / ${period}";

  static String m17(price) => "${price} XAF / Mois";

  static String m18(count) =>
      "${Intl.plural(count, one: '1 Pièce', other: '${count} Pièces')}";

  static String m19(value) => "${value} m²";

  static String m20(count) => "${count} publiées";

  static String m21(count) =>
      "${Intl.plural(count, one: '1 unité', other: '${count} unités')}";

  static String m22(phone) => "Code reçu sur ${phone}";

  static String m23(word) => "Tapez « ${word} » pour confirmer";

  static String m24(tier) => "Inclus dans ${tier}";

  static String m25(reason) => "Motif : ${reason}";

  static String m26(count) => "${count} unité(s)";

  static String m27(phone) => "Code envoyé au ${phone}";

  static String m28(seconds) => "Renvoyer dans ${seconds}s";

  static String m29(tier) => "Votre formule ${tier} est active.";

  static String m30(ref) => "Référence : ${ref}";

  static String m31(price) => "${price} FCFA / mois";

  static String m32(count) =>
      "${Intl.plural(count, one: '1 unité de résidence', other: '${count} unités de résidence')}";

  static String m33(tier) =>
      "Limite atteinte. Passe à ${tier} pour publier plus d’annonces.";

  static String m34(min) => "Ajoute au moins ${min} photos pour publier.";

  static String m35(query) => "Aucune unité ne correspond à « ${query} ».";

  static String m36(count) =>
      "${Intl.plural(count, zero: 'Aucune annonce active', one: '1 annonce active', other: '${count} annonces actives')}";

  static String m37(date) => "Valable jusqu’au ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessComingSoonBody": MessageLookupByLibrary.simpleMessage(
      "Cette fonctionnalité arrive prochainement. Nous vous préviendrons dès qu’elle sera prête.",
    ),
    "accessComingSoonTitle": MessageLookupByLibrary.simpleMessage(
      "Bientôt disponible",
    ),
    "accessKycPendingBody": MessageLookupByLibrary.simpleMessage(
      "Vos documents sont en cours d’examen. Cette fonctionnalité s’activera dès validation.",
    ),
    "accessKycPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification en cours",
    ),
    "accessKycRequiredBody": MessageLookupByLibrary.simpleMessage(
      "Complétez vos certifications pour accéder à cette fonctionnalité.",
    ),
    "accessKycRequiredCta": MessageLookupByLibrary.simpleMessage(
      "Compléter mes certifications",
    ),
    "accessKycRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification requise",
    ),
    "accessRestrictedTitle": MessageLookupByLibrary.simpleMessage(
      "Accès restreint",
    ),
    "accessRoleRequiredBody": MessageLookupByLibrary.simpleMessage(
      "Cette fonctionnalité est réservée aux comptes prestataires.",
    ),
    "accessRoleRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Non disponible pour ce compte",
    ),
    "accessTierRequiredBody": m0,
    "accessTierRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Réservé aux abonnés",
    ),
    "accessUpgradeCta": m1,
    "agentAcceptingOff": MessageLookupByLibrary.simpleMessage(
      "Vous ne recevrez plus de nouvelles assignations. Les visites déjà planifiées restent à faire.",
    ),
    "agentAcceptingOn": MessageLookupByLibrary.simpleMessage(
      "Vous pouvez recevoir de nouvelles assignations.",
    ),
    "agentAcceptingTitle": MessageLookupByLibrary.simpleMessage(
      "Je reçois des missions",
    ),
    "agentAddSlot": MessageLookupByLibrary.simpleMessage("Ajouter un créneau"),
    "agentAvailabilityHelp": MessageLookupByLibrary.simpleMessage(
      "Définissez vos horaires habituels. Les créneaux réservables en sont déduits, moins vos jours bloqués et vos visites déjà prévues.",
    ),
    "agentAvailabilitySubtitle": m2,
    "agentAvailabilityTitle": MessageLookupByLibrary.simpleMessage(
      "Mes disponibilités",
    ),
    "agentBlockDay": MessageLookupByLibrary.simpleMessage("Bloquer un jour"),
    "agentDaysOffHelp": MessageLookupByLibrary.simpleMessage(
      "Un jour bloqué annule les visites déjà planifiées ce jour-là.",
    ),
    "agentDaysOffNone": MessageLookupByLibrary.simpleMessage(
      "Aucun jour bloqué",
    ),
    "agentDaysOffTitle": MessageLookupByLibrary.simpleMessage("Jours bloqués"),
    "agentDetailMemberSince": m3,
    "agentDetailNoProperties": MessageLookupByLibrary.simpleMessage(
      "Aucun bien confié pour le moment",
    ),
    "agentDetailPending": MessageLookupByLibrary.simpleMessage(
      "En attente de réponse",
    ),
    "agentDetailProperties": MessageLookupByLibrary.simpleMessage(
      "Biens confiés",
    ),
    "agentDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Profil de l\'agent",
    ),
    "agentDetailUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profil indisponible",
    ),
    "agentDetailWholeCity": MessageLookupByLibrary.simpleMessage(
      "Toute la ville",
    ),
    "agentDetailZones": MessageLookupByLibrary.simpleMessage(
      "Zones d\'intervention",
    ),
    "agentIncompleteBody": MessageLookupByLibrary.simpleMessage(
      "Ajoutez votre nom, une photo et au moins une zone pour recevoir des missions.",
    ),
    "agentIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Profil incomplet",
    ),
    "agentNavMissions": MessageLookupByLibrary.simpleMessage("Mes missions"),
    "agentNavProfile": MessageLookupByLibrary.simpleMessage("Mon profil"),
    "agentNavVisits": MessageLookupByLibrary.simpleMessage("Mes visites"),
    "agentNoSlots": MessageLookupByLibrary.simpleMessage(
      "Aucun créneau défini",
    ),
    "agentProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Mon profil agent",
    ),
    "agentRatingCount": m4,
    "agentRatingNone": MessageLookupByLibrary.simpleMessage("Pas encore noté"),
    "agentSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Enregistrement impossible. Réessayez.",
    ),
    "agentSaved": MessageLookupByLibrary.simpleMessage(
      "Modifications enregistrées",
    ),
    "agentSlotOverlap": MessageLookupByLibrary.simpleMessage(
      "Ce créneau en chevauche un autre.",
    ),
    "agentStatsNoRating": MessageLookupByLibrary.simpleMessage(
      "Pas encore noté",
    ),
    "agentStatsRating": MessageLookupByLibrary.simpleMessage("Note moyenne"),
    "agentStatsRatingCount": m5,
    "agentStatsVisits": MessageLookupByLibrary.simpleMessage(
      "Visites réalisées",
    ),
    "agentStatusActive": MessageLookupByLibrary.simpleMessage("Actif"),
    "agentStatusDeleted": MessageLookupByLibrary.simpleMessage(
      "Compte clôturé",
    ),
    "agentStatusPending": MessageLookupByLibrary.simpleMessage(
      "En attente de validation",
    ),
    "agentStatusSuspended": MessageLookupByLibrary.simpleMessage("Suspendu"),
    "agentStatusUnknown": MessageLookupByLibrary.simpleMessage(
      "Statut inconnu",
    ),
    "agentVisitDuration": MessageLookupByLibrary.simpleMessage(
      "Durée d\'une visite",
    ),
    "agentVisitDurationValue": m6,
    "agentZonesEmptyError": MessageLookupByLibrary.simpleMessage(
      "Choisissez au moins une ville ou un quartier.",
    ),
    "agentZonesHelp": MessageLookupByLibrary.simpleMessage(
      "Choisissez une ville entière ou seulement certains quartiers. Seuls les biens situés dans vos zones vous seront proposés.",
    ),
    "agentZonesNone": MessageLookupByLibrary.simpleMessage("Aucune zone"),
    "agentZonesSubtitle": m7,
    "agentZonesTitle": MessageLookupByLibrary.simpleMessage(
      "Mes zones d\'intervention",
    ),
    "agentZonesWholeCity": MessageLookupByLibrary.simpleMessage(
      "Toute la ville",
    ),
    "agentsAcceptWarning": MessageLookupByLibrary.simpleMessage(
      "Accepter cette candidature refusera automatiquement les autres.",
    ),
    "agentsActionFailed": MessageLookupByLibrary.simpleMessage(
      "Action impossible pour le moment.",
    ),
    "agentsApplicationAccept": MessageLookupByLibrary.simpleMessage("Accepter"),
    "agentsApplicationDecline": MessageLookupByLibrary.simpleMessage("Refuser"),
    "agentsApplicationsTitle": MessageLookupByLibrary.simpleMessage(
      "Candidatures",
    ),
    "agentsAssignAction": MessageLookupByLibrary.simpleMessage("Assigner"),
    "agentsAssignConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Il ou elle recevra une proposition et pourra l\'accepter ou la refuser.",
    ),
    "agentsAssignConfirmTitle": m8,
    "agentsAssignEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucun agent disponible dans cette zone.",
    ),
    "agentsAssignTitle": MessageLookupByLibrary.simpleMessage("Liste"),
    "agentsAwaitingResponse": MessageLookupByLibrary.simpleMessage(
      "En attente de réponse",
    ),
    "agentsCurrentTitle": MessageLookupByLibrary.simpleMessage("Agent assigné"),
    "agentsMineEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucun agent assigné",
    ),
    "agentsMineEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Assignez un agent à un bien pour que les locataires puissent planifier une visite.",
    ),
    "agentsMineTitle": MessageLookupByLibrary.simpleMessage("Mes agents"),
    "agentsOfferSent": m9,
    "agentsOfferSentBody": MessageLookupByLibrary.simpleMessage(
      "Vous serez notifié de sa réponse.",
    ),
    "agentsOfferSentTitle": MessageLookupByLibrary.simpleMessage(
      "Assignation d\'agent",
    ),
    "agentsOfferSkipped": m10,
    "agentsPickPropertyBody": MessageLookupByLibrary.simpleMessage(
      "Un agent est assigné à un bien précis.",
    ),
    "agentsPickPropertyEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucun bien disponible pour une assignation.",
    ),
    "agentsPickPropertyNone": MessageLookupByLibrary.simpleMessage(
      "Aucun bien publié",
    ),
    "agentsPickPropertyNoneBody": MessageLookupByLibrary.simpleMessage(
      "Un agent ne peut être assigné qu\'à un bien publié. Publiez une annonce ou une unité de résidence pour continuer.",
    ),
    "agentsPickPropertyTitle": MessageLookupByLibrary.simpleMessage(
      "Choisir un bien",
    ),
    "agentsPropertyCount": m11,
    "agentsUnitsCovered": m12,
    "agentsVisitCount": m13,
    "agentsWithdraw": MessageLookupByLibrary.simpleMessage(
      "Retirer l\'assignation",
    ),
    "agentsWithdrawConfirm": MessageLookupByLibrary.simpleMessage(
      "Les visites déjà planifiées seront annulées.",
    ),
    "amenityAirConditioning": MessageLookupByLibrary.simpleMessage(
      "Climatisation",
    ),
    "amenityGenerator": MessageLookupByLibrary.simpleMessage(
      "Groupe électrogène",
    ),
    "amenityHotWater": MessageLookupByLibrary.simpleMessage("Eau chaude"),
    "amenityParking": MessageLookupByLibrary.simpleMessage("Parking"),
    "amenitySecurityGuard": MessageLookupByLibrary.simpleMessage("Gardien"),
    "amenityWifi": MessageLookupByLibrary.simpleMessage("Wi-Fi"),
    "annonceActionArchive": MessageLookupByLibrary.simpleMessage("Archiver"),
    "annonceActionDelete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "annonceActionFailed": MessageLookupByLibrary.simpleMessage(
      "Action impossible pour le moment.",
    ),
    "annonceActionMarkRented": MessageLookupByLibrary.simpleMessage(
      "Marquer loué",
    ),
    "annonceActionPublish": MessageLookupByLibrary.simpleMessage("Publier"),
    "annonceActionReserve": MessageLookupByLibrary.simpleMessage(
      "Marquer réservé",
    ),
    "annonceActionUnarchive": MessageLookupByLibrary.simpleMessage(
      "Désarchiver",
    ),
    "annonceDeleteConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Cette action est définitive. Le bien sera retiré de votre portefeuille.",
    ),
    "annonceDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce bien ?",
    ),
    "annonceDetailAmenities": MessageLookupByLibrary.simpleMessage(
      "Équipements",
    ),
    "annonceDetailHistory": MessageLookupByLibrary.simpleMessage("Historique"),
    "annonceDetailNoInfo": MessageLookupByLibrary.simpleMessage(
      "Aucune information\ndisponible pour le moment",
    ),
    "annonceDetailOccupant": MessageLookupByLibrary.simpleMessage("Occupant"),
    "annonceDetailStats": MessageLookupByLibrary.simpleMessage("Statistiques"),
    "annonceDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Details du bien",
    ),
    "annonceDetailUnitOfResidence": MessageLookupByLibrary.simpleMessage(
      "Unité d’une résidence",
    ),
    "annonceFormAddress": MessageLookupByLibrary.simpleMessage(
      "Adresse exacte",
    ),
    "annonceFormCityDetected": m14,
    "annonceFormCityNotDetected": MessageLookupByLibrary.simpleMessage(
      "Ville non détectée. Choisissez-la manuellement.",
    ),
    "annonceFormCurrency": MessageLookupByLibrary.simpleMessage("XAF"),
    "annonceFormDetectingCity": MessageLookupByLibrary.simpleMessage(
      "Détection de la ville…",
    ),
    "annonceFormErrorIncomplete": MessageLookupByLibrary.simpleMessage(
      "Complétez les champs obligatoires.",
    ),
    "annonceFormErrorPhoto": MessageLookupByLibrary.simpleMessage(
      "Photo non uploadée, réessaie.",
    ),
    "annonceFormErrorSave": MessageLookupByLibrary.simpleMessage(
      "Enregistrement impossible. Réessayez.",
    ),
    "annonceFormFieldAmenities": MessageLookupByLibrary.simpleMessage(
      "Équipements",
    ),
    "annonceFormFieldAvailability": MessageLookupByLibrary.simpleMessage(
      "Disponibilté",
    ),
    "annonceFormFieldBathrooms": MessageLookupByLibrary.simpleMessage(
      "Salles de bain",
    ),
    "annonceFormFieldBathrooms2": MessageLookupByLibrary.simpleMessage(
      "Salles de bain",
    ),
    "annonceFormFieldCharges": MessageLookupByLibrary.simpleMessage(
      "Charges incluses",
    ),
    "annonceFormFieldChargesAmount": MessageLookupByLibrary.simpleMessage(
      "Montant des charges",
    ),
    "annonceFormFieldDescription": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "annonceFormFieldDistrict": MessageLookupByLibrary.simpleMessage(
      "Quartier",
    ),
    "annonceFormFieldFurnished": MessageLookupByLibrary.simpleMessage("Meublé"),
    "annonceFormFieldLocation": MessageLookupByLibrary.simpleMessage(
      "Localisation",
    ),
    "annonceFormFieldName": MessageLookupByLibrary.simpleMessage("Nom"),
    "annonceFormFieldPeriod": MessageLookupByLibrary.simpleMessage(
      "Périodicité",
    ),
    "annonceFormFieldPrice": MessageLookupByLibrary.simpleMessage("Prix"),
    "annonceFormFieldRooms": MessageLookupByLibrary.simpleMessage(
      "Nbre de Pièces",
    ),
    "annonceFormFieldSurface": MessageLookupByLibrary.simpleMessage(
      "Dimensions",
    ),
    "annonceFormFieldTitle": MessageLookupByLibrary.simpleMessage("Titre"),
    "annonceFormFieldType": MessageLookupByLibrary.simpleMessage("Type"),
    "annonceFormHelpAmenities": MessageLookupByLibrary.simpleMessage(
      "Facultatif. Cochez ce que le bien propose — les locataires s\'en servent pour comparer les annonces entre elles.",
    ),
    "annonceFormHelpAvailability": MessageLookupByLibrary.simpleMessage(
      "Obligatoire. Les locataires peuvent filtrer sur la disponibilité immédiate.",
    ),
    "annonceFormHelpCharges": MessageLookupByLibrary.simpleMessage(
      "Facultatif. Indiquez si l\'eau et l\'électricité sont comprises dans le loyer, et leur montant si elles ne le sont pas.",
    ),
    "annonceFormHelpDescription": MessageLookupByLibrary.simpleMessage(
      "Facultatif, 1 500 caractères maximum.",
    ),
    "annonceFormHelpKind": MessageLookupByLibrary.simpleMessage(
      "Un Bien Multiple regroupe plusieurs unités qui partagent une adresse et des caractéristiques : immeuble, cité, hôtel, résidence meublée. Les unités se créent par groupes au moment de la création — aucune unité ne peut être ajoutée par la suite.",
    ),
    "annonceFormHelpLocation": MessageLookupByLibrary.simpleMessage(
      "La ville et le quartier sont visibles par les locataires. L\'adresse exacte ne l\'est jamais : elle n\'apparaît que dans le Contrat Mboa signé.",
    ),
    "annonceFormHelpOptionalFilters": MessageLookupByLibrary.simpleMessage(
      "Facultatif, mais les locataires filtrent leur recherche sur ces critères : un bien sans ces informations ressort moins souvent.",
    ),
    "annonceFormHelpPhotos": MessageLookupByLibrary.simpleMessage(
      "3 photos minimum et 15 maximum. Elles sont compressées automatiquement avant l\'envoi. Modifier les photos d\'une annonce publiée relance la validation du badge « Photos vérifiées ».",
    ),
    "annonceFormHelpPrice": MessageLookupByLibrary.simpleMessage(
      "Le loyer tel que vous le percevez, et sa périodicité : au jour, à la semaine, au mois, au trimestre ou à l\'année. La plateforme en déduit un équivalent mensuel, utilisé uniquement pour comparer les annonces entre elles — jamais facturé, jamais repris dans le Contrat Mboa.",
    ),
    "annonceFormHelpPropertyType": MessageLookupByLibrary.simpleMessage(
      "Appartement, Studio, Villa, Chambre, Bureau ou Local commercial. Les locataires filtrent leur recherche sur ce critère.",
    ),
    "annonceFormKindLabel": MessageLookupByLibrary.simpleMessage(
      "Type d\'annonce",
    ),
    "annonceFormKindMultiple": MessageLookupByLibrary.simpleMessage(
      "Bien multiple",
    ),
    "annonceFormKindSingle": MessageLookupByLibrary.simpleMessage(
      "Bien Unique",
    ),
    "annonceFormLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger ce bien.",
    ),
    "annonceFormLocating": MessageLookupByLibrary.simpleMessage(
      "Localisation en cours…",
    ),
    "annonceFormLocationDenied": MessageLookupByLibrary.simpleMessage(
      "Autorisez la localisation pour enregistrer la position du bien.",
    ),
    "annonceFormLocationHint": MessageLookupByLibrary.simpleMessage(
      "La position enregistrée est celle de votre téléphone. Placez-vous sur le bien, ou corrigez l’adresse.",
    ),
    "annonceFormNoDistricts": MessageLookupByLibrary.simpleMessage(
      "Aucun quartier disponible pour cette ville.",
    ),
    "annonceFormPhotosHint": m15,
    "annonceFormPhotosLabel": MessageLookupByLibrary.simpleMessage("Photos"),
    "annonceFormPickDistrict": MessageLookupByLibrary.simpleMessage(
      "Choisir le quartier",
    ),
    "annonceFormSave": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "annonceFormSavedDraft": MessageLookupByLibrary.simpleMessage(
      "Bien enregistré en brouillon.",
    ),
    "annonceFormTitleEdit": MessageLookupByLibrary.simpleMessage(
      "Modifier le bien",
    ),
    "annonceFormTitleNew": MessageLookupByLibrary.simpleMessage(
      "Ajouter un bien",
    ),
    "annonceFormUnitCount": MessageLookupByLibrary.simpleMessage("Nombre"),
    "annonceFormUnitPrefix": MessageLookupByLibrary.simpleMessage(
      "Préfixe (ex. Chambre)",
    ),
    "annonceFormUnitSquareMetres": MessageLookupByLibrary.simpleMessage("m²"),
    "annonceFormUnitsAdd": MessageLookupByLibrary.simpleMessage(
      "Ajouter un groupe d’unités",
    ),
    "annonceFormUnitsTitle": MessageLookupByLibrary.simpleMessage("Unités"),
    "annoncePeriodDay": MessageLookupByLibrary.simpleMessage("Jour"),
    "annoncePeriodMonth": MessageLookupByLibrary.simpleMessage("Mois"),
    "annoncePeriodQuarter": MessageLookupByLibrary.simpleMessage("Trimestre"),
    "annoncePeriodWeek": MessageLookupByLibrary.simpleMessage("Semaine"),
    "annoncePeriodYear": MessageLookupByLibrary.simpleMessage("An"),
    "annoncePricePerPeriod": m16,
    "annonceStatusArchived": MessageLookupByLibrary.simpleMessage("Archivé"),
    "annonceStatusDraft": MessageLookupByLibrary.simpleMessage("Brouillon"),
    "annonceStatusPublished": MessageLookupByLibrary.simpleMessage(
      "Disponible",
    ),
    "annonceStatusRented": MessageLookupByLibrary.simpleMessage("Loué"),
    "annonceStatusReserved": MessageLookupByLibrary.simpleMessage("Réservé"),
    "annoncesActionEdit": MessageLookupByLibrary.simpleMessage("Modifier"),
    "annoncesActionHistory": MessageLookupByLibrary.simpleMessage("Historique"),
    "annoncesActionMore": MessageLookupByLibrary.simpleMessage(
      "Plus d’actions",
    ),
    "annoncesEmptyArchived": MessageLookupByLibrary.simpleMessage(
      "Aucun bien archivé.",
    ),
    "annoncesEmptyAvailable": MessageLookupByLibrary.simpleMessage(
      "Aucun bien disponible. Appuyez sur + pour en enregistrer un.",
    ),
    "annoncesEmptyOccupied": MessageLookupByLibrary.simpleMessage(
      "Aucun bien occupé.",
    ),
    "annoncesMultipleTitle": MessageLookupByLibrary.simpleMessage(
      "Biens Multiples",
    ),
    "annoncesPerMonth": m17,
    "annoncesRooms": m18,
    "annoncesSingleTitle": MessageLookupByLibrary.simpleMessage("Biens Unique"),
    "annoncesSurface": m19,
    "annoncesTabArchived": MessageLookupByLibrary.simpleMessage("Archivés"),
    "annoncesTabAvailable": MessageLookupByLibrary.simpleMessage("Disponibles"),
    "annoncesTabOccupied": MessageLookupByLibrary.simpleMessage("Occupés"),
    "annoncesUnitsPublished": m20,
    "annoncesUnitsSummary": m21,
    "appName": MessageLookupByLibrary.simpleMessage("Mboa"),
    "appNamePro": MessageLookupByLibrary.simpleMessage("Mboa Pro"),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("nom@exemple.com"),
    "authEmailInvalid": MessageLookupByLibrary.simpleMessage("E-mail invalide"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authLoginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "E-mail ou mot de passe incorrect.",
    ),
    "authLogout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "authOtpResent": MessageLookupByLibrary.simpleMessage(
      "Un nouveau code a été envoyé.",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Votre mot de passe",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "authPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Mot de passe requis",
    ),
    "changePasswordButton": MessageLookupByLibrary.simpleMessage(
      "Mettre à jour",
    ),
    "changePasswordConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirmer le nouveau mot de passe",
    ),
    "changePasswordCurrent": MessageLookupByLibrary.simpleMessage(
      "Mot de passe actuel",
    ),
    "changePasswordError": MessageLookupByLibrary.simpleMessage(
      "Impossible de changer le mot de passe. Vérifiez votre mot de passe actuel.",
    ),
    "changePasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas",
    ),
    "changePasswordNew": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "changePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Mot de passe mis à jour",
    ),
    "changePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirmer le changement",
    ),
    "changePhoneNewCodeLabel": m22,
    "changePhoneOldCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code reçu sur l’ancien numéro",
    ),
    "changePhoneSuccess": MessageLookupByLibrary.simpleMessage(
      "Numéro mis à jour",
    ),
    "cityPickerEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucune ville trouvée",
    ),
    "cityPickerSearchHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une ville",
    ),
    "cityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Choisir une ville",
    ),
    "commonCancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "commonComingSoon": MessageLookupByLibrary.simpleMessage(
      "Bientôt disponible",
    ),
    "commonError": MessageLookupByLibrary.simpleMessage(
      "Une erreur est survenue. Réessayez.",
    ),
    "commonErrorTitle": MessageLookupByLibrary.simpleMessage("Oups"),
    "commonOr": MessageLookupByLibrary.simpleMessage("Ou"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "dayFriday": MessageLookupByLibrary.simpleMessage("Vendredi"),
    "dayMonday": MessageLookupByLibrary.simpleMessage("Lundi"),
    "daySaturday": MessageLookupByLibrary.simpleMessage("Samedi"),
    "daySunday": MessageLookupByLibrary.simpleMessage("Dimanche"),
    "dayThursday": MessageLookupByLibrary.simpleMessage("Jeudi"),
    "dayTuesday": MessageLookupByLibrary.simpleMessage("Mardi"),
    "dayWednesday": MessageLookupByLibrary.simpleMessage("Mercredi"),
    "deleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Supprimer définitivement",
    ),
    "deleteAccountConfirmLabel": m23,
    "deleteAccountConfirmWord": MessageLookupByLibrary.simpleMessage(
      "SUPPRIMER",
    ),
    "deleteAccountLink": MessageLookupByLibrary.simpleMessage(
      "Supprimer mon compte",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Supprimer le compte",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Cette action est définitive. Vos données personnelles seront supprimées et vous perdrez l’accès à votre compte.",
    ),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Editer le Profil",
    ),
    "errorAccessDenied": MessageLookupByLibrary.simpleMessage(
      "Votre compte n’a pas les droits pour cette action.",
    ),
    "errorConstraintViolation": MessageLookupByLibrary.simpleMessage(
      "Une écriture concurrente a échoué. Réessayez.",
    ),
    "errorInsufficientPhotos": MessageLookupByLibrary.simpleMessage(
      "Ajoute au moins 3 photos pour publier.",
    ),
    "errorInvalidTransition": MessageLookupByLibrary.simpleMessage(
      "Ce changement de statut n’est pas possible pour ce bien.",
    ),
    "errorKycRequired": MessageLookupByLibrary.simpleMessage(
      "Vos certifications doivent être validées avant cette action.",
    ),
    "errorListingLimit": MessageLookupByLibrary.simpleMessage(
      "Limite d’annonces actives atteinte pour votre formule.",
    ),
    "errorProfileIncomplete": MessageLookupByLibrary.simpleMessage(
      "Complétez votre profil (photo, type, ville) avant de continuer.",
    ),
    "errorResidenceUnitLimit": MessageLookupByLibrary.simpleMessage(
      "Votre formule ne permet pas autant d’unités. Passez à une formule supérieure ou réduisez le nombre d’unités.",
    ),
    "errorValidation": MessageLookupByLibrary.simpleMessage(
      "Certaines informations sont invalides. Vérifiez le formulaire.",
    ),
    "exitAppBody": MessageLookupByLibrary.simpleMessage(
      "Appuyez de nouveau pour quitter.",
    ),
    "exitAppTitle": MessageLookupByLibrary.simpleMessage(
      "Quitter l’application ?",
    ),
    "homeCtaAgentsAction": MessageLookupByLibrary.simpleMessage(
      "Gérer mes agents",
    ),
    "homeCtaAgentsBody": MessageLookupByLibrary.simpleMessage(
      "Créez des agents à qui déléguer la gestion partielle ou complète de vos biens",
    ),
    "homeCtaAgentsTitle": MessageLookupByLibrary.simpleMessage("Mes agents"),
    "homeCtaBiensAction": MessageLookupByLibrary.simpleMessage(
      "Gérer mes biens",
    ),
    "homeCtaBiensBody": MessageLookupByLibrary.simpleMessage(
      "Enregistrez vos biens, et gérez ces derniers plus facilement à l’aide de plusieurs options de management",
    ),
    "homeCtaBiensTitle": MessageLookupByLibrary.simpleMessage("Mes biens"),
    "homeCtaPortefeuilleAction": MessageLookupByLibrary.simpleMessage(
      "Gérer mes transactions",
    ),
    "homeCtaPortefeuilleBody": MessageLookupByLibrary.simpleMessage(
      "Gérez vos transactions financières en rapport avec vos biens immobiliers depuis l’application",
    ),
    "homeCtaPortefeuilleTitle": MessageLookupByLibrary.simpleMessage(
      "Portefeuille",
    ),
    "homeEmptyBiens": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez encore enregistré aucun bien.",
    ),
    "homeLocationEmpty": MessageLookupByLibrary.simpleMessage("--/--"),
    "homeLocationLabel": MessageLookupByLibrary.simpleMessage("Localisation"),
    "homeOfflineBanner": MessageLookupByLibrary.simpleMessage(
      "Données hors ligne",
    ),
    "homeProWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa Pro 👋",
    ),
    "homeStatsBiens": MessageLookupByLibrary.simpleMessage("Biens"),
    "homeStatsContacts": MessageLookupByLibrary.simpleMessage("Contacts"),
    "homeStatsContracts": MessageLookupByLibrary.simpleMessage("Contrats"),
    "homeStatsConversion": MessageLookupByLibrary.simpleMessage("Conversion"),
    "homeStatsLockedHint": m24,
    "homeStatsPublished": MessageLookupByLibrary.simpleMessage("Publiés"),
    "homeStatsRank": MessageLookupByLibrary.simpleMessage("Position"),
    "homeStatsRented": MessageLookupByLibrary.simpleMessage("Loués"),
    "homeStatsReserved": MessageLookupByLibrary.simpleMessage("Réservés"),
    "homeStatsTitle": MessageLookupByLibrary.simpleMessage(
      "Statistiques Globales",
    ),
    "homeStatsUnavailable": MessageLookupByLibrary.simpleMessage("Bientôt"),
    "homeStatsUnavailableHint": MessageLookupByLibrary.simpleMessage(
      "Ces mesures s’activeront dès que le backend les exposera.",
    ),
    "homeStatsViews": MessageLookupByLibrary.simpleMessage("Vues"),
    "homeStatsVisits": MessageLookupByLibrary.simpleMessage("Visites"),
    "homeTitle": MessageLookupByLibrary.simpleMessage(
      "Gérez vos biens\nà travers l’application",
    ),
    "homeUserWelcome": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Mboa 👋",
    ),
    "kycAccountAgent": MessageLookupByLibrary.simpleMessage("Compte Agent"),
    "kycAccountPrestataire": MessageLookupByLibrary.simpleMessage(
      "Compte Prestataire",
    ),
    "kycAccountStandard": MessageLookupByLibrary.simpleMessage(
      "Compte Standard",
    ),
    "kycAdded": MessageLookupByLibrary.simpleMessage("Ajouté"),
    "kycDocCni": MessageLookupByLibrary.simpleMessage("Carte d’identité"),
    "kycDocPassport": MessageLookupByLibrary.simpleMessage("Passeport"),
    "kycDocRecepisse": MessageLookupByLibrary.simpleMessage("Recépissé"),
    "kycDocResidence": MessageLookupByLibrary.simpleMessage(
      "Permis de residence",
    ),
    "kycDone": MessageLookupByLibrary.simpleMessage("Terminé"),
    "kycIdDocumentPrompt": MessageLookupByLibrary.simpleMessage(
      "Choisissez le type de document que vous souhaitez utiliser pour vérifier votre identité",
    ),
    "kycImport": MessageLookupByLibrary.simpleMessage("Importer"),
    "kycItemAddress": MessageLookupByLibrary.simpleMessage("Adresse"),
    "kycItemIdDocument": MessageLookupByLibrary.simpleMessage("ID Document"),
    "kycItemNui": MessageLookupByLibrary.simpleMessage("NUI"),
    "kycItemSelfie": MessageLookupByLibrary.simpleMessage("Selfie"),
    "kycRecto": MessageLookupByLibrary.simpleMessage("Recto"),
    "kycRejectionReason": m25,
    "kycStatusApproved": MessageLookupByLibrary.simpleMessage("Vérifié"),
    "kycStatusNotSubmitted": MessageLookupByLibrary.simpleMessage(
      "Informations requises",
    ),
    "kycStatusPending": MessageLookupByLibrary.simpleMessage(
      "Informations en attente",
    ),
    "kycStatusRejected": MessageLookupByLibrary.simpleMessage("Refusé"),
    "kycSubmit": MessageLookupByLibrary.simpleMessage("Soumettre"),
    "kycSubmitted": MessageLookupByLibrary.simpleMessage("Documents soumis"),
    "kycTabIdentification": MessageLookupByLibrary.simpleMessage(
      "Identification",
    ),
    "kycTabStatut": MessageLookupByLibrary.simpleMessage("Statut"),
    "kycTakePhoto": MessageLookupByLibrary.simpleMessage("Prendre une photo"),
    "kycUploadError": MessageLookupByLibrary.simpleMessage(
      "Échec de l’envoi. Réessayez.",
    ),
    "kycVerso": MessageLookupByLibrary.simpleMessage("Verso"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "loadingDialog_content": MessageLookupByLibrary.simpleMessage(
      "Veuillez patienter...",
    ),
    "loginContinueWithApple": MessageLookupByLibrary.simpleMessage(
      "Continuer avec Apple",
    ),
    "loginContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continuer avec Google",
    ),
    "loginEnterPhone": MessageLookupByLibrary.simpleMessage(
      "Entrez votre numéro de téléphone",
    ),
    "loginNoAccountQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez pas de compte ?",
    ),
    "loginOtpSendError": MessageLookupByLibrary.simpleMessage(
      "Impossible d’envoyer le code. Réessayez.",
    ),
    "loginPhoneHint": MessageLookupByLibrary.simpleMessage("+237 6XX XX XX XX"),
    "loginPhoneHintLocal": MessageLookupByLibrary.simpleMessage(
      "6 XX XX XX XX",
    ),
    "loginPhoneInvalid": MessageLookupByLibrary.simpleMessage(
      "Numéro invalide",
    ),
    "loginPhoneLabel": MessageLookupByLibrary.simpleMessage("Téléphone"),
    "loginRequestCode": MessageLookupByLibrary.simpleMessage(
      "Recevoir le code",
    ),
    "loginSignUpAction": MessageLookupByLibrary.simpleMessage("Inscrivez-vous"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "mediaImport": MessageLookupByLibrary.simpleMessage("Importer"),
    "mediaTakePhoto": MessageLookupByLibrary.simpleMessage("Prendre une photo"),
    "menuBookmarks": MessageLookupByLibrary.simpleMessage("Signets"),
    "menuClose": MessageLookupByLibrary.simpleMessage("Fermer le menu"),
    "menuExplore": MessageLookupByLibrary.simpleMessage("Explorer"),
    "menuGreeting": MessageLookupByLibrary.simpleMessage("Hello !!"),
    "menuMessages": MessageLookupByLibrary.simpleMessage("Message"),
    "menuNotifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "menuOther": MessageLookupByLibrary.simpleMessage("Autres"),
    "menuProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "menuQuit": MessageLookupByLibrary.simpleMessage("Quitter"),
    "menuSearch": MessageLookupByLibrary.simpleMessage("Recherche"),
    "mesBiensAttributions": MessageLookupByLibrary.simpleMessage(
      "Attributions",
    ),
    "mesBiensAttributionsBody": MessageLookupByLibrary.simpleMessage(
      "Attribuer un local",
    ),
    "mesBiensMultiple": MessageLookupByLibrary.simpleMessage(
      "Biens\nMultiples",
    ),
    "mesBiensPending": MessageLookupByLibrary.simpleMessage(
      "En attente\nde validation",
    ),
    "mesBiensProspections": MessageLookupByLibrary.simpleMessage(
      "Prospections",
    ),
    "mesBiensProspectionsBody": MessageLookupByLibrary.simpleMessage(
      "Prospection des biens en vente",
    ),
    "mesBiensReservations": MessageLookupByLibrary.simpleMessage(
      "Reservations",
    ),
    "mesBiensReservationsBody": MessageLookupByLibrary.simpleMessage(
      "Traiter les reservations",
    ),
    "mesBiensSingle": MessageLookupByLibrary.simpleMessage("Biens\nUniques"),
    "mesBiensTitle": MessageLookupByLibrary.simpleMessage("Mes biens"),
    "missionsAccept": MessageLookupByLibrary.simpleMessage("Accepter"),
    "missionsActionFailed": MessageLookupByLibrary.simpleMessage(
      "Action impossible pour le moment.",
    ),
    "missionsApplied": MessageLookupByLibrary.simpleMessage(
      "Candidature envoyée",
    ),
    "missionsApply": MessageLookupByLibrary.simpleMessage("Candidater"),
    "missionsApplyNote": MessageLookupByLibrary.simpleMessage(
      "Le prestataire choisit parmi les candidats.",
    ),
    "missionsDecline": MessageLookupByLibrary.simpleMessage("Refuser"),
    "missionsEmptyMine": MessageLookupByLibrary.simpleMessage(
      "Aucune mission en cours",
    ),
    "missionsEmptyOffers": MessageLookupByLibrary.simpleMessage(
      "Aucune proposition en attente",
    ),
    "missionsEmptyOpportunities": MessageLookupByLibrary.simpleMessage(
      "Aucune opportunité dans vos zones",
    ),
    "missionsEmptyOpportunitiesBody": MessageLookupByLibrary.simpleMessage(
      "Élargissez vos zones d\'intervention pour recevoir plus de propositions.",
    ),
    "missionsResign": MessageLookupByLibrary.simpleMessage("Me désister"),
    "missionsResignConfirm": MessageLookupByLibrary.simpleMessage(
      "Les visites déjà planifiées seront annulées.",
    ),
    "missionsTabMine": MessageLookupByLibrary.simpleMessage("Mes missions"),
    "missionsTabOffers": MessageLookupByLibrary.simpleMessage("Propositions"),
    "missionsTabOpportunities": MessageLookupByLibrary.simpleMessage(
      "Opportunités",
    ),
    "missionsUnits": m26,
    "missionsWithdraw": MessageLookupByLibrary.simpleMessage("Retirer"),
    "navFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "navHome": MessageLookupByLibrary.simpleMessage("Accueil"),
    "navManager": MessageLookupByLibrary.simpleMessage("Gestionnaire"),
    "navMenu": MessageLookupByLibrary.simpleMessage("Menu"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("Code à 6 chiffres"),
    "otpCodeSentTo": m27,
    "otpInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Code invalide. Réessayez.",
    ),
    "otpNoCodeQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous n’avez pas reçu le code ?",
    ),
    "otpResend": MessageLookupByLibrary.simpleMessage("Renvoyer le code"),
    "otpResendIn": m28,
    "otpTitle": MessageLookupByLibrary.simpleMessage("Vérification"),
    "otpValidate": MessageLookupByLibrary.simpleMessage("Valider"),
    "paymentAwaitingBody": MessageLookupByLibrary.simpleMessage(
      "Validez la demande de paiement reçue sur votre mobile (USSD ou application Mobile Money). Cet écran se met à jour automatiquement.",
    ),
    "paymentAwaitingTitle": MessageLookupByLibrary.simpleMessage(
      "Finalisez sur votre téléphone",
    ),
    "paymentConfirmedBody": m29,
    "paymentConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement confirmé",
    ),
    "paymentDone": MessageLookupByLibrary.simpleMessage("Terminé"),
    "paymentFailedBody": MessageLookupByLibrary.simpleMessage(
      "La transaction n’a pas abouti. Aucun montant n’a été débité.",
    ),
    "paymentFailedTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement échoué",
    ),
    "paymentInitiating": MessageLookupByLibrary.simpleMessage(
      "Initialisation du paiement…",
    ),
    "paymentMethodMtn": MessageLookupByLibrary.simpleMessage(
      "MTN Mobile Money",
    ),
    "paymentMethodOrange": MessageLookupByLibrary.simpleMessage("Orange Money"),
    "paymentMethodTitle": MessageLookupByLibrary.simpleMessage(
      "Mode de paiement",
    ),
    "paymentPendingBody": MessageLookupByLibrary.simpleMessage(
      "Nous n’avons pas encore reçu la confirmation. Elle peut prendre quelques minutes — vous recevrez une notification dès que votre formule sera active.",
    ),
    "paymentPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement en attente",
    ),
    "paymentReference": m30,
    "paymentRetry": MessageLookupByLibrary.simpleMessage(
      "Réessayer le paiement",
    ),
    "plansChoose": MessageLookupByLibrary.simpleMessage("Choisir"),
    "plansCurrent": MessageLookupByLibrary.simpleMessage("Formule actuelle"),
    "plansDowngradeNote": MessageLookupByLibrary.simpleMessage(
      "Un passage à une formule inférieure prend effet au prochain cycle.",
    ),
    "plansPriceFree": MessageLookupByLibrary.simpleMessage("Gratuit"),
    "plansPriceMonthly": m31,
    "plansResidenceAllowance": m32,
    "plansTitle": MessageLookupByLibrary.simpleMessage("Formules"),
    "profileDisplayName": MessageLookupByLibrary.simpleMessage("Nom affiché"),
    "profileFirstName": MessageLookupByLibrary.simpleMessage("Prénom"),
    "profileLastName": MessageLookupByLibrary.simpleMessage("Nom"),
    "profileLoadError": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger le profil.",
    ),
    "profileLocation": MessageLookupByLibrary.simpleMessage("Localisation"),
    "profileMainCity": MessageLookupByLibrary.simpleMessage("Ville principale"),
    "profilePhotoUpdated": MessageLookupByLibrary.simpleMessage(
      "Photo mise à jour",
    ),
    "profileSave": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "profileSaved": MessageLookupByLibrary.simpleMessage("Profil mis à jour"),
    "profileType": MessageLookupByLibrary.simpleMessage("Type"),
    "profileTypeAgence": MessageLookupByLibrary.simpleMessage("Agence"),
    "profileTypeParticulier": MessageLookupByLibrary.simpleMessage(
      "Particulier",
    ),
    "profileTypePromoteur": MessageLookupByLibrary.simpleMessage("Promoteur"),
    "publishBlockedLimitBody": m33,
    "publishBlockedLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Limite atteinte",
    ),
    "publishBlockedPhotosBody": m34,
    "publishBlockedPhotosTitle": MessageLookupByLibrary.simpleMessage(
      "Photos manquantes",
    ),
    "publishBlockedProfileBody": MessageLookupByLibrary.simpleMessage(
      "Complétez votre profil (logo, type, ville) avant de publier.",
    ),
    "publishBlockedProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Profil incomplet",
    ),
    "registerButton": MessageLookupByLibrary.simpleMessage("S’inscrire"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Inscription impossible. Vérifiez vos informations.",
    ),
    "registerHaveAccountQuestion": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ?",
    ),
    "registerRoleAgent": MessageLookupByLibrary.simpleMessage("Agent"),
    "registerRoleLabel": MessageLookupByLibrary.simpleMessage("Je suis"),
    "registerRolePrestataire": MessageLookupByLibrary.simpleMessage(
      "Prestataire",
    ),
    "registerSignInAction": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Créer un compte"),
    "residenceDeleteConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Cette action est définitive et supprime aussi toutes ses unités.",
    ),
    "residenceDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Supprimer cette résidence ?",
    ),
    "residenceDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de la résidence",
    ),
    "residenceUnitStatus": MessageLookupByLibrary.simpleMessage("Statut"),
    "residenceUnitsPending": MessageLookupByLibrary.simpleMessage(
      "La modification d’une unité arrivera prochainement.",
    ),
    "residenceUnitsSearchEmpty": m35,
    "residenceUnitsSearchHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une unité",
    ),
    "residenceUnitsTitle": MessageLookupByLibrary.simpleMessage("Unités"),
    "residencesTitle": MessageLookupByLibrary.simpleMessage("Biens Multiples"),
    "settingsCertificationsBody": MessageLookupByLibrary.simpleMessage(
      "Pièces d’identifications et tout autres vérifications requises",
    ),
    "settingsCertificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Certifications",
    ),
    "settingsChangePassword": MessageLookupByLibrary.simpleMessage(
      "Changer de mot passe",
    ),
    "settingsChangePhone": MessageLookupByLibrary.simpleMessage(
      "Changer de numéro",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Langue"),
    "settingsLogout": MessageLookupByLibrary.simpleMessage("Déconnexion"),
    "settingsMenuTitle": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "settingsProfileCard": MessageLookupByLibrary.simpleMessage("Profil"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Profil"),
    "subscriptionChangePlan": MessageLookupByLibrary.simpleMessage(
      "Changer de formule",
    ),
    "subscriptionCurrentPlan": MessageLookupByLibrary.simpleMessage(
      "Formule actuelle",
    ),
    "subscriptionExpired": MessageLookupByLibrary.simpleMessage(
      "Votre abonnement a expiré",
    ),
    "subscriptionListingLimit": m36,
    "subscriptionListingLimitUnlimited": MessageLookupByLibrary.simpleMessage(
      "Annonces illimitées",
    ),
    "subscriptionNoExpiry": MessageLookupByLibrary.simpleMessage(
      "Sans expiration",
    ),
    "subscriptionNoReceipts": MessageLookupByLibrary.simpleMessage(
      "Aucun paiement enregistré sur cet appareil.",
    ),
    "subscriptionReceiptOpen": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le reçu",
    ),
    "subscriptionReceipts": MessageLookupByLibrary.simpleMessage("Mes reçus"),
    "subscriptionReceiptsLocalHint": MessageLookupByLibrary.simpleMessage(
      "Les reçus sont liés à cet appareil pour le moment.",
    ),
    "subscriptionRenewsOn": m37,
    "subscriptionTitle": MessageLookupByLibrary.simpleMessage("Mon abonnement"),
    "subscriptionUnknown": MessageLookupByLibrary.simpleMessage(
      "Impossible de vérifier votre abonnement. Formule Gratuit appliquée en attendant.",
    ),
    "welcome_inscriptionButton": MessageLookupByLibrary.simpleMessage(
      "Inscription",
    ),
    "welcome_loginButton": MessageLookupByLibrary.simpleMessage("Connexion"),
  };
}
