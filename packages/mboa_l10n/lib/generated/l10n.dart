// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class I18n {
  I18n();

  static I18n? _current;

  static I18n get current {
    assert(
      _current != null,
      'No instance of I18n was loaded. Try to initialize the I18n delegate before accessing I18n.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I18n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I18n();
      I18n._current = instance;

      return instance;
    });
  }

  static I18n of(BuildContext context) {
    final instance = I18n.maybeOf(context);
    assert(
      instance != null,
      'No instance of I18n present in the widget tree. Did you add I18n.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static I18n? maybeOf(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  /// `Mboa`
  String get appName {
    return Intl.message('Mboa', name: 'appName', desc: '', args: []);
  }

  /// `Mboa Pro`
  String get appNamePro {
    return Intl.message('Mboa Pro', name: 'appNamePro', desc: '', args: []);
  }

  /// `Contrat Mboa`
  String get contractDetailTitle {
    return Intl.message(
      'Contrat Mboa',
      name: 'contractDetailTitle',
      desc: 'M08 detail.',
      args: [],
    );
  }

  /// `Termes`
  String get contractTermsTitle {
    return Intl.message(
      'Termes',
      name: 'contractTermsTitle',
      desc: 'The financial terms.',
      args: [],
    );
  }

  /// `Parties`
  String get contractPartiesTitle {
    return Intl.message(
      'Parties',
      name: 'contractPartiesTitle',
      desc: 'Landlord, tenant, agent.',
      args: [],
    );
  }

  /// `Modifications demandées`
  String get contractChangesTitle {
    return Intl.message(
      'Modifications demandées',
      name: 'contractChangesTitle',
      desc: 'CE-M08-03.',
      args: [],
    );
  }

  /// `Signatures`
  String get contractSignaturesTitle {
    return Intl.message(
      'Signatures',
      name: 'contractSignaturesTitle',
      desc: 'RM-M08-03.',
      args: [],
    );
  }

  /// `Loyer`
  String get contractTermPrice {
    return Intl.message(
      'Loyer',
      name: 'contractTermPrice',
      desc: 'price + rentalPeriod.',
      args: [],
    );
  }

  /// `Périodicité`
  String get contractTermPeriod {
    return Intl.message(
      'Périodicité',
      name: 'contractTermPeriod',
      desc: 'rentalPeriod.',
      args: [],
    );
  }

  /// `Caution`
  String get contractTermDeposit {
    return Intl.message(
      'Caution',
      name: 'contractTermDeposit',
      desc: 'depositAmount (RM-M08-06 — a declaration in MVP).',
      args: [],
    );
  }

  /// `Charges`
  String get contractTermCharges {
    return Intl.message(
      'Charges',
      name: 'contractTermCharges',
      desc: 'chargesIncluded.',
      args: [],
    );
  }

  /// `Date d'entrée`
  String get contractTermStart {
    return Intl.message(
      'Date d\'entrée',
      name: 'contractTermStart',
      desc: 'startDate.',
      args: [],
    );
  }

  /// `Durée`
  String get contractTermDuration {
    return Intl.message(
      'Durée',
      name: 'contractTermDuration',
      desc: 'durationUnits, in the contract\'s periodicity (RM-M08-08).',
      args: [],
    );
  }

  /// `Fin du bail`
  String get contractTermEnd {
    return Intl.message(
      'Fin du bail',
      name: 'contractTermEnd',
      desc: 'endDate, derived.',
      args: [],
    );
  }

  /// `Reconduction tacite`
  String get contractTermTacit {
    return Intl.message(
      'Reconduction tacite',
      name: 'contractTermTacit',
      desc: 'tacitRenewal.',
      args: [],
    );
  }

  /// `Bailleur`
  String get contractPartyPrestataire {
    return Intl.message(
      'Bailleur',
      name: 'contractPartyPrestataire',
      desc: 'Participant role.',
      args: [],
    );
  }

  /// `Locataire`
  String get contractPartyTenant {
    return Intl.message(
      'Locataire',
      name: 'contractPartyTenant',
      desc: 'Participant role.',
      args: [],
    );
  }

  /// `Agent ayant conduit la visite`
  String get contractPartyAgent {
    return Intl.message(
      'Agent ayant conduit la visite',
      name: 'contractPartyAgent',
      desc: 'RM-M08-07.',
      args: [],
    );
  }

  /// `Contrat verrouillé : aucune modification n'est possible, même par un administrateur.`
  String get contractLocked {
    return Intl.message(
      'Contrat verrouillé : aucune modification n\'est possible, même par un administrateur.',
      name: 'contractLocked',
      desc: 'RM-M08-03 / CA-M08-03.',
      args: [],
    );
  }

  /// `Objection en attente de ta réponse`
  String get contractChangePending {
    return Intl.message(
      'Objection en attente de ta réponse',
      name: 'contractChangePending',
      desc: 'CE-M08-03 — pending.',
      args: [],
    );
  }

  /// `Objection traitée`
  String get contractChangeAnswered {
    return Intl.message(
      'Objection traitée',
      name: 'contractChangeAnswered',
      desc: 'CE-M08-03 — answered.',
      args: [],
    );
  }

  /// `Objection retirée`
  String get contractChangeWithdrawn {
    return Intl.message(
      'Objection retirée',
      name: 'contractChangeWithdrawn',
      desc: 'withdrawnAt is set.',
      args: [],
    );
  }

  /// `Répondre`
  String get contractChangeAnswer {
    return Intl.message(
      'Répondre',
      name: 'contractChangeAnswer',
      desc: 'Answer one objection.',
      args: [],
    );
  }

  /// `Réponds même si tu ne modifies rien : un refus motivé est une réponse et reste au dossier.`
  String get contractChangeAnswerHelp {
    return Intl.message(
      'Réponds même si tu ne modifies rien : un refus motivé est une réponse et reste au dossier.',
      name: 'contractChangeAnswerHelp',
      desc: 'CE-M08-03.',
      args: [],
    );
  }

  /// `Envoyer la réponse`
  String get contractChangeAnswerSend {
    return Intl.message(
      'Envoyer la réponse',
      name: 'contractChangeAnswerSend',
      desc: 'Submit.',
      args: [],
    );
  }

  /// `Envoyer au locataire`
  String get contractSend {
    return Intl.message(
      'Envoyer au locataire',
      name: 'contractSend',
      desc: 'N-07.',
      args: [],
    );
  }

  /// `Signer`
  String get contractSign {
    return Intl.message(
      'Signer',
      name: 'contractSign',
      desc: 'RM-M08-03.',
      args: [],
    );
  }

  /// `Tu as signé`
  String get contractSignedByYou {
    return Intl.message(
      'Tu as signé',
      name: 'contractSignedByYou',
      desc: 'Already signed by me.',
      args: [],
    );
  }

  /// `SIGNER`
  String get contractSignWord {
    return Intl.message(
      'SIGNER',
      name: 'contractSignWord',
      desc: 'The word to type; keep it upper-case.',
      args: [],
    );
  }

  /// `Tape {word} pour confirmer`
  String contractSignPrompt(String word) {
    return Intl.message(
      'Tape $word pour confirmer',
      name: 'contractSignPrompt',
      desc: 'Signature confirmation.',
      args: [word],
    );
  }

  /// `Une fois les deux signatures apposées, le contrat est définitif : plus aucune modification n'est possible.`
  String get contractSignWarning {
    return Intl.message(
      'Une fois les deux signatures apposées, le contrat est définitif : plus aucune modification n\'est possible.',
      name: 'contractSignWarning',
      desc: 'RM-M08-03.',
      args: [],
    );
  }

  /// `Télécharger le PDF`
  String get contractPdf {
    return Intl.message(
      'Télécharger le PDF',
      name: 'contractPdf',
      desc: 'CA-M08-01.',
      args: [],
    );
  }

  /// `Modifier les termes`
  String get contractAmend {
    return Intl.message(
      'Modifier les termes',
      name: 'contractAmend',
      desc: 'RM-M08-08.',
      args: [],
    );
  }

  /// `Annuler le contrat`
  String get contractCancel {
    return Intl.message(
      'Annuler le contrat',
      name: 'contractCancel',
      desc: 'Either party, up to the second signature.',
      args: [],
    );
  }

  /// `Accepter les termes`
  String get contractAccept {
    return Intl.message(
      'Accepter les termes',
      name: 'contractAccept',
      desc: 'M08 RM-M08-02 — the tenant takes the terms as they stand.',
      args: [],
    );
  }

  /// `Demander une modification`
  String get contractContest {
    return Intl.message(
      'Demander une modification',
      name: 'contractContest',
      desc: 'M08 CE-M08-03 — the tenant contests the terms.',
      args: [],
    );
  }

  /// `Dis ce qui ne va pas. Le bailleur doit te répondre, même s'il ne change rien.`
  String get contractContestHelp {
    return Intl.message(
      'Dis ce qui ne va pas. Le bailleur doit te répondre, même s\'il ne change rien.',
      name: 'contractContestHelp',
      desc: 'M08 — a refusal is an answer; the copy says so.',
      args: [],
    );
  }

  /// `Ce qui te pose problème, et pourquoi.`
  String get contractContestHint {
    return Intl.message(
      'Ce qui te pose problème, et pourquoi.',
      name: 'contractContestHint',
      desc: 'M08 — the objection field.',
      args: [],
    );
  }

  /// `Envoyer l'objection`
  String get contractContestSend {
    return Intl.message(
      'Envoyer l\'objection',
      name: 'contractContestSend',
      desc: 'M08 — sends the objection.',
      args: [],
    );
  }

  /// `Le contrat sera annulé pour les deux parties. Cette action est définitive.`
  String get contractCancelConfirm {
    return Intl.message(
      'Le contrat sera annulé pour les deux parties. Cette action est définitive.',
      name: 'contractCancelConfirm',
      desc: 'Cancel confirmation.',
      args: [],
    );
  }

  /// `Action impossible pour le moment.`
  String get contractActionFailed {
    return Intl.message(
      'Action impossible pour le moment.',
      name: 'contractActionFailed',
      desc: 'Generic failure.',
      args: [],
    );
  }

  /// `Contrat mis à jour`
  String get contractActionDone {
    return Intl.message(
      'Contrat mis à jour',
      name: 'contractActionDone',
      desc: 'Generic success.',
      args: [],
    );
  }

  /// `Ta signature`
  String get contractSignatureMine {
    return Intl.message(
      'Ta signature',
      name: 'contractSignatureMine',
      desc: 'SignatureResponse.current.',
      args: [],
    );
  }

  /// `Signature du locataire`
  String get contractSignatureOther {
    return Intl.message(
      'Signature du locataire',
      name: 'contractSignatureOther',
      desc: 'The other party\'s.',
      args: [],
    );
  }

  /// `Créer un Contrat Mboa`
  String get contractFormTitleNew {
    return Intl.message(
      'Créer un Contrat Mboa',
      name: 'contractFormTitleNew',
      desc: 'RM-M08-01.',
      args: [],
    );
  }

  /// `Modifier les termes`
  String get contractFormTitleAmend {
    return Intl.message(
      'Modifier les termes',
      name: 'contractFormTitleAmend',
      desc: 'RM-M08-08.',
      args: [],
    );
  }

  /// `Locataire`
  String get contractFormTenantTitle {
    return Intl.message(
      'Locataire',
      name: 'contractFormTenantTitle',
      desc: 'Who the contract is with.',
      args: [],
    );
  }

  /// `Numéro du locataire`
  String get contractFormTenantPhone {
    return Intl.message(
      'Numéro du locataire',
      name: 'contractFormTenantPhone',
      desc: 'tenantPhone.',
      args: [],
    );
  }

  /// `S'il n'a pas encore de compte Mboa, une invitation lui sera envoyée par SMS et le contrat sera à établir une fois qu'il l'aura acceptée.`
  String get contractFormTenantHelp {
    return Intl.message(
      'S\'il n\'a pas encore de compte Mboa, une invitation lui sera envoyée par SMS et le contrat sera à établir une fois qu\'il l\'aura acceptée.',
      name: 'contractFormTenantHelp',
      desc: 'CE-M08-01.',
      args: [],
    );
  }

  /// `Créer le contrat`
  String get contractFormSave {
    return Intl.message(
      'Créer le contrat',
      name: 'contractFormSave',
      desc: 'Submit a new contract.',
      args: [],
    );
  }

  /// `Contrat enregistré`
  String get contractSaved {
    return Intl.message(
      'Contrat enregistré',
      name: 'contractSaved',
      desc: 'Toast.',
      args: [],
    );
  }

  /// `Ce locataire n'a pas encore de compte Mboa. Une invitation lui a été envoyée ; reprends le contrat une fois qu'il aura rejoint.`
  String get contractTenantInvited {
    return Intl.message(
      'Ce locataire n\'a pas encore de compte Mboa. Une invitation lui a été envoyée ; reprends le contrat une fois qu\'il aura rejoint.',
      name: 'contractTenantInvited',
      desc: 'CE-M08-01.',
      args: [],
    );
  }

  /// `Créer un Contrat Mboa`
  String get contractCreate {
    return Intl.message(
      'Créer un Contrat Mboa',
      name: 'contractCreate',
      desc: 'Entry point on a listing.',
      args: [],
    );
  }

  /// `Contrats Mboa`
  String get contractsTitle {
    return Intl.message(
      'Contrats Mboa',
      name: 'contractsTitle',
      desc: 'M08 list.',
      args: [],
    );
  }

  /// `À toi de jouer`
  String get contractsFilterMine {
    return Intl.message(
      'À toi de jouer',
      name: 'contractsFilterMine',
      desc: 'RM-M08-09 — awaiting = PRESTATAIRE or BOTH.',
      args: [],
    );
  }

  /// `Tous`
  String get contractsFilterAll {
    return Intl.message(
      'Tous',
      name: 'contractsFilterAll',
      desc: 'No filter.',
      args: [],
    );
  }

  /// `Aucun contrat`
  String get contractsEmptyTitle {
    return Intl.message(
      'Aucun contrat',
      name: 'contractsEmptyTitle',
      desc: 'Empty list.',
      args: [],
    );
  }

  /// `Un Contrat Mboa part toujours d'un bien. Ouvre la fiche du bien concerné pour en rédiger un.`
  String get contractsEmptyBody {
    return Intl.message(
      'Un Contrat Mboa part toujours d\'un bien. Ouvre la fiche du bien concerné pour en rédiger un.',
      name: 'contractsEmptyBody',
      desc: 'RM-M08-01.',
      args: [],
    );
  }

  /// `Tes Contrats Mboa apparaîtront ici dès qu'un bailleur t'en enverra un.`
  String get contractsEmptyTenantBody {
    return Intl.message(
      'Tes Contrats Mboa apparaîtront ici dès qu\'un bailleur t\'en enverra un.',
      name: 'contractsEmptyTenantBody',
      desc: 'M08 — the tenant half of the empty list.',
      args: [],
    );
  }

  /// `Aucun contrat dans cette vue.`
  String get contractsEmptyFiltered {
    return Intl.message(
      'Aucun contrat dans cette vue.',
      name: 'contractsEmptyFiltered',
      desc: 'Filtered empty.',
      args: [],
    );
  }

  /// `Locataire à confirmer`
  String get contractTenantPending {
    return Intl.message(
      'Locataire à confirmer',
      name: 'contractTenantPending',
      desc: 'No tenant name yet.',
      args: [],
    );
  }

  /// `Brouillon`
  String get contractStatusDraft {
    return Intl.message(
      'Brouillon',
      name: 'contractStatusDraft',
      desc: 'ContractStatus.draft.',
      args: [],
    );
  }

  /// `Envoyé`
  String get contractStatusSent {
    return Intl.message(
      'Envoyé',
      name: 'contractStatusSent',
      desc: 'ContractStatus.sent.',
      args: [],
    );
  }

  /// `Modifications demandées`
  String get contractStatusChangesRequested {
    return Intl.message(
      'Modifications demandées',
      name: 'contractStatusChangesRequested',
      desc: 'ContractStatus.changesRequested.',
      args: [],
    );
  }

  /// `Accepté`
  String get contractStatusAccepted {
    return Intl.message(
      'Accepté',
      name: 'contractStatusAccepted',
      desc: 'ContractStatus.accepted.',
      args: [],
    );
  }

  /// `Signé`
  String get contractStatusSigned {
    return Intl.message(
      'Signé',
      name: 'contractStatusSigned',
      desc: 'ContractStatus.signed.',
      args: [],
    );
  }

  /// `Annulé`
  String get contractStatusCancelled {
    return Intl.message(
      'Annulé',
      name: 'contractStatusCancelled',
      desc: 'ContractStatus.cancelled.',
      args: [],
    );
  }

  /// `En attente de ton action`
  String get contractAwaitingYou {
    return Intl.message(
      'En attente de ton action',
      name: 'contractAwaitingYou',
      desc: 'RM-M08-09 — awaiting = PRESTATAIRE.',
      args: [],
    );
  }

  /// `En attente du locataire`
  String get contractAwaitingTenant {
    return Intl.message(
      'En attente du locataire',
      name: 'contractAwaitingTenant',
      desc: 'awaiting = TENANT.',
      args: [],
    );
  }

  /// `En attente des deux signatures`
  String get contractAwaitingBoth {
    return Intl.message(
      'En attente des deux signatures',
      name: 'contractAwaitingBoth',
      desc: 'awaiting = BOTH.',
      args: [],
    );
  }

  /// `Rien à faire`
  String get contractAwaitingNobody {
    return Intl.message(
      'Rien à faire',
      name: 'contractAwaitingNobody',
      desc: 'awaiting = NOBODY.',
      args: [],
    );
  }

  /// `{count} {period}`
  String contractDurationValue(int count, String period) {
    return Intl.message(
      '$count $period',
      name: 'contractDurationValue',
      desc: 'RM-M08-08 — duration in the contract\'s own periodicity.',
      args: [count, period],
    );
  }

  /// `Recherche`
  String get navSearch {
    return Intl.message(
      'Recherche',
      name: 'navSearch',
      desc: 'Tenant shell tab.',
      args: [],
    );
  }

  /// `Favoris`
  String get navFavorites {
    return Intl.message(
      'Favoris',
      name: 'navFavorites',
      desc: 'Tenant shell tab (M06).',
      args: [],
    );
  }

  /// `Messages`
  String get navMessages {
    return Intl.message(
      'Messages',
      name: 'navMessages',
      desc: 'Tenant shell tab (M12).',
      args: [],
    );
  }

  /// `Compte`
  String get navAccount {
    return Intl.message(
      'Compte',
      name: 'navAccount',
      desc: 'Tenant shell tab.',
      args: [],
    );
  }

  /// `Crée ton compte Mboa`
  String get accountGuestTitle {
    return Intl.message(
      'Crée ton compte Mboa',
      name: 'accountGuestTitle',
      desc: 'Account tab, signed out.',
      args: [],
    );
  }

  /// `La recherche est libre. Un compte sert à contacter un prestataire, planifier une visite et enregistrer tes favoris.`
  String get accountGuestBody {
    return Intl.message(
      'La recherche est libre. Un compte sert à contacter un prestataire, planifier une visite et enregistrer tes favoris.',
      name: 'accountGuestBody',
      desc: 'RM-M04-05 — the wall is on the actions, not on the search.',
      args: [],
    );
  }

  /// `Se connecter`
  String get accountSignIn {
    return Intl.message(
      'Se connecter',
      name: 'accountSignIn',
      desc: 'CTA to /login.',
      args: [],
    );
  }

  /// `Choisir une ville`
  String get searchCityPrompt {
    return Intl.message(
      'Choisir une ville',
      name: 'searchCityPrompt',
      desc: 'RM-M04-01 — the only mandatory criterion.',
      args: [],
    );
  }

  /// `Filtres`
  String get searchFilters {
    return Intl.message(
      'Filtres',
      name: 'searchFilters',
      desc: 'Opens the optional criteria.',
      args: [],
    );
  }

  /// `Réinitialiser`
  String get searchClearFilters {
    return Intl.message(
      'Réinitialiser',
      name: 'searchClearFilters',
      desc: 'Keeps the city, drops the rest.',
      args: [],
    );
  }

  /// `Voir les résultats`
  String get searchApply {
    return Intl.message(
      'Voir les résultats',
      name: 'searchApply',
      desc: 'Applies the filters sheet.',
      args: [],
    );
  }

  /// `Tu cherches où ?`
  String get searchStartTitle {
    return Intl.message(
      'Tu cherches où ?',
      name: 'searchStartTitle',
      desc: 'No city chosen yet.',
      args: [],
    );
  }

  /// `Choisis une ville pour lancer la recherche. Les autres filtres sont facultatifs.`
  String get searchStartBody {
    return Intl.message(
      'Choisis une ville pour lancer la recherche. Les autres filtres sont facultatifs.',
      name: 'searchStartBody',
      desc: 'RM-M04-01.',
      args: [],
    );
  }

  /// `Aucun bien ici pour l'instant`
  String get searchEmptyTitle {
    return Intl.message(
      'Aucun bien ici pour l\'instant',
      name: 'searchEmptyTitle',
      desc: 'CE-M04-01.',
      args: [],
    );
  }

  /// `Essaie un autre quartier, un loyer plus haut, ou un autre type de bien.`
  String get searchEmptyBody {
    return Intl.message(
      'Essaie un autre quartier, un loyer plus haut, ou un autre type de bien.',
      name: 'searchEmptyBody',
      desc: 'CE-M04-01 — suggests widening.',
      args: [],
    );
  }

  /// `Résultats hors ligne — ils datent de ta dernière recherche.`
  String get searchOfflineBanner {
    return Intl.message(
      'Résultats hors ligne — ils datent de ta dernière recherche.',
      name: 'searchOfflineBanner',
      desc: 'CE-M04-02.',
      args: [],
    );
  }

  /// `Résultats non actualisés — le serveur n'a pas répondu.`
  String get searchStaleBanner {
    return Intl.message(
      'Résultats non actualisés — le serveur n\'a pas répondu.',
      name: 'searchStaleBanner',
      desc: 'CE-M04-03 with a warm cache: online, but the search failed.',
      args: [],
    );
  }

  /// `À venir`
  String get visitsUpcoming {
    return Intl.message(
      'À venir',
      name: 'visitsUpcoming',
      desc: 'Section of upcoming visits (M07).',
      args: [],
    );
  }

  /// `Passées`
  String get visitsPast {
    return Intl.message(
      'Passées',
      name: 'visitsPast',
      desc: 'Section of past visits (M07).',
      args: [],
    );
  }

  /// `Aucune visite`
  String get visitsEmptyTitle {
    return Intl.message(
      'Aucune visite',
      name: 'visitsEmptyTitle',
      desc: 'No visit booked yet.',
      args: [],
    );
  }

  /// `Planifie une visite depuis la fiche d'un bien.`
  String get visitsEmptyBody {
    return Intl.message(
      'Planifie une visite depuis la fiche d\'un bien.',
      name: 'visitsEmptyBody',
      desc: 'No visit booked yet.',
      args: [],
    );
  }

  /// `Visites hors ligne — tes prochaines visites, telles qu'enregistrées.`
  String get visitsOffline {
    return Intl.message(
      'Visites hors ligne — tes prochaines visites, telles qu\'enregistrées.',
      name: 'visitsOffline',
      desc: 'Cached upcoming visits.',
      args: [],
    );
  }

  /// `Planifier une visite`
  String get visitBookTitle {
    return Intl.message(
      'Planifier une visite',
      name: 'visitBookTitle',
      desc: 'M07 booking sheet title.',
      args: [],
    );
  }

  /// `Qui te fait visiter`
  String get visitBookVisitor {
    return Intl.message(
      'Qui te fait visiter',
      name: 'visitBookVisitor',
      desc: 'Visitor picker heading.',
      args: [],
    );
  }

  /// `Choisis un créneau`
  String get visitBookSlot {
    return Intl.message(
      'Choisis un créneau',
      name: 'visitBookSlot',
      desc: 'Slot picker heading.',
      args: [],
    );
  }

  /// `Confirmer la visite`
  String get visitBookConfirm {
    return Intl.message(
      'Confirmer la visite',
      name: 'visitBookConfirm',
      desc: 'Booking CTA.',
      args: [],
    );
  }

  /// `Première visite offerte.`
  String get visitBookFree {
    return Intl.message(
      'Première visite offerte.',
      name: 'visitBookFree',
      desc: 'RM-M07-02 — the first visit is free in MVP.',
      args: [],
    );
  }

  /// `Visite confirmée`
  String get visitBookedTitle {
    return Intl.message(
      'Visite confirmée',
      name: 'visitBookedTitle',
      desc: 'A published slot was taken.',
      args: [],
    );
  }

  /// `Demande envoyée`
  String get visitRequestedTitle {
    return Intl.message(
      'Demande envoyée',
      name: 'visitRequestedTitle',
      desc: 'RM-M15-06 — the visitor confirms by hand.',
      args: [],
    );
  }

  /// `Le propriétaire doit encore confirmer l'heure proposée. Tu recevras une notification.`
  String get visitRequestedBody {
    return Intl.message(
      'Le propriétaire doit encore confirmer l\'heure proposée. Tu recevras une notification.',
      name: 'visitRequestedBody',
      desc: 'RM-M15-06.',
      args: [],
    );
  }

  /// `Tu as déjà une visite en cours sur ce bien.`
  String get visitAlreadyBooked {
    return Intl.message(
      'Tu as déjà une visite en cours sur ce bien.',
      name: 'visitAlreadyBooked',
      desc: 'RM-M07-03.',
      args: [],
    );
  }

  /// `Aucun horaire n'a encore été déclaré pour ce bien. Contacte le prestataire via la messagerie.`
  String get visitNoSlotAvailability {
    return Intl.message(
      'Aucun horaire n\'a encore été déclaré pour ce bien. Contacte le prestataire via la messagerie.',
      name: 'visitNoSlotAvailability',
      desc: 'CE-M07-01 AGENT_NO_AVAILABILITY.',
      args: [],
    );
  }

  /// `Aucune disponibilité cette semaine.`
  String get visitNoSlotBlocked {
    return Intl.message(
      'Aucune disponibilité cette semaine.',
      name: 'visitNoSlotBlocked',
      desc: 'CE-M07-01 ALL_DAYS_BLOCKED.',
      args: [],
    );
  }

  /// `Tous les créneaux de cette semaine sont réservés.`
  String get visitNoSlotBooked {
    return Intl.message(
      'Tous les créneaux de cette semaine sont réservés.',
      name: 'visitNoSlotBooked',
      desc: 'CE-M07-01 FULLY_BOOKED.',
      args: [],
    );
  }

  /// `Agent Mboa`
  String get visitVisitorAgent {
    return Intl.message(
      'Agent Mboa',
      name: 'visitVisitorAgent',
      desc: 'The visitor is an assigned agent.',
      args: [],
    );
  }

  /// `Le propriétaire`
  String get visitVisitorOwner {
    return Intl.message(
      'Le propriétaire',
      name: 'visitVisitorOwner',
      desc: 'RM-M11-10 — the owner shows the property.',
      args: [],
    );
  }

  /// `{count, plural, =0{Aucune visite} =1{1 visite} other{{count} visites}}`
  String visitVisitorRecord(int count) {
    return Intl.plural(
      count,
      zero: 'Aucune visite',
      one: '1 visite',
      other: '$count visites',
      name: 'visitVisitorRecord',
      desc: 'How many visits this visitor has completed.',
      args: [count],
    );
  }

  /// `En attente de confirmation`
  String get visitStatusRequested {
    return Intl.message(
      'En attente de confirmation',
      name: 'visitStatusRequested',
      desc: 'VisitStatus.requested.',
      args: [],
    );
  }

  /// `Confirmée`
  String get visitStatusScheduled {
    return Intl.message(
      'Confirmée',
      name: 'visitStatusScheduled',
      desc: 'VisitStatus.scheduled.',
      args: [],
    );
  }

  /// `Effectuée`
  String get visitStatusCompleted {
    return Intl.message(
      'Effectuée',
      name: 'visitStatusCompleted',
      desc: 'VisitStatus.completed.',
      args: [],
    );
  }

  /// `Annulée`
  String get visitStatusCancelled {
    return Intl.message(
      'Annulée',
      name: 'visitStatusCancelled',
      desc: 'VisitStatus.cancelled.',
      args: [],
    );
  }

  /// `Non honorée`
  String get visitStatusNotFulfilled {
    return Intl.message(
      'Non honorée',
      name: 'visitStatusNotFulfilled',
      desc: 'VisitStatus.notFulfilled.',
      args: [],
    );
  }

  /// `Je suis sur place`
  String get visitConfirmPresence {
    return Intl.message(
      'Je suis sur place',
      name: 'visitConfirmPresence',
      desc: 'RM-M07-05 — the tenant\'s half.',
      args: [],
    );
  }

  /// `Ta présence est confirmée. En attente du visiteur.`
  String get visitWaitingVisitor {
    return Intl.message(
      'Ta présence est confirmée. En attente du visiteur.',
      name: 'visitWaitingVisitor',
      desc: 'RM-M07-05 — one half in.',
      args: [],
    );
  }

  /// `Annuler la visite`
  String get visitCancel {
    return Intl.message(
      'Annuler la visite',
      name: 'visitCancel',
      desc: 'RM-M07-04.',
      args: [],
    );
  }

  /// `Retirer ma demande`
  String get visitWithdraw {
    return Intl.message(
      'Retirer ma demande',
      name: 'visitWithdraw',
      desc: 'M07 §19 — withdrawing an unanswered request, at any time.',
      args: [],
    );
  }

  /// `Appeler le visiteur`
  String get visitCallVisitor {
    return Intl.message(
      'Appeler le visiteur',
      name: 'visitCallVisitor',
      desc: 'M07 CE-M07-03 — call the visitor, inside four hours.',
      args: [],
    );
  }

  /// `Le numéro du visiteur est visible jusqu'à la fin de la visite.`
  String get visitCallHint {
    return Intl.message(
      'Le numéro du visiteur est visible jusqu\'à la fin de la visite.',
      name: 'visitCallHint',
      desc: 'M07 CA-M12-02 — the number is temporary.',
      args: [],
    );
  }

  /// `L'annulation n'est plus possible : préviens le visiteur directement.`
  String get visitCancelTooLate {
    return Intl.message(
      'L\'annulation n\'est plus possible : préviens le visiteur directement.',
      name: 'visitCancelTooLate',
      desc: 'CE-M07-03.',
      args: [],
    );
  }

  /// `Noter le visiteur`
  String get visitRateTitle {
    return Intl.message(
      'Noter le visiteur',
      name: 'visitRateTitle',
      desc: 'RM-M07-07.',
      args: [],
    );
  }

  /// `Facultatif. Cette note porte sur le service du visiteur, pas sur le bien.`
  String get visitRateBody {
    return Intl.message(
      'Facultatif. Cette note porte sur le service du visiteur, pas sur le bien.',
      name: 'visitRateBody',
      desc: 'RM-M07-07.',
      args: [],
    );
  }

  /// `Merci pour ta note.`
  String get visitRateDone {
    return Intl.message(
      'Merci pour ta note.',
      name: 'visitRateDone',
      desc: 'RM-M07-07 — rated.',
      args: [],
    );
  }

  /// `Bienvenue chez toi.`
  String get welcomeHeadline {
    return Intl.message(
      'Bienvenue chez toi.',
      name: 'welcomeHeadline',
      desc: 'Brandbook §07 — the onboarding line, verbatim.',
      args: [],
    );
  }

  /// `Trouve, réserve et gère ton logement en toute confiance.`
  String get welcomeBody {
    return Intl.message(
      'Trouve, réserve et gère ton logement en toute confiance.',
      name: 'welcomeBody',
      desc: 'Brandbook §08 — the App Store short description.',
      args: [],
    );
  }

  /// `Voir mon avis`
  String get reviewSeeCta {
    return Intl.message(
      'Voir mon avis',
      name: 'reviewSeeCta',
      desc: 'M07bis — a visit already reported on.',
      args: [],
    );
  }

  /// `Télécharger en PDF`
  String get reviewDownload {
    return Intl.message(
      'Télécharger en PDF',
      name: 'reviewDownload',
      desc: 'RM-M07bis-06.',
      args: [],
    );
  }

  /// `Le PDF n'a pas pu être généré.`
  String get reviewDownloadFailed {
    return Intl.message(
      'Le PDF n\'a pas pu être généré.',
      name: 'reviewDownloadFailed',
      desc: 'RM-M07bis-06 failure.',
      args: [],
    );
  }

  /// `Ton avis`
  String get reviewYours {
    return Intl.message(
      'Ton avis',
      name: 'reviewYours',
      desc: 'Heading of the read-only review.',
      args: [],
    );
  }

  /// `Publié le {date}`
  String reviewPublishedOn(String date) {
    return Intl.message(
      'Publié le $date',
      name: 'reviewPublishedOn',
      desc: 'When the review was published.',
      args: [date],
    );
  }

  /// `État général perçu : {value}/5`
  String reviewConditionValue(int value) {
    return Intl.message(
      'État général perçu : $value/5',
      name: 'reviewConditionValue',
      desc: 'Perceived condition on the read view.',
      args: [value],
    );
  }

  /// `Laisser un avis`
  String get reviewWriteCta {
    return Intl.message(
      'Laisser un avis',
      name: 'reviewWriteCta',
      desc: 'M07bis — entry point from a completed visit.',
      args: [],
    );
  }

  /// `Ton avis sur ce bien`
  String get reviewWriteTitle {
    return Intl.message(
      'Ton avis sur ce bien',
      name: 'reviewWriteTitle',
      desc: 'M07bis writing screen title.',
      args: [],
    );
  }

  /// `Publié sur la fiche du bien. Tu ne pourras plus le modifier.`
  String get reviewWriteSubtitle {
    return Intl.message(
      'Publié sur la fiche du bien. Tu ne pourras plus le modifier.',
      name: 'reviewWriteSubtitle',
      desc: 'RM-M07bis-03 + RM-M07bis-05, said before writing.',
      args: [],
    );
  }

  /// `Note globale`
  String get reviewRatingLabel {
    return Intl.message(
      'Note globale',
      name: 'reviewRatingLabel',
      desc: 'Required, 1-5.',
      args: [],
    );
  }

  /// `État général perçu`
  String get reviewConditionLabel {
    return Intl.message(
      'État général perçu',
      name: 'reviewConditionLabel',
      desc: 'Optional, 1-5.',
      args: [],
    );
  }

  /// `Ajouter`
  String get reviewAddPoint {
    return Intl.message(
      'Ajouter',
      name: 'reviewAddPoint',
      desc: 'Adds a pro/con to the list.',
      args: [],
    );
  }

  /// `Ex. quartier calme`
  String get reviewPointHint {
    return Intl.message(
      'Ex. quartier calme',
      name: 'reviewPointHint',
      desc: 'Placeholder for a pro/con.',
      args: [],
    );
  }

  /// `Commentaire`
  String get reviewCommentLabel {
    return Intl.message(
      'Commentaire',
      name: 'reviewCommentLabel',
      desc: 'Optional free text.',
      args: [],
    );
  }

  /// `Ce que tu as vu, ce qui t'a marqué.`
  String get reviewFreeTextHint {
    return Intl.message(
      'Ce que tu as vu, ce qui t\'a marqué.',
      name: 'reviewFreeTextHint',
      desc: 'Placeholder for the free text.',
      args: [],
    );
  }

  /// `Photos prises sur place`
  String get reviewPhotosLabel {
    return Intl.message(
      'Photos prises sur place',
      name: 'reviewPhotosLabel',
      desc: 'Optional, 0-10.',
      args: [],
    );
  }

  /// `10 photos maximum.`
  String get reviewPhotosLimit {
    return Intl.message(
      '10 photos maximum.',
      name: 'reviewPhotosLimit',
      desc: 'The cap from M07bis\'s content table.',
      args: [],
    );
  }

  /// `Publier mon avis`
  String get reviewPublish {
    return Intl.message(
      'Publier mon avis',
      name: 'reviewPublish',
      desc: 'Submit.',
      args: [],
    );
  }

  /// `Avis publié`
  String get reviewPublished {
    return Intl.message(
      'Avis publié',
      name: 'reviewPublished',
      desc: 'Success.',
      args: [],
    );
  }

  /// `Ton avis est publié et ne peut plus être modifié.`
  String get reviewLocked {
    return Intl.message(
      'Ton avis est publié et ne peut plus être modifié.',
      name: 'reviewLocked',
      desc: 'RM-M07bis-03.',
      args: [],
    );
  }

  /// `Tu as déjà donné ton avis sur cette visite.`
  String get reviewAlreadyWritten {
    return Intl.message(
      'Tu as déjà donné ton avis sur cette visite.',
      name: 'reviewAlreadyWritten',
      desc: 'RM-M07bis-01 — one report per visit.',
      args: [],
    );
  }

  /// `Une visite confirmée est nécessaire pour laisser un avis sur ce bien.`
  String get reviewNotAllowed {
    return Intl.message(
      'Une visite confirmée est nécessaire pour laisser un avis sur ce bien.',
      name: 'reviewNotAllowed',
      desc: 'CE-M07bis-01, verbatim from Doc 10.',
      args: [],
    );
  }

  /// `La note globale est obligatoire.`
  String get reviewRatingRequired {
    return Intl.message(
      'La note globale est obligatoire.',
      name: 'reviewRatingRequired',
      desc: 'Only `rating` is required.',
      args: [],
    );
  }

  /// `Choisis un visiteur et une heure.`
  String get visitBookSubtitle {
    return Intl.message(
      'Choisis un visiteur et une heure.',
      name: 'visitBookSubtitle',
      desc: 'Booking sheet subtitle.',
      args: [],
    );
  }

  /// `Contacter le prestataire`
  String get visitBookNoSlotAction {
    return Intl.message(
      'Contacter le prestataire',
      name: 'visitBookNoSlotAction',
      desc: 'CE-M07-01 — the way out of a full week.',
      args: [],
    );
  }

  /// `Les 7 prochains jours`
  String get visitBookWindow {
    return Intl.message(
      'Les 7 prochains jours',
      name: 'visitBookWindow',
      desc: 'The server publishes a 7-day window.',
      args: [],
    );
  }

  /// `Jour`
  String get visitBookDay {
    return Intl.message(
      'Jour',
      name: 'visitBookDay',
      desc: 'Day strip heading.',
      args: [],
    );
  }

  /// `Heure`
  String get visitBookHour {
    return Intl.message(
      'Heure',
      name: 'visitBookHour',
      desc: 'Time chips heading.',
      args: [],
    );
  }

  /// `Propose une date et une heure`
  String get visitProposeTitle {
    return Intl.message(
      'Propose une date et une heure',
      name: 'visitProposeTitle',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Le propriétaire fait lui-même la visite : propose un moment, il l'accepte ou le décline.`
  String get visitProposeHelp {
    return Intl.message(
      'Le propriétaire fait lui-même la visite : propose un moment, il l\'accepte ou le décline.',
      name: 'visitProposeHelp',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Choisir une date et une heure`
  String get visitProposePick {
    return Intl.message(
      'Choisir une date et une heure',
      name: 'visitProposePick',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Changer`
  String get visitProposeChange {
    return Intl.message(
      'Changer',
      name: 'visitProposeChange',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Au moins une heure à l'avance, au plus 60 jours.`
  String get visitProposeBounds {
    return Intl.message(
      'Au moins une heure à l\'avance, au plus 60 jours.',
      name: 'visitProposeBounds',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Envoyer la demande`
  String get visitProposeSend {
    return Intl.message(
      'Envoyer la demande',
      name: 'visitProposeSend',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Cette heure ne peut pas être proposée : au moins une heure à l'avance, au plus 60 jours.`
  String get visitTimeRejected {
    return Intl.message(
      'Cette heure ne peut pas être proposée : au moins une heure à l\'avance, au plus 60 jours.',
      name: 'visitTimeRejected',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Semaine précédente`
  String get visitWeekPrev {
    return Intl.message(
      'Semaine précédente',
      name: 'visitWeekPrev',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Semaine suivante`
  String get visitWeekNext {
    return Intl.message(
      'Semaine suivante',
      name: 'visitWeekNext',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Du {from} au {to}`
  String visitWeekRange(String from, String to) {
    return Intl.message(
      'Du $from au $to',
      name: 'visitWeekRange',
      desc: 'M07 §19/§21 booking.',
      args: [from, to],
    );
  }

  /// `Voir la semaine suivante`
  String get visitSeeNextWeek {
    return Intl.message(
      'Voir la semaine suivante',
      name: 'visitSeeNextWeek',
      desc: 'M07 §19/§21 booking.',
      args: [],
    );
  }

  /// `Aucune heure ce jour-là.`
  String get visitBookNoHour {
    return Intl.message(
      'Aucune heure ce jour-là.',
      name: 'visitBookNoHour',
      desc: 'A day in the strip with no free time.',
      args: [],
    );
  }

  /// `Détail de la visite`
  String get visitDetailTitle {
    return Intl.message(
      'Détail de la visite',
      name: 'visitDetailTitle',
      desc: 'M07 visit detail screen.',
      args: [],
    );
  }

  /// `Présence sur place`
  String get visitPresenceSection {
    return Intl.message(
      'Présence sur place',
      name: 'visitPresenceSection',
      desc: 'RM-M07-05 — the mutual confirmation block.',
      args: [],
    );
  }

  /// `Toi`
  String get visitPresenceYou {
    return Intl.message(
      'Toi',
      name: 'visitPresenceYou',
      desc: 'RM-M07-05 — the tenant\'s half.',
      args: [],
    );
  }

  /// `Le visiteur`
  String get visitPresenceVisitor {
    return Intl.message(
      'Le visiteur',
      name: 'visitPresenceVisitor',
      desc: 'RM-M07-05 — the visitor\'s half.',
      args: [],
    );
  }

  /// `Confirmé`
  String get visitPresenceConfirmed {
    return Intl.message(
      'Confirmé',
      name: 'visitPresenceConfirmed',
      desc: 'One half is in.',
      args: [],
    );
  }

  /// `Pas encore`
  String get visitPresencePending {
    return Intl.message(
      'Pas encore',
      name: 'visitPresencePending',
      desc: 'One half is missing.',
      args: [],
    );
  }

  /// `Il faut ta confirmation et celle du visiteur pour que la visite démarre.`
  String get visitPresenceExplainer {
    return Intl.message(
      'Il faut ta confirmation et celle du visiteur pour que la visite démarre.',
      name: 'visitPresenceExplainer',
      desc: 'RM-M07-05.',
      args: [],
    );
  }

  /// `Le visiteur doit encore confirmer ce créneau. Tu ne peux pas confirmer à sa place.`
  String get visitAwaitingVisitor {
    return Intl.message(
      'Le visiteur doit encore confirmer ce créneau. Tu ne peux pas confirmer à sa place.',
      name: 'visitAwaitingVisitor',
      desc: 'RM-M15-06 — the tenant cannot confirm for the visitor.',
      args: [],
    );
  }

  /// `Voir le bien`
  String get visitSeeListing {
    return Intl.message(
      'Voir le bien',
      name: 'visitSeeListing',
      desc: 'Open the listing from a visit.',
      args: [],
    );
  }

  /// `À venir`
  String get visitsFilterUpcoming {
    return Intl.message(
      'À venir',
      name: 'visitsFilterUpcoming',
      desc: 'My visits filter.',
      args: [],
    );
  }

  /// `Passées`
  String get visitsFilterPast {
    return Intl.message(
      'Passées',
      name: 'visitsFilterPast',
      desc: 'My visits filter.',
      args: [],
    );
  }

  /// `{count, plural, =0{Aucun bien} =1{1 bien} other{{count} biens}}`
  String searchResultCount(int count) {
    return Intl.plural(
      count,
      zero: 'Aucun bien',
      one: '1 bien',
      other: '$count biens',
      name: 'searchResultCount',
      desc: 'How many results are on screen, above the list.',
      args: [count],
    );
  }

  /// `Liste`
  String get searchViewList {
    return Intl.message(
      'Liste',
      name: 'searchViewList',
      desc: 'Toggle back to the result list (M04).',
      args: [],
    );
  }

  /// `Carte`
  String get searchViewMap {
    return Intl.message(
      'Carte',
      name: 'searchViewMap',
      desc: 'Toggle to the map view (M04).',
      args: [],
    );
  }

  /// `Positions approximatives à 200 m près.`
  String get searchMapApprox {
    return Intl.message(
      'Positions approximatives à 200 m près.',
      name: 'searchMapApprox',
      desc: 'RM-M04-06 — the map never shows an exact address.',
      args: [],
    );
  }

  /// `Carte indisponible`
  String get searchMapNoKeyTitle {
    return Intl.message(
      'Carte indisponible',
      name: 'searchMapNoKeyTitle',
      desc: 'No MapTiler key was provided at build time.',
      args: [],
    );
  }

  /// `Cette version a été compilée sans clé de cartographie. Les résultats restent consultables en liste.`
  String get searchMapNoKeyBody {
    return Intl.message(
      'Cette version a été compilée sans clé de cartographie. Les résultats restent consultables en liste.',
      name: 'searchMapNoKeyBody',
      desc: 'No MapTiler key — the list still works.',
      args: [],
    );
  }

  /// `Carte indisponible hors ligne`
  String get searchMapOfflineTitle {
    return Intl.message(
      'Carte indisponible hors ligne',
      name: 'searchMapOfflineTitle',
      desc: 'CE-M04-02 on the map — tiles are not cached.',
      args: [],
    );
  }

  /// `Le fond de carte a besoin d'une connexion. Tes derniers résultats restent consultables en liste.`
  String get searchMapOfflineBody {
    return Intl.message(
      'Le fond de carte a besoin d\'une connexion. Tes derniers résultats restent consultables en liste.',
      name: 'searchMapOfflineBody',
      desc: 'CE-M04-02 on the map.',
      args: [],
    );
  }

  /// `Aucun bien à placer`
  String get searchMapNoPositionTitle {
    return Intl.message(
      'Aucun bien à placer',
      name: 'searchMapNoPositionTitle',
      desc: 'No hit carries coordinates.',
      args: [],
    );
  }

  /// `Ces résultats n'ont pas de position renseignée. Ils restent consultables en liste.`
  String get searchMapNoPositionBody {
    return Intl.message(
      'Ces résultats n\'ont pas de position renseignée. Ils restent consultables en liste.',
      name: 'searchMapNoPositionBody',
      desc: 'No hit carries coordinates.',
      args: [],
    );
  }

  /// `Le fond de carte n'a pas pu être chargé`
  String get searchMapStyleFailedTitle {
    return Intl.message(
      'Le fond de carte n\'a pas pu être chargé',
      name: 'searchMapStyleFailedTitle',
      desc:
          'The style URL never loaded — usually a bad or missing MapTiler key.',
      args: [],
    );
  }

  /// `Vérifie la clé de cartographie de cette version. Les résultats restent consultables en liste.`
  String get searchMapStyleFailedBody {
    return Intl.message(
      'Vérifie la clé de cartographie de cette version. Les résultats restent consultables en liste.',
      name: 'searchMapStyleFailedBody',
      desc: 'The style URL never loaded.',
      args: [],
    );
  }

  /// `Loyer (FCFA)`
  String get searchRentRange {
    return Intl.message(
      'Loyer (FCFA)',
      name: 'searchRentRange',
      desc: 'Rent filter.',
      args: [],
    );
  }

  /// `Superficie (m²)`
  String get searchSurfaceRange {
    return Intl.message(
      'Superficie (m²)',
      name: 'searchSurfaceRange',
      desc: 'Surface filter.',
      args: [],
    );
  }

  /// `Nombre de pièces minimum`
  String get searchRoomsMin {
    return Intl.message(
      'Nombre de pièces minimum',
      name: 'searchRoomsMin',
      desc: 'roomsMin.',
      args: [],
    );
  }

  /// `Équipements`
  String get searchAmenities {
    return Intl.message(
      'Équipements',
      name: 'searchAmenities',
      desc: 'Doc 10 M04 — the amenities filter.',
      args: [],
    );
  }

  /// `Badges requis`
  String get searchBadges {
    return Intl.message(
      'Badges requis',
      name: 'searchBadges',
      desc: 'Doc 10 M04 — the required-badges filter.',
      args: [],
    );
  }

  /// `{count}+`
  String searchRoomsPlus(int count) {
    return Intl.message(
      '$count+',
      name: 'searchRoomsPlus',
      desc: '4+ rooms.',
      args: [count],
    );
  }

  /// `Min`
  String get searchMin {
    return Intl.message(
      'Min',
      name: 'searchMin',
      desc: 'Range field.',
      args: [],
    );
  }

  /// `Max`
  String get searchMax {
    return Intl.message(
      'Max',
      name: 'searchMax',
      desc: 'Range field.',
      args: [],
    );
  }

  /// `Peu importe`
  String get searchAny {
    return Intl.message(
      'Peu importe',
      name: 'searchAny',
      desc: 'The third state of a tri-state toggle.',
      args: [],
    );
  }

  /// `Disponible immédiatement`
  String get searchAvailableNow {
    return Intl.message(
      'Disponible immédiatement',
      name: 'searchAvailableNow',
      desc: 'availableNow.',
      args: [],
    );
  }

  /// `Résidence`
  String get searchResidenceBadge {
    return Intl.message(
      'Résidence',
      name: 'searchResidenceBadge',
      desc: 'A residence card, not a listing.',
      args: [],
    );
  }

  /// `À partir de {price}`
  String searchResidenceFrom(String price) {
    return Intl.message(
      'À partir de $price',
      name: 'searchResidenceFrom',
      desc: 'fromMonthlyRent.',
      args: [price],
    );
  }

  /// `{count, plural, one{1 unité disponible} other{{count} unités disponibles}}`
  String searchResidenceUnits(int count) {
    return Intl.plural(
      count,
      one: '1 unité disponible',
      other: '$count unités disponibles',
      name: 'searchResidenceUnits',
      desc: 'availableUnitCount.',
      args: [count],
    );
  }

  /// `Enregistrer`
  String get favoritesAdd {
    return Intl.message(
      'Enregistrer',
      name: 'favoritesAdd',
      desc: 'M06 — save a listing.',
      args: [],
    );
  }

  /// `Retirer des favoris`
  String get favoritesRemove {
    return Intl.message(
      'Retirer des favoris',
      name: 'favoritesRemove',
      desc: 'M06 — unsave.',
      args: [],
    );
  }

  /// `Crée un compte pour enregistrer`
  String get favoritesSignInTitle {
    return Intl.message(
      'Crée un compte pour enregistrer',
      name: 'favoritesSignInTitle',
      desc: 'RM-M04-05 — the wall is on the action.',
      args: [],
    );
  }

  /// `Tes favoris te suivent d'un appareil à l'autre.`
  String get favoritesSignInBody {
    return Intl.message(
      'Tes favoris te suivent d\'un appareil à l\'autre.',
      name: 'favoritesSignInBody',
      desc: 'Why an account.',
      args: [],
    );
  }

  /// `Aucun favori`
  String get favoritesEmptyTitle {
    return Intl.message(
      'Aucun favori',
      name: 'favoritesEmptyTitle',
      desc: 'Empty tab.',
      args: [],
    );
  }

  /// `Touche le cœur sur un bien pour le retrouver ici.`
  String get favoritesEmptyBody {
    return Intl.message(
      'Touche le cœur sur un bien pour le retrouver ici.',
      name: 'favoritesEmptyBody',
      desc: 'Empty tab.',
      args: [],
    );
  }

  /// `Tu as atteint 50 favoris. Retires-en un pour en ajouter un autre.`
  String get favoritesLimitReached {
    return Intl.message(
      'Tu as atteint 50 favoris. Retires-en un pour en ajouter un autre.',
      name: 'favoritesLimitReached',
      desc: 'RM-M06-02.',
      args: [],
    );
  }

  /// `Ce bien n'est plus disponible`
  String get favoritesUnavailable {
    return Intl.message(
      'Ce bien n\'est plus disponible',
      name: 'favoritesUnavailable',
      desc: 'FavoriResponse.available = false.',
      args: [],
    );
  }

  /// `Il restera ici 30 jours, puis disparaîtra.`
  String get favoritesUnavailableNote {
    return Intl.message(
      'Il restera ici 30 jours, puis disparaîtra.',
      name: 'favoritesUnavailableNote',
      desc: 'The 30-day grace.',
      args: [],
    );
  }

  /// `Détail du bien`
  String get listingTitle {
    return Intl.message(
      'Détail du bien',
      name: 'listingTitle',
      desc: 'M05 screen title.',
      args: [],
    );
  }

  /// `Ce bien n'est plus disponible`
  String get listingGoneTitle {
    return Intl.message(
      'Ce bien n\'est plus disponible',
      name: 'listingGoneTitle',
      desc: 'CE-M05-01.',
      args: [],
    );
  }

  /// `L'annonce a été retirée ou a expiré. Essaie une nouvelle recherche.`
  String get listingGoneBody {
    return Intl.message(
      'L\'annonce a été retirée ou a expiré. Essaie une nouvelle recherche.',
      name: 'listingGoneBody',
      desc: 'CE-M05-01.',
      args: [],
    );
  }

  /// `Fiche hors ligne — certaines actions sont indisponibles.`
  String get listingOfflineBanner {
    return Intl.message(
      'Fiche hors ligne — certaines actions sont indisponibles.',
      name: 'listingOfflineBanner',
      desc: 'Cached fiche: the verdicts are stale, so the actions stay off.',
      args: [],
    );
  }

  /// `Ce bien est réservé pour le moment.`
  String get listingReservedBanner {
    return Intl.message(
      'Ce bien est réservé pour le moment.',
      name: 'listingReservedBanner',
      desc: 'M05 §20 — the fiche is off the market.',
      args: [],
    );
  }

  /// `Ce bien est déjà loué.`
  String get listingRentedBanner {
    return Intl.message(
      'Ce bien est déjà loué.',
      name: 'listingRentedBanner',
      desc: 'M05 §20 — the fiche is off the market.',
      args: [],
    );
  }

  /// `Cette annonce n'est plus en ligne.`
  String get listingOffMarketBanner {
    return Intl.message(
      'Cette annonce n\'est plus en ligne.',
      name: 'listingOffMarketBanner',
      desc: 'M05 §20 — the fiche is off the market.',
      args: [],
    );
  }

  /// `Caractéristiques`
  String get listingCharacteristics {
    return Intl.message(
      'Caractéristiques',
      name: 'listingCharacteristics',
      desc: 'Fiche section.',
      args: [],
    );
  }

  /// `Équipements`
  String get listingAmenities {
    return Intl.message(
      'Équipements',
      name: 'listingAmenities',
      desc: 'Fiche section.',
      args: [],
    );
  }

  /// `Description`
  String get listingDescription {
    return Intl.message(
      'Description',
      name: 'listingDescription',
      desc: 'Fiche section.',
      args: [],
    );
  }

  /// `Le prestataire`
  String get listingProvider {
    return Intl.message(
      'Le prestataire',
      name: 'listingProvider',
      desc: 'Fiche section.',
      args: [],
    );
  }

  /// `Localisation approximative : l'adresse exacte n'est communiquée qu'au contrat signé.`
  String get listingLocationNote {
    return Intl.message(
      'Localisation approximative : l\'adresse exacte n\'est communiquée qu\'au contrat signé.',
      name: 'listingLocationNote',
      desc: 'RM-M05-02 / RM-M04-06.',
      args: [],
    );
  }

  /// `{count} photos`
  String listingPhotosCount(int count) {
    return Intl.message(
      '$count photos',
      name: 'listingPhotosCount',
      desc: 'Gallery entry.',
      args: [count],
    );
  }

  /// `Contacter`
  String get listingContact {
    return Intl.message(
      'Contacter',
      name: 'listingContact',
      desc: 'Fiche action.',
      args: [],
    );
  }

  /// `Planifier une visite`
  String get listingPlanVisit {
    return Intl.message(
      'Planifier une visite',
      name: 'listingPlanVisit',
      desc: 'RM-M05-07.',
      args: [],
    );
  }

  /// `Signaler`
  String get listingReport {
    return Intl.message(
      'Signaler',
      name: 'listingReport',
      desc: 'RM-M05-05.',
      args: [],
    );
  }

  /// `Signaler`
  String get reportTitle {
    return Intl.message(
      'Signaler',
      name: 'reportTitle',
      desc: 'M23 — the report sheet.',
      args: [],
    );
  }

  /// `Signaler cet avis`
  String get reportReviewTitle {
    return Intl.message(
      'Signaler cet avis',
      name: 'reportReviewTitle',
      desc: 'M23 RM-M27-06 — reporting a review.',
      args: [],
    );
  }

  /// `Pourquoi ?`
  String get reportReasonLabel {
    return Intl.message(
      'Pourquoi ?',
      name: 'reportReasonLabel',
      desc: 'M23 RM-M23-01 — the reason is required.',
      args: [],
    );
  }

  /// `Précisions (facultatif)`
  String get reportCommentLabel {
    return Intl.message(
      'Précisions (facultatif)',
      name: 'reportCommentLabel',
      desc: 'M23 — optional free text.',
      args: [],
    );
  }

  /// `Ce que l'admin doit savoir.`
  String get reportCommentHint {
    return Intl.message(
      'Ce que l\'admin doit savoir.',
      name: 'reportCommentHint',
      desc: 'M23 — the comment field.',
      args: [],
    );
  }

  /// `Envoyer le signalement`
  String get reportSend {
    return Intl.message(
      'Envoyer le signalement',
      name: 'reportSend',
      desc: 'M23 — submits the report.',
      args: [],
    );
  }

  /// `Ton signalement a été pris en compte.`
  String get reportSent {
    return Intl.message(
      'Ton signalement a été pris en compte.',
      name: 'reportSent',
      desc: 'M23 RM-M23-05, verbatim — received, and no outcome is ever given.',
      args: [],
    );
  }

  /// `Le signalement n'est pas parti. Réessaie.`
  String get reportFailed {
    return Intl.message(
      'Le signalement n\'est pas parti. Réessaie.',
      name: 'reportFailed',
      desc: 'M23 — the request failed.',
      args: [],
    );
  }

  /// `Connecte-toi pour signaler un contenu.`
  String get reportSignInBody {
    return Intl.message(
      'Connecte-toi pour signaler un contenu.',
      name: 'reportSignInBody',
      desc: 'M23 — reporting needs an account.',
      args: [],
    );
  }

  /// `Annonce frauduleuse`
  String get reportReasonFraud {
    return Intl.message(
      'Annonce frauduleuse',
      name: 'reportReasonFraud',
      desc: 'M23 — FRAUDULENT_LISTING.',
      args: [],
    );
  }

  /// `Prix anormal`
  String get reportReasonPrice {
    return Intl.message(
      'Prix anormal',
      name: 'reportReasonPrice',
      desc: 'M23 — ABNORMAL_PRICE.',
      args: [],
    );
  }

  /// `Contenu inapproprié`
  String get reportReasonContent {
    return Intl.message(
      'Contenu inapproprié',
      name: 'reportReasonContent',
      desc: 'M23 — INAPPROPRIATE_CONTENT.',
      args: [],
    );
  }

  /// `Harcèlement`
  String get reportReasonHarassment {
    return Intl.message(
      'Harcèlement',
      name: 'reportReasonHarassment',
      desc: 'M23 — HARASSMENT.',
      args: [],
    );
  }

  /// `Connecte-toi pour contacter le prestataire ou planifier une visite.`
  String get listingActionsSignIn {
    return Intl.message(
      'Connecte-toi pour contacter le prestataire ou planifier une visite.',
      name: 'listingActionsSignIn',
      desc: 'RM-M04-05 / CA-M05-04.',
      args: [],
    );
  }

  /// `Ce bien n'accepte pas encore de visites.`
  String get listingNoVisitor {
    return Intl.message(
      'Ce bien n\'accepte pas encore de visites.',
      name: 'listingNoVisitor',
      desc: 'RM-M05-07 — no bookable visitor.',
      args: [],
    );
  }

  /// `Avis sur le bien`
  String get listingReviewsTitle {
    return Intl.message(
      'Avis sur le bien',
      name: 'listingReviewsTitle',
      desc: 'RM-M05-08.',
      args: [],
    );
  }

  /// `{average} · {count} avis`
  String listingRatingSummary(int count, String average) {
    return Intl.message(
      '$average · $count avis',
      name: 'listingRatingSummary',
      desc: 'Rating block.',
      args: [count, average],
    );
  }

  /// `Visite`
  String get listingReviewVisit {
    return Intl.message(
      'Visite',
      name: 'listingReviewVisit',
      desc: 'ReviewKind.visit.',
      args: [],
    );
  }

  /// `Locataire`
  String get listingReviewResident {
    return Intl.message(
      'Locataire',
      name: 'listingReviewResident',
      desc: 'ReviewKind.resident.',
      args: [],
    );
  }

  /// `{count} mois sur place`
  String listingReviewMonths(int count) {
    return Intl.message(
      '$count mois sur place',
      name: 'listingReviewMonths',
      desc: 'residenceMonths.',
      args: [count],
    );
  }

  /// `{count, plural, one{{count} jour sur place} other{{count} jours sur place}}`
  String residenceStayDay(int count) {
    return Intl.plural(
      count,
      one: '$count jour sur place',
      other: '$count jours sur place',
      name: 'residenceStayDay',
      desc: 'M27 RM-M27-02 — residence duration in days.',
      args: [count],
    );
  }

  /// `{count, plural, one{{count} semaine sur place} other{{count} semaines sur place}}`
  String residenceStayWeek(int count) {
    return Intl.plural(
      count,
      one: '$count semaine sur place',
      other: '$count semaines sur place',
      name: 'residenceStayWeek',
      desc: 'M27 RM-M27-02 — residence duration in weeks.',
      args: [count],
    );
  }

  /// `{count, plural, one{{count} mois sur place} other{{count} mois sur place}}`
  String residenceStayMonth(int count) {
    return Intl.plural(
      count,
      one: '$count mois sur place',
      other: '$count mois sur place',
      name: 'residenceStayMonth',
      desc: 'M27 RM-M27-02 — residence duration in months.',
      args: [count],
    );
  }

  /// `{count, plural, one{{count} trimestre sur place} other{{count} trimestres sur place}}`
  String residenceStayQuarter(int count) {
    return Intl.plural(
      count,
      one: '$count trimestre sur place',
      other: '$count trimestres sur place',
      name: 'residenceStayQuarter',
      desc: 'M27 RM-M27-02 — residence duration in quarters.',
      args: [count],
    );
  }

  /// `{count, plural, one{{count} an sur place} other{{count} ans sur place}}`
  String residenceStayYear(int count) {
    return Intl.plural(
      count,
      one: '$count an sur place',
      other: '$count ans sur place',
      name: 'residenceStayYear',
      desc: 'M27 RM-M27-02 — residence duration in years.',
      args: [count],
    );
  }

  /// `Corrigé le {date}`
  String listingReviewEdited(String date) {
    return Intl.message(
      'Corrigé le $date',
      name: 'listingReviewEdited',
      desc: 'RM-M27-02.',
      args: [date],
    );
  }

  /// `Prestataire de confiance`
  String get badgeTrustedProvider {
    return Intl.message(
      'Prestataire de confiance',
      name: 'badgeTrustedProvider',
      desc: '🏆',
      args: [],
    );
  }

  /// `Recertifié`
  String get badgeRecertified {
    return Intl.message(
      'Recertifié',
      name: 'badgeRecertified',
      desc: '🔄',
      args: [],
    );
  }

  /// `Identité vérifiée`
  String get badgeVerifiedIdentity {
    return Intl.message(
      'Identité vérifiée',
      name: 'badgeVerifiedIdentity',
      desc: '✅',
      args: [],
    );
  }

  /// `Photos vérifiées`
  String get badgeVerifiedPhotos {
    return Intl.message(
      'Photos vérifiées',
      name: 'badgeVerifiedPhotos',
      desc: '📸',
      args: [],
    );
  }

  /// `Détail de la résidence`
  String get residenceTitle {
    return Intl.message(
      'Détail de la résidence',
      name: 'residenceTitle',
      desc: 'Residence fiche.',
      args: [],
    );
  }

  /// `{count, plural, one{1 unité disponible} other{{count} unités disponibles}}`
  String residenceUnitsAvailable(int count) {
    return Intl.plural(
      count,
      one: '1 unité disponible',
      other: '$count unités disponibles',
      name: 'residenceUnitsAvailable',
      desc: 'Residence units.',
      args: [count],
    );
  }

  /// `Particulier`
  String get prestataireKindParticulier {
    return Intl.message(
      'Particulier',
      name: 'prestataireKindParticulier',
      desc: 'ProviderCard.type.',
      args: [],
    );
  }

  /// `Agence`
  String get prestataireKindAgence {
    return Intl.message(
      'Agence',
      name: 'prestataireKindAgence',
      desc: 'ProviderCard.type.',
      args: [],
    );
  }

  /// `Promoteur`
  String get prestataireKindPromoteur {
    return Intl.message(
      'Promoteur',
      name: 'prestataireKindPromoteur',
      desc: 'ProviderCard.type.',
      args: [],
    );
  }

  /// `Messages`
  String get messagingTitle {
    return Intl.message(
      'Messages',
      name: 'messagingTitle',
      desc: 'M12 screen title.',
      args: [],
    );
  }

  /// `Aucune conversation`
  String get messagingEmptyTitle {
    return Intl.message(
      'Aucune conversation',
      name: 'messagingEmptyTitle',
      desc: 'Empty list.',
      args: [],
    );
  }

  /// `Contacte un prestataire depuis la fiche d'un bien pour démarrer une conversation.`
  String get messagingEmptyTenant {
    return Intl.message(
      'Contacte un prestataire depuis la fiche d\'un bien pour démarrer une conversation.',
      name: 'messagingEmptyTenant',
      desc: 'RM-M12-01 — the tenant has the first word.',
      args: [],
    );
  }

  /// `Les locataires t'écriront depuis tes annonces. Tu ne peux pas ouvrir une conversation.`
  String get messagingEmptyProvider {
    return Intl.message(
      'Les locataires t\'écriront depuis tes annonces. Tu ne peux pas ouvrir une conversation.',
      name: 'messagingEmptyProvider',
      desc: 'RM-M12-01 — the provider cannot write first.',
      args: [],
    );
  }

  /// `Écrire un message…`
  String get messagingHint {
    return Intl.message(
      'Écrire un message…',
      name: 'messagingHint',
      desc: 'Composer placeholder.',
      args: [],
    );
  }

  /// `Envoyer`
  String get messagingSend {
    return Intl.message(
      'Envoyer',
      name: 'messagingSend',
      desc: 'Composer action.',
      args: [],
    );
  }

  /// `Joindre une image`
  String get messagingAttach {
    return Intl.message(
      'Joindre une image',
      name: 'messagingAttach',
      desc: 'RM-M12-04.',
      args: [],
    );
  }

  /// `Image`
  String get messagingAttachment {
    return Intl.message(
      'Image',
      name: 'messagingAttachment',
      desc: 'An attached image chip.',
      args: [],
    );
  }

  /// `3 images maximum par message.`
  String get messagingAttachmentsMax {
    return Intl.message(
      '3 images maximum par message.',
      name: 'messagingAttachmentsMax',
      desc: 'RM-M12-04.',
      args: [],
    );
  }

  /// `En attente de réseau`
  String get messagingPending {
    return Intl.message(
      'En attente de réseau',
      name: 'messagingPending',
      desc: 'CE-M12-01 — queued, not lost.',
      args: [],
    );
  }

  /// `Non envoyé`
  String get messagingFailed {
    return Intl.message(
      'Non envoyé',
      name: 'messagingFailed',
      desc: 'A queued message that keeps failing.',
      args: [],
    );
  }

  /// `Cette annonce n'est plus disponible. La conversation reste consultable.`
  String get messagingReadOnly {
    return Intl.message(
      'Cette annonce n\'est plus disponible. La conversation reste consultable.',
      name: 'messagingReadOnly',
      desc: 'CE-M12-02.',
      args: [],
    );
  }

  /// `Message envoyé au prestataire`
  String get messagingContactSent {
    return Intl.message(
      'Message envoyé au prestataire',
      name: 'messagingContactSent',
      desc: 'Toast after starting a thread from a fiche.',
      args: [],
    );
  }

  /// `Réessayer`
  String get commonRetry {
    return Intl.message('Réessayer', name: 'commonRetry', desc: '', args: []);
  }

  /// `Ça n'a pas marché. Réessaie.`
  String get commonError {
    return Intl.message(
      'Ça n\'a pas marché. Réessaie.',
      name: 'commonError',
      desc: '',
      args: [],
    );
  }

  /// `Oups`
  String get commonErrorTitle {
    return Intl.message('Oups', name: 'commonErrorTitle', desc: '', args: []);
  }

  /// `Ou`
  String get commonOr {
    return Intl.message('Ou', name: 'commonOr', desc: '', args: []);
  }

  /// `Prendre une photo`
  String get mediaTakePhoto {
    return Intl.message(
      'Prendre une photo',
      name: 'mediaTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Importer`
  String get mediaImport {
    return Intl.message('Importer', name: 'mediaImport', desc: '', args: []);
  }

  /// `Photo mise à jour`
  String get profilePhotoUpdated {
    return Intl.message(
      'Photo mise à jour',
      name: 'profilePhotoUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Choisir une ville`
  String get cityPickerTitle {
    return Intl.message(
      'Choisir une ville',
      name: 'cityPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rechercher une ville`
  String get cityPickerSearchHint {
    return Intl.message(
      'Rechercher une ville',
      name: 'cityPickerSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Aucune ville trouvée`
  String get cityPickerEmpty {
    return Intl.message(
      'Aucune ville trouvée',
      name: 'cityPickerEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Un instant…`
  String get loadingDialog_content {
    return Intl.message(
      'Un instant…',
      name: 'loadingDialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Inscription`
  String get welcome_inscriptionButton {
    return Intl.message(
      'Inscription',
      name: 'welcome_inscriptionButton',
      desc: '',
      args: [],
    );
  }

  /// `Connexion`
  String get welcome_loginButton {
    return Intl.message(
      'Connexion',
      name: 'welcome_loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get loginTitle {
    return Intl.message('Se connecter', name: 'loginTitle', desc: '', args: []);
  }

  /// `Créer un compte`
  String get registerTitle {
    return Intl.message(
      'Créer un compte',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entre ton numéro de téléphone`
  String get loginEnterPhone {
    return Intl.message(
      'Entre ton numéro de téléphone',
      name: 'loginEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone`
  String get loginPhoneLabel {
    return Intl.message(
      'Téléphone',
      name: 'loginPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `+237 6XX XX XX XX`
  String get loginPhoneHint {
    return Intl.message(
      '+237 6XX XX XX XX',
      name: 'loginPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `6 XX XX XX XX`
  String get loginPhoneHintLocal {
    return Intl.message(
      '6 XX XX XX XX',
      name: 'loginPhoneHintLocal',
      desc: '',
      args: [],
    );
  }

  /// `Numéro invalide`
  String get loginPhoneInvalid {
    return Intl.message(
      'Numéro invalide',
      name: 'loginPhoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Recevoir le code`
  String get loginRequestCode {
    return Intl.message(
      'Recevoir le code',
      name: 'loginRequestCode',
      desc: '',
      args: [],
    );
  }

  /// `Impossible d’envoyer le code. Réessaie.`
  String get loginOtpSendError {
    return Intl.message(
      'Impossible d’envoyer le code. Réessaie.',
      name: 'loginOtpSendError',
      desc: '',
      args: [],
    );
  }

  /// `Continuer avec Google`
  String get loginContinueWithGoogle {
    return Intl.message(
      'Continuer avec Google',
      name: 'loginContinueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continuer avec Apple`
  String get loginContinueWithApple {
    return Intl.message(
      'Continuer avec Apple',
      name: 'loginContinueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Tu n’as pas de compte ?`
  String get loginNoAccountQuestion {
    return Intl.message(
      'Tu n’as pas de compte ?',
      name: 'loginNoAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Inscris-toi`
  String get loginSignUpAction {
    return Intl.message(
      'Inscris-toi',
      name: 'loginSignUpAction',
      desc: '',
      args: [],
    );
  }

  /// `Tu as déjà un compte ?`
  String get registerHaveAccountQuestion {
    return Intl.message(
      'Tu as déjà un compte ?',
      name: 'registerHaveAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Connecte-toi`
  String get registerSignInAction {
    return Intl.message(
      'Connecte-toi',
      name: 'registerSignInAction',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get authEmailLabel {
    return Intl.message('E-mail', name: 'authEmailLabel', desc: '', args: []);
  }

  /// `nom@exemple.com`
  String get authEmailHint {
    return Intl.message(
      'nom@exemple.com',
      name: 'authEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `E-mail invalide`
  String get authEmailInvalid {
    return Intl.message(
      'E-mail invalide',
      name: 'authEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get authPasswordLabel {
    return Intl.message(
      'Mot de passe',
      name: 'authPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ton mot de passe`
  String get authPasswordHint {
    return Intl.message(
      'Ton mot de passe',
      name: 'authPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe requis`
  String get authPasswordRequired {
    return Intl.message(
      'Mot de passe requis',
      name: 'authPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get authLoginButton {
    return Intl.message(
      'Se connecter',
      name: 'authLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `E-mail ou mot de passe incorrect.`
  String get authLoginInvalidCredentials {
    return Intl.message(
      'E-mail ou mot de passe incorrect.',
      name: 'authLoginInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Un nouveau code a été envoyé.`
  String get authOtpResent {
    return Intl.message(
      'Un nouveau code a été envoyé.',
      name: 'authOtpResent',
      desc: '',
      args: [],
    );
  }

  /// `Se déconnecter`
  String get authLogout {
    return Intl.message(
      'Se déconnecter',
      name: 'authLogout',
      desc: '',
      args: [],
    );
  }

  /// `Je suis`
  String get registerRoleLabel {
    return Intl.message(
      'Je suis',
      name: 'registerRoleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Prestataire`
  String get registerRolePrestataire {
    return Intl.message(
      'Prestataire',
      name: 'registerRolePrestataire',
      desc: '',
      args: [],
    );
  }

  /// `Agent`
  String get registerRoleAgent {
    return Intl.message('Agent', name: 'registerRoleAgent', desc: '', args: []);
  }

  /// `S’inscrire`
  String get registerButton {
    return Intl.message(
      'S’inscrire',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Inscription impossible. Vérifie tes informations.`
  String get registerFailed {
    return Intl.message(
      'Inscription impossible. Vérifie tes informations.',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Bientôt disponible`
  String get commonComingSoon {
    return Intl.message(
      'Bientôt disponible',
      name: 'commonComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get settingsTitle {
    return Intl.message('Profil', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Profil`
  String get settingsProfileCard {
    return Intl.message(
      'Profil',
      name: 'settingsProfileCard',
      desc: '',
      args: [],
    );
  }

  /// `Certifications`
  String get settingsCertificationsTitle {
    return Intl.message(
      'Certifications',
      name: 'settingsCertificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pièces d’identifications et tout autres vérifications requises`
  String get settingsCertificationsBody {
    return Intl.message(
      'Pièces d’identifications et tout autres vérifications requises',
      name: 'settingsCertificationsBody',
      desc: '',
      args: [],
    );
  }

  /// `Changer de mot passe`
  String get settingsChangePassword {
    return Intl.message(
      'Changer de mot passe',
      name: 'settingsChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Déconnexion`
  String get settingsLogout {
    return Intl.message(
      'Déconnexion',
      name: 'settingsLogout',
      desc: '',
      args: [],
    );
  }

  /// `Paramètres`
  String get settingsMenuTitle {
    return Intl.message(
      'Paramètres',
      name: 'settingsMenuTitle',
      desc: '',
      args: [],
    );
  }

  /// `Langue`
  String get settingsLanguage {
    return Intl.message('Langue', name: 'settingsLanguage', desc: '', args: []);
  }

  /// `Français`
  String get languageFrench {
    return Intl.message('Français', name: 'languageFrench', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `Changer de numéro`
  String get settingsChangePhone {
    return Intl.message(
      'Changer de numéro',
      name: 'settingsChangePhone',
      desc: '',
      args: [],
    );
  }

  /// `Code reçu sur l’ancien numéro`
  String get changePhoneOldCodeLabel {
    return Intl.message(
      'Code reçu sur l’ancien numéro',
      name: 'changePhoneOldCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Code reçu sur {phone}`
  String changePhoneNewCodeLabel(String phone) {
    return Intl.message(
      'Code reçu sur $phone',
      name: 'changePhoneNewCodeLabel',
      desc: '',
      args: [phone],
    );
  }

  /// `Confirmer le changement`
  String get changePhoneConfirm {
    return Intl.message(
      'Confirmer le changement',
      name: 'changePhoneConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Numéro mis à jour`
  String get changePhoneSuccess {
    return Intl.message(
      'Numéro mis à jour',
      name: 'changePhoneSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe actuel`
  String get changePasswordCurrent {
    return Intl.message(
      'Mot de passe actuel',
      name: 'changePasswordCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Nouveau mot de passe`
  String get changePasswordNew {
    return Intl.message(
      'Nouveau mot de passe',
      name: 'changePasswordNew',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer le nouveau mot de passe`
  String get changePasswordConfirm {
    return Intl.message(
      'Confirmer le nouveau mot de passe',
      name: 'changePasswordConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Les mots de passe ne correspondent pas`
  String get changePasswordMismatch {
    return Intl.message(
      'Les mots de passe ne correspondent pas',
      name: 'changePasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Mettre à jour`
  String get changePasswordButton {
    return Intl.message(
      'Mettre à jour',
      name: 'changePasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe mis à jour`
  String get changePasswordSuccess {
    return Intl.message(
      'Mot de passe mis à jour',
      name: 'changePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de changer le mot de passe. Vérifie ton mot de passe actuel.`
  String get changePasswordError {
    return Intl.message(
      'Impossible de changer le mot de passe. Vérifie ton mot de passe actuel.',
      name: 'changePasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer mon compte`
  String get deleteAccountLink {
    return Intl.message(
      'Supprimer mon compte',
      name: 'deleteAccountLink',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer le compte`
  String get deleteAccountTitle {
    return Intl.message(
      'Supprimer le compte',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette action est définitive. Tes données personnelles seront supprimées et tu perdras l’accès à ton compte.`
  String get deleteAccountWarning {
    return Intl.message(
      'Cette action est définitive. Tes données personnelles seront supprimées et tu perdras l’accès à ton compte.',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `SUPPRIMER`
  String get deleteAccountConfirmWord {
    return Intl.message(
      'SUPPRIMER',
      name: 'deleteAccountConfirmWord',
      desc: '',
      args: [],
    );
  }

  /// `Tape « {word} » pour confirmer`
  String deleteAccountConfirmLabel(String word) {
    return Intl.message(
      'Tape « $word » pour confirmer',
      name: 'deleteAccountConfirmLabel',
      desc: '',
      args: [word],
    );
  }

  /// `Supprimer définitivement`
  String get deleteAccountButton {
    return Intl.message(
      'Supprimer définitivement',
      name: 'deleteAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Editer le Profil`
  String get editProfileTitle {
    return Intl.message(
      'Editer le Profil',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Prénom`
  String get profileFirstName {
    return Intl.message('Prénom', name: 'profileFirstName', desc: '', args: []);
  }

  /// `Nom`
  String get profileLastName {
    return Intl.message('Nom', name: 'profileLastName', desc: '', args: []);
  }

  /// `Localisation`
  String get profileLocation {
    return Intl.message(
      'Localisation',
      name: 'profileLocation',
      desc: '',
      args: [],
    );
  }

  /// `Nom affiché`
  String get profileDisplayName {
    return Intl.message(
      'Nom affiché',
      name: 'profileDisplayName',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get profileType {
    return Intl.message('Type', name: 'profileType', desc: '', args: []);
  }

  /// `Particulier`
  String get profileTypeParticulier {
    return Intl.message(
      'Particulier',
      name: 'profileTypeParticulier',
      desc: '',
      args: [],
    );
  }

  /// `Agence`
  String get profileTypeAgence {
    return Intl.message(
      'Agence',
      name: 'profileTypeAgence',
      desc: '',
      args: [],
    );
  }

  /// `Promoteur`
  String get profileTypePromoteur {
    return Intl.message(
      'Promoteur',
      name: 'profileTypePromoteur',
      desc: '',
      args: [],
    );
  }

  /// `Ville principale`
  String get profileMainCity {
    return Intl.message(
      'Ville principale',
      name: 'profileMainCity',
      desc: '',
      args: [],
    );
  }

  /// `Identité`
  String get profileSectionIdentity {
    return Intl.message(
      'Identité',
      name: 'profileSectionIdentity',
      desc: 'Edit form — the person.',
      args: [],
    );
  }

  /// `Activité`
  String get profileSectionBusiness {
    return Intl.message(
      'Activité',
      name: 'profileSectionBusiness',
      desc: 'Edit form — the business (prestataire only).',
      args: [],
    );
  }

  /// `N° CNI ou RCCM`
  String get profileRegistrationNumber {
    return Intl.message(
      'N° CNI ou RCCM',
      name: 'profileRegistrationNumber',
      desc: 'PrestataireProfileResponse.registrationNumber.',
      args: [],
    );
  }

  /// `Ex. RC/DLA/2024/B/1234`
  String get profileRegistrationNumberHint {
    return Intl.message(
      'Ex. RC/DLA/2024/B/1234',
      name: 'profileRegistrationNumberHint',
      desc: 'Placeholder.',
      args: [],
    );
  }

  /// `Figure sur le Contrat Mboa, à côté de la pièce d'identité du locataire.`
  String get profileRegistrationNumberHelp {
    return Intl.message(
      'Figure sur le Contrat Mboa, à côté de la pièce d\'identité du locataire.',
      name: 'profileRegistrationNumberHelp',
      desc: 'M08 — why it is asked.',
      args: [],
    );
  }

  /// `Profil incomplet`
  String get profileIncompleteTitle {
    return Intl.message(
      'Profil incomplet',
      name: 'profileIncompleteTitle',
      desc: 'RM-M10-01 — publishing is blocked until it is complete.',
      args: [],
    );
  }

  /// `Complète ton profil pour publier tes biens.`
  String get profileIncompleteBody {
    return Intl.message(
      'Complète ton profil pour publier tes biens.',
      name: 'profileIncompleteBody',
      desc: 'RM-M10-01.',
      args: [],
    );
  }

  /// `Compléter`
  String get profileIncompleteAction {
    return Intl.message(
      'Compléter',
      name: 'profileIncompleteAction',
      desc: 'CTA to the edit form.',
      args: [],
    );
  }

  /// `Mon activité`
  String get profileBusinessTitle {
    return Intl.message(
      'Mon activité',
      name: 'profileBusinessTitle',
      desc: 'Hub card — the business identity.',
      args: [],
    );
  }

  /// `À renseigner`
  String get profileBusinessMissing {
    return Intl.message(
      'À renseigner',
      name: 'profileBusinessMissing',
      desc: 'A business field the profile does not carry yet.',
      args: [],
    );
  }

  /// `Enregistrer`
  String get profileSave {
    return Intl.message('Enregistrer', name: 'profileSave', desc: '', args: []);
  }

  /// `Profil mis à jour`
  String get profileSaved {
    return Intl.message(
      'Profil mis à jour',
      name: 'profileSaved',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de charger le profil.`
  String get profileLoadError {
    return Intl.message(
      'Impossible de charger le profil.',
      name: 'profileLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Statut`
  String get kycTabStatut {
    return Intl.message('Statut', name: 'kycTabStatut', desc: '', args: []);
  }

  /// `Identification`
  String get kycTabIdentification {
    return Intl.message(
      'Identification',
      name: 'kycTabIdentification',
      desc: '',
      args: [],
    );
  }

  /// `Selfie`
  String get kycItemSelfie {
    return Intl.message('Selfie', name: 'kycItemSelfie', desc: '', args: []);
  }

  /// `Pièce d'identité`
  String get kycItemIdDocument {
    return Intl.message(
      'Pièce d\'identité',
      name: 'kycItemIdDocument',
      desc: '',
      args: [],
    );
  }

  /// `NUI`
  String get kycItemNui {
    return Intl.message('NUI', name: 'kycItemNui', desc: '', args: []);
  }

  /// `Adresse`
  String get kycItemAddress {
    return Intl.message('Adresse', name: 'kycItemAddress', desc: '', args: []);
  }

  /// `Compte Standard`
  String get kycAccountStandard {
    return Intl.message(
      'Compte Standard',
      name: 'kycAccountStandard',
      desc: '',
      args: [],
    );
  }

  /// `Compte Prestataire`
  String get kycAccountPrestataire {
    return Intl.message(
      'Compte Prestataire',
      name: 'kycAccountPrestataire',
      desc: '',
      args: [],
    );
  }

  /// `Compte Agent`
  String get kycAccountAgent {
    return Intl.message(
      'Compte Agent',
      name: 'kycAccountAgent',
      desc: '',
      args: [],
    );
  }

  /// `Informations requises`
  String get kycStatusNotSubmitted {
    return Intl.message(
      'Informations requises',
      name: 'kycStatusNotSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Informations en attente`
  String get kycStatusPending {
    return Intl.message(
      'Informations en attente',
      name: 'kycStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Vérifié`
  String get kycStatusApproved {
    return Intl.message(
      'Vérifié',
      name: 'kycStatusApproved',
      desc: '',
      args: [],
    );
  }

  /// `Refusé`
  String get kycStatusRejected {
    return Intl.message(
      'Refusé',
      name: 'kycStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Motif : {reason}`
  String kycRejectionReason(String reason) {
    return Intl.message(
      'Motif : $reason',
      name: 'kycRejectionReason',
      desc: '',
      args: [reason],
    );
  }

  /// `Ajouté`
  String get kycAdded {
    return Intl.message('Ajouté', name: 'kycAdded', desc: '', args: []);
  }

  /// `Soumettre`
  String get kycSubmit {
    return Intl.message('Soumettre', name: 'kycSubmit', desc: '', args: []);
  }

  /// `Documents soumis`
  String get kycSubmitted {
    return Intl.message(
      'Documents soumis',
      name: 'kycSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Échec de l’envoi. Réessaie.`
  String get kycUploadError {
    return Intl.message(
      'Échec de l’envoi. Réessaie.',
      name: 'kycUploadError',
      desc: '',
      args: [],
    );
  }

  /// `Prendre une photo`
  String get kycTakePhoto {
    return Intl.message(
      'Prendre une photo',
      name: 'kycTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Importer`
  String get kycImport {
    return Intl.message('Importer', name: 'kycImport', desc: '', args: []);
  }

  /// `Choisis le document avec lequel tu veux vérifier ton identité`
  String get kycIdDocumentPrompt {
    return Intl.message(
      'Choisis le document avec lequel tu veux vérifier ton identité',
      name: 'kycIdDocumentPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Carte d’identité`
  String get kycDocCni {
    return Intl.message(
      'Carte d’identité',
      name: 'kycDocCni',
      desc: '',
      args: [],
    );
  }

  /// `Recépissé`
  String get kycDocRecepisse {
    return Intl.message(
      'Recépissé',
      name: 'kycDocRecepisse',
      desc: '',
      args: [],
    );
  }

  /// `Passeport`
  String get kycDocPassport {
    return Intl.message(
      'Passeport',
      name: 'kycDocPassport',
      desc: '',
      args: [],
    );
  }

  /// `Permis de residence`
  String get kycDocResidence {
    return Intl.message(
      'Permis de residence',
      name: 'kycDocResidence',
      desc: '',
      args: [],
    );
  }

  /// `Recto`
  String get kycRecto {
    return Intl.message('Recto', name: 'kycRecto', desc: '', args: []);
  }

  /// `Verso`
  String get kycVerso {
    return Intl.message('Verso', name: 'kycVerso', desc: '', args: []);
  }

  /// `Terminé`
  String get kycDone {
    return Intl.message('Terminé', name: 'kycDone', desc: '', args: []);
  }

  /// `Vérification`
  String get otpTitle {
    return Intl.message('Vérification', name: 'otpTitle', desc: '', args: []);
  }

  /// `Code envoyé au {phone}`
  String otpCodeSentTo(String phone) {
    return Intl.message(
      'Code envoyé au $phone',
      name: 'otpCodeSentTo',
      desc: '',
      args: [phone],
    );
  }

  /// `Code à 6 chiffres`
  String get otpCodeLabel {
    return Intl.message(
      'Code à 6 chiffres',
      name: 'otpCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Valider`
  String get otpValidate {
    return Intl.message('Valider', name: 'otpValidate', desc: '', args: []);
  }

  /// `Code invalide. Réessaie.`
  String get otpInvalidCode {
    return Intl.message(
      'Code invalide. Réessaie.',
      name: 'otpInvalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Tu n’as pas reçu le code ?`
  String get otpNoCodeQuestion {
    return Intl.message(
      'Tu n’as pas reçu le code ?',
      name: 'otpNoCodeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Renvoyer le code`
  String get otpResend {
    return Intl.message(
      'Renvoyer le code',
      name: 'otpResend',
      desc: '',
      args: [],
    );
  }

  /// `Renvoyer dans {seconds}s`
  String otpResendIn(int seconds) {
    return Intl.message(
      'Renvoyer dans ${seconds}s',
      name: 'otpResendIn',
      desc: '',
      args: [seconds],
    );
  }

  /// `Bienvenue sur Mboa 👋`
  String get homeUserWelcome {
    return Intl.message(
      'Bienvenue sur Mboa 👋',
      name: 'homeUserWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Bienvenue sur Mboa Pro 👋`
  String get homeProWelcome {
    return Intl.message(
      'Bienvenue sur Mboa Pro 👋',
      name: 'homeProWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Accueil`
  String get navHome {
    return Intl.message('Accueil', name: 'navHome', desc: '', args: []);
  }

  /// `Gestionnaire`
  String get navManager {
    return Intl.message('Gestionnaire', name: 'navManager', desc: '', args: []);
  }

  /// `Finance`
  String get navFinance {
    return Intl.message('Finance', name: 'navFinance', desc: '', args: []);
  }

  /// `Menu`
  String get navMenu {
    return Intl.message('Menu', name: 'navMenu', desc: '', args: []);
  }

  /// `Salut, `
  String get menuGreeting {
    return Intl.message('Salut, ', name: 'menuGreeting', desc: '', args: []);
  }

  /// `Profil`
  String get menuProfile {
    return Intl.message('Profil', name: 'menuProfile', desc: '', args: []);
  }

  /// `Notifications`
  String get menuNotifications {
    return Intl.message(
      'Notifications',
      name: 'menuNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get menuMessages {
    return Intl.message('Message', name: 'menuMessages', desc: '', args: []);
  }

  /// `Recherche`
  String get menuSearch {
    return Intl.message('Recherche', name: 'menuSearch', desc: '', args: []);
  }

  /// `Explorer`
  String get menuExplore {
    return Intl.message('Explorer', name: 'menuExplore', desc: '', args: []);
  }

  /// `Signets`
  String get menuBookmarks {
    return Intl.message('Signets', name: 'menuBookmarks', desc: '', args: []);
  }

  /// `Autres`
  String get menuOther {
    return Intl.message('Autres', name: 'menuOther', desc: '', args: []);
  }

  /// `Quitter`
  String get menuQuit {
    return Intl.message('Quitter', name: 'menuQuit', desc: '', args: []);
  }

  /// `Fermer le menu`
  String get menuClose {
    return Intl.message(
      'Fermer le menu',
      name: 'menuClose',
      desc: '',
      args: [],
    );
  }

  /// `Accès restreint`
  String get accessRestrictedTitle {
    return Intl.message(
      'Accès restreint',
      name: 'accessRestrictedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bientôt disponible`
  String get accessComingSoonTitle {
    return Intl.message(
      'Bientôt disponible',
      name: 'accessComingSoonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette fonctionnalité arrive bientôt. On te prévient dès qu’elle est prête.`
  String get accessComingSoonBody {
    return Intl.message(
      'Cette fonctionnalité arrive bientôt. On te prévient dès qu’elle est prête.',
      name: 'accessComingSoonBody',
      desc: '',
      args: [],
    );
  }

  /// `Vérification requise`
  String get accessKycRequiredTitle {
    return Intl.message(
      'Vérification requise',
      name: 'accessKycRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complète tes certifications pour accéder à cette fonctionnalité.`
  String get accessKycRequiredBody {
    return Intl.message(
      'Complète tes certifications pour accéder à cette fonctionnalité.',
      name: 'accessKycRequiredBody',
      desc: '',
      args: [],
    );
  }

  /// `Compléter mes certifications`
  String get accessKycRequiredCta {
    return Intl.message(
      'Compléter mes certifications',
      name: 'accessKycRequiredCta',
      desc: '',
      args: [],
    );
  }

  /// `Vérification en cours`
  String get accessKycPendingTitle {
    return Intl.message(
      'Vérification en cours',
      name: 'accessKycPendingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tes documents sont en cours d’examen. Cette fonctionnalité s’activera dès validation.`
  String get accessKycPendingBody {
    return Intl.message(
      'Tes documents sont en cours d’examen. Cette fonctionnalité s’activera dès validation.',
      name: 'accessKycPendingBody',
      desc: '',
      args: [],
    );
  }

  /// `Réservé aux abonnés`
  String get accessTierRequiredTitle {
    return Intl.message(
      'Réservé aux abonnés',
      name: 'accessTierRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette donnée est incluse dans l’abonnement {tier}.`
  String accessTierRequiredBody(String tier) {
    return Intl.message(
      'Cette donnée est incluse dans l’abonnement $tier.',
      name: 'accessTierRequiredBody',
      desc: '',
      args: [tier],
    );
  }

  /// `Passer à {tier}`
  String accessUpgradeCta(String tier) {
    return Intl.message(
      'Passer à $tier',
      name: 'accessUpgradeCta',
      desc: '',
      args: [tier],
    );
  }

  /// `Non disponible pour ce compte`
  String get accessRoleRequiredTitle {
    return Intl.message(
      'Non disponible pour ce compte',
      name: 'accessRoleRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette fonctionnalité est réservée aux comptes prestataires.`
  String get accessRoleRequiredBody {
    return Intl.message(
      'Cette fonctionnalité est réservée aux comptes prestataires.',
      name: 'accessRoleRequiredBody',
      desc: '',
      args: [],
    );
  }

  /// `Quitter l’application ?`
  String get exitAppTitle {
    return Intl.message(
      'Quitter l’application ?',
      name: 'exitAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Appuie de nouveau pour quitter.`
  String get exitAppBody {
    return Intl.message(
      'Appuie de nouveau pour quitter.',
      name: 'exitAppBody',
      desc: '',
      args: [],
    );
  }

  /// `Gère tes biens\ndepuis l’application`
  String get homeTitle {
    return Intl.message(
      'Gère tes biens\ndepuis l’application',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Localisation`
  String get homeLocationLabel {
    return Intl.message(
      'Localisation',
      name: 'homeLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `--/--`
  String get homeLocationEmpty {
    return Intl.message('--/--', name: 'homeLocationEmpty', desc: '', args: []);
  }

  /// `Données hors ligne`
  String get homeOfflineBanner {
    return Intl.message(
      'Données hors ligne',
      name: 'homeOfflineBanner',
      desc: '',
      args: [],
    );
  }

  /// `Mes biens`
  String get homeCtaBiensTitle {
    return Intl.message(
      'Mes biens',
      name: 'homeCtaBiensTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enregistre tes biens et gère-les plus facilement, depuis un seul endroit`
  String get homeCtaBiensBody {
    return Intl.message(
      'Enregistre tes biens et gère-les plus facilement, depuis un seul endroit',
      name: 'homeCtaBiensBody',
      desc: '',
      args: [],
    );
  }

  /// `Gérer mes biens`
  String get homeCtaBiensAction {
    return Intl.message(
      'Gérer mes biens',
      name: 'homeCtaBiensAction',
      desc: '',
      args: [],
    );
  }

  /// `Mes agents`
  String get homeCtaAgentsTitle {
    return Intl.message(
      'Mes agents',
      name: 'homeCtaAgentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Crée des agents à qui déléguer tout ou partie de la gestion de tes biens`
  String get homeCtaAgentsBody {
    return Intl.message(
      'Crée des agents à qui déléguer tout ou partie de la gestion de tes biens',
      name: 'homeCtaAgentsBody',
      desc: '',
      args: [],
    );
  }

  /// `Gérer mes agents`
  String get homeCtaAgentsAction {
    return Intl.message(
      'Gérer mes agents',
      name: 'homeCtaAgentsAction',
      desc: '',
      args: [],
    );
  }

  /// `Statistiques Globales`
  String get homeStatsTitle {
    return Intl.message(
      'Statistiques Globales',
      name: 'homeStatsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Biens`
  String get homeStatsBiens {
    return Intl.message('Biens', name: 'homeStatsBiens', desc: '', args: []);
  }

  /// `Publiés`
  String get homeStatsPublished {
    return Intl.message(
      'Publiés',
      name: 'homeStatsPublished',
      desc: '',
      args: [],
    );
  }

  /// `Réservés`
  String get homeStatsReserved {
    return Intl.message(
      'Réservés',
      name: 'homeStatsReserved',
      desc: '',
      args: [],
    );
  }

  /// `Loués`
  String get homeStatsRented {
    return Intl.message('Loués', name: 'homeStatsRented', desc: '', args: []);
  }

  /// `Vues`
  String get homeStatsViews {
    return Intl.message('Vues', name: 'homeStatsViews', desc: '', args: []);
  }

  /// `Contacts`
  String get homeStatsContacts {
    return Intl.message(
      'Contacts',
      name: 'homeStatsContacts',
      desc: '',
      args: [],
    );
  }

  /// `Conversion`
  String get homeStatsConversion {
    return Intl.message(
      'Conversion',
      name: 'homeStatsConversion',
      desc: '',
      args: [],
    );
  }

  /// `Visites`
  String get homeStatsVisits {
    return Intl.message('Visites', name: 'homeStatsVisits', desc: '', args: []);
  }

  /// `Contrats`
  String get homeStatsContracts {
    return Intl.message(
      'Contrats',
      name: 'homeStatsContracts',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get homeStatsRank {
    return Intl.message('Position', name: 'homeStatsRank', desc: '', args: []);
  }

  /// `Bientôt`
  String get homeStatsUnavailable {
    return Intl.message(
      'Bientôt',
      name: 'homeStatsUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Certaines mesures arrivent bientôt.`
  String get homeStatsUnavailableHint {
    return Intl.message(
      'Certaines mesures arrivent bientôt.',
      name: 'homeStatsUnavailableHint',
      desc: '',
      args: [],
    );
  }

  /// `Inclus dans {tier}`
  String homeStatsLockedHint(String tier) {
    return Intl.message(
      'Inclus dans $tier',
      name: 'homeStatsLockedHint',
      desc: '',
      args: [tier],
    );
  }

  /// `Tu n’as encore enregistré aucun bien.`
  String get homeEmptyBiens {
    return Intl.message(
      'Tu n’as encore enregistré aucun bien.',
      name: 'homeEmptyBiens',
      desc: '',
      args: [],
    );
  }

  /// `Mon abonnement`
  String get subscriptionTitle {
    return Intl.message(
      'Mon abonnement',
      name: 'subscriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Formule actuelle`
  String get subscriptionCurrentPlan {
    return Intl.message(
      'Formule actuelle',
      name: 'subscriptionCurrentPlan',
      desc: '',
      args: [],
    );
  }

  /// `Valable jusqu’au {date}`
  String subscriptionRenewsOn(String date) {
    return Intl.message(
      'Valable jusqu’au $date',
      name: 'subscriptionRenewsOn',
      desc: '',
      args: [date],
    );
  }

  /// `Sans expiration`
  String get subscriptionNoExpiry {
    return Intl.message(
      'Sans expiration',
      name: 'subscriptionNoExpiry',
      desc: '',
      args: [],
    );
  }

  /// `Ton abonnement a expiré`
  String get subscriptionExpired {
    return Intl.message(
      'Ton abonnement a expiré',
      name: 'subscriptionExpired',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{Aucune annonce active} one{1 annonce active} other{{count} annonces actives}}`
  String subscriptionListingLimit(int count) {
    return Intl.plural(
      count,
      zero: 'Aucune annonce active',
      one: '1 annonce active',
      other: '$count annonces actives',
      name: 'subscriptionListingLimit',
      desc: '',
      args: [count],
    );
  }

  /// `Annonces illimitées`
  String get subscriptionListingLimitUnlimited {
    return Intl.message(
      'Annonces illimitées',
      name: 'subscriptionListingLimitUnlimited',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de vérifier ton abonnement. Formule Gratuit appliquée en attendant.`
  String get subscriptionUnknown {
    return Intl.message(
      'Impossible de vérifier ton abonnement. Formule Gratuit appliquée en attendant.',
      name: 'subscriptionUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Changer de formule`
  String get subscriptionChangePlan {
    return Intl.message(
      'Changer de formule',
      name: 'subscriptionChangePlan',
      desc: '',
      args: [],
    );
  }

  /// `Mes reçus`
  String get subscriptionReceipts {
    return Intl.message(
      'Mes reçus',
      name: 'subscriptionReceipts',
      desc: '',
      args: [],
    );
  }

  /// `Ouvrir le reçu`
  String get subscriptionReceiptOpen {
    return Intl.message(
      'Ouvrir le reçu',
      name: 'subscriptionReceiptOpen',
      desc: '',
      args: [],
    );
  }

  /// `Aucun paiement enregistré sur cet appareil.`
  String get subscriptionNoReceipts {
    return Intl.message(
      'Aucun paiement enregistré sur cet appareil.',
      name: 'subscriptionNoReceipts',
      desc: '',
      args: [],
    );
  }

  /// `Les reçus sont liés à cet appareil pour le moment.`
  String get subscriptionReceiptsLocalHint {
    return Intl.message(
      'Les reçus sont liés à cet appareil pour le moment.',
      name: 'subscriptionReceiptsLocalHint',
      desc: '',
      args: [],
    );
  }

  /// `Formules`
  String get plansTitle {
    return Intl.message('Formules', name: 'plansTitle', desc: '', args: []);
  }

  /// `Formule actuelle`
  String get plansCurrent {
    return Intl.message(
      'Formule actuelle',
      name: 'plansCurrent',
      desc: '',
      args: [],
    );
  }

  /// `{price} FCFA / mois`
  String plansPriceMonthly(String price) {
    return Intl.message(
      '$price FCFA / mois',
      name: 'plansPriceMonthly',
      desc: '',
      args: [price],
    );
  }

  /// `Gratuit`
  String get plansPriceFree {
    return Intl.message('Gratuit', name: 'plansPriceFree', desc: '', args: []);
  }

  /// `Choisir`
  String get plansChoose {
    return Intl.message('Choisir', name: 'plansChoose', desc: '', args: []);
  }

  /// `{count, plural, one{1 unité de résidence} other{{count} unités de résidence}}`
  String plansResidenceAllowance(int count) {
    return Intl.plural(
      count,
      one: '1 unité de résidence',
      other: '$count unités de résidence',
      name: 'plansResidenceAllowance',
      desc: '',
      args: [count],
    );
  }

  /// `Un passage à une formule inférieure prend effet au prochain cycle.`
  String get plansDowngradeNote {
    return Intl.message(
      'Un passage à une formule inférieure prend effet au prochain cycle.',
      name: 'plansDowngradeNote',
      desc: '',
      args: [],
    );
  }

  /// `Mode de paiement`
  String get paymentMethodTitle {
    return Intl.message(
      'Mode de paiement',
      name: 'paymentMethodTitle',
      desc: '',
      args: [],
    );
  }

  /// `MTN Mobile Money`
  String get paymentMethodMtn {
    return Intl.message(
      'MTN Mobile Money',
      name: 'paymentMethodMtn',
      desc: '',
      args: [],
    );
  }

  /// `Orange Money`
  String get paymentMethodOrange {
    return Intl.message(
      'Orange Money',
      name: 'paymentMethodOrange',
      desc: '',
      args: [],
    );
  }

  /// `Initialisation du paiement…`
  String get paymentInitiating {
    return Intl.message(
      'Initialisation du paiement…',
      name: 'paymentInitiating',
      desc: '',
      args: [],
    );
  }

  /// `Termine sur ton téléphone`
  String get paymentAwaitingTitle {
    return Intl.message(
      'Termine sur ton téléphone',
      name: 'paymentAwaitingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Valide la demande de paiement reçue sur ton mobile (USSD ou application Mobile Money). Cet écran se met à jour tout seul.`
  String get paymentAwaitingBody {
    return Intl.message(
      'Valide la demande de paiement reçue sur ton mobile (USSD ou application Mobile Money). Cet écran se met à jour tout seul.',
      name: 'paymentAwaitingBody',
      desc: '',
      args: [],
    );
  }

  /// `Référence : {ref}`
  String paymentReference(String ref) {
    return Intl.message(
      'Référence : $ref',
      name: 'paymentReference',
      desc: '',
      args: [ref],
    );
  }

  /// `Paiement confirmé`
  String get paymentConfirmedTitle {
    return Intl.message(
      'Paiement confirmé',
      name: 'paymentConfirmedTitle',
      desc: '',
      args: [],
    );
  }

  /// `C'est réglé. Ta formule {tier} est active.`
  String paymentConfirmedBody(String tier) {
    return Intl.message(
      'C\'est réglé. Ta formule $tier est active.',
      name: 'paymentConfirmedBody',
      desc: '',
      args: [tier],
    );
  }

  /// `Paiement en attente`
  String get paymentPendingTitle {
    return Intl.message(
      'Paiement en attente',
      name: 'paymentPendingTitle',
      desc: '',
      args: [],
    );
  }

  /// `On n’a pas encore reçu la confirmation. Ça peut prendre quelques minutes — tu recevras une notification dès que ta formule sera active.`
  String get paymentPendingBody {
    return Intl.message(
      'On n’a pas encore reçu la confirmation. Ça peut prendre quelques minutes — tu recevras une notification dès que ta formule sera active.',
      name: 'paymentPendingBody',
      desc: '',
      args: [],
    );
  }

  /// `Paiement échoué`
  String get paymentFailedTitle {
    return Intl.message(
      'Paiement échoué',
      name: 'paymentFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `La transaction n’a pas abouti. Aucun montant n’a été débité.`
  String get paymentFailedBody {
    return Intl.message(
      'La transaction n’a pas abouti. Aucun montant n’a été débité.',
      name: 'paymentFailedBody',
      desc: '',
      args: [],
    );
  }

  /// `Réessayer le paiement`
  String get paymentRetry {
    return Intl.message(
      'Réessayer le paiement',
      name: 'paymentRetry',
      desc: '',
      args: [],
    );
  }

  /// `Terminé`
  String get paymentDone {
    return Intl.message('Terminé', name: 'paymentDone', desc: '', args: []);
  }

  /// `Mes biens`
  String get mesBiensTitle {
    return Intl.message('Mes biens', name: 'mesBiensTitle', desc: '', args: []);
  }

  /// `En attente\nde validation`
  String get mesBiensPending {
    return Intl.message(
      'En attente\nde validation',
      name: 'mesBiensPending',
      desc: '',
      args: [],
    );
  }

  /// `Biens\nUniques`
  String get mesBiensSingle {
    return Intl.message(
      'Biens\nUniques',
      name: 'mesBiensSingle',
      desc: '',
      args: [],
    );
  }

  /// `Biens\nMultiples`
  String get mesBiensMultiple {
    return Intl.message(
      'Biens\nMultiples',
      name: 'mesBiensMultiple',
      desc: '',
      args: [],
    );
  }

  /// `Attributions`
  String get mesBiensAttributions {
    return Intl.message(
      'Attributions',
      name: 'mesBiensAttributions',
      desc: '',
      args: [],
    );
  }

  /// `Attribuer un local`
  String get mesBiensAttributionsBody {
    return Intl.message(
      'Attribuer un local',
      name: 'mesBiensAttributionsBody',
      desc: '',
      args: [],
    );
  }

  /// `Reservations`
  String get mesBiensReservations {
    return Intl.message(
      'Reservations',
      name: 'mesBiensReservations',
      desc: '',
      args: [],
    );
  }

  /// `Traiter les reservations`
  String get mesBiensReservationsBody {
    return Intl.message(
      'Traiter les reservations',
      name: 'mesBiensReservationsBody',
      desc: '',
      args: [],
    );
  }

  /// `Prospections`
  String get mesBiensProspections {
    return Intl.message(
      'Prospections',
      name: 'mesBiensProspections',
      desc: '',
      args: [],
    );
  }

  /// `Prospection des biens en vente`
  String get mesBiensProspectionsBody {
    return Intl.message(
      'Prospection des biens en vente',
      name: 'mesBiensProspectionsBody',
      desc: '',
      args: [],
    );
  }

  /// `Biens Unique`
  String get annoncesSingleTitle {
    return Intl.message(
      'Biens Unique',
      name: 'annoncesSingleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Biens Multiples`
  String get annoncesMultipleTitle {
    return Intl.message(
      'Biens Multiples',
      name: 'annoncesMultipleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Disponibles`
  String get annoncesTabAvailable {
    return Intl.message(
      'Disponibles',
      name: 'annoncesTabAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Occupés`
  String get annoncesTabOccupied {
    return Intl.message(
      'Occupés',
      name: 'annoncesTabOccupied',
      desc: '',
      args: [],
    );
  }

  /// `Aucun bien disponible. Appuie sur + pour en enregistrer un.`
  String get annoncesEmptyAvailable {
    return Intl.message(
      'Aucun bien disponible. Appuie sur + pour en enregistrer un.',
      name: 'annoncesEmptyAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Aucun bien occupé.`
  String get annoncesEmptyOccupied {
    return Intl.message(
      'Aucun bien occupé.',
      name: 'annoncesEmptyOccupied',
      desc: '',
      args: [],
    );
  }

  /// `{price} FCFA / mois`
  String annoncesPerMonth(String price) {
    return Intl.message(
      '$price FCFA / mois',
      name: 'annoncesPerMonth',
      desc: '',
      args: [price],
    );
  }

  /// `{count, plural, one{1 Pièce} other{{count} Pièces}}`
  String annoncesRooms(int count) {
    return Intl.plural(
      count,
      one: '1 Pièce',
      other: '$count Pièces',
      name: 'annoncesRooms',
      desc: '',
      args: [count],
    );
  }

  /// `{value} m²`
  String annoncesSurface(String value) {
    return Intl.message(
      '$value m²',
      name: 'annoncesSurface',
      desc: '',
      args: [value],
    );
  }

  /// `Historique`
  String get annoncesActionHistory {
    return Intl.message(
      'Historique',
      name: 'annoncesActionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Modifier`
  String get annoncesActionEdit {
    return Intl.message(
      'Modifier',
      name: 'annoncesActionEdit',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 unité} other{{count} unités}}`
  String annoncesUnitsSummary(int count) {
    return Intl.plural(
      count,
      one: '1 unité',
      other: '$count unités',
      name: 'annoncesUnitsSummary',
      desc: '',
      args: [count],
    );
  }

  /// `{count} publiées`
  String annoncesUnitsPublished(int count) {
    return Intl.message(
      '$count publiées',
      name: 'annoncesUnitsPublished',
      desc: '',
      args: [count],
    );
  }

  /// `Brouillon`
  String get annonceStatusDraft {
    return Intl.message(
      'Brouillon',
      name: 'annonceStatusDraft',
      desc: '',
      args: [],
    );
  }

  /// `Disponible`
  String get annonceStatusPublished {
    return Intl.message(
      'Disponible',
      name: 'annonceStatusPublished',
      desc: '',
      args: [],
    );
  }

  /// `Réservé`
  String get annonceStatusReserved {
    return Intl.message(
      'Réservé',
      name: 'annonceStatusReserved',
      desc: '',
      args: [],
    );
  }

  /// `Loué`
  String get annonceStatusRented {
    return Intl.message(
      'Loué',
      name: 'annonceStatusRented',
      desc: '',
      args: [],
    );
  }

  /// `Archivé`
  String get annonceStatusArchived {
    return Intl.message(
      'Archivé',
      name: 'annonceStatusArchived',
      desc: '',
      args: [],
    );
  }

  /// `Publier`
  String get annonceActionPublish {
    return Intl.message(
      'Publier',
      name: 'annonceActionPublish',
      desc: '',
      args: [],
    );
  }

  /// `Marquer réservé`
  String get annonceActionReserve {
    return Intl.message(
      'Marquer réservé',
      name: 'annonceActionReserve',
      desc: '',
      args: [],
    );
  }

  /// `Marquer loué`
  String get annonceActionMarkRented {
    return Intl.message(
      'Marquer loué',
      name: 'annonceActionMarkRented',
      desc: '',
      args: [],
    );
  }

  /// `Archiver`
  String get annonceActionArchive {
    return Intl.message(
      'Archiver',
      name: 'annonceActionArchive',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer`
  String get annonceActionDelete {
    return Intl.message(
      'Supprimer',
      name: 'annonceActionDelete',
      desc: '',
      args: [],
    );
  }

  /// `Action impossible pour le moment.`
  String get annonceActionFailed {
    return Intl.message(
      'Action impossible pour le moment.',
      name: 'annonceActionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer ce bien ?`
  String get annonceDeleteConfirmTitle {
    return Intl.message(
      'Supprimer ce bien ?',
      name: 'annonceDeleteConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette action est définitive. Le bien sera retiré de ton portefeuille.`
  String get annonceDeleteConfirmBody {
    return Intl.message(
      'Cette action est définitive. Le bien sera retiré de ton portefeuille.',
      name: 'annonceDeleteConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Ajouter un bien`
  String get annonceFormTitleNew {
    return Intl.message(
      'Ajouter un bien',
      name: 'annonceFormTitleNew',
      desc: '',
      args: [],
    );
  }

  /// `Modifier le bien`
  String get annonceFormTitleEdit {
    return Intl.message(
      'Modifier le bien',
      name: 'annonceFormTitleEdit',
      desc: '',
      args: [],
    );
  }

  /// `Bien unique`
  String get annonceFormKindSingle {
    return Intl.message(
      'Bien unique',
      name: 'annonceFormKindSingle',
      desc: '',
      args: [],
    );
  }

  /// `Bien multiple`
  String get annonceFormKindMultiple {
    return Intl.message(
      'Bien multiple',
      name: 'annonceFormKindMultiple',
      desc: '',
      args: [],
    );
  }

  /// `Ajouter des images ({min} photos minimum)`
  String annonceFormPhotosHint(int min) {
    return Intl.message(
      'Ajouter des images ($min photos minimum)',
      name: 'annonceFormPhotosHint',
      desc: '',
      args: [min],
    );
  }

  /// `Nom`
  String get annonceFormFieldName {
    return Intl.message(
      'Nom',
      name: 'annonceFormFieldName',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get annonceFormFieldType {
    return Intl.message(
      'Type',
      name: 'annonceFormFieldType',
      desc: '',
      args: [],
    );
  }

  /// `Prix`
  String get annonceFormFieldPrice {
    return Intl.message(
      'Prix',
      name: 'annonceFormFieldPrice',
      desc: '',
      args: [],
    );
  }

  /// `Dimensions`
  String get annonceFormFieldSurface {
    return Intl.message(
      'Dimensions',
      name: 'annonceFormFieldSurface',
      desc: '',
      args: [],
    );
  }

  /// `Nbre de Pièces`
  String get annonceFormFieldRooms {
    return Intl.message(
      'Nbre de Pièces',
      name: 'annonceFormFieldRooms',
      desc: '',
      args: [],
    );
  }

  /// `Salles de bain`
  String get annonceFormFieldBathrooms {
    return Intl.message(
      'Salles de bain',
      name: 'annonceFormFieldBathrooms',
      desc: '',
      args: [],
    );
  }

  /// `Meublé`
  String get annonceFormFieldFurnished {
    return Intl.message(
      'Meublé',
      name: 'annonceFormFieldFurnished',
      desc: '',
      args: [],
    );
  }

  /// `Localisation`
  String get annonceFormFieldLocation {
    return Intl.message(
      'Localisation',
      name: 'annonceFormFieldLocation',
      desc: '',
      args: [],
    );
  }

  /// `Disponibilité`
  String get annonceFormFieldAvailability {
    return Intl.message(
      'Disponibilité',
      name: 'annonceFormFieldAvailability',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get annonceFormFieldDescription {
    return Intl.message(
      'Description',
      name: 'annonceFormFieldDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enregistrer`
  String get annonceFormSave {
    return Intl.message(
      'Enregistrer',
      name: 'annonceFormSave',
      desc: '',
      args: [],
    );
  }

  /// `Bien enregistré en brouillon.`
  String get annonceFormSavedDraft {
    return Intl.message(
      'Bien enregistré en brouillon.',
      name: 'annonceFormSavedDraft',
      desc: '',
      args: [],
    );
  }

  /// `Localisation en cours…`
  String get annonceFormLocating {
    return Intl.message(
      'Localisation en cours…',
      name: 'annonceFormLocating',
      desc: '',
      args: [],
    );
  }

  /// `Autorise la localisation pour enregistrer la position du bien.`
  String get annonceFormLocationDenied {
    return Intl.message(
      'Autorise la localisation pour enregistrer la position du bien.',
      name: 'annonceFormLocationDenied',
      desc: '',
      args: [],
    );
  }

  /// `La position enregistrée est celle de ton téléphone. Place-toi sur le bien, ou corrige l’adresse.`
  String get annonceFormLocationHint {
    return Intl.message(
      'La position enregistrée est celle de ton téléphone. Place-toi sur le bien, ou corrige l’adresse.',
      name: 'annonceFormLocationHint',
      desc: '',
      args: [],
    );
  }

  /// `Adresse exacte`
  String get annonceFormAddress {
    return Intl.message(
      'Adresse exacte',
      name: 'annonceFormAddress',
      desc: '',
      args: [],
    );
  }

  /// `Unités`
  String get annonceFormUnitsTitle {
    return Intl.message(
      'Unités',
      name: 'annonceFormUnitsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ajouter un groupe d’unités`
  String get annonceFormUnitsAdd {
    return Intl.message(
      'Ajouter un groupe d’unités',
      name: 'annonceFormUnitsAdd',
      desc: '',
      args: [],
    );
  }

  /// `Préfixe (ex. Chambre)`
  String get annonceFormUnitPrefix {
    return Intl.message(
      'Préfixe (ex. Chambre)',
      name: 'annonceFormUnitPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get annonceFormUnitCount {
    return Intl.message(
      'Nombre',
      name: 'annonceFormUnitCount',
      desc: '',
      args: [],
    );
  }

  /// `Photo non uploadée, réessaie.`
  String get annonceFormErrorPhoto {
    return Intl.message(
      'Photo non uploadée, réessaie.',
      name: 'annonceFormErrorPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Complète les champs obligatoires.`
  String get annonceFormErrorIncomplete {
    return Intl.message(
      'Complète les champs obligatoires.',
      name: 'annonceFormErrorIncomplete',
      desc: '',
      args: [],
    );
  }

  /// `Enregistrement impossible. Réessaie.`
  String get annonceFormErrorSave {
    return Intl.message(
      'Enregistrement impossible. Réessaie.',
      name: 'annonceFormErrorSave',
      desc: '',
      args: [],
    );
  }

  /// `Appartement`
  String get propertyTypeApartment {
    return Intl.message(
      'Appartement',
      name: 'propertyTypeApartment',
      desc: 'PropertyType.apartment.',
      args: [],
    );
  }

  /// `Studio`
  String get propertyTypeStudio {
    return Intl.message(
      'Studio',
      name: 'propertyTypeStudio',
      desc: 'PropertyType.studio.',
      args: [],
    );
  }

  /// `Villa`
  String get propertyTypeVilla {
    return Intl.message(
      'Villa',
      name: 'propertyTypeVilla',
      desc: 'PropertyType.villa.',
      args: [],
    );
  }

  /// `Chambre`
  String get propertyTypeRoom {
    return Intl.message(
      'Chambre',
      name: 'propertyTypeRoom',
      desc: 'PropertyType.room.',
      args: [],
    );
  }

  /// `Bureau`
  String get propertyTypeOffice {
    return Intl.message(
      'Bureau',
      name: 'propertyTypeOffice',
      desc: 'PropertyType.office.',
      args: [],
    );
  }

  /// `Local commercial`
  String get propertyTypeCommercialSpace {
    return Intl.message(
      'Local commercial',
      name: 'propertyTypeCommercialSpace',
      desc: 'PropertyType.commercialSpace.',
      args: [],
    );
  }

  /// `Oui`
  String get commonYes {
    return Intl.message(
      'Oui',
      name: 'commonYes',
      desc: 'Generic yes.',
      args: [],
    );
  }

  /// `Non`
  String get commonNo {
    return Intl.message('Non', name: 'commonNo', desc: 'Generic no.', args: []);
  }

  /// `Caractéristiques`
  String get annonceDetailFacts {
    return Intl.message(
      'Caractéristiques',
      name: 'annonceDetailFacts',
      desc: 'The listing\'s own fields, which the detail did not show at all.',
      args: [],
    );
  }

  /// `Visites`
  String get annonceDetailVisits {
    return Intl.message(
      'Visites',
      name: 'annonceDetailVisits',
      desc: 'M11 — who may show this property.',
      args: [],
    );
  }

  /// `Agents assignés`
  String get annonceDetailAgents {
    return Intl.message(
      'Agents assignés',
      name: 'annonceDetailAgents',
      desc: 'Opens the property\'s agent pool (RM-M11-01).',
      args: [],
    );
  }

  /// `Charges`
  String get annonceDetailCharges {
    return Intl.message(
      'Charges',
      name: 'annonceDetailCharges',
      desc: 'chargesIncluded.',
      args: [],
    );
  }

  /// `Incluses`
  String get annonceDetailChargesIncluded {
    return Intl.message(
      'Incluses',
      name: 'annonceDetailChargesIncluded',
      desc: 'chargesIncluded = true.',
      args: [],
    );
  }

  /// `En sus`
  String get annonceDetailChargesExtra {
    return Intl.message(
      'En sus',
      name: 'annonceDetailChargesExtra',
      desc: 'chargesIncluded = false.',
      args: [],
    );
  }

  /// `Total`
  String get residenceDetailUnitsLabel {
    return Intl.message(
      'Total',
      name: 'residenceDetailUnitsLabel',
      desc: 'Residence count tile.',
      args: [],
    );
  }

  /// `Publiées`
  String get residenceDetailPublishedLabel {
    return Intl.message(
      'Publiées',
      name: 'residenceDetailPublishedLabel',
      desc: 'Residence count tile.',
      args: [],
    );
  }

  /// `Occupées`
  String get residenceDetailOccupiedLabel {
    return Intl.message(
      'Occupées',
      name: 'residenceDetailOccupiedLabel',
      desc: 'Residence count tile — reserved + rented.',
      args: [],
    );
  }

  /// `Details du bien`
  String get annonceDetailTitle {
    return Intl.message(
      'Details du bien',
      name: 'annonceDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Statistiques`
  String get annonceDetailStats {
    return Intl.message(
      'Statistiques',
      name: 'annonceDetailStats',
      desc: '',
      args: [],
    );
  }

  /// `Occupant`
  String get annonceDetailOccupant {
    return Intl.message(
      'Occupant',
      name: 'annonceDetailOccupant',
      desc: '',
      args: [],
    );
  }

  /// `Historique`
  String get annonceDetailHistory {
    return Intl.message(
      'Historique',
      name: 'annonceDetailHistory',
      desc: '',
      args: [],
    );
  }

  /// `Aucune information\ndisponible pour le moment`
  String get annonceDetailNoInfo {
    return Intl.message(
      'Aucune information\ndisponible pour le moment',
      name: 'annonceDetailNoInfo',
      desc: '',
      args: [],
    );
  }

  /// `Profil incomplet`
  String get publishBlockedProfileTitle {
    return Intl.message(
      'Profil incomplet',
      name: 'publishBlockedProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complète ton profil (logo, type, ville) avant de publier.`
  String get publishBlockedProfileBody {
    return Intl.message(
      'Complète ton profil (logo, type, ville) avant de publier.',
      name: 'publishBlockedProfileBody',
      desc: '',
      args: [],
    );
  }

  /// `Photos manquantes`
  String get publishBlockedPhotosTitle {
    return Intl.message(
      'Photos manquantes',
      name: 'publishBlockedPhotosTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ajoute au moins {min} photos pour publier.`
  String publishBlockedPhotosBody(int min) {
    return Intl.message(
      'Ajoute au moins $min photos pour publier.',
      name: 'publishBlockedPhotosBody',
      desc: '',
      args: [min],
    );
  }

  /// `Limite atteinte`
  String get publishBlockedLimitTitle {
    return Intl.message(
      'Limite atteinte',
      name: 'publishBlockedLimitTitle',
      desc: '',
      args: [],
    );
  }

  /// `Limite atteinte. Passe à {tier} pour publier plus d’annonces.`
  String publishBlockedLimitBody(String tier) {
    return Intl.message(
      'Limite atteinte. Passe à $tier pour publier plus d’annonces.',
      name: 'publishBlockedLimitBody',
      desc: '',
      args: [tier],
    );
  }

  /// `Titre`
  String get annonceFormFieldTitle {
    return Intl.message(
      'Titre',
      name: 'annonceFormFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quartier`
  String get annonceFormFieldDistrict {
    return Intl.message(
      'Quartier',
      name: 'annonceFormFieldDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Détection de la ville…`
  String get annonceFormDetectingCity {
    return Intl.message(
      'Détection de la ville…',
      name: 'annonceFormDetectingCity',
      desc: '',
      args: [],
    );
  }

  /// `Ville détectée : {city}`
  String annonceFormCityDetected(String city) {
    return Intl.message(
      'Ville détectée : $city',
      name: 'annonceFormCityDetected',
      desc: '',
      args: [city],
    );
  }

  /// `Ville non détectée. Choisis-la manuellement.`
  String get annonceFormCityNotDetected {
    return Intl.message(
      'Ville non détectée. Choisis-la manuellement.',
      name: 'annonceFormCityNotDetected',
      desc: '',
      args: [],
    );
  }

  /// `Choisir le quartier`
  String get annonceFormPickDistrict {
    return Intl.message(
      'Choisir le quartier',
      name: 'annonceFormPickDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Aucun quartier disponible pour cette ville.`
  String get annonceFormNoDistricts {
    return Intl.message(
      'Aucun quartier disponible pour cette ville.',
      name: 'annonceFormNoDistricts',
      desc: '',
      args: [],
    );
  }

  /// `Charges incluses`
  String get annonceFormFieldCharges {
    return Intl.message(
      'Charges incluses',
      name: 'annonceFormFieldCharges',
      desc: '',
      args: [],
    );
  }

  /// `Montant des charges`
  String get annonceFormFieldChargesAmount {
    return Intl.message(
      'Montant des charges',
      name: 'annonceFormFieldChargesAmount',
      desc: '',
      args: [],
    );
  }

  /// `Salles de bain`
  String get annonceFormFieldBathrooms2 {
    return Intl.message(
      'Salles de bain',
      name: 'annonceFormFieldBathrooms2',
      desc: '',
      args: [],
    );
  }

  /// `m²`
  String get annonceFormUnitSquareMetres {
    return Intl.message(
      'm²',
      name: 'annonceFormUnitSquareMetres',
      desc: '',
      args: [],
    );
  }

  /// `FCFA`
  String get annonceFormCurrency {
    return Intl.message(
      'FCFA',
      name: 'annonceFormCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Impossible de charger ce bien.`
  String get annonceFormLoadFailed {
    return Intl.message(
      'Impossible de charger ce bien.',
      name: 'annonceFormLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Biens Multiples`
  String get residencesTitle {
    return Intl.message(
      'Biens Multiples',
      name: 'residencesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Plus d’actions`
  String get annoncesActionMore {
    return Intl.message(
      'Plus d’actions',
      name: 'annoncesActionMore',
      desc: '',
      args: [],
    );
  }

  /// `Ta formule ne permet pas autant d’unités. Passe à une formule supérieure ou réduis le nombre d’unités.`
  String get errorResidenceUnitLimit {
    return Intl.message(
      'Ta formule ne permet pas autant d’unités. Passe à une formule supérieure ou réduis le nombre d’unités.',
      name: 'errorResidenceUnitLimit',
      desc: '',
      args: [],
    );
  }

  /// `Limite d’annonces actives atteinte pour ta formule.`
  String get errorListingLimit {
    return Intl.message(
      'Limite d’annonces actives atteinte pour ta formule.',
      name: 'errorListingLimit',
      desc: '',
      args: [],
    );
  }

  /// `Complète ton profil (photo, type, ville) avant de continuer.`
  String get errorProfileIncomplete {
    return Intl.message(
      'Complète ton profil (photo, type, ville) avant de continuer.',
      name: 'errorProfileIncomplete',
      desc: '',
      args: [],
    );
  }

  /// `Tes certifications doivent être validées avant cette action.`
  String get errorKycRequired {
    return Intl.message(
      'Tes certifications doivent être validées avant cette action.',
      name: 'errorKycRequired',
      desc: '',
      args: [],
    );
  }

  /// `Certaines informations sont invalides. Vérifie le formulaire.`
  String get errorValidation {
    return Intl.message(
      'Certaines informations sont invalides. Vérifie le formulaire.',
      name: 'errorValidation',
      desc: '',
      args: [],
    );
  }

  /// `Archivés`
  String get annoncesTabArchived {
    return Intl.message(
      'Archivés',
      name: 'annoncesTabArchived',
      desc: '',
      args: [],
    );
  }

  /// `Aucun bien archivé.`
  String get annoncesEmptyArchived {
    return Intl.message(
      'Aucun bien archivé.',
      name: 'annoncesEmptyArchived',
      desc: '',
      args: [],
    );
  }

  /// `Détails de la résidence`
  String get residenceDetailTitle {
    return Intl.message(
      'Détails de la résidence',
      name: 'residenceDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unités`
  String get residenceUnitsTitle {
    return Intl.message(
      'Unités',
      name: 'residenceUnitsTitle',
      desc: '',
      args: [],
    );
  }

  /// `La modification d’une unité arrivera prochainement.`
  String get residenceUnitsPending {
    return Intl.message(
      'La modification d’une unité arrivera prochainement.',
      name: 'residenceUnitsPending',
      desc: '',
      args: [],
    );
  }

  /// `Statut`
  String get residenceUnitStatus {
    return Intl.message(
      'Statut',
      name: 'residenceUnitStatus',
      desc: '',
      args: [],
    );
  }

  /// `Désarchiver`
  String get annonceActionUnarchive {
    return Intl.message(
      'Désarchiver',
      name: 'annonceActionUnarchive',
      desc: '',
      args: [],
    );
  }

  /// `Annuler`
  String get commonCancel {
    return Intl.message('Annuler', name: 'commonCancel', desc: '', args: []);
  }

  /// `Supprimer cette résidence ?`
  String get residenceDeleteConfirmTitle {
    return Intl.message(
      'Supprimer cette résidence ?',
      name: 'residenceDeleteConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cette action est définitive et supprime aussi toutes ses unités.`
  String get residenceDeleteConfirmBody {
    return Intl.message(
      'Cette action est définitive et supprime aussi toutes ses unités.',
      name: 'residenceDeleteConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Ajoute au moins 3 photos pour publier.`
  String get errorInsufficientPhotos {
    return Intl.message(
      'Ajoute au moins 3 photos pour publier.',
      name: 'errorInsufficientPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Ce changement de statut n’est pas possible pour ce bien.`
  String get errorInvalidTransition {
    return Intl.message(
      'Ce changement de statut n’est pas possible pour ce bien.',
      name: 'errorInvalidTransition',
      desc: '',
      args: [],
    );
  }

  /// `Deux modifications se sont croisées. Réessaie.`
  String get errorConstraintViolation {
    return Intl.message(
      'Deux modifications se sont croisées. Réessaie.',
      name: 'errorConstraintViolation',
      desc: '',
      args: [],
    );
  }

  /// `Ton compte n’a pas les droits pour cette action.`
  String get errorAccessDenied {
    return Intl.message(
      'Ton compte n’a pas les droits pour cette action.',
      name: 'errorAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `Unité d’une résidence`
  String get annonceDetailUnitOfResidence {
    return Intl.message(
      'Unité d’une résidence',
      name: 'annonceDetailUnitOfResidence',
      desc: '',
      args: [],
    );
  }

  /// `Un Bien Multiple regroupe plusieurs unités qui partagent une adresse et des caractéristiques : immeuble, cité, hôtel, résidence meublée. Les unités se créent par groupes au moment de la création — aucune unité ne peut être ajoutée par la suite.`
  String get annonceFormHelpKind {
    return Intl.message(
      'Un Bien Multiple regroupe plusieurs unités qui partagent une adresse et des caractéristiques : immeuble, cité, hôtel, résidence meublée. Les unités se créent par groupes au moment de la création — aucune unité ne peut être ajoutée par la suite.',
      name: 'annonceFormHelpKind',
      desc:
          'Doc 10 §M10bis (Modèle). Help text on the Bien Unique / Bien Multiple selector.',
      args: [],
    );
  }

  /// `Appartement, Studio, Villa, Chambre, Bureau ou Local commercial. Les locataires filtrent leur recherche sur ce critère.`
  String get annonceFormHelpPropertyType {
    return Intl.message(
      'Appartement, Studio, Villa, Chambre, Bureau ou Local commercial. Les locataires filtrent leur recherche sur ce critère.',
      name: 'annonceFormHelpPropertyType',
      desc:
          'Doc 10 §M10 (Champs) + §M04 (filtres). Help text on the property-type field.',
      args: [],
    );
  }

  /// `Le loyer tel que tu le perçois, et sa périodicité : au jour, à la semaine, au mois, au trimestre ou à l'année. Mboa en déduit un équivalent mensuel, utilisé uniquement pour comparer les annonces entre elles — jamais facturé, jamais repris dans le Contrat Mboa.`
  String get annonceFormHelpPrice {
    return Intl.message(
      'Le loyer tel que tu le perçois, et sa périodicité : au jour, à la semaine, au mois, au trimestre ou à l\'année. Mboa en déduit un équivalent mensuel, utilisé uniquement pour comparer les annonces entre elles — jamais facturé, jamais repris dans le Contrat Mboa.',
      name: 'annonceFormHelpPrice',
      desc: 'Doc 10 RM-M10-09. Help text on the rent field.',
      args: [],
    );
  }

  /// `Facultatif. Indique si l'eau et l'électricité sont comprises dans le loyer, et leur montant si elles ne le sont pas.`
  String get annonceFormHelpCharges {
    return Intl.message(
      'Facultatif. Indique si l\'eau et l\'électricité sont comprises dans le loyer, et leur montant si elles ne le sont pas.',
      name: 'annonceFormHelpCharges',
      desc:
          'Doc 10 §M10 (Champs) — « Charges incluses (oui/non + montant) », facultatif, visible par les users.',
      args: [],
    );
  }

  /// `Facultatif, mais les locataires filtrent leur recherche sur ces critères : un bien sans ces informations ressort moins souvent.`
  String get annonceFormHelpOptionalFilters {
    return Intl.message(
      'Facultatif, mais les locataires filtrent leur recherche sur ces critères : un bien sans ces informations ressort moins souvent.',
      name: 'annonceFormHelpOptionalFilters',
      desc:
          'Doc 10 §M04 (filtres) — surface, pièces, meublé. Help text shared by the optional characteristics.',
      args: [],
    );
  }

  /// `La ville et le quartier sont visibles par les locataires. L'adresse exacte ne l'est jamais : elle n'apparaît que dans le Contrat Mboa signé.`
  String get annonceFormHelpLocation {
    return Intl.message(
      'La ville et le quartier sont visibles par les locataires. L\'adresse exacte ne l\'est jamais : elle n\'apparaît que dans le Contrat Mboa signé.',
      name: 'annonceFormHelpLocation',
      desc:
          'Doc 10 §M10 (Champs) — « Adresse exacte : visible par les users = Non ».',
      args: [],
    );
  }

  /// `Obligatoire. Les locataires peuvent filtrer sur la disponibilité immédiate.`
  String get annonceFormHelpAvailability {
    return Intl.message(
      'Obligatoire. Les locataires peuvent filtrer sur la disponibilité immédiate.',
      name: 'annonceFormHelpAvailability',
      desc: 'Doc 10 §M10 (Champs) + §M04 (filtre « Disponibilité immédiate »).',
      args: [],
    );
  }

  /// `3 photos minimum et 15 maximum. Elles sont compressées automatiquement avant l'envoi. Modifier les photos d'une annonce publiée relance la validation du badge « Photos vérifiées ».`
  String get annonceFormHelpPhotos {
    return Intl.message(
      '3 photos minimum et 15 maximum. Elles sont compressées automatiquement avant l\'envoi. Modifier les photos d\'une annonce publiée relance la validation du badge « Photos vérifiées ».',
      name: 'annonceFormHelpPhotos',
      desc: 'Doc 10 RM-M10-03, RM-M10-06, CE-M10-03.',
      args: [],
    );
  }

  /// `Facultatif, 1 500 caractères maximum.`
  String get annonceFormHelpDescription {
    return Intl.message(
      'Facultatif, 1 500 caractères maximum.',
      name: 'annonceFormHelpDescription',
      desc: 'Doc 10 §M10 (Champs).',
      args: [],
    );
  }

  /// `Type d'annonce`
  String get annonceFormKindLabel {
    return Intl.message(
      'Type d\'annonce',
      name: 'annonceFormKindLabel',
      desc:
          'Label above the Bien Unique / Bien Multiple selector; also the title of its help sheet.',
      args: [],
    );
  }

  /// `Photos`
  String get annonceFormPhotosLabel {
    return Intl.message(
      'Photos',
      name: 'annonceFormPhotosLabel',
      desc: 'Label above the photo strip; also the title of its help sheet.',
      args: [],
    );
  }

  /// `{price} FCFA / {period}`
  String annoncePricePerPeriod(String price, String period) {
    return Intl.message(
      '$price FCFA / $period',
      name: 'annoncePricePerPeriod',
      desc:
          'Rent as entered, with its period (RM-M10-09). {period} is one of annoncePeriodMonth/Quarter/Year.',
      args: [price, period],
    );
  }

  /// `Mois`
  String get annoncePeriodMonth {
    return Intl.message(
      'Mois',
      name: 'annoncePeriodMonth',
      desc: 'Doc 10 RM-M10-09 — rental period.',
      args: [],
    );
  }

  /// `mois`
  String get annoncePeriodMonthInline {
    return Intl.message(
      'mois',
      name: 'annoncePeriodMonthInline',
      desc: 'Lowercase form, for "{price} FCFA / {period}" (§25: normal case).',
      args: [],
    );
  }

  /// `Trimestre`
  String get annoncePeriodQuarter {
    return Intl.message(
      'Trimestre',
      name: 'annoncePeriodQuarter',
      desc: 'Doc 10 RM-M10-09 — rental period.',
      args: [],
    );
  }

  /// `trimestre`
  String get annoncePeriodQuarterInline {
    return Intl.message(
      'trimestre',
      name: 'annoncePeriodQuarterInline',
      desc: 'Lowercase form, for "{price} FCFA / {period}" (§25: normal case).',
      args: [],
    );
  }

  /// `An`
  String get annoncePeriodYear {
    return Intl.message(
      'An',
      name: 'annoncePeriodYear',
      desc: 'Doc 10 RM-M10-09 — rental period.',
      args: [],
    );
  }

  /// `an`
  String get annoncePeriodYearInline {
    return Intl.message(
      'an',
      name: 'annoncePeriodYearInline',
      desc: 'Lowercase form, for "{price} FCFA / {period}" (§25: normal case).',
      args: [],
    );
  }

  /// `Périodicité`
  String get annonceFormFieldPeriod {
    return Intl.message(
      'Périodicité',
      name: 'annonceFormFieldPeriod',
      desc: 'Label of the rental-period selector on the listing form.',
      args: [],
    );
  }

  /// `Rechercher une unité`
  String get residenceUnitsSearchHint {
    return Intl.message(
      'Rechercher une unité',
      name: 'residenceUnitsSearchHint',
      desc:
          'Placeholder of the unit search box on the residence detail (M10bis).',
      args: [],
    );
  }

  /// `Aucune unité ne correspond à « {query} ».`
  String residenceUnitsSearchEmpty(String query) {
    return Intl.message(
      'Aucune unité ne correspond à « $query ».',
      name: 'residenceUnitsSearchEmpty',
      desc: 'Empty state when a unit search matches nothing.',
      args: [query],
    );
  }

  /// `Climatisation`
  String get amenityAirConditioning {
    return Intl.message(
      'Climatisation',
      name: 'amenityAirConditioning',
      desc: 'Doc 10 §M10 — Équipements (checklist).',
      args: [],
    );
  }

  /// `Eau chaude`
  String get amenityHotWater {
    return Intl.message(
      'Eau chaude',
      name: 'amenityHotWater',
      desc: 'Doc 10 §M10 — Équipements (checklist).',
      args: [],
    );
  }

  /// `Groupe électrogène`
  String get amenityGenerator {
    return Intl.message(
      'Groupe électrogène',
      name: 'amenityGenerator',
      desc: 'Doc 10 §M10 — Équipements (checklist).',
      args: [],
    );
  }

  /// `Gardien`
  String get amenitySecurityGuard {
    return Intl.message(
      'Gardien',
      name: 'amenitySecurityGuard',
      desc: 'Doc 10 §M10 — Équipements (checklist).',
      args: [],
    );
  }

  /// `Parking`
  String get amenityParking {
    return Intl.message(
      'Parking',
      name: 'amenityParking',
      desc: 'Doc 10 §M10 — Équipements (checklist).',
      args: [],
    );
  }

  /// `Wi-Fi`
  String get amenityWifi {
    return Intl.message(
      'Wi-Fi',
      name: 'amenityWifi',
      desc: 'Doc 10 §M10 — Équipements (checklist).',
      args: [],
    );
  }

  /// `Équipements`
  String get annonceFormFieldAmenities {
    return Intl.message(
      'Équipements',
      name: 'annonceFormFieldAmenities',
      desc: 'Label of the amenities checklist on the listing form.',
      args: [],
    );
  }

  /// `Facultatif. Coche ce que le bien propose — les locataires s'en servent pour comparer les annonces entre elles.`
  String get annonceFormHelpAmenities {
    return Intl.message(
      'Facultatif. Coche ce que le bien propose — les locataires s\'en servent pour comparer les annonces entre elles.',
      name: 'annonceFormHelpAmenities',
      desc:
          'Doc 10 §M10 (Champs) — « Équipements (checklist) », facultatif, visible par les users.',
      args: [],
    );
  }

  /// `Équipements`
  String get annonceDetailAmenities {
    return Intl.message(
      'Équipements',
      name: 'annonceDetailAmenities',
      desc: 'Section heading on the listing detail.',
      args: [],
    );
  }

  /// `Jour`
  String get annoncePeriodDay {
    return Intl.message(
      'Jour',
      name: 'annoncePeriodDay',
      desc:
          'Doc 10 RM-M10-09 — rental period. DAY/WEEK were added by the API after the CDC; RM-M10-09 excludes them.',
      args: [],
    );
  }

  /// `jour`
  String get annoncePeriodDayInline {
    return Intl.message(
      'jour',
      name: 'annoncePeriodDayInline',
      desc: 'Lowercase form, for "{price} FCFA / {period}" (§25: normal case).',
      args: [],
    );
  }

  /// `Semaine`
  String get annoncePeriodWeek {
    return Intl.message(
      'Semaine',
      name: 'annoncePeriodWeek',
      desc:
          'Doc 10 RM-M10-09 — rental period. DAY/WEEK were added by the API after the CDC; RM-M10-09 excludes them.',
      args: [],
    );
  }

  /// `semaine`
  String get annoncePeriodWeekInline {
    return Intl.message(
      'semaine',
      name: 'annoncePeriodWeekInline',
      desc: 'Lowercase form, for "{price} FCFA / {period}" (§25: normal case).',
      args: [],
    );
  }

  /// `Mes visites`
  String get agentNavVisits {
    return Intl.message(
      'Mes visites',
      name: 'agentNavVisits',
      desc: 'Agent shell tab (M16).',
      args: [],
    );
  }

  /// `Mes missions`
  String get agentNavMissions {
    return Intl.message(
      'Mes missions',
      name: 'agentNavMissions',
      desc: 'Agent shell tab (M11 assignments).',
      args: [],
    );
  }

  /// `Mon profil`
  String get agentNavProfile {
    return Intl.message(
      'Mon profil',
      name: 'agentNavProfile',
      desc: 'Agent shell tab (M15).',
      args: [],
    );
  }

  /// `Mon profil agent`
  String get agentProfileTitle {
    return Intl.message(
      'Mon profil agent',
      name: 'agentProfileTitle',
      desc: 'Agent profile screen title (M15).',
      args: [],
    );
  }

  /// `En attente de validation`
  String get agentStatusPending {
    return Intl.message(
      'En attente de validation',
      name: 'agentStatusPending',
      desc: 'AgentProfileResponse.status = PENDING.',
      args: [],
    );
  }

  /// `Actif`
  String get agentStatusActive {
    return Intl.message(
      'Actif',
      name: 'agentStatusActive',
      desc: 'AgentProfileResponse.status = ACTIVE.',
      args: [],
    );
  }

  /// `Suspendu`
  String get agentStatusSuspended {
    return Intl.message(
      'Suspendu',
      name: 'agentStatusSuspended',
      desc: 'AgentProfileResponse.status = SUSPENDED.',
      args: [],
    );
  }

  /// `Compte clôturé`
  String get agentStatusDeleted {
    return Intl.message(
      'Compte clôturé',
      name: 'agentStatusDeleted',
      desc: 'AgentProfileResponse.status = DELETED.',
      args: [],
    );
  }

  /// `Statut inconnu`
  String get agentStatusUnknown {
    return Intl.message(
      'Statut inconnu',
      name: 'agentStatusUnknown',
      desc: 'AgentProfileResponse.status absent or unrecognised.',
      args: [],
    );
  }

  /// `Visites réalisées`
  String get agentStatsVisits {
    return Intl.message(
      'Visites réalisées',
      name: 'agentStatsVisits',
      desc: 'completedVisitCount on the agent profile.',
      args: [],
    );
  }

  /// `Note moyenne`
  String get agentStatsRating {
    return Intl.message(
      'Note moyenne',
      name: 'agentStatsRating',
      desc: 'averageRating on the agent profile.',
      args: [],
    );
  }

  /// `{count} avis`
  String agentStatsRatingCount(int count) {
    return Intl.message(
      '$count avis',
      name: 'agentStatsRatingCount',
      desc: 'How many ratings the average is based on.',
      args: [count],
    );
  }

  /// `Pas encore noté`
  String get agentStatsNoRating {
    return Intl.message(
      'Pas encore noté',
      name: 'agentStatsNoRating',
      desc: 'Shown instead of an average when ratingCount is 0.',
      args: [],
    );
  }

  /// `Je reçois des missions`
  String get agentAcceptingTitle {
    return Intl.message(
      'Je reçois des missions',
      name: 'agentAcceptingTitle',
      desc: 'RM-M15-05 toggle.',
      args: [],
    );
  }

  /// `Tu peux recevoir de nouvelles assignations.`
  String get agentAcceptingOn {
    return Intl.message(
      'Tu peux recevoir de nouvelles assignations.',
      name: 'agentAcceptingOn',
      desc: 'RM-M15-05, accepting.',
      args: [],
    );
  }

  /// `Tu ne recevras plus de nouvelles assignations. Les visites déjà planifiées restent à faire.`
  String get agentAcceptingOff {
    return Intl.message(
      'Tu ne recevras plus de nouvelles assignations. Les visites déjà planifiées restent à faire.',
      name: 'agentAcceptingOff',
      desc:
          'RM-M15-05, inactive — Doc 10 is explicit that scheduled visits are still carried out.',
      args: [],
    );
  }

  /// `Profil incomplet`
  String get agentIncompleteTitle {
    return Intl.message(
      'Profil incomplet',
      name: 'agentIncompleteTitle',
      desc: 'profileComplete == false.',
      args: [],
    );
  }

  /// `Ajoute ton nom, une photo et au moins une zone pour recevoir des missions.`
  String get agentIncompleteBody {
    return Intl.message(
      'Ajoute ton nom, une photo et au moins une zone pour recevoir des missions.',
      name: 'agentIncompleteBody',
      desc:
          'The server\'s completeness rule, spelled out: firstName + lastName + photoObjectKey + >=1 zone.',
      args: [],
    );
  }

  /// `Mes zones d'intervention`
  String get agentZonesTitle {
    return Intl.message(
      'Mes zones d\'intervention',
      name: 'agentZonesTitle',
      desc: 'RM-M15-04 screen title.',
      args: [],
    );
  }

  /// `{count} zone(s)`
  String agentZonesSubtitle(int count) {
    return Intl.message(
      '$count zone(s)',
      name: 'agentZonesSubtitle',
      desc: 'Zone count on the profile screen.',
      args: [count],
    );
  }

  /// `Aucune zone`
  String get agentZonesNone {
    return Intl.message(
      'Aucune zone',
      name: 'agentZonesNone',
      desc: 'No zones selected yet.',
      args: [],
    );
  }

  /// `Choisis une ville entière ou seulement certains quartiers. Seuls les biens situés dans tes zones te seront proposés.`
  String get agentZonesHelp {
    return Intl.message(
      'Choisis une ville entière ou seulement certains quartiers. Seuls les biens situés dans tes zones te seront proposés.',
      name: 'agentZonesHelp',
      desc: 'Doc 10 RM-M15-04.',
      args: [],
    );
  }

  /// `Choisis au moins une ville ou un quartier.`
  String get agentZonesEmptyError {
    return Intl.message(
      'Choisis au moins une ville ou un quartier.',
      name: 'agentZonesEmptyError',
      desc: 'The backend rejects a zones update where both lists are empty.',
      args: [],
    );
  }

  /// `Toute la ville`
  String get agentZonesWholeCity {
    return Intl.message(
      'Toute la ville',
      name: 'agentZonesWholeCity',
      desc: 'Option to cover a whole city rather than picking districts.',
      args: [],
    );
  }

  /// `Mes disponibilités`
  String get agentAvailabilityTitle {
    return Intl.message(
      'Mes disponibilités',
      name: 'agentAvailabilityTitle',
      desc: 'RM-M15-01 screen title.',
      args: [],
    );
  }

  /// `{count} créneau(x) par semaine`
  String agentAvailabilitySubtitle(int count) {
    return Intl.message(
      '$count créneau(x) par semaine',
      name: 'agentAvailabilitySubtitle',
      desc: 'Weekly rule count on the profile screen.',
      args: [count],
    );
  }

  /// `Définis tes horaires habituels. Les créneaux réservables en sont déduits, moins tes jours bloqués et tes visites déjà prévues.`
  String get agentAvailabilityHelp {
    return Intl.message(
      'Définis tes horaires habituels. Les créneaux réservables en sont déduits, moins tes jours bloqués et tes visites déjà prévues.',
      name: 'agentAvailabilityHelp',
      desc: 'Doc 10 RM-M15-01.',
      args: [],
    );
  }

  /// `Durée d'une visite`
  String get agentVisitDuration {
    return Intl.message(
      'Durée d\'une visite',
      name: 'agentVisitDuration',
      desc: 'visitDurationMinutes label.',
      args: [],
    );
  }

  /// `{minutes} min`
  String agentVisitDurationValue(int minutes) {
    return Intl.message(
      '$minutes min',
      name: 'agentVisitDurationValue',
      desc: 'visitDurationMinutes value.',
      args: [minutes],
    );
  }

  /// `Ajouter un créneau`
  String get agentAddSlot {
    return Intl.message(
      'Ajouter un créneau',
      name: 'agentAddSlot',
      desc: 'Add an availability window.',
      args: [],
    );
  }

  /// `Ce créneau en chevauche un autre.`
  String get agentSlotOverlap {
    return Intl.message(
      'Ce créneau en chevauche un autre.',
      name: 'agentSlotOverlap',
      desc: 'Rejected: overlapping window on the same day.',
      args: [],
    );
  }

  /// `Jours bloqués`
  String get agentDaysOffTitle {
    return Intl.message(
      'Jours bloqués',
      name: 'agentDaysOffTitle',
      desc: 'RM-M15-03 section.',
      args: [],
    );
  }

  /// `Un jour bloqué annule les visites déjà planifiées ce jour-là.`
  String get agentDaysOffHelp {
    return Intl.message(
      'Un jour bloqué annule les visites déjà planifiées ce jour-là.',
      name: 'agentDaysOffHelp',
      desc:
          'Doc 10 RM-M15-03 — the cancellation is why this saves immediately.',
      args: [],
    );
  }

  /// `Aucun jour bloqué`
  String get agentDaysOffNone {
    return Intl.message(
      'Aucun jour bloqué',
      name: 'agentDaysOffNone',
      desc: 'Empty state for days off.',
      args: [],
    );
  }

  /// `Bloquer un jour`
  String get agentBlockDay {
    return Intl.message(
      'Bloquer un jour',
      name: 'agentBlockDay',
      desc: 'Add a day off.',
      args: [],
    );
  }

  /// `Aucun créneau défini`
  String get agentNoSlots {
    return Intl.message(
      'Aucun créneau défini',
      name: 'agentNoSlots',
      desc: 'Empty state for the weekly pattern.',
      args: [],
    );
  }

  /// `Modifications enregistrées`
  String get agentSaved {
    return Intl.message(
      'Modifications enregistrées',
      name: 'agentSaved',
      desc: 'Confirmation toast.',
      args: [],
    );
  }

  /// `Enregistrement impossible. Réessaie.`
  String get agentSaveFailed {
    return Intl.message(
      'Enregistrement impossible. Réessaie.',
      name: 'agentSaveFailed',
      desc: 'Generic failure toast on the agent screens.',
      args: [],
    );
  }

  /// `Lundi`
  String get dayMonday {
    return Intl.message(
      'Lundi',
      name: 'dayMonday',
      desc: 'Day of week 1.',
      args: [],
    );
  }

  /// `Mardi`
  String get dayTuesday {
    return Intl.message(
      'Mardi',
      name: 'dayTuesday',
      desc: 'Day of week 2.',
      args: [],
    );
  }

  /// `Mercredi`
  String get dayWednesday {
    return Intl.message(
      'Mercredi',
      name: 'dayWednesday',
      desc: 'Day of week 3.',
      args: [],
    );
  }

  /// `Jeudi`
  String get dayThursday {
    return Intl.message(
      'Jeudi',
      name: 'dayThursday',
      desc: 'Day of week 4.',
      args: [],
    );
  }

  /// `Vendredi`
  String get dayFriday {
    return Intl.message(
      'Vendredi',
      name: 'dayFriday',
      desc: 'Day of week 5.',
      args: [],
    );
  }

  /// `Samedi`
  String get daySaturday {
    return Intl.message(
      'Samedi',
      name: 'daySaturday',
      desc: 'Day of week 6.',
      args: [],
    );
  }

  /// `Dimanche`
  String get daySunday {
    return Intl.message(
      'Dimanche',
      name: 'daySunday',
      desc: 'Day of week 7.',
      args: [],
    );
  }

  /// `Mes agents`
  String get agentsMineTitle {
    return Intl.message(
      'Mes agents',
      name: 'agentsMineTitle',
      desc: 'M11 hub — the prestataire\'s assigned agents.',
      args: [],
    );
  }

  /// `Aucun agent assigné`
  String get agentsMineEmpty {
    return Intl.message(
      'Aucun agent assigné',
      name: 'agentsMineEmpty',
      desc: 'Empty state for Mes agents.',
      args: [],
    );
  }

  /// `Assigne un agent à un bien pour que les locataires puissent planifier une visite.`
  String get agentsMineEmptyBody {
    return Intl.message(
      'Assigne un agent à un bien pour que les locataires puissent planifier une visite.',
      name: 'agentsMineEmptyBody',
      desc: 'Doc 10 RM-M07-01 — the point of an assignment.',
      args: [],
    );
  }

  /// `{count} biens`
  String agentsPropertyCount(int count) {
    return Intl.message(
      '$count biens',
      name: 'agentsPropertyCount',
      desc: 'How many properties an agent covers.',
      args: [count],
    );
  }

  /// `En attente de réponse`
  String get agentsAwaitingResponse {
    return Intl.message(
      'En attente de réponse',
      name: 'agentsAwaitingResponse',
      desc: 'An offer the agent has not answered (RM-M11-04).',
      args: [],
    );
  }

  /// `Choisir un bien`
  String get agentsPickPropertyTitle {
    return Intl.message(
      'Choisir un bien',
      name: 'agentsPickPropertyTitle',
      desc: 'Property picker before choosing an agent.',
      args: [],
    );
  }

  /// `Un agent est assigné à un bien précis.`
  String get agentsPickPropertyBody {
    return Intl.message(
      'Un agent est assigné à un bien précis.',
      name: 'agentsPickPropertyBody',
      desc: 'Explains why a property comes first.',
      args: [],
    );
  }

  /// `Aucun bien disponible pour une assignation.`
  String get agentsPickPropertyEmpty {
    return Intl.message(
      'Aucun bien disponible pour une assignation.',
      name: 'agentsPickPropertyEmpty',
      desc: 'No assignable property.',
      args: [],
    );
  }

  /// `Liste`
  String get agentsAssignTitle {
    return Intl.message(
      'Liste',
      name: 'agentsAssignTitle',
      desc: 'Candidate picker title, matching the Annuaire design.',
      args: [],
    );
  }

  /// `Aucun agent disponible dans cette zone.`
  String get agentsAssignEmpty {
    return Intl.message(
      'Aucun agent disponible dans cette zone.',
      name: 'agentsAssignEmpty',
      desc:
          'Doc 10 RM-M15-04 / RM-M11-08 — candidates are filtered to the property\'s zone.',
      args: [],
    );
  }

  /// `{count} visites réalisées`
  String agentsVisitCount(int count) {
    return Intl.message(
      '$count visites réalisées',
      name: 'agentsVisitCount',
      desc:
          'An agent\'s completed visit count — the only quality signal available.',
      args: [count],
    );
  }

  /// `Assigner`
  String get agentsAssignAction {
    return Intl.message(
      'Assigner',
      name: 'agentsAssignAction',
      desc: 'Offer the property to this agent.',
      args: [],
    );
  }

  /// `Assigner {name} ?`
  String agentsAssignConfirmTitle(String name) {
    return Intl.message(
      'Assigner $name ?',
      name: 'agentsAssignConfirmTitle',
      desc: 'Confirmation before offering.',
      args: [name],
    );
  }

  /// `Il ou elle recevra une proposition et pourra l'accepter ou la refuser.`
  String get agentsAssignConfirmBody {
    return Intl.message(
      'Il ou elle recevra une proposition et pourra l\'accepter ou la refuser.',
      name: 'agentsAssignConfirmBody',
      desc: 'Doc 10 RM-M11-04.',
      args: [],
    );
  }

  /// `Assignation d'agent`
  String get agentsOfferSentTitle {
    return Intl.message(
      'Assignation d\'agent',
      name: 'agentsOfferSentTitle',
      desc: 'Success screen title.',
      args: [],
    );
  }

  /// `Une proposition a été envoyée à {name}`
  String agentsOfferSent(String name) {
    return Intl.message(
      'Une proposition a été envoyée à $name',
      name: 'agentsOfferSent',
      desc: 'Success screen body — an offer, not a completed assignment.',
      args: [name],
    );
  }

  /// `Tu seras notifié de sa réponse.`
  String get agentsOfferSentBody {
    return Intl.message(
      'Tu seras notifié de sa réponse.',
      name: 'agentsOfferSentBody',
      desc: 'Doc 10 RM-M11-04.',
      args: [],
    );
  }

  /// `{count} unité(s) avaient déjà un agent et ont été ignorées.`
  String agentsOfferSkipped(int count) {
    return Intl.message(
      '$count unité(s) avaient déjà un agent et ont été ignorées.',
      name: 'agentsOfferSkipped',
      desc: 'Doc 10 RM-M10bis-06.',
      args: [count],
    );
  }

  /// `Je fais les visites moi-même`
  String get agentsOwnerVisitsTitle {
    return Intl.message(
      'Je fais les visites moi-même',
      name: 'agentsOwnerVisitsTitle',
      desc: 'RM-M11-10 — the owner joins the property\'s visitor pool.',
      args: [],
    );
  }

  /// `Tu apparaîtras parmi les visiteurs proposés pour ce bien. Chaque demande te sera transmise pour confirmer un créneau.`
  String get agentsOwnerVisitsBody {
    return Intl.message(
      'Tu apparaîtras parmi les visiteurs proposés pour ce bien. Chaque demande te sera transmise pour confirmer un créneau.',
      name: 'agentsOwnerVisitsBody',
      desc: 'RM-M11-10 / RM-M15-06 — no weekly availability for an owner.',
      args: [],
    );
  }

  /// `Tes visites personnelles se règlent sur la fiche du bien.`
  String get agentsOwnerVisitsElsewhere {
    return Intl.message(
      'Tes visites personnelles se règlent sur la fiche du bien.',
      name: 'agentsOwnerVisitsElsewhere',
      desc: 'RM-M11-10 — the switch lives on the listing; this points to it.',
      args: [],
    );
  }

  /// `Agents assignés`
  String get agentsPoolTitle {
    return Intl.message(
      'Agents assignés',
      name: 'agentsPoolTitle',
      desc: 'RM-M11-01 — a property carries a pool, not one agent.',
      args: [],
    );
  }

  /// `Plusieurs agents peuvent couvrir le même bien. Le locataire choisit ensuite avec qui il visite.`
  String get agentsPoolBody {
    return Intl.message(
      'Plusieurs agents peuvent couvrir le même bien. Le locataire choisit ensuite avec qui il visite.',
      name: 'agentsPoolBody',
      desc: 'RM-M11-01 / RM-M07-01.',
      args: [],
    );
  }

  /// `Aucun agent assigné pour le moment.`
  String get agentsPoolEmpty {
    return Intl.message(
      'Aucun agent assigné pour le moment.',
      name: 'agentsPoolEmpty',
      desc: 'Empty pool.',
      args: [],
    );
  }

  /// `Ajouter un agent`
  String get agentsAddAgent {
    return Intl.message(
      'Ajouter un agent',
      name: 'agentsAddAgent',
      desc: 'Opens the candidate picker.',
      args: [],
    );
  }

  /// `Agents actifs dont la zone couvre ce bien.`
  String get agentsAddAgentBody {
    return Intl.message(
      'Agents actifs dont la zone couvre ce bien.',
      name: 'agentsAddAgentBody',
      desc: 'RM-M11-08 — the server filters the list.',
      args: [],
    );
  }

  /// `Le retrait d'un agent n'est pas encore possible lorsque plusieurs agents sont assignés à ce bien.`
  String get agentsWithdrawUnavailable {
    return Intl.message(
      'Le retrait d\'un agent n\'est pas encore possible lorsque plusieurs agents sont assignés à ce bien.',
      name: 'agentsWithdrawUnavailable',
      desc:
          'RM-M11-06 — the endpoint names no agent; see docs/backend-requests.md §12.',
      args: [],
    );
  }

  /// `Candidatures`
  String get agentsApplicationsTitle {
    return Intl.message(
      'Candidatures',
      name: 'agentsApplicationsTitle',
      desc: 'Agents who applied (RM-M11-07).',
      args: [],
    );
  }

  /// `Accepter`
  String get agentsApplicationAccept {
    return Intl.message(
      'Accepter',
      name: 'agentsApplicationAccept',
      desc: 'Accept an application.',
      args: [],
    );
  }

  /// `Refuser`
  String get agentsApplicationDecline {
    return Intl.message(
      'Refuser',
      name: 'agentsApplicationDecline',
      desc: 'Decline an application.',
      args: [],
    );
  }

  /// `Plusieurs agents peuvent couvrir le même bien : accepter cette candidature n'écarte pas les autres.`
  String get agentsAcceptWarning {
    return Intl.message(
      'Plusieurs agents peuvent couvrir le même bien : accepter cette candidature n\'écarte pas les autres.',
      name: 'agentsAcceptWarning',
      desc: 'Doc 10 RM-M11-07.',
      args: [],
    );
  }

  /// `Agent assigné`
  String get agentsCurrentTitle {
    return Intl.message(
      'Agent assigné',
      name: 'agentsCurrentTitle',
      desc: 'The live assignment on a property.',
      args: [],
    );
  }

  /// `Retirer l'assignation`
  String get agentsWithdraw {
    return Intl.message(
      'Retirer l\'assignation',
      name: 'agentsWithdraw',
      desc: 'RM-M11-06.',
      args: [],
    );
  }

  /// `Les visites déjà planifiées seront annulées.`
  String get agentsWithdrawConfirm {
    return Intl.message(
      'Les visites déjà planifiées seront annulées.',
      name: 'agentsWithdrawConfirm',
      desc: 'Doc 10 RM-M11-06 / CE-M07-02.',
      args: [],
    );
  }

  /// `Action impossible pour le moment.`
  String get agentsActionFailed {
    return Intl.message(
      'Action impossible pour le moment.',
      name: 'agentsActionFailed',
      desc: 'Generic failure on the assignment screens.',
      args: [],
    );
  }

  /// `{count} unité(s)`
  String agentsUnitsCovered(int count) {
    return Intl.message(
      '$count unité(s)',
      name: 'agentsUnitsCovered',
      desc: 'How many units a residence assignment covers.',
      args: [count],
    );
  }

  /// `Propositions`
  String get missionsTabOffers {
    return Intl.message(
      'Propositions',
      name: 'missionsTabOffers',
      desc: 'Offers awaiting the agent\'s answer.',
      args: [],
    );
  }

  /// `Mes missions`
  String get missionsTabMine {
    return Intl.message(
      'Mes missions',
      name: 'missionsTabMine',
      desc: 'Work the agent holds (RM-M11-09 — status, not origin).',
      args: [],
    );
  }

  /// `Opportunités`
  String get missionsTabOpportunities {
    return Intl.message(
      'Opportunités',
      name: 'missionsTabOpportunities',
      desc: 'Properties in the agent\'s zones with no agent (RM-M11-07).',
      args: [],
    );
  }

  /// `Aucune proposition en attente`
  String get missionsEmptyOffers {
    return Intl.message(
      'Aucune proposition en attente',
      name: 'missionsEmptyOffers',
      desc: 'Empty offers segment.',
      args: [],
    );
  }

  /// `Aucune mission en cours`
  String get missionsEmptyMine {
    return Intl.message(
      'Aucune mission en cours',
      name: 'missionsEmptyMine',
      desc: 'Empty missions segment.',
      args: [],
    );
  }

  /// `Aucune opportunité dans tes zones`
  String get missionsEmptyOpportunities {
    return Intl.message(
      'Aucune opportunité dans tes zones',
      name: 'missionsEmptyOpportunities',
      desc: 'Empty opportunities — tied to RM-M15-04 zones.',
      args: [],
    );
  }

  /// `Élargis tes zones d'intervention pour recevoir plus de propositions.`
  String get missionsEmptyOpportunitiesBody {
    return Intl.message(
      'Élargis tes zones d\'intervention pour recevoir plus de propositions.',
      name: 'missionsEmptyOpportunitiesBody',
      desc: 'Points at the fixable cause: the agent\'s zones.',
      args: [],
    );
  }

  /// `Accepter`
  String get missionsAccept {
    return Intl.message(
      'Accepter',
      name: 'missionsAccept',
      desc: 'Accept an offer.',
      args: [],
    );
  }

  /// `Refuser`
  String get missionsDecline {
    return Intl.message(
      'Refuser',
      name: 'missionsDecline',
      desc: 'Decline an offer.',
      args: [],
    );
  }

  /// `Me désister`
  String get missionsResign {
    return Intl.message(
      'Me désister',
      name: 'missionsResign',
      desc: 'RM-M11-06 — step down from a mission.',
      args: [],
    );
  }

  /// `Les visites déjà planifiées seront annulées.`
  String get missionsResignConfirm {
    return Intl.message(
      'Les visites déjà planifiées seront annulées.',
      name: 'missionsResignConfirm',
      desc: 'Doc 10 RM-M11-06 / CE-M07-02.',
      args: [],
    );
  }

  /// `Candidater`
  String get missionsApply {
    return Intl.message(
      'Candidater',
      name: 'missionsApply',
      desc: 'Apply to an opportunity.',
      args: [],
    );
  }

  /// `Candidature envoyée`
  String get missionsApplied {
    return Intl.message(
      'Candidature envoyée',
      name: 'missionsApplied',
      desc: 'The agent already applied and is waiting.',
      args: [],
    );
  }

  /// `Retirer`
  String get missionsWithdraw {
    return Intl.message(
      'Retirer',
      name: 'missionsWithdraw',
      desc: 'Take back an application.',
      args: [],
    );
  }

  /// `Le prestataire choisit parmi les candidats.`
  String get missionsApplyNote {
    return Intl.message(
      'Le prestataire choisit parmi les candidats.',
      name: 'missionsApplyNote',
      desc: 'RM-M11-07 — applying is not self-assignment.',
      args: [],
    );
  }

  /// `{count} unité(s)`
  String missionsUnits(int count) {
    return Intl.message(
      '$count unité(s)',
      name: 'missionsUnits',
      desc: 'Units a residence mission covers.',
      args: [count],
    );
  }

  /// `Action impossible pour le moment.`
  String get missionsActionFailed {
    return Intl.message(
      'Action impossible pour le moment.',
      name: 'missionsActionFailed',
      desc: 'Generic failure on the missions screen.',
      args: [],
    );
  }

  /// `Aucun bien publié`
  String get agentsPickPropertyNone {
    return Intl.message(
      'Aucun bien publié',
      name: 'agentsPickPropertyNone',
      desc: 'Picker empty state title.',
      args: [],
    );
  }

  /// `Un agent ne peut être assigné qu'à un bien publié. Publie une annonce ou une unité de résidence pour continuer.`
  String get agentsPickPropertyNoneBody {
    return Intl.message(
      'Un agent ne peut être assigné qu\'à un bien publié. Publie une annonce ou une unité de résidence pour continuer.',
      name: 'agentsPickPropertyNoneBody',
      desc:
          'The backend refuses a non-published listing (ANNONCE_NOT_PUBLISHED) and a residence with no published unit (NO_PUBLISHED_UNITS).',
      args: [],
    );
  }

  /// `Profil de l'agent`
  String get agentDetailTitle {
    return Intl.message(
      'Profil de l\'agent',
      name: 'agentDetailTitle',
      desc: 'M11 agent detail screen.',
      args: [],
    );
  }

  /// `Membre depuis {date}`
  String agentDetailMemberSince(String date) {
    return Intl.message(
      'Membre depuis $date',
      name: 'agentDetailMemberSince',
      desc: 'AgentPublicProfile.memberSince.',
      args: [date],
    );
  }

  /// `Zones d'intervention`
  String get agentDetailZones {
    return Intl.message(
      'Zones d\'intervention',
      name: 'agentDetailZones',
      desc: 'The agent\'s declared zones (RM-M15-04).',
      args: [],
    );
  }

  /// `Toute la ville`
  String get agentDetailWholeCity {
    return Intl.message(
      'Toute la ville',
      name: 'agentDetailWholeCity',
      desc: 'A zone covering a whole city — district is absent.',
      args: [],
    );
  }

  /// `Biens confiés`
  String get agentDetailProperties {
    return Intl.message(
      'Biens confiés',
      name: 'agentDetailProperties',
      desc: 'Properties this agent works for this prestataire.',
      args: [],
    );
  }

  /// `En attente de réponse`
  String get agentDetailPending {
    return Intl.message(
      'En attente de réponse',
      name: 'agentDetailPending',
      desc: 'Offers this agent has not answered.',
      args: [],
    );
  }

  /// `Aucun bien confié pour le moment`
  String get agentDetailNoProperties {
    return Intl.message(
      'Aucun bien confié pour le moment',
      name: 'agentDetailNoProperties',
      desc: 'Empty state.',
      args: [],
    );
  }

  /// `Profil indisponible`
  String get agentDetailUnavailable {
    return Intl.message(
      'Profil indisponible',
      name: 'agentDetailUnavailable',
      desc: 'The public profile could not be loaded.',
      args: [],
    );
  }

  /// `Pas encore noté`
  String get agentRatingNone {
    return Intl.message(
      'Pas encore noté',
      name: 'agentRatingNone',
      desc: 'averageRating is null until someone rates — never render 0 ★.',
      args: [],
    );
  }

  /// `{count} avis`
  String agentRatingCount(int count) {
    return Intl.message(
      '$count avis',
      name: 'agentRatingCount',
      desc: 'How many ratings the average rests on.',
      args: [count],
    );
  }

  /// `Aujourd'hui`
  String get visitsTabToday {
    return Intl.message(
      'Aujourd\'hui',
      name: 'visitsTabToday',
      desc: 'M16 list tab.',
      args: [],
    );
  }

  /// `À venir`
  String get visitsTabUpcoming {
    return Intl.message(
      'À venir',
      name: 'visitsTabUpcoming',
      desc: 'M16 list tab.',
      args: [],
    );
  }

  /// `Passées`
  String get visitsTabPast {
    return Intl.message(
      'Passées',
      name: 'visitsTabPast',
      desc: 'M16 list tab — done, cancelled, and missed.',
      args: [],
    );
  }

  /// `Aucune visite aujourd'hui`
  String get visitsEmptyToday {
    return Intl.message(
      'Aucune visite aujourd\'hui',
      name: 'visitsEmptyToday',
      desc: 'Empty today.',
      args: [],
    );
  }

  /// `Aucune visite prévue`
  String get visitsEmptyUpcoming {
    return Intl.message(
      'Aucune visite prévue',
      name: 'visitsEmptyUpcoming',
      desc: 'Empty upcoming.',
      args: [],
    );
  }

  /// `Aucune visite passée`
  String get visitsEmptyPast {
    return Intl.message(
      'Aucune visite passée',
      name: 'visitsEmptyPast',
      desc: 'Empty past.',
      args: [],
    );
  }

  /// `Prévue`
  String get visitsStatusScheduled {
    return Intl.message(
      'Prévue',
      name: 'visitsStatusScheduled',
      desc: 'VisiteResponse.status = SCHEDULED.',
      args: [],
    );
  }

  /// `Effectuée`
  String get visitsStatusCompleted {
    return Intl.message(
      'Effectuée',
      name: 'visitsStatusCompleted',
      desc: 'VisiteResponse.status = COMPLETED.',
      args: [],
    );
  }

  /// `Annulée`
  String get visitsStatusCancelled {
    return Intl.message(
      'Annulée',
      name: 'visitsStatusCancelled',
      desc: 'VisiteResponse.status = CANCELLED.',
      args: [],
    );
  }

  /// `Mes visites`
  String get visitsTitle {
    return Intl.message(
      'Mes visites',
      name: 'visitsTitle',
      desc: 'Agent agenda screen title.',
      args: [],
    );
  }

  /// `Mes visites`
  String get visitsMineTitle {
    return Intl.message(
      'Mes visites',
      name: 'visitsMineTitle',
      desc:
          'Prestataire agenda — the visits he carries out himself (RM-M11-10).',
      args: [],
    );
  }

  /// `Demandes à confirmer`
  String get visitsRequestsTitle {
    return Intl.message(
      'Demandes à confirmer',
      name: 'visitsRequestsTitle',
      desc: 'RM-M15-06 — proposed times awaiting the owner\'s answer.',
      args: [],
    );
  }

  /// `Un locataire propose un créneau. Confirme-le ou refuse-le : il pourra en proposer un autre.`
  String get visitsRequestsBody {
    return Intl.message(
      'Un locataire propose un créneau. Confirme-le ou refuse-le : il pourra en proposer un autre.',
      name: 'visitsRequestsBody',
      desc: 'RM-M15-06.',
      args: [],
    );
  }

  /// `Confirmer le créneau`
  String get visitsRequestConfirm {
    return Intl.message(
      'Confirmer le créneau',
      name: 'visitsRequestConfirm',
      desc: 'RM-M15-06.',
      args: [],
    );
  }

  /// `Refuser`
  String get visitsRequestDecline {
    return Intl.message(
      'Refuser',
      name: 'visitsRequestDecline',
      desc: 'RM-M15-06.',
      args: [],
    );
  }

  /// `Avis de visite`
  String get reviewTitle {
    return Intl.message(
      'Avis de visite',
      name: 'reviewTitle',
      desc: 'M07bis — the client\'s report on the visit.',
      args: [],
    );
  }

  /// `Aucun avis pour le moment`
  String get reviewNoneTitle {
    return Intl.message(
      'Aucun avis pour le moment',
      name: 'reviewNoneTitle',
      desc: 'RM-M07bis-02 — writing is optional and undated.',
      args: [],
    );
  }

  /// `Le locataire peut publier son avis quand il le souhaite. Tu seras notifié dès qu'il l'aura fait.`
  String get reviewNoneBody {
    return Intl.message(
      'Le locataire peut publier son avis quand il le souhaite. Tu seras notifié dès qu\'il l\'aura fait.',
      name: 'reviewNoneBody',
      desc: 'RM-M07bis-02 / N-18.',
      args: [],
    );
  }

  /// `Ce que le locataire a vu`
  String get reviewWhatTheySaw {
    return Intl.message(
      'Ce que le locataire a vu',
      name: 'reviewWhatTheySaw',
      desc: 'The evaluative body of the review.',
      args: [],
    );
  }

  /// `Points positifs`
  String get reviewPros {
    return Intl.message(
      'Points positifs',
      name: 'reviewPros',
      desc: 'RM-M07bis content.',
      args: [],
    );
  }

  /// `Points négatifs`
  String get reviewCons {
    return Intl.message(
      'Points négatifs',
      name: 'reviewCons',
      desc: 'RM-M07bis content.',
      args: [],
    );
  }

  /// `État général perçu : {value}/5`
  String reviewCondition(int value) {
    return Intl.message(
      'État général perçu : $value/5',
      name: 'reviewCondition',
      desc: 'perceivedCondition.',
      args: [value],
    );
  }

  /// `Compte supprimé`
  String get reviewDeletedAuthor {
    return Intl.message(
      'Compte supprimé',
      name: 'reviewDeletedAuthor',
      desc: 'RM-M07bis-08 — the review outlives its author.',
      args: [],
    );
  }

  /// `Tes réponses`
  String get reviewCommentsTitle {
    return Intl.message(
      'Tes réponses',
      name: 'reviewCommentsTitle',
      desc: 'RM-M07bis-04 — the visitor\'s comments.',
      args: [],
    );
  }

  /// `Tu n'as pas encore répondu à cet avis.`
  String get reviewCommentsEmpty {
    return Intl.message(
      'Tu n\'as pas encore répondu à cet avis.',
      name: 'reviewCommentsEmpty',
      desc: 'No comments yet.',
      args: [],
    );
  }

  /// `Répondre à cet avis…`
  String get reviewCommentHint {
    return Intl.message(
      'Répondre à cet avis…',
      name: 'reviewCommentHint',
      desc: 'Composer placeholder.',
      args: [],
    );
  }

  /// `Ta réponse s'ajoute à l'avis : elle ne modifie ni la note ni le texte du locataire.`
  String get reviewCommentRule {
    return Intl.message(
      'Ta réponse s\'ajoute à l\'avis : elle ne modifie ni la note ni le texte du locataire.',
      name: 'reviewCommentRule',
      desc: 'RM-M07bis-04 — the asymmetry, said plainly.',
      args: [],
    );
  }

  /// `Publier ma réponse`
  String get reviewCommentSend {
    return Intl.message(
      'Publier ma réponse',
      name: 'reviewCommentSend',
      desc: 'Submit a comment.',
      args: [],
    );
  }

  /// `Réponse publiée`
  String get reviewCommentSent {
    return Intl.message(
      'Réponse publiée',
      name: 'reviewCommentSent',
      desc: 'Toast after commenting.',
      args: [],
    );
  }

  /// `Exporter en PDF`
  String get reviewExport {
    return Intl.message(
      'Exporter en PDF',
      name: 'reviewExport',
      desc: 'RM-M07bis-06.',
      args: [],
    );
  }

  /// `Ton avis de locataire`
  String get residentReviewTitle {
    return Intl.message(
      'Ton avis de locataire',
      name: 'residentReviewTitle',
      desc: 'M27 — the resident review screen.',
      args: [],
    );
  }

  /// `Publié sur la fiche du bien. Tu peux le corriger tant que tu habites là, et 30 jours après ton départ.`
  String get residentReviewSubtitle {
    return Intl.message(
      'Publié sur la fiche du bien. Tu peux le corriger tant que tu habites là, et 30 jours après ton départ.',
      name: 'residentReviewSubtitle',
      desc: 'M27 RM-M27-02 — the editing window, said plainly.',
      args: [],
    );
  }

  /// `Laisser mon avis`
  String get residentReviewCta {
    return Intl.message(
      'Laisser mon avis',
      name: 'residentReviewCta',
      desc: 'M27 — opens the form from the contract.',
      args: [],
    );
  }

  /// `Modifier mon avis`
  String get residentReviewEditCta {
    return Intl.message(
      'Modifier mon avis',
      name: 'residentReviewEditCta',
      desc: 'M27 — same entry point once a review exists.',
      args: [],
    );
  }

  /// `Enregistrer mes corrections`
  String get residentReviewSave {
    return Intl.message(
      'Enregistrer mes corrections',
      name: 'residentReviewSave',
      desc: 'M27 — submits a correction rather than a first review.',
      args: [],
    );
  }

  /// `Avis mis à jour`
  String get residentReviewSaved {
    return Intl.message(
      'Avis mis à jour',
      name: 'residentReviewSaved',
      desc: 'M27 — confirmation after a correction.',
      args: [],
    );
  }

  /// `Avis verrouillé`
  String get residentReviewLockedTitle {
    return Intl.message(
      'Avis verrouillé',
      name: 'residentReviewLockedTitle',
      desc: 'M27 RM-M27-02 — the window has closed.',
      args: [],
    );
  }

  /// `La période de modification est passée. Ton avis reste publié sur la fiche.`
  String get residentReviewLockedBody {
    return Intl.message(
      'La période de modification est passée. Ton avis reste publié sur la fiche.',
      name: 'residentReviewLockedBody',
      desc: 'M27 — and the review still stands.',
      args: [],
    );
  }

  /// `Un avis de locataire pèse trois fois plus qu'un avis de visite dans la note du bien.`
  String get residentReviewWeight {
    return Intl.message(
      'Un avis de locataire pèse trois fois plus qu\'un avis de visite dans la note du bien.',
      name: 'residentReviewWeight',
      desc: 'M27 RG-06 — why this review matters more.',
      args: [],
    );
  }

  /// `L'avis de ton locataire`
  String get residentReviewReadTitle {
    return Intl.message(
      'L\'avis de ton locataire',
      name: 'residentReviewReadTitle',
      desc: 'M27 — the landlord reading the review.',
      args: [],
    );
  }

  /// `Voir l'avis du locataire`
  String get residentReviewSeeCta {
    return Intl.message(
      'Voir l\'avis du locataire',
      name: 'residentReviewSeeCta',
      desc: 'M27 — opens it from the contract.',
      args: [],
    );
  }

  /// `Ta réponse`
  String get residentReplyTitle {
    return Intl.message(
      'Ta réponse',
      name: 'residentReplyTitle',
      desc: 'M27 RM-M27-03 — the answer composer.',
      args: [],
    );
  }

  /// `Ta réponse s'ajoute à l'avis, une seule fois. Elle ne modifie ni la note ni le texte de ton locataire.`
  String get residentReplyRule {
    return Intl.message(
      'Ta réponse s\'ajoute à l\'avis, une seule fois. Elle ne modifie ni la note ni le texte de ton locataire.',
      name: 'residentReplyRule',
      desc: 'M27 RM-M27-03 — once, and it changes nothing.',
      args: [],
    );
  }

  /// `Réponds publiquement à cet avis…`
  String get residentReplyHint {
    return Intl.message(
      'Réponds publiquement à cet avis…',
      name: 'residentReplyHint',
      desc: 'M27 — the answer field.',
      args: [],
    );
  }

  /// `Publier ma réponse`
  String get residentReplySend {
    return Intl.message(
      'Publier ma réponse',
      name: 'residentReplySend',
      desc: 'M27 — publishes the answer.',
      args: [],
    );
  }

  /// `Réponse publiée`
  String get residentReplySent {
    return Intl.message(
      'Réponse publiée',
      name: 'residentReplySent',
      desc: 'M27 — confirmation.',
      args: [],
    );
  }

  /// `Tu as déjà répondu à cet avis.`
  String get residentReplyDone {
    return Intl.message(
      'Tu as déjà répondu à cet avis.',
      name: 'residentReplyDone',
      desc: 'M27 RM-M27-03 — one answer per review.',
      args: [],
    );
  }

  /// `Ton locataire peut publier son avis quand il le souhaite, pendant tout le bail.`
  String get residentReviewNoneBody {
    return Intl.message(
      'Ton locataire peut publier son avis quand il le souhaite, pendant tout le bail.',
      name: 'residentReviewNoneBody',
      desc: 'M27 — no review yet, from the landlord side.',
      args: [],
    );
  }

  /// `Voir l'avis du locataire`
  String get visitsReviewOpen {
    return Intl.message(
      'Voir l\'avis du locataire',
      name: 'visitsReviewOpen',
      desc: 'Entry point from a visit.',
      args: [],
    );
  }

  /// `Avis de visite`
  String get visitsReviewCta {
    return Intl.message(
      'Avis de visite',
      name: 'visitsReviewCta',
      desc: 'Card title on the visit detail.',
      args: [],
    );
  }

  /// `Aucune visite ce jour-là.`
  String get visitsAgendaEmptyDay {
    return Intl.message(
      'Aucune visite ce jour-là.',
      name: 'visitsAgendaEmptyDay',
      desc: 'Empty day in the agenda.',
      args: [],
    );
  }

  /// `Aujourd'hui`
  String get visitsAgendaToday {
    return Intl.message(
      'Aujourd\'hui',
      name: 'visitsAgendaToday',
      desc: 'Jumps the agenda back to the current week.',
      args: [],
    );
  }

  /// `Semaine précédente`
  String get visitsAgendaPreviousWeek {
    return Intl.message(
      'Semaine précédente',
      name: 'visitsAgendaPreviousWeek',
      desc: 'Strip arrow tooltip.',
      args: [],
    );
  }

  /// `Semaine suivante`
  String get visitsAgendaNextWeek {
    return Intl.message(
      'Semaine suivante',
      name: 'visitsAgendaNextWeek',
      desc: 'Strip arrow tooltip.',
      args: [],
    );
  }

  /// `Détail de la visite`
  String get visitsDetailTitle {
    return Intl.message(
      'Détail de la visite',
      name: 'visitsDetailTitle',
      desc: 'M16 detail screen.',
      args: [],
    );
  }

  /// `Confirmation de présence`
  String get visitsPresenceTitle {
    return Intl.message(
      'Confirmation de présence',
      name: 'visitsPresenceTitle',
      desc: 'RM-M07-05 — the mutual confirmation section.',
      args: [],
    );
  }

  /// `Toi`
  String get visitsPresenceYou {
    return Intl.message(
      'Toi',
      name: 'visitsPresenceYou',
      desc: 'The visitor\'s own half of the confirmation.',
      args: [],
    );
  }

  /// `Locataire`
  String get visitsPresenceClient {
    return Intl.message(
      'Locataire',
      name: 'visitsPresenceClient',
      desc: 'The client\'s half.',
      args: [],
    );
  }

  /// `En attente`
  String get visitsPresencePending {
    return Intl.message(
      'En attente',
      name: 'visitsPresencePending',
      desc: 'No timestamp yet on that half.',
      args: [],
    );
  }

  /// `Confirmé à {time}`
  String visitsPresenceConfirmedAt(String time) {
    return Intl.message(
      'Confirmé à $time',
      name: 'visitsPresenceConfirmedAt',
      desc: 'One half is in, with the hour it was.',
      args: [time],
    );
  }

  /// `La visite n'est validée que lorsque les deux présences sont confirmées.`
  String get visitsPresenceExplain {
    return Intl.message(
      'La visite n\'est validée que lorsque les deux présences sont confirmées.',
      name: 'visitsPresenceExplain',
      desc: 'RM-M07-05 — neither party can supply the other\'s.',
      args: [],
    );
  }

  /// `Contacts`
  String get visitsContactsTitle {
    return Intl.message(
      'Contacts',
      name: 'visitsContactsTitle',
      desc: 'The visit\'s two contacts (RM-M16-01).',
      args: [],
    );
  }

  /// `Numéro copié`
  String get visitsPhoneCopied {
    return Intl.message(
      'Numéro copié',
      name: 'visitsPhoneCopied',
      desc: 'Toast after tapping a contact row.',
      args: [],
    );
  }

  /// `Adresse exacte`
  String get visitsAddress {
    return Intl.message(
      'Adresse exacte',
      name: 'visitsAddress',
      desc: 'RM-M16-01 — only the agent\'s view shows it.',
      args: [],
    );
  }

  /// `Visible uniquement par toi, pour cette visite.`
  String get visitsAddressNote {
    return Intl.message(
      'Visible uniquement par toi, pour cette visite.',
      name: 'visitsAddressNote',
      desc: 'RM-M16-01.',
      args: [],
    );
  }

  /// `Locataire`
  String get visitsTenant {
    return Intl.message(
      'Locataire',
      name: 'visitsTenant',
      desc: 'The user who booked.',
      args: [],
    );
  }

  /// `Prestataire`
  String get visitsOwner {
    return Intl.message(
      'Prestataire',
      name: 'visitsOwner',
      desc: 'The property owner.',
      args: [],
    );
  }

  /// `Appeler`
  String get visitsCall {
    return Intl.message(
      'Appeler',
      name: 'visitsCall',
      desc: 'Dial a contact.',
      args: [],
    );
  }

  /// `Localisation en cours…`
  String get visitsLocating {
    return Intl.message(
      'Localisation en cours…',
      name: 'visitsLocating',
      desc: 'Taking the GPS fix.',
      args: [],
    );
  }

  /// `Tu sembles loin du bien`
  String get visitsTooFarTitle {
    return Intl.message(
      'Tu sembles loin du bien',
      name: 'visitsTooFarTitle',
      desc: 'RM-M16-02 — beyond 500 m.',
      args: [],
    );
  }

  /// `Tu es à environ {distance} m. Explique pourquoi tu confirmes ta présence depuis cet endroit.`
  String visitsTooFarBody(int distance) {
    return Intl.message(
      'Tu es à environ $distance m. Explique pourquoi tu confirmes ta présence depuis cet endroit.',
      name: 'visitsTooFarBody',
      desc: 'The justification Doc 10 asks for.',
      args: [distance],
    );
  }

  /// `Ex. GPS imprécis, je suis au portail`
  String get visitsTooFarHint {
    return Intl.message(
      'Ex. GPS imprécis, je suis au portail',
      name: 'visitsTooFarHint',
      desc: 'Placeholder for the justification.',
      args: [],
    );
  }

  /// `Confirmer quand même`
  String get visitsTooFarConfirm {
    return Intl.message(
      'Confirmer quand même',
      name: 'visitsTooFarConfirm',
      desc: 'Confirm with a justification.',
      args: [],
    );
  }

  /// `Autorise la localisation pour confirmer ta présence.`
  String get visitsLocationDenied {
    return Intl.message(
      'Autorise la localisation pour confirmer ta présence.',
      name: 'visitsLocationDenied',
      desc: 'LocationFailure.denied.',
      args: [],
    );
  }

  /// `La localisation est bloquée. Active-la dans les réglages du téléphone.`
  String get visitsLocationDeniedForever {
    return Intl.message(
      'La localisation est bloquée. Active-la dans les réglages du téléphone.',
      name: 'visitsLocationDeniedForever',
      desc: 'LocationFailure.deniedForever.',
      args: [],
    );
  }

  /// `Active la localisation de ton téléphone.`
  String get visitsLocationDisabled {
    return Intl.message(
      'Active la localisation de ton téléphone.',
      name: 'visitsLocationDisabled',
      desc: 'LocationFailure.disabled.',
      args: [],
    );
  }

  /// `Position introuvable. Réessaie dans un instant.`
  String get visitsLocationUnavailable {
    return Intl.message(
      'Position introuvable. Réessaie dans un instant.',
      name: 'visitsLocationUnavailable',
      desc: 'LocationFailure.unavailable.',
      args: [],
    );
  }

  /// `Annuler la visite`
  String get visitsCancel {
    return Intl.message(
      'Annuler la visite',
      name: 'visitsCancel',
      desc: 'RM-M16-04.',
      args: [],
    );
  }

  /// `Demandée`
  String get visitsStatusRequested {
    return Intl.message(
      'Demandée',
      name: 'visitsStatusRequested',
      desc:
          'VisiteResponse.status = REQUESTED — awaiting the owner\'s confirmation (RM-M15-06).',
      args: [],
    );
  }

  /// `Non honorée`
  String get visitsStatusNotFulfilled {
    return Intl.message(
      'Non honorée',
      name: 'visitsStatusNotFulfilled',
      desc: 'VisiteResponse.status = NOT_FULFILLED (RM-M16-05).',
      args: [],
    );
  }

  /// `Confirmer ma présence`
  String get visitsConfirmPresence {
    return Intl.message(
      'Confirmer ma présence',
      name: 'visitsConfirmPresence',
      desc:
          'RM-M07-05 / RM-M16-02 — the agent\'s half of the mutual confirmation.',
      args: [],
    );
  }

  /// `Le locataire doit confirmer de son côté pour que la visite soit validée.`
  String get visitsConfirmPresenceHint {
    return Intl.message(
      'Le locataire doit confirmer de son côté pour que la visite soit validée.',
      name: 'visitsConfirmPresenceHint',
      desc: 'RM-M07-05 — one confirmation is never enough.',
      args: [],
    );
  }

  /// `Disponible le jour de la visite`
  String get visitsConfirmNotYet {
    return Intl.message(
      'Disponible le jour de la visite',
      name: 'visitsConfirmNotYet',
      desc: 'canConfirm is false — the server decides.',
      args: [],
    );
  }

  /// `Présence confirmée`
  String get visitsAwaitingClientTitle {
    return Intl.message(
      'Présence confirmée',
      name: 'visitsAwaitingClientTitle',
      desc: 'visitorConfirmedAt is set, clientConfirmedAt is not.',
      args: [],
    );
  }

  /// `En attente de la confirmation du locataire. La visite sera validée dès qu'il aura confirmé de son côté.`
  String get visitsAwaitingClientBody {
    return Intl.message(
      'En attente de la confirmation du locataire. La visite sera validée dès qu\'il aura confirmé de son côté.',
      name: 'visitsAwaitingClientBody',
      desc: 'RM-M07-05.',
      args: [],
    );
  }

  /// `Visite effectuée`
  String get visitsCompletedTitle {
    return Intl.message(
      'Visite effectuée',
      name: 'visitsCompletedTitle',
      desc: 'Both parties confirmed (RM-M16-03).',
      args: [],
    );
  }

  /// `Les deux présences ont été confirmées. Le locataire peut désormais publier son avis sur le bien.`
  String get visitsCompletedBody {
    return Intl.message(
      'Les deux présences ont été confirmées. Le locataire peut désormais publier son avis sur le bien.',
      name: 'visitsCompletedBody',
      desc: 'RM-M07bis — the report is the client\'s to write.',
      args: [],
    );
  }

  /// `Visite non honorée`
  String get visitsNotFulfilledTitle {
    return Intl.message(
      'Visite non honorée',
      name: 'visitsNotFulfilledTitle',
      desc: 'RM-M16-05.',
      args: [],
    );
  }

  /// `Aucune présence n'a été confirmée pendant le créneau. Cette visite ne peut plus être démarrée.`
  String get visitsNotFulfilledBody {
    return Intl.message(
      'Aucune présence n\'a été confirmée pendant le créneau. Cette visite ne peut plus être démarrée.',
      name: 'visitsNotFulfilledBody',
      desc: 'RM-M16-05 — no automatic penalty; the admin is alerted.',
      args: [],
    );
  }

  /// `Possible jusqu'à 1 heure avant le créneau. Le locataire sera prévenu.`
  String get visitsCancelConfirm {
    return Intl.message(
      'Possible jusqu\'à 1 heure avant le créneau. Le locataire sera prévenu.',
      name: 'visitsCancelConfirm',
      desc: 'RM-M16-04.',
      args: [],
    );
  }

  /// `Action impossible pour le moment.`
  String get visitsActionFailed {
    return Intl.message(
      'Action impossible pour le moment.',
      name: 'visitsActionFailed',
      desc: 'Generic failure on the visits screens.',
      args: [],
    );
  }

  /// `Tu as annulé cette visite.`
  String get visitCancelledByClient {
    return Intl.message(
      'Tu as annulé cette visite.',
      name: 'visitCancelledByClient',
      desc: 'M07 — cancellationReason BY_USER.',
      args: [],
    );
  }

  /// `Le visiteur a annulé cette visite.`
  String get visitCancelledByVisitor {
    return Intl.message(
      'Le visiteur a annulé cette visite.',
      name: 'visitCancelledByVisitor',
      desc:
          'M07 — cancellationReason BY_AGENT: the agent or owner who was to show the property.',
      args: [],
    );
  }

  /// `L'agent n'est plus disponible pour cette visite.`
  String get visitCancelledAgentUnavailable {
    return Intl.message(
      'L\'agent n\'est plus disponible pour cette visite.',
      name: 'visitCancelledAgentUnavailable',
      desc: 'M07 — cancellationReason AGENT_UNAVAILABLE (assignment revoked).',
      args: [],
    );
  }

  /// `L'agent ne s'occupe plus de ce bien.`
  String get visitCancelledAgentRemoved {
    return Intl.message(
      'L\'agent ne s\'occupe plus de ce bien.',
      name: 'visitCancelledAgentRemoved',
      desc:
          'M07 — cancellationReason AGENT_REMOVED (withdrawal or resignation).',
      args: [],
    );
  }

  /// `L'annonce n'est plus en ligne.`
  String get visitCancelledListingUnavailable {
    return Intl.message(
      'L\'annonce n\'est plus en ligne.',
      name: 'visitCancelledListingUnavailable',
      desc:
          'CE-M07-04 — cancellationReason LISTING_UNAVAILABLE; wording from the backend.',
      args: [],
    );
  }

  /// `Chercher un autre logement`
  String get visitSearchAgain {
    return Intl.message(
      'Chercher un autre logement',
      name: 'visitSearchAgain',
      desc:
          'CE-M07-04 — offered instead of rebooking a listing that left the market.',
      args: [],
    );
  }

  /// `Annulée par le locataire`
  String get visitsCancelledByClient {
    return Intl.message(
      'Annulée par le locataire',
      name: 'visitsCancelledByClient',
      desc: 'Pro agenda — cancellationReason BY_USER.',
      args: [],
    );
  }

  /// `Annulée par le visiteur`
  String get visitsCancelledByVisitor {
    return Intl.message(
      'Annulée par le visiteur',
      name: 'visitsCancelledByVisitor',
      desc: 'Pro agenda — cancellationReason BY_AGENT (agent or owner).',
      args: [],
    );
  }

  /// `Agent plus disponible`
  String get visitsCancelledAgentUnavailable {
    return Intl.message(
      'Agent plus disponible',
      name: 'visitsCancelledAgentUnavailable',
      desc: 'Pro agenda — cancellationReason AGENT_UNAVAILABLE.',
      args: [],
    );
  }

  /// `Agent retiré du bien`
  String get visitsCancelledAgentRemoved {
    return Intl.message(
      'Agent retiré du bien',
      name: 'visitsCancelledAgentRemoved',
      desc: 'Pro agenda — cancellationReason AGENT_REMOVED.',
      args: [],
    );
  }

  /// `Annonce retirée du marché`
  String get visitsCancelledListingUnavailable {
    return Intl.message(
      'Annonce retirée du marché',
      name: 'visitsCancelledListingUnavailable',
      desc: 'Pro agenda — cancellationReason LISTING_UNAVAILABLE.',
      args: [],
    );
  }

  /// `Expirée après 30 jours`
  String get annonceExpiredTitle {
    return Intl.message(
      'Expirée après 30 jours',
      name: 'annonceExpiredTitle',
      desc: 'RM-M10-04 — archivedReason EXPIRED, on the listing detail.',
      args: [],
    );
  }

  /// `Sur la formule gratuite, une annonce reste en ligne 30 jours. Désarchive-la puis publie-la : elle repart pour 30 jours.`
  String get annonceExpiredBody {
    return Intl.message(
      'Sur la formule gratuite, une annonce reste en ligne 30 jours. Désarchive-la puis publie-la : elle repart pour 30 jours.',
      name: 'annonceExpiredBody',
      desc: 'RM-M10-04 — how an expired listing comes back.',
      args: [],
    );
  }

  /// `Archivée : limite de la formule gratuite`
  String get annoncePlanLimitTitle {
    return Intl.message(
      'Archivée : limite de la formule gratuite',
      name: 'annoncePlanLimitTitle',
      desc:
          'archivedReason PLAN_LIMIT — a paid plan lapsed and the listing was over the Free limit.',
      args: [],
    );
  }

  /// `Ta formule a pris fin et cette annonce dépassait la limite gratuite. Passe à une formule payante, ou archive une autre annonce pour lui faire de la place.`
  String get annoncePlanLimitBody {
    return Intl.message(
      'Ta formule a pris fin et cette annonce dépassait la limite gratuite. Passe à une formule payante, ou archive une autre annonce pour lui faire de la place.',
      name: 'annoncePlanLimitBody',
      desc: 'archivedReason PLAN_LIMIT — the two ways back.',
      args: [],
    );
  }

  /// `{count, plural, =0{Expire aujourd'hui} =1{Expire demain} other{Expire dans {count} jours}}`
  String annonceExpiresIn(int count) {
    return Intl.plural(
      count,
      zero: 'Expire aujourd\'hui',
      one: 'Expire demain',
      other: 'Expire dans $count jours',
      name: 'annonceExpiresIn',
      desc: 'RM-M10-04 — countdown on a live Free-tier listing.',
      args: [count],
    );
  }

  /// `Sur la formule gratuite, une annonce reste en ligne 30 jours. Une formule payante la garde en ligne sans limite.`
  String get annonceExpiresBody {
    return Intl.message(
      'Sur la formule gratuite, une annonce reste en ligne 30 jours. Une formule payante la garde en ligne sans limite.',
      name: 'annonceExpiresBody',
      desc: 'RM-M10-04 / RG-02 — why the countdown exists.',
      args: [],
    );
  }

  /// `Voir les formules`
  String get annonceSeePlans {
    return Intl.message(
      'Voir les formules',
      name: 'annonceSeePlans',
      desc: 'Opens the subscription screen from a listing\'s lifecycle notice.',
      args: [],
    );
  }

  /// `Expirée`
  String get annonceCardExpired {
    return Intl.message(
      'Expirée',
      name: 'annonceCardExpired',
      desc: 'Listing card — archivedReason EXPIRED.',
      args: [],
    );
  }

  /// `Limite de formule`
  String get annonceCardPlanLimit {
    return Intl.message(
      'Limite de formule',
      name: 'annonceCardPlanLimit',
      desc: 'Listing card — archivedReason PLAN_LIMIT.',
      args: [],
    );
  }

  /// `Notifications`
  String get settingsNotifications {
    return Intl.message(
      'Notifications',
      name: 'settingsNotifications',
      desc: 'Paramètres — entry to the notification switches (RM-M03-01).',
      args: [],
    );
  }

  /// `Notifications`
  String get notifPrefsTitle {
    return Intl.message(
      'Notifications',
      name: 'notifPrefsTitle',
      desc: 'Notification preferences screen title.',
      args: [],
    );
  }

  /// `Les alertes essentielles (contrats, paiements, modération, badges) restent toujours actives.`
  String get notifPrefsMandatoryNote {
    return Intl.message(
      'Les alertes essentielles (contrats, paiements, modération, badges) restent toujours actives.',
      name: 'notifPrefsMandatoryNote',
      desc: 'RM-M03-01 — the mandatory types get no switch; this line says so.',
      args: [],
    );
  }

  /// `Impossible de charger tes réglages. Vérifie ta connexion.`
  String get notifPrefsLoadFailed {
    return Intl.message(
      'Impossible de charger tes réglages. Vérifie ta connexion.',
      name: 'notifPrefsLoadFailed',
      desc:
          'Notification preferences could not be loaded (offline or server error).',
      args: [],
    );
  }

  /// `Ce réglage n'a pas été enregistré. Réessaie.`
  String get notifPrefsSaveFailed {
    return Intl.message(
      'Ce réglage n\'a pas été enregistré. Réessaie.',
      name: 'notifPrefsSaveFailed',
      desc: 'A switch was put back because the save failed.',
      args: [],
    );
  }

  /// `Cette notification ne peut pas être coupée.`
  String get notifPrefsMandatoryRefused {
    return Intl.message(
      'Cette notification ne peut pas être coupée.',
      name: 'notifPrefsMandatoryRefused',
      desc: 'Server answered NOTIFICATION_MANDATORY.',
      args: [],
    );
  }

  /// `Nouvelles annonces pour mes recherches`
  String get notifPrefN01 {
    return Intl.message(
      'Nouvelles annonces pour mes recherches',
      name: 'notifPrefN01',
      desc: 'N-01 — a saved search has new matches.',
      args: [],
    );
  }

  /// `Nouveaux contacts sur mes annonces`
  String get notifPrefN02 {
    return Intl.message(
      'Nouveaux contacts sur mes annonces',
      name: 'notifPrefN02',
      desc: 'N-02 — a user contacted a listing.',
      args: [],
    );
  }

  /// `Visites confirmées`
  String get notifPrefN03 {
    return Intl.message(
      'Visites confirmées',
      name: 'notifPrefN03',
      desc: 'N-03 — a visit request sent, or a visit confirmed / scheduled.',
      args: [],
    );
  }

  /// `Nouvelles demandes de visite`
  String get notifPrefN04 {
    return Intl.message(
      'Nouvelles demandes de visite',
      name: 'notifPrefN04',
      desc: 'N-04 — a new visit request (owner) or a new visit (agent).',
      args: [],
    );
  }

  /// `Visites annulées`
  String get notifPrefN05 {
    return Intl.message(
      'Visites annulées',
      name: 'notifPrefN05',
      desc: 'N-05 — a visit cancelled, declined or withdrawn.',
      args: [],
    );
  }

  /// `Annonces bientôt expirées`
  String get notifPrefN10 {
    return Intl.message(
      'Annonces bientôt expirées',
      name: 'notifPrefN10',
      desc: 'N-10 — a Free listing expires in 5 days.',
      args: [],
    );
  }

  /// `Attributions d'agents`
  String get notifPrefN15 {
    return Intl.message(
      'Attributions d\'agents',
      name: 'notifPrefN15',
      desc:
          'N-15 — an agent assignment offered, declined, withdrawn or revoked.',
      args: [],
    );
  }

  /// `Rappel pour laisser un avis`
  String get notifPrefN18 {
    return Intl.message(
      'Rappel pour laisser un avis',
      name: 'notifPrefN18',
      desc: 'N-18 — the day-after nudge to review a visit.',
      args: [],
    );
  }

  /// `Réponses à mes avis`
  String get notifPrefN21 {
    return Intl.message(
      'Réponses à mes avis',
      name: 'notifPrefN21',
      desc:
          'N-21 — an answer was published under the user\'s review (label asked for by the backend).',
      args: [],
    );
  }

  /// `Fin de l'option Gestion financière`
  String get notifPrefN26 {
    return Intl.message(
      'Fin de l\'option Gestion financière',
      name: 'notifPrefN26',
      desc: 'N-26 — the finance add-on ends in 7 days.',
      args: [],
    );
  }

  /// `Rappels de facture`
  String get notifPrefN23 {
    return Intl.message(
      'Rappels de facture',
      name: 'notifPrefN23',
      desc: 'N-23 — an invoice is due in 3 days (tenant).',
      args: [],
    );
  }

  /// `Factures payées`
  String get notifPrefN25 {
    return Intl.message(
      'Factures payées',
      name: 'notifPrefN25',
      desc: 'N-25 — a tenant paid an invoice in the app (owner).',
      args: [],
    );
  }

  /// `Recherches sauvegardées`
  String get savedSearchesTitle {
    return Intl.message(
      'Recherches sauvegardées',
      name: 'savedSearchesTitle',
      desc: 'RM-M04-07 — list title, Compte tile.',
      args: [],
    );
  }

  /// `{count} sur {limit}`
  String savedSearchesCount(int count, int limit) {
    return Intl.message(
      '$count sur $limit',
      name: 'savedSearchesCount',
      desc: 'How many saved searches, out of the MVP limit (3).',
      args: [count, limit],
    );
  }

  /// `Aucune recherche sauvegardée. Lance une recherche, puis touche le signet pour être prévenu des nouveaux biens.`
  String get savedSearchesEmpty {
    return Intl.message(
      'Aucune recherche sauvegardée. Lance une recherche, puis touche le signet pour être prévenu des nouveaux biens.',
      name: 'savedSearchesEmpty',
      desc: 'Empty saved-search list.',
      args: [],
    );
  }

  /// `Hors ligne : voici tes recherches telles qu'enregistrées. Tu pourras les modifier une fois reconnecté.`
  String get savedSearchesOffline {
    return Intl.message(
      'Hors ligne : voici tes recherches telles qu\'enregistrées. Tu pourras les modifier une fois reconnecté.',
      name: 'savedSearchesOffline',
      desc: 'Saved-search list shown from the cache, read-only.',
      args: [],
    );
  }

  /// `Les filtres d'une recherche sauvegardée ne changent pas. Pour d'autres filtres, sauvegarde une nouvelle recherche.`
  String get savedSearchesFiltersFixed {
    return Intl.message(
      'Les filtres d\'une recherche sauvegardée ne changent pas. Pour d\'autres filtres, sauvegarde une nouvelle recherche.',
      name: 'savedSearchesFiltersFixed',
      desc: 'The server does not edit a saved search\'s criteria.',
      args: [],
    );
  }

  /// `{count, plural, =1{1 nouveau} other{{count} nouveaux}}`
  String savedSearchNewCount(int count) {
    return Intl.plural(
      count,
      one: '1 nouveau',
      other: '$count nouveaux',
      name: 'savedSearchNewCount',
      desc: 'newMatchCount badge on a saved search.',
      args: [count],
    );
  }

  /// `Me prévenir des nouveaux biens`
  String get savedSearchAlerts {
    return Intl.message(
      'Me prévenir des nouveaux biens',
      name: 'savedSearchAlerts',
      desc: 'N-01 switch on a saved search.',
      args: [],
    );
  }

  /// `Renommer`
  String get savedSearchRename {
    return Intl.message(
      'Renommer',
      name: 'savedSearchRename',
      desc: 'Saved-search menu.',
      args: [],
    );
  }

  /// `Enregistrer`
  String get savedSearchRenameConfirm {
    return Intl.message(
      'Enregistrer',
      name: 'savedSearchRenameConfirm',
      desc: 'Rename dialog confirm.',
      args: [],
    );
  }

  /// `Supprimer`
  String get savedSearchDelete {
    return Intl.message(
      'Supprimer',
      name: 'savedSearchDelete',
      desc: 'Saved-search menu.',
      args: [],
    );
  }

  /// `Supprimer cette recherche ?`
  String get savedSearchDeleteTitle {
    return Intl.message(
      'Supprimer cette recherche ?',
      name: 'savedSearchDeleteTitle',
      desc: 'Delete confirmation title.',
      args: [],
    );
  }

  /// `« {name} » ne te préviendra plus des nouveaux biens.`
  String savedSearchDeleteBody(String name) {
    return Intl.message(
      '« $name » ne te préviendra plus des nouveaux biens.',
      name: 'savedSearchDeleteBody',
      desc: 'Delete confirmation body.',
      args: [name],
    );
  }

  /// `Nom (facultatif)`
  String get savedSearchNameLabel {
    return Intl.message(
      'Nom (facultatif)',
      name: 'savedSearchNameLabel',
      desc: 'Save sheet name field.',
      args: [],
    );
  }

  /// `Sinon, on la nomme d'après tes filtres`
  String get savedSearchNameHint {
    return Intl.message(
      'Sinon, on la nomme d\'après tes filtres',
      name: 'savedSearchNameHint',
      desc: 'The server builds a name when none is given.',
      args: [],
    );
  }

  /// `Ce changement n'a pas été enregistré. Réessaie.`
  String get savedSearchChangeFailed {
    return Intl.message(
      'Ce changement n\'a pas été enregistré. Réessaie.',
      name: 'savedSearchChangeFailed',
      desc: 'Rename / alerts / delete failed.',
      args: [],
    );
  }

  /// `Aucun bien ne correspond à cette recherche pour le moment. On te prévient dès qu'il y en a un.`
  String get savedSearchResultsEmpty {
    return Intl.message(
      'Aucun bien ne correspond à cette recherche pour le moment. On te prévient dès qu\'il y en a un.',
      name: 'savedSearchResultsEmpty',
      desc: 'Saved-search results, empty.',
      args: [],
    );
  }

  /// `Impossible de charger les résultats. Vérifie ta connexion.`
  String get savedSearchResultsFailed {
    return Intl.message(
      'Impossible de charger les résultats. Vérifie ta connexion.',
      name: 'savedSearchResultsFailed',
      desc: 'Saved-search results failed (offline or server).',
      args: [],
    );
  }

  /// `Sauvegarder la recherche`
  String get saveSearchAction {
    return Intl.message(
      'Sauvegarder la recherche',
      name: 'saveSearchAction',
      desc: 'Tooltip of the bookmark on the search results header.',
      args: [],
    );
  }

  /// `Sauvegarder cette recherche`
  String get saveSearchTitle {
    return Intl.message(
      'Sauvegarder cette recherche',
      name: 'saveSearchTitle',
      desc: 'Save sheet title.',
      args: [],
    );
  }

  /// `Une notification groupée quand de nouveaux biens correspondent, jamais la nuit.`
  String get saveSearchAlertsHelp {
    return Intl.message(
      'Une notification groupée quand de nouveaux biens correspondent, jamais la nuit.',
      name: 'saveSearchAlertsHelp',
      desc: 'N-01 — one grouped push per search, not between 22:00 and 07:00.',
      args: [],
    );
  }

  /// `Sauvegarder`
  String get saveSearchConfirm {
    return Intl.message(
      'Sauvegarder',
      name: 'saveSearchConfirm',
      desc: 'Save sheet confirm.',
      args: [],
    );
  }

  /// `Connecte-toi pour sauvegarder`
  String get saveSearchSignInTitle {
    return Intl.message(
      'Connecte-toi pour sauvegarder',
      name: 'saveSearchSignInTitle',
      desc: 'Visitor tried to save a search (RM-M04-05).',
      args: [],
    );
  }

  /// `Une recherche sauvegardée te prévient des nouveaux biens : il faut un compte pour ça.`
  String get saveSearchSignInBody {
    return Intl.message(
      'Une recherche sauvegardée te prévient des nouveaux biens : il faut un compte pour ça.',
      name: 'saveSearchSignInBody',
      desc: 'Visitor tried to save a search.',
      args: [],
    );
  }

  /// `3 recherches au maximum`
  String get saveSearchLimitTitle {
    return Intl.message(
      '3 recherches au maximum',
      name: 'saveSearchLimitTitle',
      desc: 'RM-M04-07 / SAVED_SEARCH_LIMIT.',
      args: [],
    );
  }

  /// `Supprime une recherche sauvegardée (dans Compte) pour en ajouter une autre.`
  String get saveSearchLimitBody {
    return Intl.message(
      'Supprime une recherche sauvegardée (dans Compte) pour en ajouter une autre.',
      name: 'saveSearchLimitBody',
      desc: 'RM-M04-07 / SAVED_SEARCH_LIMIT.',
      args: [],
    );
  }

  /// `Recherche sauvegardée`
  String get saveSearchDone {
    return Intl.message(
      'Recherche sauvegardée',
      name: 'saveSearchDone',
      desc: 'Save succeeded.',
      args: [],
    );
  }

  /// `Tu la retrouves dans Compte.`
  String get saveSearchDoneBody {
    return Intl.message(
      'Tu la retrouves dans Compte.',
      name: 'saveSearchDoneBody',
      desc: 'Save succeeded.',
      args: [],
    );
  }

  /// `Cette recherche est déjà sauvegardée.`
  String get saveSearchDuplicate {
    return Intl.message(
      'Cette recherche est déjà sauvegardée.',
      name: 'saveSearchDuplicate',
      desc: 'SAVED_SEARCH_DUPLICATE.',
      args: [],
    );
  }

  /// `La recherche n'a pas été sauvegardée. Réessaie.`
  String get saveSearchFailed {
    return Intl.message(
      'La recherche n\'a pas été sauvegardée. Réessaie.',
      name: 'saveSearchFailed',
      desc: 'Save failed.',
      args: [],
    );
  }

  /// `Mboa Score`
  String get scoreTitle {
    return Intl.message(
      'Mboa Score',
      name: 'scoreTitle',
      desc: 'M09 — title.',
      args: [],
    );
  }

  /// `Mon Mboa Score`
  String get scoreMine {
    return Intl.message(
      'Mon Mboa Score',
      name: 'scoreMine',
      desc: 'Compte tile (RM-M09-03).',
      args: [],
    );
  }

  /// `Ton score de fiabilité, en détail`
  String get scoreMineSubtitle {
    return Intl.message(
      'Ton score de fiabilité, en détail',
      name: 'scoreMineSubtitle',
      desc: 'Compte tile subtitle.',
      args: [],
    );
  }

  /// `Voir son Mboa Score`
  String get scoreOpen {
    return Intl.message(
      'Voir son Mboa Score',
      name: 'scoreOpen',
      desc: 'Pro thread action tooltip (RM-M09-04).',
      args: [],
    );
  }

  /// `Fermer`
  String get scoreClose {
    return Intl.message(
      'Fermer',
      name: 'scoreClose',
      desc: 'Closes the score sheet.',
      args: [],
    );
  }

  /// `sur {max}`
  String scoreOutOf(int max) {
    return Intl.message(
      'sur $max',
      name: 'scoreOutOf',
      desc: 'Under the number in the ring.',
      args: [max],
    );
  }

  /// `Mboa Score : {score} sur {max}`
  String scoreA11y(int score, int max) {
    return Intl.message(
      'Mboa Score : $score sur $max',
      name: 'scoreA11y',
      desc: 'Screen-reader label of the ring.',
      args: [score, max],
    );
  }

  /// `Ton Mboa Score montre aux propriétaires que tu es un locataire fiable.`
  String get scoreIntroSelf {
    return Intl.message(
      'Ton Mboa Score montre aux propriétaires que tu es un locataire fiable.',
      name: 'scoreIntroSelf',
      desc: 'Own score — intro.',
      args: [],
    );
  }

  /// `Il n'est jamais public : seuls les propriétaires que tu contactes le voient.`
  String get scorePrivateSelf {
    return Intl.message(
      'Il n\'est jamais public : seuls les propriétaires que tu contactes le voient.',
      name: 'scorePrivateSelf',
      desc: 'RM-M09-04/05 — who sees it.',
      args: [],
    );
  }

  /// `{max}, c'est le maximum. Le score parfait n'existe pas : il reste toujours une marge.`
  String scoreMaxNote(int max) {
    return Intl.message(
      '$max, c\'est le maximum. Le score parfait n\'existe pas : il reste toujours une marge.',
      name: 'scoreMaxNote',
      desc: 'Doc 10 M09 — 90 is the ceiling on purpose.',
      args: [max],
    );
  }

  /// `Ce qui compte dans ton score`
  String get scoreSectionSelf {
    return Intl.message(
      'Ce qui compte dans ton score',
      name: 'scoreSectionSelf',
      desc: 'Own score — breakdown title.',
      args: [],
    );
  }

  /// `Ton score se met à jour tout seul dès que quelque chose change.`
  String get scoreFooterSelf {
    return Intl.message(
      'Ton score se met à jour tout seul dès que quelque chose change.',
      name: 'scoreFooterSelf',
      desc: 'RM-M09-02 — recomputed live.',
      args: [],
    );
  }

  /// `La fiabilité de ce locataire, calculée par Mboa à partir de son activité.`
  String get scoreIntroTenant {
    return Intl.message(
      'La fiabilité de ce locataire, calculée par Mboa à partir de son activité.',
      name: 'scoreIntroTenant',
      desc: 'Prestataire sheet — intro.',
      args: [],
    );
  }

  /// `Privé : rien que pour ta décision.`
  String get scorePrivateTenant {
    return Intl.message(
      'Privé : rien que pour ta décision.',
      name: 'scorePrivateTenant',
      desc: 'RM-M09-05.',
      args: [],
    );
  }

  /// `Une aide à la décision, pas un verdict.`
  String get scoreFooterTenant {
    return Intl.message(
      'Une aide à la décision, pas un verdict.',
      name: 'scoreFooterTenant',
      desc: 'Prestataire sheet — footnote.',
      args: [],
    );
  }

  /// `Profil complet (photo, prénom, nom)`
  String get scoreSignalProfile {
    return Intl.message(
      'Profil complet (photo, prénom, nom)',
      name: 'scoreSignalProfile',
      desc: 'PROFILE_COMPLETE.',
      args: [],
    );
  }

  /// `Identité vérifiée`
  String get scoreSignalIdentity {
    return Intl.message(
      'Identité vérifiée',
      name: 'scoreSignalIdentity',
      desc: 'IDENTITY_VERIFIED.',
      args: [],
    );
  }

  /// `Membre depuis plus de 6 mois`
  String get scoreSignalSeniority {
    return Intl.message(
      'Membre depuis plus de 6 mois',
      name: 'scoreSignalSeniority',
      desc: 'ACCOUNT_SENIORITY.',
      args: [],
    );
  }

  /// `Contrats signés sans litige`
  String get scoreSignalContracts {
    return Intl.message(
      'Contrats signés sans litige',
      name: 'scoreSignalContracts',
      desc: 'SIGNED_CONTRACTS.',
      args: [],
    );
  }

  /// `Note des propriétaires`
  String get scoreSignalRating {
    return Intl.message(
      'Note des propriétaires',
      name: 'scoreSignalRating',
      desc: 'PROVIDER_RATING (not computed yet).',
      args: [],
    );
  }

  /// `Signalements retenus`
  String get scoreSignalReports {
    return Intl.message(
      'Signalements retenus',
      name: 'scoreSignalReports',
      desc: 'VALIDATED_REPORTS.',
      args: [],
    );
  }

  /// `Ajustement par l'équipe Mboa`
  String get scoreSignalAdjustment {
    return Intl.message(
      'Ajustement par l\'équipe Mboa',
      name: 'scoreSignalAdjustment',
      desc: 'ADMIN_ADJUSTMENT (hidden at 0).',
      args: [],
    );
  }

  /// `Autre`
  String get scoreSignalOther {
    return Intl.message(
      'Autre',
      name: 'scoreSignalOther',
      desc: 'A signal newer than this build.',
      args: [],
    );
  }

  /// `{count, plural, =0{Aucun contrat sans litige pour l'instant} =1{1 contrat sans litige} other{{count} contrats sans litige}}`
  String scoreContractsCount(int count) {
    return Intl.plural(
      count,
      zero: 'Aucun contrat sans litige pour l\'instant',
      one: '1 contrat sans litige',
      other: '$count contrats sans litige',
      name: 'scoreContractsCount',
      desc: 'SIGNED_CONTRACTS count.',
      args: [count],
    );
  }

  /// `{count, plural, =0{Aucun signalement retenu} =1{1 signalement retenu} other{{count} signalements retenus}}`
  String scoreReportsCount(int count) {
    return Intl.plural(
      count,
      zero: 'Aucun signalement retenu',
      one: '1 signalement retenu',
      other: '$count signalements retenus',
      name: 'scoreReportsCount',
      desc: 'VALIDATED_REPORTS count.',
      args: [count],
    );
  }

  /// `Bientôt`
  String get scoreSoon {
    return Intl.message(
      'Bientôt',
      name: 'scoreSoon',
      desc: 'A signal not computed yet — not a zero.',
      args: [],
    );
  }

  /// `Complète ton profil pour booster ton Mboa Score.`
  String get scoreHintProfile {
    return Intl.message(
      'Complète ton profil pour booster ton Mboa Score.',
      name: 'scoreHintProfile',
      desc: 'Own score hint (charter §9.2 wording).',
      args: [],
    );
  }

  /// `Ta pièce d'identité, vérifiée par l'équipe Mboa.`
  String get scoreHintIdentity {
    return Intl.message(
      'Ta pièce d\'identité, vérifiée par l\'équipe Mboa.',
      name: 'scoreHintIdentity',
      desc: 'Own score hint.',
      args: [],
    );
  }

  /// `Celui-là vient tout seul, avec le temps.`
  String get scoreHintSeniority {
    return Intl.message(
      'Celui-là vient tout seul, avec le temps.',
      name: 'scoreHintSeniority',
      desc: 'Own score hint.',
      args: [],
    );
  }

  /// `Chaque contrat signé sur Mboa compte, tant qu'aucun litige n'a été retenu à son sujet, jusqu'à {max} points.`
  String scoreHintContracts(int max) {
    return Intl.message(
      'Chaque contrat signé sur Mboa compte, tant qu\'aucun litige n\'a été retenu à son sujet, jusqu\'à $max points.',
      name: 'scoreHintContracts',
      desc: 'Own score hint — the ceiling comes from the server (maxPoints).',
      args: [max],
    );
  }

  /// `Les propriétaires pourront bientôt te noter.`
  String get scoreHintRating {
    return Intl.message(
      'Les propriétaires pourront bientôt te noter.',
      name: 'scoreHintRating',
      desc: 'Own score hint.',
      args: [],
    );
  }

  /// `Un message ou un avis signalé et retenu par l'équipe Mboa fait baisser ton score.`
  String get scoreHintReports {
    return Intl.message(
      'Un message ou un avis signalé et retenu par l\'équipe Mboa fait baisser ton score.',
      name: 'scoreHintReports',
      desc: 'Own score hint.',
      args: [],
    );
  }

  /// `plus {points} points sur {max}`
  String scoreA11yEarned(int points, int max) {
    return Intl.message(
      'plus $points points sur $max',
      name: 'scoreA11yEarned',
      desc: 'Screen reader, earned line.',
      args: [points, max],
    );
  }

  /// `0 point sur {max}`
  String scoreA11yZero(int max) {
    return Intl.message(
      '0 point sur $max',
      name: 'scoreA11yZero',
      desc: 'Screen reader, nothing yet on the line.',
      args: [max],
    );
  }

  /// `moins {points} points`
  String scoreA11yPenalty(int points) {
    return Intl.message(
      'moins $points points',
      name: 'scoreA11yPenalty',
      desc: 'Screen reader, a penalty.',
      args: [points],
    );
  }

  /// `{points} points`
  String scoreA11yPoints(int points) {
    return Intl.message(
      '$points points',
      name: 'scoreA11yPoints',
      desc: 'Screen reader, a line without a ceiling.',
      args: [points],
    );
  }

  /// `bientôt disponible`
  String get scoreA11ySoon {
    return Intl.message(
      'bientôt disponible',
      name: 'scoreA11ySoon',
      desc: 'Screen reader, not computed yet.',
      args: [],
    );
  }

  /// `Le score n'a pas pu se charger`
  String get scoreLoadFailedTitle {
    return Intl.message(
      'Le score n\'a pas pu se charger',
      name: 'scoreLoadFailedTitle',
      desc: 'Offline or server error.',
      args: [],
    );
  }

  /// `Vérifie ta connexion, puis réessaie.`
  String get scoreLoadFailedBody {
    return Intl.message(
      'Vérifie ta connexion, puis réessaie.',
      name: 'scoreLoadFailedBody',
      desc: 'Offline or server error.',
      args: [],
    );
  }

  /// `Pas encore visible`
  String get scoreNotContactedTitle {
    return Intl.message(
      'Pas encore visible',
      name: 'scoreNotContactedTitle',
      desc: '403 SCORE_NOT_ACCESSIBLE.',
      args: [],
    );
  }

  /// `Tu verras son score dès que ce locataire t'aura écrit ou demandé une visite.`
  String get scoreNotContactedBody {
    return Intl.message(
      'Tu verras son score dès que ce locataire t\'aura écrit ou demandé une visite.',
      name: 'scoreNotContactedBody',
      desc: '403 SCORE_NOT_ACCESSIBLE (RM-M09-04).',
      args: [],
    );
  }

  /// `Pas de score pour ce compte`
  String get scoreNoneTitle {
    return Intl.message(
      'Pas de score pour ce compte',
      name: 'scoreNoneTitle',
      desc: '404 SCORE_NOT_APPLICABLE.',
      args: [],
    );
  }

  /// `Seuls les comptes locataires ont un Mboa Score.`
  String get scoreNoneBody {
    return Intl.message(
      'Seuls les comptes locataires ont un Mboa Score.',
      name: 'scoreNoneBody',
      desc: '404 SCORE_NOT_APPLICABLE.',
      args: [],
    );
  }

  /// `Positions approximatives à 200 m près, sauf pour les biens que tu as contactés.`
  String get searchMapApproxExceptContacted {
    return Intl.message(
      'Positions approximatives à 200 m près, sauf pour les biens que tu as contactés.',
      name: 'searchMapApproxExceptContacted',
      desc:
          'RM-M04-06 — some points on the map are exact (contact established).',
      args: [],
    );
  }

  /// `Position exacte, car tu as contacté ce prestataire. L'adresse écrite n'est communiquée qu'au contrat signé.`
  String get listingLocationExactNote {
    return Intl.message(
      'Position exacte, car tu as contacté ce prestataire. L\'adresse écrite n\'est communiquée qu\'au contrat signé.',
      name: 'listingLocationExactNote',
      desc: 'RM-M04-06 / RM-M05-02 — exactLocation true on the fiche.',
      args: [],
    );
  }

  /// `—`
  String get homeStatsNoData {
    return Intl.message(
      '—',
      name: 'homeStatsNoData',
      desc:
          'M14 — a figure the tier can see, with nothing to measure yet (no views, never shown in search). Never 0.',
      args: [],
    );
  }

  /// `Mot de passe oublié ?`
  String get pwdResetLink {
    return Intl.message(
      'Mot de passe oublié ?',
      name: 'pwdResetLink',
      desc: 'Pro login — link to the reset flow.',
      args: [],
    );
  }

  /// `Mot de passe oublié`
  String get pwdResetTitle {
    return Intl.message(
      'Mot de passe oublié',
      name: 'pwdResetTitle',
      desc: 'Reset flow title.',
      args: [],
    );
  }

  /// `Saisis l'email de ton compte. Un code te sera envoyé par SMS au numéro associé.`
  String get pwdResetEmailBody {
    return Intl.message(
      'Saisis l\'email de ton compte. Un code te sera envoyé par SMS au numéro associé.',
      name: 'pwdResetEmailBody',
      desc:
          'Reset step 1 — the code goes by SMS to the account\'s phone, not by email.',
      args: [],
    );
  }

  /// `Envoyer le code`
  String get pwdResetSendCode {
    return Intl.message(
      'Envoyer le code',
      name: 'pwdResetSendCode',
      desc: 'Reset step 1 button.',
      args: [],
    );
  }

  /// `Si un compte correspond à {email}, un code a été envoyé par SMS au numéro associé.`
  String pwdResetCodeBody(String email) {
    return Intl.message(
      'Si un compte correspond à $email, un code a été envoyé par SMS au numéro associé.',
      name: 'pwdResetCodeBody',
      desc:
          'Reset step 2 — said the same whether or not the email has an account (the server never says).',
      args: [email],
    );
  }

  /// `Changer le mot de passe`
  String get pwdResetSubmit {
    return Intl.message(
      'Changer le mot de passe',
      name: 'pwdResetSubmit',
      desc: 'Reset step 2 button.',
      args: [],
    );
  }

  /// `{min} caractères minimum.`
  String pwdResetTooShort(int min) {
    return Intl.message(
      '$min caractères minimum.',
      name: 'pwdResetTooShort',
      desc: 'New password too short (server: 8).',
      args: [min],
    );
  }

  /// `{max} caractères maximum.`
  String pwdResetTooLong(int max) {
    return Intl.message(
      '$max caractères maximum.',
      name: 'pwdResetTooLong',
      desc: 'New password too long (server: 72).',
      args: [max],
    );
  }

  /// `Ce code n'est plus valable. Demande un nouveau code.`
  String get pwdResetCodeExpired {
    return Intl.message(
      'Ce code n\'est plus valable. Demande un nouveau code.',
      name: 'pwdResetCodeExpired',
      desc: 'OTP_INVALID_OR_EXPIRED.',
      args: [],
    );
  }

  /// `Trop d'essais. Demande un nouveau code.`
  String get pwdResetTooManyAttempts {
    return Intl.message(
      'Trop d\'essais. Demande un nouveau code.',
      name: 'pwdResetTooManyAttempts',
      desc: 'OTP_MAX_ATTEMPTS.',
      args: [],
    );
  }

  /// `Mot de passe modifié`
  String get pwdResetDoneTitle {
    return Intl.message(
      'Mot de passe modifié',
      name: 'pwdResetDoneTitle',
      desc: 'Reset succeeded.',
      args: [],
    );
  }

  /// `Reconnecte-toi avec ton nouveau mot de passe. Tes autres sessions ont été fermées.`
  String get pwdResetDoneBody {
    return Intl.message(
      'Reconnecte-toi avec ton nouveau mot de passe. Tes autres sessions ont été fermées.',
      name: 'pwdResetDoneBody',
      desc: 'Reset succeeded — the server revokes every session.',
      args: [],
    );
  }

  /// `Demande de réservation`
  String get messageSystemReservationTitle {
    return Intl.message(
      'Demande de réservation',
      name: 'messageSystemReservationTitle',
      desc: 'RM-M29-14 — the system message a request opens the thread with.',
      args: [],
    );
  }

  /// `À partir du {date} · {duration}`
  String messageSystemReservationStay(String date, String duration) {
    return Intl.message(
      'À partir du $date · $duration',
      name: 'messageSystemReservationStay',
      desc: 'The requested stay in the system message.',
      args: [date, duration],
    );
  }

  /// `Demande d'argent avant la signature du contrat`
  String get reportReasonAskedForMoney {
    return Intl.message(
      'Demande d\'argent avant la signature du contrat',
      name: 'reportReasonAskedForMoney',
      desc: 'RM-M29-09 — ASKED_FOR_MONEY.',
      args: [],
    );
  }

  /// `En attente`
  String get reservationStatusPending {
    return Intl.message(
      'En attente',
      name: 'reservationStatusPending',
      desc: 'M29 — PENDING: the prestataire has 48 h to answer.',
      args: [],
    );
  }

  /// `Réservée`
  String get reservationStatusAccepted {
    return Intl.message(
      'Réservée',
      name: 'reservationStatusAccepted',
      desc: 'M29 — ACCEPTED: the listing is held for the client.',
      args: [],
    );
  }

  /// `Contrat signé`
  String get reservationStatusContracted {
    return Intl.message(
      'Contrat signé',
      name: 'reservationStatusContracted',
      desc: 'M29 — CONTRACTED: its contract was signed by both.',
      args: [],
    );
  }

  /// `Refusée`
  String get reservationStatusRefused {
    return Intl.message(
      'Refusée',
      name: 'reservationStatusRefused',
      desc: 'M29 — REFUSED.',
      args: [],
    );
  }

  /// `Non retenue`
  String get reservationStatusNotRetained {
    return Intl.message(
      'Non retenue',
      name: 'reservationStatusNotRetained',
      desc: 'M29 — NOT_RETAINED: another request was accepted (RM-M29-04).',
      args: [],
    );
  }

  /// `Sans réponse`
  String get reservationStatusExpired {
    return Intl.message(
      'Sans réponse',
      name: 'reservationStatusExpired',
      desc: 'M29 — EXPIRED: unanswered after 48 h.',
      args: [],
    );
  }

  /// `Annulée`
  String get reservationStatusCancelled {
    return Intl.message(
      'Annulée',
      name: 'reservationStatusCancelled',
      desc: 'M29 — CANCELLED.',
      args: [],
    );
  }

  /// `Échue`
  String get reservationStatusLapsed {
    return Intl.message(
      'Échue',
      name: 'reservationStatusLapsed',
      desc:
          'M29 — LAPSED: the reservation ran out with no signed contract (RM-M29-07).',
      args: [],
    );
  }

  /// `Statut inconnu`
  String get reservationStatusUnknown {
    return Intl.message(
      'Statut inconnu',
      name: 'reservationStatusUnknown',
      desc: 'M29 — a status this build predates.',
      args: [],
    );
  }

  /// `Ne verse aucun argent avant d'avoir signé le Contrat Mboa dans l'app. Réserver est gratuit.`
  String get reservationNoMoney {
    return Intl.message(
      'Ne verse aucun argent avant d\'avoir signé le Contrat Mboa dans l\'app. Réserver est gratuit.',
      name: 'reservationNoMoney',
      desc: 'RM-M29-09 / CA-M29-04 — nothing is paid through a reservation.',
      args: [],
    );
  }

  /// `Réservation`
  String get reservationTitle {
    return Intl.message(
      'Réservation',
      name: 'reservationTitle',
      desc: 'M29 — the request screen\'s title.',
      args: [],
    );
  }

  /// `Durée du séjour`
  String get reservationStayTitle {
    return Intl.message(
      'Durée du séjour',
      name: 'reservationStayTitle',
      desc: 'M29 — step 2 of the request.',
      args: [],
    );
  }

  /// `Loyer`
  String get reservationRentTitle {
    return Intl.message(
      'Loyer',
      name: 'reservationRentTitle',
      desc: 'M29 — step 3 of the request; never "payment" (RM-M29-09).',
      args: [],
    );
  }

  /// `Début`
  String get reservationStart {
    return Intl.message(
      'Début',
      name: 'reservationStart',
      desc: 'M29 — move-in day.',
      args: [],
    );
  }

  /// `Fin`
  String get reservationEnd {
    return Intl.message(
      'Fin',
      name: 'reservationEnd',
      desc: 'M29 — the stay\'s last day, computed.',
      args: [],
    );
  }

  /// `Choisir`
  String get reservationPickDate {
    return Intl.message(
      'Choisir',
      name: 'reservationPickDate',
      desc: 'M29 — the start day before one is picked.',
      args: [],
    );
  }

  /// `Durée`
  String get reservationDuration {
    return Intl.message(
      'Durée',
      name: 'reservationDuration',
      desc: 'M29 — the duration stepper\'s label.',
      args: [],
    );
  }

  /// `Raccourcir`
  String get reservationDurationLess {
    return Intl.message(
      'Raccourcir',
      name: 'reservationDurationLess',
      desc: 'M29 — stepper tooltip.',
      args: [],
    );
  }

  /// `Allonger`
  String get reservationDurationMore {
    return Intl.message(
      'Allonger',
      name: 'reservationDurationMore',
      desc: 'M29 — stepper tooltip.',
      args: [],
    );
  }

  /// `Sur la durée : {total} · indicatif`
  String reservationIndicativeTotal(String total) {
    return Intl.message(
      'Sur la durée : $total · indicatif',
      name: 'reservationIndicativeTotal',
      desc: 'M29 — rent times duration; indicative, nothing is paid here.',
      args: [total],
    );
  }

  /// `Un mot pour le prestataire (facultatif)`
  String get reservationMessageLabel {
    return Intl.message(
      'Un mot pour le prestataire (facultatif)',
      name: 'reservationMessageLabel',
      desc: 'M29 — the request\'s optional message.',
      args: [],
    );
  }

  /// `Présente-toi en quelques mots`
  String get reservationMessageHint {
    return Intl.message(
      'Présente-toi en quelques mots',
      name: 'reservationMessageHint',
      desc: 'M29 — message hint.',
      args: [],
    );
  }

  /// `Une visite avant de réserver est recommandée. Le prestataire a 48 h pour te répondre.`
  String get reservationVisitAdvice {
    return Intl.message(
      'Une visite avant de réserver est recommandée. Le prestataire a 48 h pour te répondre.',
      name: 'reservationVisitAdvice',
      desc: 'RM-M29-02 / RM-M29-05.',
      args: [],
    );
  }

  /// `Envoyer la demande`
  String get reservationSend {
    return Intl.message(
      'Envoyer la demande',
      name: 'reservationSend',
      desc: 'M29 — submit.',
      args: [],
    );
  }

  /// `Demande envoyée`
  String get reservationSentTitle {
    return Intl.message(
      'Demande envoyée',
      name: 'reservationSentTitle',
      desc: 'M29 — after sending.',
      args: [],
    );
  }

  /// `Le prestataire a 48 h pour te répondre.`
  String get reservationSentBody {
    return Intl.message(
      'Le prestataire a 48 h pour te répondre.',
      name: 'reservationSentBody',
      desc: 'M29 — after sending.',
      args: [],
    );
  }

  /// `Complète ton profil`
  String get reservationProfileIncompleteTitle {
    return Intl.message(
      'Complète ton profil',
      name: 'reservationProfileIncompleteTitle',
      desc: 'CE-M29-02.',
      args: [],
    );
  }

  /// `Ton profil doit être complet pour demander une réservation.`
  String get reservationProfileIncompleteBody {
    return Intl.message(
      'Ton profil doit être complet pour demander une réservation.',
      name: 'reservationProfileIncompleteBody',
      desc: 'CE-M29-02 — PROFILE_INCOMPLETE.',
      args: [],
    );
  }

  /// `Ce bien n'est plus réservable.`
  String get reservationNotReservable {
    return Intl.message(
      'Ce bien n\'est plus réservable.',
      name: 'reservationNotReservable',
      desc: 'LISTING_NOT_RESERVABLE.',
      args: [],
    );
  }

  /// `Tu as déjà une demande en cours pour ce bien.`
  String get reservationAlreadyActive {
    return Intl.message(
      'Tu as déjà une demande en cours pour ce bien.',
      name: 'reservationAlreadyActive',
      desc: 'RESERVATION_ALREADY_ACTIVE.',
      args: [],
    );
  }

  /// `Tu as trop de demandes en attente. Attends une réponse ou annule une demande.`
  String get reservationLimitReached {
    return Intl.message(
      'Tu as trop de demandes en attente. Attends une réponse ou annule une demande.',
      name: 'reservationLimitReached',
      desc: 'CE-M29-03 — RESERVATION_LIMIT_REACHED.',
      args: [],
    );
  }

  /// `La date de début ne peut pas être passée.`
  String get reservationStartPast {
    return Intl.message(
      'La date de début ne peut pas être passée.',
      name: 'reservationStartPast',
      desc: 'RESERVATION_START_PAST.',
      args: [],
    );
  }

  /// `La date de début doit être dans les 12 prochains mois.`
  String get reservationStartTooFar {
    return Intl.message(
      'La date de début doit être dans les 12 prochains mois.',
      name: 'reservationStartTooFar',
      desc: 'RESERVATION_START_TOO_FAR.',
      args: [],
    );
  }

  /// `La demande n'est pas partie. Réessaie.`
  String get reservationSendFailed {
    return Intl.message(
      'La demande n\'est pas partie. Réessaie.',
      name: 'reservationSendFailed',
      desc: 'M29 — network or server failure.',
      args: [],
    );
  }

  /// `Réserver`
  String get listingRequestReservation {
    return Intl.message(
      'Réserver',
      name: 'listingRequestReservation',
      desc: 'M29 — the fiche\'s main action.',
      args: [],
    );
  }

  /// `Demande envoyée`
  String get listingReservationSent {
    return Intl.message(
      'Demande envoyée',
      name: 'listingReservationSent',
      desc: 'M29 — the fiche when the reader has an open request; opens it.',
      args: [],
    );
  }

  /// `Ma demande`
  String get reservationDetailTitle {
    return Intl.message(
      'Ma demande',
      name: 'reservationDetailTitle',
      desc: 'M29 — the tenant\'s request screen.',
      args: [],
    );
  }

  /// `En attente de réponse`
  String get reservationPendingTitle {
    return Intl.message(
      'En attente de réponse',
      name: 'reservationPendingTitle',
      desc: 'M29 — PENDING card.',
      args: [],
    );
  }

  /// `Le prestataire a jusqu'au {date} pour te répondre.`
  String reservationPendingUntil(String date) {
    return Intl.message(
      'Le prestataire a jusqu\'au $date pour te répondre.',
      name: 'reservationPendingUntil',
      desc: 'M29 — PENDING card, with expiresAt.',
      args: [date],
    );
  }

  /// `Réservation confirmée`
  String get reservationConfirmedTitle {
    return Intl.message(
      'Réservation confirmée',
      name: 'reservationConfirmedTitle',
      desc: 'M29 — ACCEPTED: the ticket-style card.',
      args: [],
    );
  }

  /// `Référence`
  String get reservationReference {
    return Intl.message(
      'Référence',
      name: 'reservationReference',
      desc: 'M29 — the request\'s short reference.',
      args: [],
    );
  }

  /// `Réservé jusqu'au`
  String get reservationReservedUntil {
    return Intl.message(
      'Réservé jusqu\'au',
      name: 'reservationReservedUntil',
      desc: 'M29 — ACCEPTED: reservedUntil.',
      args: [],
    );
  }

  /// `Prochaine étape`
  String get reservationNextStep {
    return Intl.message(
      'Prochaine étape',
      name: 'reservationNextStep',
      desc: 'M29 — ACCEPTED.',
      args: [],
    );
  }

  /// `Le prestataire prépare le Contrat Mboa. Tu le reliras et le signeras dans l'app.`
  String get reservationNextStepBody {
    return Intl.message(
      'Le prestataire prépare le Contrat Mboa. Tu le reliras et le signeras dans l\'app.',
      name: 'reservationNextStepBody',
      desc: 'M29 — ACCEPTED: what happens next (RM-M08-10).',
      args: [],
    );
  }

  /// `Le Contrat Mboa est signé des deux côtés. Tu le retrouves dans Mes contrats.`
  String get reservationContractedBody {
    return Intl.message(
      'Le Contrat Mboa est signé des deux côtés. Tu le retrouves dans Mes contrats.',
      name: 'reservationContractedBody',
      desc: 'M29 — CONTRACTED.',
      args: [],
    );
  }

  /// `Voir mes contrats`
  String get reservationSeeContracts {
    return Intl.message(
      'Voir mes contrats',
      name: 'reservationSeeContracts',
      desc: 'M29 — CONTRACTED.',
      args: [],
    );
  }

  /// `Motif : {reason}`
  String reservationRefusedReason(String reason) {
    return Intl.message(
      'Motif : $reason',
      name: 'reservationRefusedReason',
      desc: 'M29 — the prestataire\'s reason (RM-M29-06).',
      args: [reason],
    );
  }

  /// `Bien déjà réservé`
  String get reservationRefusalReservedElsewhere {
    return Intl.message(
      'Bien déjà réservé',
      name: 'reservationRefusalReservedElsewhere',
      desc: 'RESERVED_ELSEWHERE.',
      args: [],
    );
  }

  /// `Profil non retenu`
  String get reservationRefusalProfileNotRetained {
    return Intl.message(
      'Profil non retenu',
      name: 'reservationRefusalProfileNotRetained',
      desc: 'PROFILE_NOT_RETAINED.',
      args: [],
    );
  }

  /// `Dates incompatibles`
  String get reservationRefusalDatesIncompatible {
    return Intl.message(
      'Dates incompatibles',
      name: 'reservationRefusalDatesIncompatible',
      desc: 'DATES_INCOMPATIBLE.',
      args: [],
    );
  }

  /// `Autre motif`
  String get reservationRefusalOther {
    return Intl.message(
      'Autre motif',
      name: 'reservationRefusalOther',
      desc: 'OTHER.',
      args: [],
    );
  }

  /// `Le prestataire n'a pas donné suite à ta demande.`
  String get reservationRefusedBody {
    return Intl.message(
      'Le prestataire n\'a pas donné suite à ta demande.',
      name: 'reservationRefusedBody',
      desc: 'M29 — REFUSED.',
      args: [],
    );
  }

  /// `Un autre dossier a été retenu pour ce bien.`
  String get reservationNotRetainedBody {
    return Intl.message(
      'Un autre dossier a été retenu pour ce bien.',
      name: 'reservationNotRetainedBody',
      desc: 'M29 — NOT_RETAINED.',
      args: [],
    );
  }

  /// `Le prestataire n'a pas répondu dans les 48 h : ta demande est close.`
  String get reservationExpiredBody {
    return Intl.message(
      'Le prestataire n\'a pas répondu dans les 48 h : ta demande est close.',
      name: 'reservationExpiredBody',
      desc: 'M29 — EXPIRED.',
      args: [],
    );
  }

  /// `Tu as annulé cette demande.`
  String get reservationCancelledByYou {
    return Intl.message(
      'Tu as annulé cette demande.',
      name: 'reservationCancelledByYou',
      desc: 'M29 — CANCELLED by the client.',
      args: [],
    );
  }

  /// `Le prestataire a annulé la réservation.`
  String get reservationCancelledByProvider {
    return Intl.message(
      'Le prestataire a annulé la réservation.',
      name: 'reservationCancelledByProvider',
      desc: 'M29 — CANCELLED by the prestataire.',
      args: [],
    );
  }

  /// `Le bien a quitté le marché : la réservation est close.`
  String get reservationCancelledBySystem {
    return Intl.message(
      'Le bien a quitté le marché : la réservation est close.',
      name: 'reservationCancelledBySystem',
      desc: 'CE-M29-04 — CANCELLED by the system.',
      args: [],
    );
  }

  /// `Le délai de réservation est passé sans contrat signé.`
  String get reservationLapsedBody {
    return Intl.message(
      'Le délai de réservation est passé sans contrat signé.',
      name: 'reservationLapsedBody',
      desc: 'RM-M29-07 — LAPSED.',
      args: [],
    );
  }

  /// `Mot du prestataire`
  String get reservationProviderNote {
    return Intl.message(
      'Mot du prestataire',
      name: 'reservationProviderNote',
      desc: 'M29 — ownerNote.',
      args: [],
    );
  }

  /// `Ton séjour`
  String get reservationYourStay {
    return Intl.message(
      'Ton séjour',
      name: 'reservationYourStay',
      desc: 'M29 — the request\'s dates.',
      args: [],
    );
  }

  /// `Ton message`
  String get reservationYourMessage {
    return Intl.message(
      'Ton message',
      name: 'reservationYourMessage',
      desc: 'M29 — the request\'s message.',
      args: [],
    );
  }

  /// `Écrire au prestataire`
  String get reservationWriteProvider {
    return Intl.message(
      'Écrire au prestataire',
      name: 'reservationWriteProvider',
      desc: 'RM-M29-14 — the thread the request opened.',
      args: [],
    );
  }

  /// `Voir le bien`
  String get reservationSeeListing {
    return Intl.message(
      'Voir le bien',
      name: 'reservationSeeListing',
      desc: 'M29 — back to the fiche.',
      args: [],
    );
  }

  /// `Annuler ma demande`
  String get reservationCancel {
    return Intl.message(
      'Annuler ma demande',
      name: 'reservationCancel',
      desc: 'M29 — the client withdraws.',
      args: [],
    );
  }

  /// `Annuler ta demande ?`
  String get reservationCancelConfirmTitle {
    return Intl.message(
      'Annuler ta demande ?',
      name: 'reservationCancelConfirmTitle',
      desc: 'M29 — confirm dialog.',
      args: [],
    );
  }

  /// `Le prestataire en sera informé et le bien sera libéré.`
  String get reservationCancelConfirmBody {
    return Intl.message(
      'Le prestataire en sera informé et le bien sera libéré.',
      name: 'reservationCancelConfirmBody',
      desc: 'M29 — confirm dialog.',
      args: [],
    );
  }

  /// `Oui, annuler`
  String get reservationCancelConfirm {
    return Intl.message(
      'Oui, annuler',
      name: 'reservationCancelConfirm',
      desc: 'M29 — confirm dialog.',
      args: [],
    );
  }

  /// `Garder ma demande`
  String get reservationKeep {
    return Intl.message(
      'Garder ma demande',
      name: 'reservationKeep',
      desc: 'M29 — confirm dialog.',
      args: [],
    );
  }

  /// `Demande annulée`
  String get reservationCancelDone {
    return Intl.message(
      'Demande annulée',
      name: 'reservationCancelDone',
      desc: 'M29 — after cancelling.',
      args: [],
    );
  }

  /// `L'annulation n'a pas abouti. Réessaie.`
  String get reservationCancelFailed {
    return Intl.message(
      'L\'annulation n\'a pas abouti. Réessaie.',
      name: 'reservationCancelFailed',
      desc: 'M29 — cancel failed.',
      args: [],
    );
  }

  /// `Bien`
  String get reservationUntitled {
    return Intl.message(
      'Bien',
      name: 'reservationUntitled',
      desc: 'M29 — a request whose listing title is unknown.',
      args: [],
    );
  }

  /// `Mes demandes de réservation`
  String get reservationsTitle {
    return Intl.message(
      'Mes demandes de réservation',
      name: 'reservationsTitle',
      desc: 'M29 — the list, and its Compte tile.',
      args: [],
    );
  }

  /// `Aucune demande`
  String get reservationsEmptyTitle {
    return Intl.message(
      'Aucune demande',
      name: 'reservationsEmptyTitle',
      desc: 'M29 — empty list.',
      args: [],
    );
  }

  /// `Depuis la fiche d'un bien, demande à le réserver : le prestataire te répond sous 48 h.`
  String get reservationsEmptyBody {
    return Intl.message(
      'Depuis la fiche d\'un bien, demande à le réserver : le prestataire te répond sous 48 h.',
      name: 'reservationsEmptyBody',
      desc: 'M29 — empty list.',
      args: [],
    );
  }

  /// `Hors ligne : voici tes demandes telles qu'à ta dernière connexion.`
  String get reservationsOffline {
    return Intl.message(
      'Hors ligne : voici tes demandes telles qu\'à ta dernière connexion.',
      name: 'reservationsOffline',
      desc: 'M29 — cached list.',
      args: [],
    );
  }

  /// `Dès le {start} · {duration}`
  String reservationRowStay(String start, String duration) {
    return Intl.message(
      'Dès le $start · $duration',
      name: 'reservationRowStay',
      desc: 'M29 — a list row\'s stay.',
      args: [start, duration],
    );
  }

  /// `Plus d'actions`
  String get listingMoreActions {
    return Intl.message(
      'Plus d\'actions',
      name: 'listingMoreActions',
      desc: 'The fiche\'s ⋯ button: contact, plan a visit, report.',
      args: [],
    );
  }

  /// `Mes réservations`
  String get reservationsTile {
    return Intl.message(
      'Mes réservations',
      name: 'reservationsTile',
      desc: 'M29 — the Compte tile; short so it holds one line.',
      args: [],
    );
  }

  /// `Demandes de réservation`
  String get proReservationsTitle {
    return Intl.message(
      'Demandes de réservation',
      name: 'proReservationsTitle',
      desc: 'M29 — the prestataire\'s inbox.',
      args: [],
    );
  }

  /// `En attente`
  String get proReservationsFilterPending {
    return Intl.message(
      'En attente',
      name: 'proReservationsFilterPending',
      desc: 'M29 — inbox tab.',
      args: [],
    );
  }

  /// `Toutes`
  String get proReservationsFilterAll {
    return Intl.message(
      'Toutes',
      name: 'proReservationsFilterAll',
      desc: 'M29 — inbox tab.',
      args: [],
    );
  }

  /// `Aucune demande n'attend ta réponse.`
  String get proReservationsEmptyPending {
    return Intl.message(
      'Aucune demande n\'attend ta réponse.',
      name: 'proReservationsEmptyPending',
      desc: 'M29 — empty tab.',
      args: [],
    );
  }

  /// `Aucune demande de réservation pour l'instant.`
  String get proReservationsEmptyAll {
    return Intl.message(
      'Aucune demande de réservation pour l\'instant.',
      name: 'proReservationsEmptyAll',
      desc: 'M29 — empty inbox.',
      args: [],
    );
  }

  /// `Hors ligne : les demandes telles qu'à ta dernière connexion.`
  String get proReservationsOffline {
    return Intl.message(
      'Hors ligne : les demandes telles qu\'à ta dernière connexion.',
      name: 'proReservationsOffline',
      desc: 'M29 — cached inbox.',
      args: [],
    );
  }

  /// `{name} · {listing}`
  String proReservationRowBody(String name, String listing) {
    return Intl.message(
      '$name · $listing',
      name: 'proReservationRowBody',
      desc: 'M29 — an inbox row: the client and the listing.',
      args: [name, listing],
    );
  }

  /// `Un client`
  String get proReservationClient {
    return Intl.message(
      'Un client',
      name: 'proReservationClient',
      desc: 'M29 — a client with no name.',
      args: [],
    );
  }

  /// `Demande de réservation`
  String get proReservationDetailTitle {
    return Intl.message(
      'Demande de réservation',
      name: 'proReservationDetailTitle',
      desc: 'M29 — the request\'s screen.',
      args: [],
    );
  }

  /// `Profil du demandeur`
  String get proReservationRequester {
    return Intl.message(
      'Profil du demandeur',
      name: 'proReservationRequester',
      desc: 'M29 — the client block.',
      args: [],
    );
  }

  /// `Voir son Mboa Score`
  String get proReservationScore {
    return Intl.message(
      'Voir son Mboa Score',
      name: 'proReservationScore',
      desc: 'RM-M09-04 — the client\'s score.',
      args: [],
    );
  }

  /// `Écrire au client`
  String get proReservationWrite {
    return Intl.message(
      'Écrire au client',
      name: 'proReservationWrite',
      desc: 'RM-M29-14 — the request\'s thread.',
      args: [],
    );
  }

  /// `Séjour`
  String get proReservationStay {
    return Intl.message(
      'Séjour',
      name: 'proReservationStay',
      desc: 'M29 — the request\'s dates.',
      args: [],
    );
  }

  /// `Son message`
  String get proReservationClientMessage {
    return Intl.message(
      'Son message',
      name: 'proReservationClientMessage',
      desc: 'M29 — the client\'s words.',
      args: [],
    );
  }

  /// `{count, plural, =1{1 autre demande pour ce bien} other{{count} autres demandes pour ce bien}}`
  String proReservationOthers(int count) {
    return Intl.plural(
      count,
      one: '1 autre demande pour ce bien',
      other: '$count autres demandes pour ce bien',
      name: 'proReservationOthers',
      desc: 'M29 — other requests waiting on the same listing.',
      args: [count],
    );
  }

  /// `À traiter avant le {date} : sans réponse, la demande expire.`
  String proReservationAnswerBy(String date) {
    return Intl.message(
      'À traiter avant le $date : sans réponse, la demande expire.',
      name: 'proReservationAnswerBy',
      desc: 'RM-M29-05 — the 48 h.',
      args: [date],
    );
  }

  /// `Accepter la demande`
  String get proReservationAccept {
    return Intl.message(
      'Accepter la demande',
      name: 'proReservationAccept',
      desc: 'M29 — main action while pending.',
      args: [],
    );
  }

  /// `Accepter cette demande ?`
  String get proReservationAcceptConfirmTitle {
    return Intl.message(
      'Accepter cette demande ?',
      name: 'proReservationAcceptConfirmTitle',
      desc: 'M29 — confirm.',
      args: [],
    );
  }

  /// `Le bien sera réservé pour ce client le temps d'établir le Contrat Mboa. Les autres demandes en attente ne seront pas retenues.`
  String get proReservationAcceptConfirmBody {
    return Intl.message(
      'Le bien sera réservé pour ce client le temps d\'établir le Contrat Mboa. Les autres demandes en attente ne seront pas retenues.',
      name: 'proReservationAcceptConfirmBody',
      desc: 'RM-M29-04 / RM-M29-07.',
      args: [],
    );
  }

  /// `Accepter`
  String get proReservationAcceptConfirm {
    return Intl.message(
      'Accepter',
      name: 'proReservationAcceptConfirm',
      desc: 'M29 — confirm.',
      args: [],
    );
  }

  /// `Refuser la demande`
  String get proReservationRefuse {
    return Intl.message(
      'Refuser la demande',
      name: 'proReservationRefuse',
      desc: 'M29 — behind ⋯ while pending.',
      args: [],
    );
  }

  /// `Motif du refus`
  String get proReservationRefuseTitle {
    return Intl.message(
      'Motif du refus',
      name: 'proReservationRefuseTitle',
      desc: 'RM-M29-06 — the reason sheet.',
      args: [],
    );
  }

  /// `Le client verra ce motif. Il n'est jamais public.`
  String get proReservationReasonHint {
    return Intl.message(
      'Le client verra ce motif. Il n\'est jamais public.',
      name: 'proReservationReasonHint',
      desc: 'RM-M29-06.',
      args: [],
    );
  }

  /// `Un mot pour le client (facultatif)`
  String get proReservationNoteLabel {
    return Intl.message(
      'Un mot pour le client (facultatif)',
      name: 'proReservationNoteLabel',
      desc: 'M29 — ownerNote, 500 max.',
      args: [],
    );
  }

  /// `Prolonger la réservation`
  String get proReservationExtend {
    return Intl.message(
      'Prolonger la réservation',
      name: 'proReservationExtend',
      desc: 'RM-M29-07 — once.',
      args: [],
    );
  }

  /// `Prolonger la réservation ?`
  String get proReservationExtendConfirmTitle {
    return Intl.message(
      'Prolonger la réservation ?',
      name: 'proReservationExtendConfirmTitle',
      desc: 'RM-M29-07.',
      args: [],
    );
  }

  /// `Le bien reste réservé pour ce client quelques jours de plus. Tu ne peux prolonger qu'une fois.`
  String get proReservationExtendConfirmBody {
    return Intl.message(
      'Le bien reste réservé pour ce client quelques jours de plus. Tu ne peux prolonger qu\'une fois.',
      name: 'proReservationExtendConfirmBody',
      desc: 'RM-M29-07.',
      args: [],
    );
  }

  /// `Prolonger`
  String get proReservationExtendConfirm {
    return Intl.message(
      'Prolonger',
      name: 'proReservationExtendConfirm',
      desc: 'RM-M29-07.',
      args: [],
    );
  }

  /// `Annuler la réservation`
  String get proReservationCancel {
    return Intl.message(
      'Annuler la réservation',
      name: 'proReservationCancel',
      desc: 'RM-M29-08.',
      args: [],
    );
  }

  /// `Motif de l'annulation`
  String get proReservationCancelTitle {
    return Intl.message(
      'Motif de l\'annulation',
      name: 'proReservationCancelTitle',
      desc: 'RM-M29-08 — the reason sheet.',
      args: [],
    );
  }

  /// `Le bien redevient disponible et le client est prévenu. Les annulations sont suivies par Mboa.`
  String get proReservationCancelHint {
    return Intl.message(
      'Le bien redevient disponible et le client est prévenu. Les annulations sont suivies par Mboa.',
      name: 'proReservationCancelHint',
      desc: 'RM-M29-08 — counted for the admin.',
      args: [],
    );
  }

  /// `Établis le Contrat Mboa avec le client avant la fin de la réservation. Sans contrat signé, le bien redevient disponible.`
  String get proReservationNextStep {
    return Intl.message(
      'Établis le Contrat Mboa avec le client avant la fin de la réservation. Sans contrat signé, le bien redevient disponible.',
      name: 'proReservationNextStep',
      desc: 'M29 — ACCEPTED, the prestataire\'s next step.',
      args: [],
    );
  }

  /// `Prolongée`
  String get proReservationExtendedTag {
    return Intl.message(
      'Prolongée',
      name: 'proReservationExtendedTag',
      desc: 'RM-M29-07 — already extended.',
      args: [],
    );
  }

  /// `Demande acceptée : le bien est réservé.`
  String get proReservationAcceptedToast {
    return Intl.message(
      'Demande acceptée : le bien est réservé.',
      name: 'proReservationAcceptedToast',
      desc: 'M29.',
      args: [],
    );
  }

  /// `Demande refusée.`
  String get proReservationRefusedToast {
    return Intl.message(
      'Demande refusée.',
      name: 'proReservationRefusedToast',
      desc: 'M29.',
      args: [],
    );
  }

  /// `Réservation prolongée.`
  String get proReservationExtendedToast {
    return Intl.message(
      'Réservation prolongée.',
      name: 'proReservationExtendedToast',
      desc: 'M29.',
      args: [],
    );
  }

  /// `Réservation annulée.`
  String get proReservationCancelledToast {
    return Intl.message(
      'Réservation annulée.',
      name: 'proReservationCancelledToast',
      desc: 'M29.',
      args: [],
    );
  }

  /// `Cette demande n'attend plus de réponse.`
  String get proReservationClosed {
    return Intl.message(
      'Cette demande n\'attend plus de réponse.',
      name: 'proReservationClosed',
      desc: 'RESERVATION_CLOSED.',
      args: [],
    );
  }

  /// `Ce bien n'est plus publié : il ne peut pas être réservé.`
  String get proReservationNotReservable {
    return Intl.message(
      'Ce bien n\'est plus publié : il ne peut pas être réservé.',
      name: 'proReservationNotReservable',
      desc: 'LISTING_NOT_RESERVABLE.',
      args: [],
    );
  }

  /// `Cette réservation a déjà été prolongée.`
  String get proReservationAlreadyExtended {
    return Intl.message(
      'Cette réservation a déjà été prolongée.',
      name: 'proReservationAlreadyExtended',
      desc: 'RESERVATION_ALREADY_EXTENDED.',
      args: [],
    );
  }

  /// `Cette réservation n'est plus active.`
  String get proReservationNotAccepted {
    return Intl.message(
      'Cette réservation n\'est plus active.',
      name: 'proReservationNotAccepted',
      desc: 'RESERVATION_NOT_ACCEPTED.',
      args: [],
    );
  }

  /// `La réponse n'est pas partie. Réessaie.`
  String get proReservationFailed {
    return Intl.message(
      'La réponse n\'est pas partie. Réessaie.',
      name: 'proReservationFailed',
      desc: 'M29 — network failure.',
      args: [],
    );
  }

  /// `Tu as refusé cette demande.`
  String get proReservationRefusedBody {
    return Intl.message(
      'Tu as refusé cette demande.',
      name: 'proReservationRefusedBody',
      desc: 'M29 — REFUSED.',
      args: [],
    );
  }

  /// `Une autre demande a été acceptée pour ce bien.`
  String get proReservationNotRetainedBody {
    return Intl.message(
      'Une autre demande a été acceptée pour ce bien.',
      name: 'proReservationNotRetainedBody',
      desc: 'M29 — NOT_RETAINED.',
      args: [],
    );
  }

  /// `Sans réponse sous 48 h, la demande a expiré.`
  String get proReservationExpiredBody {
    return Intl.message(
      'Sans réponse sous 48 h, la demande a expiré.',
      name: 'proReservationExpiredBody',
      desc: 'M29 — EXPIRED.',
      args: [],
    );
  }

  /// `Le client a annulé sa demande.`
  String get proReservationCancelledByClient {
    return Intl.message(
      'Le client a annulé sa demande.',
      name: 'proReservationCancelledByClient',
      desc: 'M29 — CANCELLED by the client.',
      args: [],
    );
  }

  /// `Tu as annulé cette réservation.`
  String get proReservationCancelledByYou {
    return Intl.message(
      'Tu as annulé cette réservation.',
      name: 'proReservationCancelledByYou',
      desc: 'M29 — CANCELLED by the prestataire.',
      args: [],
    );
  }

  /// `Le Contrat Mboa est signé : le bien est loué.`
  String get proReservationContractedBody {
    return Intl.message(
      'Le Contrat Mboa est signé : le bien est loué.',
      name: 'proReservationContractedBody',
      desc: 'M29 — CONTRACTED.',
      args: [],
    );
  }

  /// `{count, plural, =1{1 demande de réservation attend ta réponse} other{{count} demandes de réservation attendent ta réponse}}`
  String proReservationsPending(int count) {
    return Intl.plural(
      count,
      one: '1 demande de réservation attend ta réponse',
      other: '$count demandes de réservation attendent ta réponse',
      name: 'proReservationsPending',
      desc: 'M29 — the home\'s counter.',
      args: [count],
    );
  }

  /// `Répondre`
  String get proReservationsPendingAction {
    return Intl.message(
      'Répondre',
      name: 'proReservationsPendingAction',
      desc: 'M29 — the home\'s counter.',
      args: [],
    );
  }

  /// `Voir les demandes`
  String get proReservationsSeeAll {
    return Intl.message(
      'Voir les demandes',
      name: 'proReservationsSeeAll',
      desc: 'M29 — the listing\'s card.',
      args: [],
    );
  }

  /// `Le locataire est le client de la demande de réservation acceptée.`
  String get contractFormTenantFromReservation {
    return Intl.message(
      'Le locataire est le client de la demande de réservation acceptée.',
      name: 'contractFormTenantFromReservation',
      desc: 'RM-M08-10 — contract from a reservation.',
      args: [],
    );
  }

  /// `Ce bien est réservé pour une demande : établis le contrat depuis cette demande.`
  String get contractListingReserved {
    return Intl.message(
      'Ce bien est réservé pour une demande : établis le contrat depuis cette demande.',
      name: 'contractListingReserved',
      desc: 'LISTING_RESERVED.',
      args: [],
    );
  }

  /// `Établir le contrat`
  String get proReservationDraftContract {
    return Intl.message(
      'Établir le contrat',
      name: 'proReservationDraftContract',
      desc: 'RM-M08-10 — main action once accepted.',
      args: [],
    );
  }

  /// `Location`
  String get contractTenancyTitle {
    return Intl.message(
      'Location',
      name: 'contractTenancyTitle',
      desc: 'RM-M08-12 — the signed contract\'s tenancy card.',
      args: [],
    );
  }

  /// `À venir`
  String get contractTenancyUpcoming {
    return Intl.message(
      'À venir',
      name: 'contractTenancyUpcoming',
      desc: 'TenancyState UPCOMING.',
      args: [],
    );
  }

  /// `En cours`
  String get contractTenancyRunning {
    return Intl.message(
      'En cours',
      name: 'contractTenancyRunning',
      desc: 'TenancyState RUNNING.',
      args: [],
    );
  }

  /// `Terminée`
  String get contractTenancyEnded {
    return Intl.message(
      'Terminée',
      name: 'contractTenancyEnded',
      desc: 'TenancyState ENDED.',
      args: [],
    );
  }

  /// `Dernier jour : {date}`
  String contractTenancyEndsOn(String date) {
    return Intl.message(
      'Dernier jour : $date',
      name: 'contractTenancyEndsOn',
      desc: 'RM-M08-12 — endsOn.',
      args: [date],
    );
  }

  /// `Reconduction tacite : pas de date de fin`
  String get contractTenancyTacit {
    return Intl.message(
      'Reconduction tacite : pas de date de fin',
      name: 'contractTenancyTacit',
      desc: 'RM-M08-12 — endsOn null.',
      args: [],
    );
  }

  /// `Résilier le contrat`
  String get contractTerminate {
    return Intl.message(
      'Résilier le contrat',
      name: 'contractTerminate',
      desc: 'RM-M08-11 — behind ⋯ on a signed contract.',
      args: [],
    );
  }

  /// `Tu as proposé de terminer la location le {date}. En attente de réponse.`
  String contractTerminationProposedByYou(String date) {
    return Intl.message(
      'Tu as proposé de terminer la location le $date. En attente de réponse.',
      name: 'contractTerminationProposedByYou',
      desc: 'RM-M08-11 — PROPOSED, author\'s side.',
      args: [date],
    );
  }

  /// `L'autre partie propose de terminer la location le {date}.`
  String contractTerminationProposedToYou(String date) {
    return Intl.message(
      'L\'autre partie propose de terminer la location le $date.',
      name: 'contractTerminationProposedToYou',
      desc: 'RM-M08-11 — PROPOSED, the other side.',
      args: [date],
    );
  }

  /// `Tu as résilié le contrat : la location se termine le {date}.`
  String contractTerminationNotifiedByYou(String date) {
    return Intl.message(
      'Tu as résilié le contrat : la location se termine le $date.',
      name: 'contractTerminationNotifiedByYou',
      desc: 'RM-M08-11 — NOTIFIED, author\'s side.',
      args: [date],
    );
  }

  /// `L'autre partie a résilié le contrat : la location se termine le {date}.`
  String contractTerminationNotifiedToYou(String date) {
    return Intl.message(
      'L\'autre partie a résilié le contrat : la location se termine le $date.',
      name: 'contractTerminationNotifiedToYou',
      desc: 'RM-M08-11 — NOTIFIED, the other side.',
      args: [date],
    );
  }

  /// `Résiliation acceptée : la location se termine le {date}.`
  String contractTerminationConfirmed(String date) {
    return Intl.message(
      'Résiliation acceptée : la location se termine le $date.',
      name: 'contractTerminationConfirmed',
      desc: 'RM-M08-11 — CONFIRMED.',
      args: [date],
    );
  }

  /// `La proposition de résiliation a été refusée : la location continue.`
  String get contractTerminationDeclined {
    return Intl.message(
      'La proposition de résiliation a été refusée : la location continue.',
      name: 'contractTerminationDeclined',
      desc: 'RM-M08-11 — DECLINED.',
      args: [],
    );
  }

  /// `La proposition de résiliation a été retirée.`
  String get contractTerminationWithdrawn {
    return Intl.message(
      'La proposition de résiliation a été retirée.',
      name: 'contractTerminationWithdrawn',
      desc: 'RM-M08-11 — WITHDRAWN.',
      args: [],
    );
  }

  /// `Motif : « {reason} »`
  String contractTerminationReason(String reason) {
    return Intl.message(
      'Motif : « $reason »',
      name: 'contractTerminationReason',
      desc: 'RM-M08-11 — the reason as written.',
      args: [reason],
    );
  }

  /// `Accepter`
  String get contractTerminationAccept {
    return Intl.message(
      'Accepter',
      name: 'contractTerminationAccept',
      desc: 'RM-M08-11 — confirm a proposal.',
      args: [],
    );
  }

  /// `Refuser`
  String get contractTerminationDecline {
    return Intl.message(
      'Refuser',
      name: 'contractTerminationDecline',
      desc: 'RM-M08-11 — decline a proposal.',
      args: [],
    );
  }

  /// `Retirer ma proposition`
  String get contractTerminationWithdraw {
    return Intl.message(
      'Retirer ma proposition',
      name: 'contractTerminationWithdraw',
      desc: 'RM-M08-11 — the author takes it back.',
      args: [],
    );
  }

  /// `Accepter la résiliation ? La location se terminera le {date}.`
  String contractTerminationAcceptConfirm(String date) {
    return Intl.message(
      'Accepter la résiliation ? La location se terminera le $date.',
      name: 'contractTerminationAcceptConfirm',
      desc: 'RM-M08-11 — confirm dialog.',
      args: [date],
    );
  }

  /// `Refuser la proposition ? La location continue.`
  String get contractTerminationDeclineConfirm {
    return Intl.message(
      'Refuser la proposition ? La location continue.',
      name: 'contractTerminationDeclineConfirm',
      desc: 'RM-M08-11 — confirm dialog.',
      args: [],
    );
  }

  /// `Retirer ta proposition de résiliation ?`
  String get contractTerminationWithdrawConfirm {
    return Intl.message(
      'Retirer ta proposition de résiliation ?',
      name: 'contractTerminationWithdrawConfirm',
      desc: 'RM-M08-11 — confirm dialog.',
      args: [],
    );
  }

  /// `À l'amiable`
  String get contractTerminationMutual {
    return Intl.message(
      'À l\'amiable',
      name: 'contractTerminationMutual',
      desc: 'RM-M08-11 — mutual.',
      args: [],
    );
  }

  /// `Tu proposes une date à l'autre partie, qui accepte ou refuse. Tu peux retirer ta proposition tant qu'elle n'a pas répondu.`
  String get contractTerminationMutualBody {
    return Intl.message(
      'Tu proposes une date à l\'autre partie, qui accepte ou refuse. Tu peux retirer ta proposition tant qu\'elle n\'a pas répondu.',
      name: 'contractTerminationMutualBody',
      desc: 'RM-M08-11 — mutual.',
      args: [],
    );
  }

  /// `Avec préavis`
  String get contractTerminationAlone {
    return Intl.message(
      'Avec préavis',
      name: 'contractTerminationAlone',
      desc: 'RM-M08-11 — notified alone.',
      args: [],
    );
  }

  /// `Tu notifies seul la fin de la location, au plus tôt le {date}. C'est définitif dès l'envoi.`
  String contractTerminationAloneBody(String date) {
    return Intl.message(
      'Tu notifies seul la fin de la location, au plus tôt le $date. C\'est définitif dès l\'envoi.',
      name: 'contractTerminationAloneBody',
      desc: 'RM-M08-11 — notified alone, earliestNoticeDate.',
      args: [date],
    );
  }

  /// `Dernier jour de location`
  String get contractTerminationLastDay {
    return Intl.message(
      'Dernier jour de location',
      name: 'contractTerminationLastDay',
      desc: 'RM-M08-11 — effectiveDate.',
      args: [],
    );
  }

  /// `Motif`
  String get contractTerminationReasonLabel {
    return Intl.message(
      'Motif',
      name: 'contractTerminationReasonLabel',
      desc: 'RM-M08-11 — required, 500 max.',
      args: [],
    );
  }

  /// `Explique pourquoi tu mets fin à la location`
  String get contractTerminationReasonHint {
    return Intl.message(
      'Explique pourquoi tu mets fin à la location',
      name: 'contractTerminationReasonHint',
      desc: 'RM-M08-11.',
      args: [],
    );
  }

  /// `Proposer la résiliation`
  String get contractTerminationPropose {
    return Intl.message(
      'Proposer la résiliation',
      name: 'contractTerminationPropose',
      desc: 'RM-M08-11 — send, mutual.',
      args: [],
    );
  }

  /// `Notifier la résiliation`
  String get contractTerminationNotify {
    return Intl.message(
      'Notifier la résiliation',
      name: 'contractTerminationNotify',
      desc: 'RM-M08-11 — send, alone.',
      args: [],
    );
  }

  /// `Notifier la résiliation ? Elle est définitive et ne pourra pas être retirée.`
  String get contractTerminationNotifyConfirm {
    return Intl.message(
      'Notifier la résiliation ? Elle est définitive et ne pourra pas être retirée.',
      name: 'contractTerminationNotifyConfirm',
      desc: 'RM-M08-11 — confirm dialog, alone.',
      args: [],
    );
  }

  /// `Le préavis est trop court pour cette date.`
  String get contractTerminationNoticeTooShort {
    return Intl.message(
      'Le préavis est trop court pour cette date.',
      name: 'contractTerminationNoticeTooShort',
      desc: 'NOTICE_TOO_SHORT.',
      args: [],
    );
  }

  /// `Le dernier jour ne peut pas être passé.`
  String get contractTerminationDatePast {
    return Intl.message(
      'Le dernier jour ne peut pas être passé.',
      name: 'contractTerminationDatePast',
      desc: 'TERMINATION_DATE_PAST.',
      args: [],
    );
  }

  /// `Cette date est après la fin prévue du contrat.`
  String get contractTerminationAfterTerm {
    return Intl.message(
      'Cette date est après la fin prévue du contrat.',
      name: 'contractTerminationAfterTerm',
      desc: 'TERMINATION_AFTER_TERM.',
      args: [],
    );
  }

  /// `Une résiliation attend déjà une réponse.`
  String get contractTerminationPending {
    return Intl.message(
      'Une résiliation attend déjà une réponse.',
      name: 'contractTerminationPending',
      desc: 'TERMINATION_PENDING.',
      args: [],
    );
  }

  /// `Ce contrat est déjà résilié.`
  String get contractTerminationAlready {
    return Intl.message(
      'Ce contrat est déjà résilié.',
      name: 'contractTerminationAlready',
      desc: 'CONTRACT_ALREADY_TERMINATED.',
      args: [],
    );
  }

  /// `Cette location est terminée.`
  String get contractTerminationEnded {
    return Intl.message(
      'Cette location est terminée.',
      name: 'contractTerminationEnded',
      desc: 'CONTRACT_ENDED.',
      args: [],
    );
  }

  /// `La résiliation a changé entre-temps : voici où elle en est.`
  String get contractTerminationClosed {
    return Intl.message(
      'La résiliation a changé entre-temps : voici où elle en est.',
      name: 'contractTerminationClosed',
      desc: 'TERMINATION_FINAL, NO_PENDING_TERMINATION…',
      args: [],
    );
  }

  /// `Lever la réservation`
  String get annonceActionUnreserve {
    return Intl.message(
      'Lever la réservation',
      name: 'annonceActionUnreserve',
      desc: 'RM-M10-10 — a reservation set by hand.',
      args: [],
    );
  }

  /// `Réservée pour un client`
  String get annonceReservedByRequestTitle {
    return Intl.message(
      'Réservée pour un client',
      name: 'annonceReservedByRequestTitle',
      desc: 'M29 — held by an accepted request.',
      args: [],
    );
  }

  /// `Jusqu'au {date}, le temps d'établir le Contrat Mboa. Cette réservation s'annule depuis la demande.`
  String annonceReservedByRequestUntil(String date) {
    return Intl.message(
      'Jusqu\'au $date, le temps d\'établir le Contrat Mboa. Cette réservation s\'annule depuis la demande.',
      name: 'annonceReservedByRequestUntil',
      desc: 'M29 — reservedUntil.',
      args: [date],
    );
  }

  /// `Une demande acceptée réserve ce bien : gère la réservation depuis la demande.`
  String get annonceReservedByRequestBody {
    return Intl.message(
      'Une demande acceptée réserve ce bien : gère la réservation depuis la demande.',
      name: 'annonceReservedByRequestBody',
      desc: 'RESERVATION_FROM_REQUEST.',
      args: [],
    );
  }

  /// `Voir la demande`
  String get annonceSeeRequest {
    return Intl.message(
      'Voir la demande',
      name: 'annonceSeeRequest',
      desc: 'M29 — open the holding request.',
      args: [],
    );
  }

  /// `Réservée`
  String get annonceReservedManualTitle {
    return Intl.message(
      'Réservée',
      name: 'annonceReservedManualTitle',
      desc: 'RM-M10-10 — set by hand.',
      args: [],
    );
  }

  /// `Tu as réservé ce bien toi-même. Lève la réservation pour le remettre en ligne.`
  String get annonceReservedManualBody {
    return Intl.message(
      'Tu as réservé ce bien toi-même. Lève la réservation pour le remettre en ligne.',
      name: 'annonceReservedManualBody',
      desc: 'RM-M10-10.',
      args: [],
    );
  }

  /// `Voir le contrat`
  String get proReservationSeeContract {
    return Intl.message(
      'Voir le contrat',
      name: 'proReservationSeeContract',
      desc: 'RM-M08-10 — the contract already drawn up from this request.',
      args: [],
    );
  }

  /// `Signature du prestataire`
  String get contractSignatureProvider {
    return Intl.message(
      'Signature du prestataire',
      name: 'contractSignatureProvider',
      desc: 'A signature by the prestataire, read by the tenant.',
      args: [],
    );
  }

  /// `Sur des termes modifiés depuis : elle ne compte plus.`
  String get contractSignatureSuperseded {
    return Intl.message(
      'Sur des termes modifiés depuis : elle ne compte plus.',
      name: 'contractSignatureSuperseded',
      desc:
          'SignatureResponse.current false — a signature against superseded terms.',
      args: [],
    );
  }

  /// `Voir toutes les photos`
  String get listingAllPhotos {
    return Intl.message(
      'Voir toutes les photos',
      name: 'listingAllPhotos',
      desc: 'RM-M05-01 — the hero\'s gallery button.',
      args: [],
    );
  }

  /// `{index} / {count}`
  String listingGalleryPosition(String index, String count) {
    return Intl.message(
      '$index / $count',
      name: 'listingGalleryPosition',
      desc: 'Full-screen gallery counter.',
      args: [index, count],
    );
  }

  /// `Localisation`
  String get listingLocationCard {
    return Intl.message(
      'Localisation',
      name: 'listingLocationCard',
      desc: 'The fiche\'s map card, after the mockup.',
      args: [],
    );
  }

  /// `Avis`
  String get listingReviewsCard {
    return Intl.message(
      'Avis',
      name: 'listingReviewsCard',
      desc: 'The fiche\'s reviews card, after the mockup.',
      args: [],
    );
  }

  /// `{count, plural, =0{Pas encore d'avis} =1{1 avis} other{{count} avis}}`
  String listingReviewsCount(int count) {
    return Intl.plural(
      count,
      zero: 'Pas encore d\'avis',
      one: '1 avis',
      other: '$count avis',
      name: 'listingReviewsCount',
      desc: 'Under the average on the reviews card.',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 pièce} other{{count} pièces}}`
  String listingFactRooms(int count) {
    return Intl.plural(
      count,
      one: '1 pièce',
      other: '$count pièces',
      name: 'listingFactRooms',
      desc: 'Fact chip.',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 salle de bain} other{{count} salles de bain}}`
  String listingFactBathrooms(int count) {
    return Intl.plural(
      count,
      one: '1 salle de bain',
      other: '$count salles de bain',
      name: 'listingFactBathrooms',
      desc: 'Fact chip.',
      args: [count],
    );
  }

  /// `Meublé`
  String get listingFactFurnished {
    return Intl.message(
      'Meublé',
      name: 'listingFactFurnished',
      desc: 'Fact chip.',
      args: [],
    );
  }

  /// `Non meublé`
  String get listingFactUnfurnished {
    return Intl.message(
      'Non meublé',
      name: 'listingFactUnfurnished',
      desc: 'Fact chip.',
      args: [],
    );
  }

  /// `Charges incluses`
  String get listingFactChargesIncluded {
    return Intl.message(
      'Charges incluses',
      name: 'listingFactChargesIncluded',
      desc: 'Fact chip.',
      args: [],
    );
  }

  /// `Charges en sus`
  String get listingFactChargesExtra {
    return Intl.message(
      'Charges en sus',
      name: 'listingFactChargesExtra',
      desc: 'Fact chip.',
      args: [],
    );
  }

  /// `Libre dès le {date}`
  String listingFactAvailableFrom(String date) {
    return Intl.message(
      'Libre dès le $date',
      name: 'listingFactAvailableFrom',
      desc: 'Fact chip.',
      args: [date],
    );
  }

  /// `Localisation du bien`
  String get listingMapTitle {
    return Intl.message(
      'Localisation du bien',
      name: 'listingMapTitle',
      desc: 'The full-screen map from the fiche.',
      args: [],
    );
  }

  /// `Mon logement`
  String get myHomeTitle {
    return Intl.message(
      'Mon logement',
      name: 'myHomeTitle',
      desc: 'M30 — the space, and its Compte tile.',
      args: [],
    );
  }

  /// `Mes logements`
  String get myHomesTitle {
    return Intl.message(
      'Mes logements',
      name: 'myHomesTitle',
      desc: 'M30 — the list when there are several.',
      args: [],
    );
  }

  /// `Pas encore de logement`
  String get myHomesEmptyTitle {
    return Intl.message(
      'Pas encore de logement',
      name: 'myHomesEmptyTitle',
      desc: 'M30 — no signed contract.',
      args: [],
    );
  }

  /// `Ton espace s'ouvre dès que ton Contrat Mboa est signé par les deux parties.`
  String get myHomesEmptyBody {
    return Intl.message(
      'Ton espace s\'ouvre dès que ton Contrat Mboa est signé par les deux parties.',
      name: 'myHomesEmptyBody',
      desc: 'RM-M30-01.',
      args: [],
    );
  }

  /// `Prochain loyer`
  String get myHomeNextRent {
    return Intl.message(
      'Prochain loyer',
      name: 'myHomeNextRent',
      desc: 'M30 — the header, an échéance to pay.',
      args: [],
    );
  }

  /// `En retard`
  String get myHomeOverdue {
    return Intl.message(
      'En retard',
      name: 'myHomeOverdue',
      desc: 'M30 — the header, échéances late.',
      args: [],
    );
  }

  /// `À venir`
  String get myHomeUpcomingState {
    return Intl.message(
      'À venir',
      name: 'myHomeUpcomingState',
      desc: 'RM-M30-01 — before the move-in day.',
      args: [],
    );
  }

  /// `Tout est à jour`
  String get myHomeUpToDate {
    return Intl.message(
      'Tout est à jour',
      name: 'myHomeUpToDate',
      desc: 'M30 — nothing to pay.',
      args: [],
    );
  }

  /// `Location terminée`
  String get myHomeEnded {
    return Intl.message(
      'Location terminée',
      name: 'myHomeEnded',
      desc: 'RM-M30-16 — read only.',
      args: [],
    );
  }

  /// `À payer le {date}`
  String myHomeDueOn(String date) {
    return Intl.message(
      'À payer le $date',
      name: 'myHomeDueOn',
      desc: 'M30 — the header.',
      args: [date],
    );
  }

  /// `{count, plural, =1{1 échéance en retard} other{{count} échéances en retard}}`
  String myHomeOverdueCount(int count) {
    return Intl.plural(
      count,
      one: '1 échéance en retard',
      other: '$count échéances en retard',
      name: 'myHomeOverdueCount',
      desc: 'M30 — the header.',
      args: [count],
    );
  }

  /// `Entrée le {date}`
  String myHomeStartsOn(String date) {
    return Intl.message(
      'Entrée le $date',
      name: 'myHomeStartsOn',
      desc: 'M30 — an upcoming space.',
      args: [date],
    );
  }

  /// `Déclarer un paiement`
  String get myHomeDeclare {
    return Intl.message(
      'Déclarer un paiement',
      name: 'myHomeDeclare',
      desc: 'RM-M30-03 — the tenant\'s round button.',
      args: [],
    );
  }

  /// `Caution`
  String get myHomeDeposit {
    return Intl.message(
      'Caution',
      name: 'myHomeDeposit',
      desc: 'M30 — the deposit button and label.',
      args: [],
    );
  }

  /// `Confirmé`
  String get myHomeConfirmedTotal {
    return Intl.message(
      'Confirmé',
      name: 'myHomeConfirmedTotal',
      desc: 'M30 — totals.',
      args: [],
    );
  }

  /// `En attente`
  String get myHomeDeclaredTotal {
    return Intl.message(
      'En attente',
      name: 'myHomeDeclaredTotal',
      desc: 'M30 — totals.',
      args: [],
    );
  }

  /// `Contesté`
  String get myHomeContestedTotal {
    return Intl.message(
      'Contesté',
      name: 'myHomeContestedTotal',
      desc: 'M30 — totals.',
      args: [],
    );
  }

  /// `Échéancier`
  String get myHomeScheduleTitle {
    return Intl.message(
      'Échéancier',
      name: 'myHomeScheduleTitle',
      desc: 'RM-M30-02.',
      args: [],
    );
  }

  /// `Échéances plus anciennes`
  String get myHomeOlder {
    return Intl.message(
      'Échéances plus anciennes',
      name: 'myHomeOlder',
      desc: 'M30 — paging back.',
      args: [],
    );
  }

  /// `Hors ligne : ton espace tel qu'à ta dernière connexion.`
  String get myHomeOffline {
    return Intl.message(
      'Hors ligne : ton espace tel qu\'à ta dernière connexion.',
      name: 'myHomeOffline',
      desc: 'M30 — the cached space.',
      args: [],
    );
  }

  /// `Les loyers se paient hors de Mboa : tu les déclares ici, ton propriétaire les confirme.`
  String get myHomeNoMoney {
    return Intl.message(
      'Les loyers se paient hors de Mboa : tu les déclares ici, ton propriétaire les confirme.',
      name: 'myHomeNoMoney',
      desc: 'RM-M30-06.',
      args: [],
    );
  }

  /// `À venir`
  String get dueUpcoming {
    return Intl.message(
      'À venir',
      name: 'dueUpcoming',
      desc: 'Due status.',
      args: [],
    );
  }

  /// `À payer`
  String get dueDue {
    return Intl.message(
      'À payer',
      name: 'dueDue',
      desc: 'Due status.',
      args: [],
    );
  }

  /// `En retard`
  String get dueLate {
    return Intl.message(
      'En retard',
      name: 'dueLate',
      desc: 'Due status.',
      args: [],
    );
  }

  /// `Déclaré, en attente`
  String get dueDeclared {
    return Intl.message(
      'Déclaré, en attente',
      name: 'dueDeclared',
      desc: 'Due status.',
      args: [],
    );
  }

  /// `Déclaré, non confirmé`
  String get dueUnconfirmed {
    return Intl.message(
      'Déclaré, non confirmé',
      name: 'dueUnconfirmed',
      desc: 'Due status — 7 days without an answer.',
      args: [],
    );
  }

  /// `Payé`
  String get dueConfirmed {
    return Intl.message(
      'Payé',
      name: 'dueConfirmed',
      desc: 'Due status.',
      args: [],
    );
  }

  /// `Contesté`
  String get dueContested {
    return Intl.message(
      'Contesté',
      name: 'dueContested',
      desc: 'Due status.',
      args: [],
    );
  }

  /// `Avant le suivi Mboa`
  String get dueUntracked {
    return Intl.message(
      'Avant le suivi Mboa',
      name: 'dueUntracked',
      desc: 'Due status — UNTRACKED.',
      args: [],
    );
  }

  /// `{paid} sur {total}`
  String duePartial(String paid, String total) {
    return Intl.message(
      '$paid sur $total',
      name: 'duePartial',
      desc: 'A partly paid échéance.',
      args: [paid, total],
    );
  }

  /// `{from} – {to}`
  String myHomePeriod(String from, String to) {
    return Intl.message(
      '$from – $to',
      name: 'myHomePeriod',
      desc: 'An échéance\'s period.',
      args: [from, to],
    );
  }

  /// `Déclarations`
  String get myHomeDeclarationsTitle {
    return Intl.message(
      'Déclarations',
      name: 'myHomeDeclarationsTitle',
      desc: 'M30 — the declarations section.',
      args: [],
    );
  }

  /// `{count, plural, =1{Loyer · 1 échéance} other{Loyer · {count} échéances}}`
  String declarationRentCount(int count) {
    return Intl.plural(
      count,
      one: 'Loyer · 1 échéance',
      other: 'Loyer · $count échéances',
      name: 'declarationRentCount',
      desc: 'A declaration row.',
      args: [count],
    );
  }

  /// `En attente`
  String get declStatusDeclared {
    return Intl.message(
      'En attente',
      name: 'declStatusDeclared',
      desc: 'Declaration status.',
      args: [],
    );
  }

  /// `Non confirmé`
  String get declStatusUnconfirmed {
    return Intl.message(
      'Non confirmé',
      name: 'declStatusUnconfirmed',
      desc: 'Declaration status.',
      args: [],
    );
  }

  /// `Confirmé`
  String get declStatusConfirmed {
    return Intl.message(
      'Confirmé',
      name: 'declStatusConfirmed',
      desc: 'Declaration status.',
      args: [],
    );
  }

  /// `Contesté`
  String get declStatusContested {
    return Intl.message(
      'Contesté',
      name: 'declStatusContested',
      desc: 'Declaration status.',
      args: [],
    );
  }

  /// `MTN Mobile Money`
  String get methodMobileMoney {
    return Intl.message(
      'MTN Mobile Money',
      name: 'methodMobileMoney',
      desc: 'Payment method.',
      args: [],
    );
  }

  /// `Orange Money`
  String get methodOrangeMoney {
    return Intl.message(
      'Orange Money',
      name: 'methodOrangeMoney',
      desc: 'Payment method.',
      args: [],
    );
  }

  /// `Espèces`
  String get methodCash {
    return Intl.message(
      'Espèces',
      name: 'methodCash',
      desc: 'Payment method.',
      args: [],
    );
  }

  /// `Virement`
  String get methodTransfer {
    return Intl.message(
      'Virement',
      name: 'methodTransfer',
      desc: 'Payment method.',
      args: [],
    );
  }

  /// `Autre`
  String get methodOther {
    return Intl.message(
      'Autre',
      name: 'methodOther',
      desc: 'Payment method.',
      args: [],
    );
  }

  /// `Sans justificatif`
  String get myHomeNoProof {
    return Intl.message(
      'Sans justificatif',
      name: 'myHomeNoProof',
      desc: 'RM-M30-03 — declared without proof.',
      args: [],
    );
  }

  /// `Déclarer`
  String get myHomeDeclareShort {
    return Intl.message(
      'Déclarer',
      name: 'myHomeDeclareShort',
      desc: 'M30 — the round button, one word like the mockup.',
      args: [],
    );
  }

  /// `Déclarer un paiement`
  String get declareTitle {
    return Intl.message(
      'Déclarer un paiement',
      name: 'declareTitle',
      desc: 'RM-M30-03 — the form\'s title.',
      args: [],
    );
  }

  /// `Déclarer la caution`
  String get declareDepositTitle {
    return Intl.message(
      'Déclarer la caution',
      name: 'declareDepositTitle',
      desc: 'The deposit form\'s title.',
      args: [],
    );
  }

  /// `Pour quelles échéances ?`
  String get declareWhich {
    return Intl.message(
      'Pour quelles échéances ?',
      name: 'declareWhich',
      desc: 'The échéances to cover.',
      args: [],
    );
  }

  /// `Elles se suivent : touche la suivante pour payer plusieurs mois d'avance.`
  String get declareWhichHint {
    return Intl.message(
      'Elles se suivent : touche la suivante pour payer plusieurs mois d\'avance.',
      name: 'declareWhichHint',
      desc: '§29.1 — consecutive.',
      args: [],
    );
  }

  /// `Aucune échéance à déclarer pour l'instant.`
  String get declareNoOpen {
    return Intl.message(
      'Aucune échéance à déclarer pour l\'instant.',
      name: 'declareNoOpen',
      desc: 'No open échéance.',
      args: [],
    );
  }

  /// `Montant payé`
  String get declareAmount {
    return Intl.message(
      'Montant payé',
      name: 'declareAmount',
      desc: 'The amount field.',
      args: [],
    );
  }

  /// `Payé le`
  String get declarePaidOn {
    return Intl.message(
      'Payé le',
      name: 'declarePaidOn',
      desc: 'The date field.',
      args: [],
    );
  }

  /// `Moyen de paiement`
  String get declareMethod {
    return Intl.message(
      'Moyen de paiement',
      name: 'declareMethod',
      desc: 'The method field.',
      args: [],
    );
  }

  /// `Mobile Money`
  String get declareTabMobile {
    return Intl.message(
      'Mobile Money',
      name: 'declareTabMobile',
      desc: 'The mockup\'s first tab.',
      args: [],
    );
  }

  /// `Autres`
  String get declareTabOther {
    return Intl.message(
      'Autres',
      name: 'declareTabOther',
      desc: 'The mockup\'s second tab.',
      args: [],
    );
  }

  /// `Référence (facultatif)`
  String get declareReference {
    return Intl.message(
      'Référence (facultatif)',
      name: 'declareReference',
      desc: 'The transaction reference.',
      args: [],
    );
  }

  /// `Le code reçu par SMS, par exemple`
  String get declareReferenceHint {
    return Intl.message(
      'Le code reçu par SMS, par exemple',
      name: 'declareReferenceHint',
      desc: 'Reference hint.',
      args: [],
    );
  }

  /// `Un mot pour ton propriétaire (facultatif)`
  String get declareNote {
    return Intl.message(
      'Un mot pour ton propriétaire (facultatif)',
      name: 'declareNote',
      desc: 'The note.',
      args: [],
    );
  }

  /// `Justificatifs (facultatif)`
  String get declareProofs {
    return Intl.message(
      'Justificatifs (facultatif)',
      name: 'declareProofs',
      desc: 'RM-M30-03.',
      args: [],
    );
  }

  /// `Une capture du SMS ou une photo du reçu. Sans justificatif, la déclaration le dit.`
  String get declareProofsHint {
    return Intl.message(
      'Une capture du SMS ou une photo du reçu. Sans justificatif, la déclaration le dit.',
      name: 'declareProofsHint',
      desc: 'RM-M30-03.',
      args: [],
    );
  }

  /// `Ajouter`
  String get declareAddProof {
    return Intl.message(
      'Ajouter',
      name: 'declareAddProof',
      desc: 'Add a proof.',
      args: [],
    );
  }

  /// `Justificatif {n}`
  String declareProofN(String n) {
    return Intl.message(
      'Justificatif $n',
      name: 'declareProofN',
      desc: 'A proof tile.',
      args: [n],
    );
  }

  /// `Déclarer le paiement`
  String get declareSend {
    return Intl.message(
      'Déclarer le paiement',
      name: 'declareSend',
      desc: 'Submit.',
      args: [],
    );
  }

  /// `Montant inhabituel`
  String get declareUnusualTitle {
    return Intl.message(
      'Montant inhabituel',
      name: 'declareUnusualTitle',
      desc: 'CE-M30-02.',
      args: [],
    );
  }

  /// `Tu déclares {amount} pour {due} à payer. Vérifie le montant avant d'envoyer.`
  String declareUnusualBody(String amount, String due) {
    return Intl.message(
      'Tu déclares $amount pour $due à payer. Vérifie le montant avant d\'envoyer.',
      name: 'declareUnusualBody',
      desc: 'CE-M30-02.',
      args: [amount, due],
    );
  }

  /// `Envoyer quand même`
  String get declareUnusualConfirm {
    return Intl.message(
      'Envoyer quand même',
      name: 'declareUnusualConfirm',
      desc: 'CE-M30-02.',
      args: [],
    );
  }

  /// `Paiement déclaré`
  String get declareSentTitle {
    return Intl.message(
      'Paiement déclaré',
      name: 'declareSentTitle',
      desc: 'After sending.',
      args: [],
    );
  }

  /// `Ton propriétaire va le confirmer.`
  String get declareSentBody {
    return Intl.message(
      'Ton propriétaire va le confirmer.',
      name: 'declareSentBody',
      desc: 'After sending.',
      args: [],
    );
  }

  /// `Le justificatif n'est pas parti. Réessaie.`
  String get declareUploadFailed {
    return Intl.message(
      'Le justificatif n\'est pas parti. Réessaie.',
      name: 'declareUploadFailed',
      desc: 'CE-M30-01.',
      args: [],
    );
  }

  /// `La déclaration n'est pas partie. Réessaie.`
  String get declareFailed {
    return Intl.message(
      'La déclaration n\'est pas partie. Réessaie.',
      name: 'declareFailed',
      desc: 'Network failure.',
      args: [],
    );
  }

  /// `Le montant doit être supérieur à zéro.`
  String get declRefusedAmount {
    return Intl.message(
      'Le montant doit être supérieur à zéro.',
      name: 'declRefusedAmount',
      desc: 'DECLARATION_AMOUNT_INVALID.',
      args: [],
    );
  }

  /// `La date de paiement ne peut pas être dans le futur.`
  String get declRefusedDate {
    return Intl.message(
      'La date de paiement ne peut pas être dans le futur.',
      name: 'declRefusedDate',
      desc: 'DECLARATION_DATE_INVALID.',
      args: [],
    );
  }

  /// `Choisis des échéances qui se suivent, dans les 12 prochaines.`
  String get declRefusedDues {
    return Intl.message(
      'Choisis des échéances qui se suivent, dans les 12 prochaines.',
      name: 'declRefusedDues',
      desc: 'DUE_INDEXES_INVALID.',
      args: [],
    );
  }

  /// `Une de ces échéances est déjà payée.`
  String get declRefusedDueConfirmed {
    return Intl.message(
      'Une de ces échéances est déjà payée.',
      name: 'declRefusedDueConfirmed',
      desc: 'DUE_ALREADY_CONFIRMED.',
      args: [],
    );
  }

  /// `Ce contrat ne prévoit pas de caution.`
  String get declRefusedNoDeposit {
    return Intl.message(
      'Ce contrat ne prévoit pas de caution.',
      name: 'declRefusedNoDeposit',
      desc: 'NO_DEPOSIT.',
      args: [],
    );
  }

  /// `La caution est déjà confirmée.`
  String get declRefusedDepositConfirmed {
    return Intl.message(
      'La caution est déjà confirmée.',
      name: 'declRefusedDepositConfirmed',
      desc: 'DEPOSIT_ALREADY_CONFIRMED.',
      args: [],
    );
  }

  /// `Trois justificatifs au plus.`
  String get declRefusedProofLimit {
    return Intl.message(
      'Trois justificatifs au plus.',
      name: 'declRefusedProofLimit',
      desc: 'PROOF_LIMIT.',
      args: [],
    );
  }

  /// `Un justificatif n'a pas pu être lu : ajoute-le à nouveau.`
  String get declRefusedAttachment {
    return Intl.message(
      'Un justificatif n\'a pas pu être lu : ajoute-le à nouveau.',
      name: 'declRefusedAttachment',
      desc: 'INVALID_ATTACHMENT.',
      args: [],
    );
  }

  /// `Cette location est terminée : tu ne peux plus déclarer de paiement.`
  String get declRefusedReadOnly {
    return Intl.message(
      'Cette location est terminée : tu ne peux plus déclarer de paiement.',
      name: 'declRefusedReadOnly',
      desc: 'HOME_READ_ONLY.',
      args: [],
    );
  }

  /// `Ce paiement a déjà reçu une réponse.`
  String get declRefusedAnswered {
    return Intl.message(
      'Ce paiement a déjà reçu une réponse.',
      name: 'declRefusedAnswered',
      desc: 'DECLARATION_ANSWERED.',
      args: [],
    );
  }

  /// `Donne le motif de la contestation.`
  String get declRefusedReason {
    return Intl.message(
      'Donne le motif de la contestation.',
      name: 'declRefusedReason',
      desc: 'CONTEST_REASON_REQUIRED.',
      args: [],
    );
  }

  /// `Paiement déclaré`
  String get declarationTitle {
    return Intl.message(
      'Paiement déclaré',
      name: 'declarationTitle',
      desc: 'The declaration\'s screen.',
      args: [],
    );
  }

  /// `Locataire`
  String get declarationTenant {
    return Intl.message(
      'Locataire',
      name: 'declarationTenant',
      desc: 'The card\'s left side.',
      args: [],
    );
  }

  /// `Propriétaire`
  String get declarationLandlord {
    return Intl.message(
      'Propriétaire',
      name: 'declarationLandlord',
      desc: 'The card\'s right side.',
      args: [],
    );
  }

  /// `Payé hors de Mboa`
  String get declarationOutside {
    return Intl.message(
      'Payé hors de Mboa',
      name: 'declarationOutside',
      desc: 'RM-M30-06.',
      args: [],
    );
  }

  /// `Échéances`
  String get declarationCovers {
    return Intl.message(
      'Échéances',
      name: 'declarationCovers',
      desc: 'What it covers.',
      args: [],
    );
  }

  /// `Mot du locataire`
  String get declarationTenantNote {
    return Intl.message(
      'Mot du locataire',
      name: 'declarationTenantNote',
      desc: 'The note.',
      args: [],
    );
  }

  /// `Motif de la contestation`
  String get declarationContestReason {
    return Intl.message(
      'Motif de la contestation',
      name: 'declarationContestReason',
      desc: 'RM-M30-07.',
      args: [],
    );
  }

  /// `Justificatifs`
  String get declarationProofs {
    return Intl.message(
      'Justificatifs',
      name: 'declarationProofs',
      desc: 'RM-M30-12 — never public.',
      args: [],
    );
  }

  /// `Déclaré le {date}`
  String declarationDeclaredOn(String date) {
    return Intl.message(
      'Déclaré le $date',
      name: 'declarationDeclaredOn',
      desc: 'When it was sent.',
      args: [date],
    );
  }

  /// `En attente de la réponse du propriétaire.`
  String get declarationWaiting {
    return Intl.message(
      'En attente de la réponse du propriétaire.',
      name: 'declarationWaiting',
      desc: 'DECLARED.',
      args: [],
    );
  }

  /// `Sans réponse depuis 7 jours : la déclaration reste visible des deux côtés.`
  String get declarationUnconfirmedBody {
    return Intl.message(
      'Sans réponse depuis 7 jours : la déclaration reste visible des deux côtés.',
      name: 'declarationUnconfirmedBody',
      desc: 'RM-M30-04 — UNCONFIRMED.',
      args: [],
    );
  }

  /// `Confirmer le paiement`
  String get declarationConfirm {
    return Intl.message(
      'Confirmer le paiement',
      name: 'declarationConfirm',
      desc: 'RM-M30-04 — the landlord\'s main action.',
      args: [],
    );
  }

  /// `Contester`
  String get declarationContest {
    return Intl.message(
      'Contester',
      name: 'declarationContest',
      desc: 'RM-M30-04 — behind ⋯.',
      args: [],
    );
  }

  /// `Confirmer ce paiement ?`
  String get declarationConfirmTitle {
    return Intl.message(
      'Confirmer ce paiement ?',
      name: 'declarationConfirmTitle',
      desc: 'Confirm dialog.',
      args: [],
    );
  }

  /// `Tu confirmes avoir reçu {amount}. Une quittance sera établie pour le locataire.`
  String declarationConfirmBody(String amount) {
    return Intl.message(
      'Tu confirmes avoir reçu $amount. Une quittance sera établie pour le locataire.',
      name: 'declarationConfirmBody',
      desc: 'RM-M30-05.',
      args: [amount],
    );
  }

  /// `Le locataire verra ce motif. La déclaration reste visible des deux côtés.`
  String get declarationContestHint {
    return Intl.message(
      'Le locataire verra ce motif. La déclaration reste visible des deux côtés.',
      name: 'declarationContestHint',
      desc: 'RM-M30-07.',
      args: [],
    );
  }

  /// `Paiement confirmé`
  String get declarationConfirmedToast {
    return Intl.message(
      'Paiement confirmé',
      name: 'declarationConfirmedToast',
      desc: 'After confirming.',
      args: [],
    );
  }

  /// `Paiement contesté`
  String get declarationContestedToast {
    return Intl.message(
      'Paiement contesté',
      name: 'declarationContestedToast',
      desc: 'After contesting.',
      args: [],
    );
  }

  /// `Référence`
  String get declarationReference {
    return Intl.message(
      'Référence',
      name: 'declarationReference',
      desc: 'The declaration detail.',
      args: [],
    );
  }

  /// `Déclaré le`
  String get declarationDeclaredAt {
    return Intl.message(
      'Déclaré le',
      name: 'declarationDeclaredAt',
      desc: 'The declaration detail.',
      args: [],
    );
  }

  /// `Logement`
  String get declarationProperty {
    return Intl.message(
      'Logement',
      name: 'declarationProperty',
      desc: 'Declaration detail: label of the rented property\'s title',
      args: [],
    );
  }

  /// `Le locataire attend ta réponse : confirme si tu as bien reçu ce paiement, ou conteste-le.`
  String get declarationWaitingYou {
    return Intl.message(
      'Le locataire attend ta réponse : confirme si tu as bien reçu ce paiement, ou conteste-le.',
      name: 'declarationWaitingYou',
      desc:
          'Declaration detail, landlord side: a declaration waiting for their answer',
      args: [],
    );
  }

  /// `Loyers`
  String get proRentsTitle {
    return Intl.message(
      'Loyers',
      name: 'proRentsTitle',
      desc: 'Pro: the rents screen title (M30, landlord side)',
      args: [],
    );
  }

  /// `À confirmer`
  String get proRentsTabWaiting {
    return Intl.message(
      'À confirmer',
      name: 'proRentsTabWaiting',
      desc: 'Pro rents: tab of declared payments waiting for an answer',
      args: [],
    );
  }

  /// `Locataires`
  String get proRentsTabHomes {
    return Intl.message(
      'Locataires',
      name: 'proRentsTabHomes',
      desc: 'Pro rents: tab of the tenants\' spaces',
      args: [],
    );
  }

  /// `Aucun paiement à confirmer. Quand un locataire déclare un loyer, il arrive ici.`
  String get proRentsEmptyWaiting {
    return Intl.message(
      'Aucun paiement à confirmer. Quand un locataire déclare un loyer, il arrive ici.',
      name: 'proRentsEmptyWaiting',
      desc: 'Pro rents: empty waiting tab',
      args: [],
    );
  }

  /// `Aucun locataire pour l'instant. Un espace s'ouvre dès qu'un contrat est signé.`
  String get proRentsEmptyHomes {
    return Intl.message(
      'Aucun locataire pour l\'instant. Un espace s\'ouvre dès qu\'un contrat est signé.',
      name: 'proRentsEmptyHomes',
      desc: 'Pro rents: empty tenants tab',
      args: [],
    );
  }

  /// `Hors ligne : les loyers tels qu'à ta dernière connexion.`
  String get proRentsOffline {
    return Intl.message(
      'Hors ligne : les loyers tels qu\'à ta dernière connexion.',
      name: 'proRentsOffline',
      desc: 'Pro rents: offline banner',
      args: [],
    );
  }

  /// `{count, plural, =1{1 paiement déclaré attend ta confirmation} other{{count} paiements déclarés attendent ta confirmation}}`
  String proRentsPending(int count) {
    return Intl.plural(
      count,
      one: '1 paiement déclaré attend ta confirmation',
      other: '$count paiements déclarés attendent ta confirmation',
      name: 'proRentsPending',
      desc: 'Pro home: nudge counting declared payments waiting for an answer',
      args: [count],
    );
  }

  /// `Voir`
  String get proRentsPendingAction {
    return Intl.message(
      'Voir',
      name: 'proRentsPendingAction',
      desc: 'Pro home: action on the declared payments nudge',
      args: [],
    );
  }

  /// `Voir les loyers`
  String get proRentsSeeAll {
    return Intl.message(
      'Voir les loyers',
      name: 'proRentsSeeAll',
      desc: 'Pro listing detail: link to the listing\'s rents',
      args: [],
    );
  }

  /// `Loyers`
  String get homeCtaRentsTitle {
    return Intl.message(
      'Loyers',
      name: 'homeCtaRentsTitle',
      desc: 'Pro home CTA card title (M30)',
      args: [],
    );
  }

  /// `Les paiements que tes locataires déclarent, à confirmer depuis l'application`
  String get homeCtaRentsBody {
    return Intl.message(
      'Les paiements que tes locataires déclarent, à confirmer depuis l\'application',
      name: 'homeCtaRentsBody',
      desc: 'Pro home CTA card body (M30)',
      args: [],
    );
  }

  /// `Voir mes loyers`
  String get homeCtaRentsAction {
    return Intl.message(
      'Voir mes loyers',
      name: 'homeCtaRentsAction',
      desc: 'Pro home CTA card action (M30)',
      args: [],
    );
  }

  /// `Facture`
  String get declarationInvoice {
    return Intl.message(
      'Facture',
      name: 'declarationInvoice',
      desc:
          'A declaration\'s title when it declares an invoice paid (M30 slice E)',
      args: [],
    );
  }

  /// `Cette facture est déjà réglée ou annulée.`
  String get declRefusedInvoiceSettled {
    return Intl.message(
      'Cette facture est déjà réglée ou annulée.',
      name: 'declRefusedInvoiceSettled',
      desc: 'Refusal: declaring an invoice that is no longer open',
      args: [],
    );
  }

  /// `Reçu de paiement`
  String get receiptTitle {
    return Intl.message(
      'Reçu de paiement',
      name: 'receiptTitle',
      desc:
          'M30 slice D: the receipt a confirmed payment produces (card title, file name)',
      args: [],
    );
  }

  /// `Établi par Mboa à la confirmation. Il précise que le paiement a été fait hors de Mboa.`
  String get receiptBody {
    return Intl.message(
      'Établi par Mboa à la confirmation. Il précise que le paiement a été fait hors de Mboa.',
      name: 'receiptBody',
      desc: 'M30 slice D: receipt card, ready',
      args: [],
    );
  }

  /// `Quittance en préparation…`
  String get receiptPreparing {
    return Intl.message(
      'Quittance en préparation…',
      name: 'receiptPreparing',
      desc: 'M30 slice D: receipt card while the PDF is made (CA-M30-02)',
      args: [],
    );
  }

  /// `Le reçu tarde à arriver. Réessaie dans un instant.`
  String get receiptLate {
    return Intl.message(
      'Le reçu tarde à arriver. Réessaie dans un instant.',
      name: 'receiptLate',
      desc: 'M30 slice D: receipt still not made after the automatic reads',
      args: [],
    );
  }

  /// `Télécharger le reçu`
  String get receiptDownload {
    return Intl.message(
      'Télécharger le reçu',
      name: 'receiptDownload',
      desc: 'M30 slice D: main action once a payment is confirmed',
      args: [],
    );
  }

  /// `Le reçu n'a pas pu être téléchargé. Réessaie.`
  String get receiptFailed {
    return Intl.message(
      'Le reçu n\'a pas pu être téléchargé. Réessaie.',
      name: 'receiptFailed',
      desc: 'M30 slice D: the receipt PDF could not be fetched',
      args: [],
    );
  }

  /// `Contrat Mboa`
  String get contractPdfFileName {
    return Intl.message(
      'Contrat Mboa',
      name: 'contractPdfFileName',
      desc:
          'File name of a contract\'s PDF on the share sheet (followed by the property)',
      args: [],
    );
  }

  /// `Le propriétaire a confirmé l'avoir reçu.`
  String get declarationConfirmedBody {
    return Intl.message(
      'Le propriétaire a confirmé l\'avoir reçu.',
      name: 'declarationConfirmedBody',
      desc: 'Declaration detail: a confirmed payment, no date known',
      args: [],
    );
  }

  /// `Le propriétaire a confirmé l'avoir reçu le {date}.`
  String declarationConfirmedOn(String date) {
    return Intl.message(
      'Le propriétaire a confirmé l\'avoir reçu le $date.',
      name: 'declarationConfirmedOn',
      desc:
          'Declaration detail: a confirmed payment, with the day of the answer',
      args: [date],
    );
  }

  /// `Le propriétaire conteste ce paiement.`
  String get declarationContestedBody {
    return Intl.message(
      'Le propriétaire conteste ce paiement.',
      name: 'declarationContestedBody',
      desc: 'Declaration detail: a contested payment (its reason follows)',
      args: [],
    );
  }

  /// `Factures`
  String get invoicesTitle {
    return Intl.message(
      'Factures',
      name: 'invoicesTitle',
      desc: 'M30 slice E: the space\'s section of the tenancy\'s invoices',
      args: [],
    );
  }

  /// `Facture`
  String get invoiceTitle {
    return Intl.message(
      'Facture',
      name: 'invoiceTitle',
      desc: 'M30 slice E: one invoice\'s screen title',
      args: [],
    );
  }

  /// `Eau`
  String get invoiceKindWater {
    return Intl.message(
      'Eau',
      name: 'invoiceKindWater',
      desc: 'Invoice kind',
      args: [],
    );
  }

  /// `Électricité`
  String get invoiceKindElectricity {
    return Intl.message(
      'Électricité',
      name: 'invoiceKindElectricity',
      desc: 'Invoice kind',
      args: [],
    );
  }

  /// `Autre`
  String get invoiceKindOther {
    return Intl.message(
      'Autre',
      name: 'invoiceKindOther',
      desc: 'Invoice kind',
      args: [],
    );
  }

  /// `À payer`
  String get invoiceStatusToPay {
    return Intl.message(
      'À payer',
      name: 'invoiceStatusToPay',
      desc: 'Invoice status',
      args: [],
    );
  }

  /// `En retard`
  String get invoiceStatusOverdue {
    return Intl.message(
      'En retard',
      name: 'invoiceStatusOverdue',
      desc: 'Invoice status',
      args: [],
    );
  }

  /// `Payée`
  String get invoiceStatusPaid {
    return Intl.message(
      'Payée',
      name: 'invoiceStatusPaid',
      desc: 'Invoice status',
      args: [],
    );
  }

  /// `Annulée`
  String get invoiceStatusCancelled {
    return Intl.message(
      'Annulée',
      name: 'invoiceStatusCancelled',
      desc: 'Invoice status',
      args: [],
    );
  }

  /// `Échéance : {date}`
  String invoiceDueOn(String date) {
    return Intl.message(
      'Échéance : $date',
      name: 'invoiceDueOn',
      desc: 'An open invoice\'s due date',
      args: [date],
    );
  }

  /// `Payée le {date}`
  String invoicePaidOn(String date) {
    return Intl.message(
      'Payée le $date',
      name: 'invoicePaidOn',
      desc: 'A paid invoice\'s day',
      args: [date],
    );
  }

  /// `Déjà confirmé : {confirmed} · reste {left}`
  String invoiceConfirmedSoFar(String confirmed, String left) {
    return Intl.message(
      'Déjà confirmé : $confirmed · reste $left',
      name: 'invoiceConfirmedSoFar',
      desc: 'An open invoice partly confirmed',
      args: [confirmed, left],
    );
  }

  /// `Déclarer payée`
  String get invoiceDeclare {
    return Intl.message(
      'Déclarer payée',
      name: 'invoiceDeclare',
      desc: 'Main action on an open invoice: declare it paid outside Mboa',
      args: [],
    );
  }

  /// `Déclarations`
  String get invoiceDeclarations {
    return Intl.message(
      'Déclarations',
      name: 'invoiceDeclarations',
      desc: 'The invoice\'s declarations section',
      args: [],
    );
  }

  /// `Déclarer une facture payée`
  String get declareInvoiceTitle {
    return Intl.message(
      'Déclarer une facture payée',
      name: 'declareInvoiceTitle',
      desc: 'Declare form title for an invoice',
      args: [],
    );
  }

  /// `Les factures se paient hors de Mboa : tu les déclares ici, ton propriétaire les confirme.`
  String get invoiceNoMoney {
    return Intl.message(
      'Les factures se paient hors de Mboa : tu les déclares ici, ton propriétaire les confirme.',
      name: 'invoiceNoMoney',
      desc: 'M30 slice E: notice on an open invoice (RM-M30-06)',
      args: [],
    );
  }

  /// `Quittances et reçus`
  String get receiptsTitle {
    return Intl.message(
      'Quittances et reçus',
      name: 'receiptsTitle',
      desc: 'M30 slice D: the space\'s section of receipts',
      args: [],
    );
  }

  /// `Quittance de loyer`
  String get receiptKindRent {
    return Intl.message(
      'Quittance de loyer',
      name: 'receiptKindRent',
      desc: 'Receipt kind: rent fully paid for its period',
      args: [],
    );
  }

  /// `Reçu de paiement partiel`
  String get receiptKindRentPartial {
    return Intl.message(
      'Reçu de paiement partiel',
      name: 'receiptKindRentPartial',
      desc: 'Receipt kind: part of a rent',
      args: [],
    );
  }

  /// `Reçu de dépôt de garantie`
  String get receiptKindDeposit {
    return Intl.message(
      'Reçu de dépôt de garantie',
      name: 'receiptKindDeposit',
      desc: 'Receipt kind: the deposit',
      args: [],
    );
  }

  /// `Reçu de facture`
  String get receiptKindInvoice {
    return Intl.message(
      'Reçu de facture',
      name: 'receiptKindInvoice',
      desc: 'Receipt kind: an invoice declared paid',
      args: [],
    );
  }

  /// `Émis le {date}`
  String receiptIssuedOn(String date) {
    return Intl.message(
      'Émis le $date',
      name: 'receiptIssuedOn',
      desc: 'A receipt without a period: its issue day',
      args: [date],
    );
  }

  /// `En préparation…`
  String get receiptRowPreparing {
    return Intl.message(
      'En préparation…',
      name: 'receiptRowPreparing',
      desc: 'A receipt in the space\'s list whose PDF is still being made',
      args: [],
    );
  }

  /// `Ce bien n'est pas une unité de résidence : il n'y a pas d'autre unité à attribuer.`
  String get proReservationUnitNotApplicable {
    return Intl.message(
      'Ce bien n\'est pas une unité de résidence : il n\'y a pas d\'autre unité à attribuer.',
      name: 'proReservationUnitNotApplicable',
      desc: 'Refusal: assigning a unit on a standalone listing',
      args: [],
    );
  }

  /// `Cette unité n'est pas dans la même résidence.`
  String get proReservationUnitNotInResidence {
    return Intl.message(
      'Cette unité n\'est pas dans la même résidence.',
      name: 'proReservationUnitNotInResidence',
      desc: 'Refusal: unit of another residence',
      args: [],
    );
  }

  /// `Cette unité n'est plus disponible. Choisis-en une autre.`
  String get proReservationUnitNotReservable {
    return Intl.message(
      'Cette unité n\'est plus disponible. Choisis-en une autre.',
      name: 'proReservationUnitNotReservable',
      desc: 'Refusal: unit not published',
      args: [],
    );
  }

  /// `Cette unité ne se loue pas sur la même période (mois, semaine…).`
  String get proReservationUnitPeriodMismatch {
    return Intl.message(
      'Cette unité ne se loue pas sur la même période (mois, semaine…).',
      name: 'proReservationUnitPeriodMismatch',
      desc: 'Refusal: unit on another rental period',
      args: [],
    );
  }

  /// `Ce client a déjà demandé cette unité : accepte plutôt cette demande-là.`
  String get proReservationUnitAlreadyRequested {
    return Intl.message(
      'Ce client a déjà demandé cette unité : accepte plutôt cette demande-là.',
      name: 'proReservationUnitAlreadyRequested',
      desc: 'Refusal: client already has a request on the unit',
      args: [],
    );
  }

  /// `Attribuée à la place de « {title} »`
  String reservationAssignedInsteadOf(String title) {
    return Intl.message(
      'Attribuée à la place de « $title »',
      name: 'reservationAssignedInsteadOf',
      desc:
          'RM-M29-16: the unit reserved is another than the one asked for (both apps)',
      args: [title],
    );
  }

  /// `Quelle unité attribuer ?`
  String get proReservationAssignTitle {
    return Intl.message(
      'Quelle unité attribuer ?',
      name: 'proReservationAssignTitle',
      desc: 'Pro: sheet title when accepting a request on a residence',
      args: [],
    );
  }

  /// `La demande porte sur « {title} ». Tu peux attribuer une autre unité libre de la résidence : le contrat sera rédigé sur celle-ci.`
  String proReservationAssignHint(String title) {
    return Intl.message(
      'La demande porte sur « $title ». Tu peux attribuer une autre unité libre de la résidence : le contrat sera rédigé sur celle-ci.',
      name: 'proReservationAssignHint',
      desc: 'Pro: hint in the unit sheet',
      args: [title],
    );
  }

  /// `Demandée`
  String get proReservationAssignRequested {
    return Intl.message(
      'Demandée',
      name: 'proReservationAssignRequested',
      desc: 'Pro: tag on the unit the client asked for',
      args: [],
    );
  }

  /// `Accepter avec « {title} »`
  String proReservationAcceptWith(String title) {
    return Intl.message(
      'Accepter avec « $title »',
      name: 'proReservationAcceptWith',
      desc: 'Pro: accepting while assigning another unit',
      args: [title],
    );
  }

  /// `Les unités de la résidence n'ont pas pu être lues. Réessaie.`
  String get proReservationAssignFailed {
    return Intl.message(
      'Les unités de la résidence n\'ont pas pu être lues. Réessaie.',
      name: 'proReservationAssignFailed',
      desc: 'Pro: the assignable units could not be read',
      args: [],
    );
  }

  /// `Unité attribuée`
  String get messageSystemUnitAssignedTitle {
    return Intl.message(
      'Unité attribuée',
      name: 'messageSystemUnitAssignedTitle',
      desc:
          'Thread system message: the landlord assigned another unit (RM-M29-16)',
      args: [],
    );
  }

  /// `Demande au propriétaire`
  String get messageSystemHomeRequestTitle {
    return Intl.message(
      'Demande au propriétaire',
      name: 'messageSystemHomeRequestTitle',
      desc: 'Thread system message: a request to the landlord (M30 lot 3)',
      args: [],
    );
  }

  /// `Message de Mboa`
  String get messageSystemTitle {
    return Intl.message(
      'Message de Mboa',
      name: 'messageSystemTitle',
      desc: 'Thread system message of a kind this build does not know',
      args: [],
    );
  }

  /// `{count, plural, =1{1 unité louée} other{{count} unités louées}}`
  String proRentsResidenceUnits(int count) {
    return Intl.plural(
      count,
      one: '1 unité louée',
      other: '$count unités louées',
      name: 'proRentsResidenceUnits',
      desc: 'Pro rents: a residence card, how many units have a tenant space',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 unité en retard} other{{count} unités en retard}}`
  String proRentsResidenceLate(int count) {
    return Intl.plural(
      count,
      one: '1 unité en retard',
      other: '$count unités en retard',
      name: 'proRentsResidenceLate',
      desc: 'Pro rents: a residence card, how many units are late',
      args: [count],
    );
  }

  /// `Quittances`
  String get myHomeTabReceipts {
    return Intl.message(
      'Quittances',
      name: 'myHomeTabReceipts',
      desc: 'Space tab: the receipts',
      args: [],
    );
  }

  /// `Aucune échéance pour l'instant.`
  String get myHomeScheduleEmpty {
    return Intl.message(
      'Aucune échéance pour l\'instant.',
      name: 'myHomeScheduleEmpty',
      desc: 'Space: empty schedule tab',
      args: [],
    );
  }

  /// `Aucune quittance pour l'instant. Elle arrive dès qu'un paiement est confirmé.`
  String get myHomeReceiptsEmpty {
    return Intl.message(
      'Aucune quittance pour l\'instant. Elle arrive dès qu\'un paiement est confirmé.',
      name: 'myHomeReceiptsEmpty',
      desc: 'Space: empty receipts tab',
      args: [],
    );
  }

  /// `Aucun paiement déclaré pour l'instant.`
  String get myHomeDeclarationsEmpty {
    return Intl.message(
      'Aucun paiement déclaré pour l\'instant.',
      name: 'myHomeDeclarationsEmpty',
      desc: 'Space: empty declarations tab',
      args: [],
    );
  }

  /// `Aucune facture pour l'instant.`
  String get invoicesEmpty {
    return Intl.message(
      'Aucune facture pour l\'instant.',
      name: 'invoicesEmpty',
      desc: 'Space: empty invoices tab',
      args: [],
    );
  }

  /// `Bonjour !`
  String get searchHello {
    return Intl.message(
      'Bonjour !',
      name: 'searchHello',
      desc: 'Search home greeting',
      args: [],
    );
  }

  /// `Bienvenue sur Mboa`
  String get searchWelcome {
    return Intl.message(
      'Bienvenue sur Mboa',
      name: 'searchWelcome',
      desc: 'Search home greeting line for a guest',
      args: [],
    );
  }

  /// `Tous`
  String get searchCategoryAll {
    return Intl.message(
      'Tous',
      name: 'searchCategoryAll',
      desc: 'Search category tab: every kind of place',
      args: [],
    );
  }

  /// `Chambres`
  String get searchCategoryRoom {
    return Intl.message(
      'Chambres',
      name: 'searchCategoryRoom',
      desc: 'Search category tab',
      args: [],
    );
  }

  /// `Studios`
  String get searchCategoryStudio {
    return Intl.message(
      'Studios',
      name: 'searchCategoryStudio',
      desc: 'Search category tab',
      args: [],
    );
  }

  /// `Appartements`
  String get searchCategoryApartment {
    return Intl.message(
      'Appartements',
      name: 'searchCategoryApartment',
      desc: 'Search category tab',
      args: [],
    );
  }

  /// `Maisons`
  String get searchCategoryHouse {
    return Intl.message(
      'Maisons',
      name: 'searchCategoryHouse',
      desc: 'Search category tab (villas)',
      args: [],
    );
  }

  /// `Bureaux`
  String get searchCategoryOffice {
    return Intl.message(
      'Bureaux',
      name: 'searchCategoryOffice',
      desc: 'Search category tab',
      args: [],
    );
  }

  /// `Commerces`
  String get searchCategoryCommercial {
    return Intl.message(
      'Commerces',
      name: 'searchCategoryCommercial',
      desc: 'Search category tab (commercial spaces)',
      args: [],
    );
  }

  /// `{count, plural, =1{1 pièce} other{{count} pièces}}`
  String searchRooms(int count) {
    return Intl.plural(
      count,
      one: '1 pièce',
      other: '$count pièces',
      name: 'searchRooms',
      desc: 'Search card facts: room count',
      args: [count],
    );
  }

  /// `Résidence`
  String get searchResidence {
    return Intl.message(
      'Résidence',
      name: 'searchResidence',
      desc: 'Search card kind chip for a residence',
      args: [],
    );
  }

  /// `À la une`
  String get searchFeatured {
    return Intl.message(
      'À la une',
      name: 'searchFeatured',
      desc: 'Search home: the carousel of Pro and Pro+ places',
      args: [],
    );
  }

  /// `À {city}`
  String searchInCity(String city) {
    return Intl.message(
      'À $city',
      name: 'searchInCity',
      desc: 'Search home: the list\'s title',
      args: [city],
    );
  }

  /// `Tous les biens`
  String get searchAllPlaces {
    return Intl.message(
      'Tous les biens',
      name: 'searchAllPlaces',
      desc: 'Search home: the list\'s title without a city',
      args: [],
    );
  }

  /// `Remarque`
  String get requestTypeRemark {
    return Intl.message(
      'Remarque',
      name: 'requestTypeRemark',
      desc: 'Request to the landlord: type',
      args: [],
    );
  }

  /// `Entretien / réparation`
  String get requestTypeMaintenance {
    return Intl.message(
      'Entretien / réparation',
      name: 'requestTypeMaintenance',
      desc: 'Request to the landlord: type',
      args: [],
    );
  }

  /// `Question`
  String get requestTypeQuestion {
    return Intl.message(
      'Question',
      name: 'requestTypeQuestion',
      desc: 'Request to the landlord: type',
      args: [],
    );
  }

  /// `Envoyée`
  String get requestStatusSent {
    return Intl.message(
      'Envoyée',
      name: 'requestStatusSent',
      desc: 'Request status',
      args: [],
    );
  }

  /// `Vue`
  String get requestStatusSeen {
    return Intl.message(
      'Vue',
      name: 'requestStatusSeen',
      desc: 'Request status',
      args: [],
    );
  }

  /// `En cours`
  String get requestStatusInProgress {
    return Intl.message(
      'En cours',
      name: 'requestStatusInProgress',
      desc: 'Request status',
      args: [],
    );
  }

  /// `Résolue`
  String get requestStatusResolved {
    return Intl.message(
      'Résolue',
      name: 'requestStatusResolved',
      desc: 'Request status',
      args: [],
    );
  }

  /// `Clôturée`
  String get requestStatusClosed {
    return Intl.message(
      'Clôturée',
      name: 'requestStatusClosed',
      desc: 'Request status',
      args: [],
    );
  }

  /// `Demandes`
  String get requestsTitle {
    return Intl.message(
      'Demandes',
      name: 'requestsTitle',
      desc: 'Requests to the landlord: list title',
      args: [],
    );
  }

  /// `Aucune demande pour l'instant. Une remarque, une réparation, une question : ton propriétaire la reçoit ici.`
  String get requestsEmptyTenant {
    return Intl.message(
      'Aucune demande pour l\'instant. Une remarque, une réparation, une question : ton propriétaire la reçoit ici.',
      name: 'requestsEmptyTenant',
      desc: 'Requests: empty, tenant side',
      args: [],
    );
  }

  /// `Aucune demande en attente.`
  String get requestsEmptyLandlord {
    return Intl.message(
      'Aucune demande en attente.',
      name: 'requestsEmptyLandlord',
      desc: 'Requests: empty, landlord side',
      args: [],
    );
  }

  /// `Hors ligne : les demandes telles qu'à ta dernière connexion.`
  String get requestsOffline {
    return Intl.message(
      'Hors ligne : les demandes telles qu\'à ta dernière connexion.',
      name: 'requestsOffline',
      desc: 'Requests: offline banner',
      args: [],
    );
  }

  /// `Nouvelle demande`
  String get requestNew {
    return Intl.message(
      'Nouvelle demande',
      name: 'requestNew',
      desc: 'Requests: main action, tenant',
      args: [],
    );
  }

  /// `Demande`
  String get requestDetailTitle {
    return Intl.message(
      'Demande',
      name: 'requestDetailTitle',
      desc: 'One request: title',
      args: [],
    );
  }

  /// `Suivi`
  String get requestHistory {
    return Intl.message(
      'Suivi',
      name: 'requestHistory',
      desc: 'One request: the history section',
      args: [],
    );
  }

  /// `Échanges`
  String get requestExchanges {
    return Intl.message(
      'Échanges',
      name: 'requestExchanges',
      desc: 'One request: its replies',
      args: [],
    );
  }

  /// `Aucun échange pour l'instant.`
  String get requestNoExchange {
    return Intl.message(
      'Aucun échange pour l\'instant.',
      name: 'requestNoExchange',
      desc: 'One request: no replies yet',
      args: [],
    );
  }

  /// `Écrire une réponse…`
  String get requestReplyHint {
    return Intl.message(
      'Écrire une réponse…',
      name: 'requestReplyHint',
      desc: 'One request: reply field',
      args: [],
    );
  }

  /// `Envoyer`
  String get requestSend {
    return Intl.message(
      'Envoyer',
      name: 'requestSend',
      desc: 'One request: send a reply',
      args: [],
    );
  }

  /// `par le propriétaire`
  String get requestByLandlord {
    return Intl.message(
      'par le propriétaire',
      name: 'requestByLandlord',
      desc: 'Request history: who acted',
      args: [],
    );
  }

  /// `par le locataire`
  String get requestByTenant {
    return Intl.message(
      'par le locataire',
      name: 'requestByTenant',
      desc: 'Request history: who acted',
      args: [],
    );
  }

  /// `Prendre en charge`
  String get requestStart {
    return Intl.message(
      'Prendre en charge',
      name: 'requestStart',
      desc: 'Request: landlord\'s step',
      args: [],
    );
  }

  /// `Marquer résolue`
  String get requestResolve {
    return Intl.message(
      'Marquer résolue',
      name: 'requestResolve',
      desc: 'Request: landlord\'s step',
      args: [],
    );
  }

  /// `Le problème persiste`
  String get requestReopen {
    return Intl.message(
      'Le problème persiste',
      name: 'requestReopen',
      desc: 'Request: tenant reopens a resolved request',
      args: [],
    );
  }

  /// `Clore la demande`
  String get requestClose {
    return Intl.message(
      'Clore la demande',
      name: 'requestClose',
      desc: 'Request: tenant closes for good',
      args: [],
    );
  }

  /// `Un mot à ajouter ?`
  String get requestNoteTitle {
    return Intl.message(
      'Un mot à ajouter ?',
      name: 'requestNoteTitle',
      desc: 'Request step: optional note dialog',
      args: [],
    );
  }

  /// `Facultatif — par exemple « Le plombier passe jeudi »`
  String get requestNoteHint {
    return Intl.message(
      'Facultatif — par exemple « Le plombier passe jeudi »',
      name: 'requestNoteHint',
      desc: 'Request step: note hint',
      args: [],
    );
  }

  /// `Valider`
  String get requestNoteSend {
    return Intl.message(
      'Valider',
      name: 'requestNoteSend',
      desc: 'Request step: confirm',
      args: [],
    );
  }

  /// `C'est noté.`
  String get requestMovedToast {
    return Intl.message(
      'C\'est noté.',
      name: 'requestMovedToast',
      desc: 'Request step done',
      args: [],
    );
  }

  /// `Cette demande a déjà avancé : la voici telle qu'elle est.`
  String get requestRefusedTransition {
    return Intl.message(
      'Cette demande a déjà avancé : la voici telle qu\'elle est.',
      name: 'requestRefusedTransition',
      desc: 'Request step refused: out of order',
      args: [],
    );
  }

  /// `Ce logement est en lecture seule : la demande ne peut plus avancer.`
  String get requestRefusedReadOnly {
    return Intl.message(
      'Ce logement est en lecture seule : la demande ne peut plus avancer.',
      name: 'requestRefusedReadOnly',
      desc: 'Request step refused: read only',
      args: [],
    );
  }

  /// `La réponse n'est pas partie. Réessaie.`
  String get requestReplyFailed {
    return Intl.message(
      'La réponse n\'est pas partie. Réessaie.',
      name: 'requestReplyFailed',
      desc: 'Request reply failed',
      args: [],
    );
  }

  /// `État des lieux`
  String get evidenceTitle {
    return Intl.message(
      'État des lieux',
      name: 'evidenceTitle',
      desc: 'M30 lot 3: photo proofs (tile, screen title)',
      args: [],
    );
  }

  /// `Contacts`
  String get contactsTitle {
    return Intl.message(
      'Contacts',
      name: 'contactsTitle',
      desc: 'M30 lot 3: useful contacts (tile)',
      args: [],
    );
  }

  /// `C'est à propos de…`
  String get requestFormType {
    return Intl.message(
      'C\'est à propos de…',
      name: 'requestFormType',
      desc: 'New request: the type',
      args: [],
    );
  }

  /// `En quelques mots`
  String get requestFormTitle {
    return Intl.message(
      'En quelques mots',
      name: 'requestFormTitle',
      desc: 'New request: the title label',
      args: [],
    );
  }

  /// `Par exemple « Fuite sous l'évier »`
  String get requestFormTitleHint {
    return Intl.message(
      'Par exemple « Fuite sous l\'évier »',
      name: 'requestFormTitleHint',
      desc: 'New request: title hint',
      args: [],
    );
  }

  /// `Ce qui se passe`
  String get requestFormDescription {
    return Intl.message(
      'Ce qui se passe',
      name: 'requestFormDescription',
      desc: 'New request: description label',
      args: [],
    );
  }

  /// `Depuis quand, où, ce que tu as déjà essayé…`
  String get requestFormDescriptionHint {
    return Intl.message(
      'Depuis quand, où, ce que tu as déjà essayé…',
      name: 'requestFormDescriptionHint',
      desc: 'New request: description hint',
      args: [],
    );
  }

  /// `Photos (facultatif, 5 au plus)`
  String get requestFormPhotos {
    return Intl.message(
      'Photos (facultatif, 5 au plus)',
      name: 'requestFormPhotos',
      desc: 'New request: photos label',
      args: [],
    );
  }

  /// `Photo {n}`
  String requestFormPhotoN(String n) {
    return Intl.message(
      'Photo $n',
      name: 'requestFormPhotoN',
      desc: 'New request: one photo\'s chip',
      args: [n],
    );
  }

  /// `Envoyer la demande`
  String get requestFormSend {
    return Intl.message(
      'Envoyer la demande',
      name: 'requestFormSend',
      desc: 'New request: main action',
      args: [],
    );
  }

  /// `Demande envoyée`
  String get requestSentTitle {
    return Intl.message(
      'Demande envoyée',
      name: 'requestSentTitle',
      desc: 'New request sent: toast',
      args: [],
    );
  }

  /// `Ton propriétaire la reçoit, et tu suis ses réponses ici.`
  String get requestSentBody {
    return Intl.message(
      'Ton propriétaire la reçoit, et tu suis ses réponses ici.',
      name: 'requestSentBody',
      desc: 'New request sent: toast body',
      args: [],
    );
  }

  /// `La demande n'est pas partie. Réessaie.`
  String get requestFailed {
    return Intl.message(
      'La demande n\'est pas partie. Réessaie.',
      name: 'requestFailed',
      desc: 'New request failed',
      args: [],
    );
  }

  /// `Demandes des locataires`
  String get proRequestsTitle {
    return Intl.message(
      'Demandes des locataires',
      name: 'proRequestsTitle',
      desc: 'Pro: menu entry for the tenants\' requests inbox',
      args: [],
    );
  }

  /// `{count, plural, =1{1 demande de locataire attend ta réponse} other{{count} demandes de locataires attendent ta réponse}}`
  String proRequestsPending(int count) {
    return Intl.plural(
      count,
      one: '1 demande de locataire attend ta réponse',
      other: '$count demandes de locataires attendent ta réponse',
      name: 'proRequestsPending',
      desc: 'Pro home: nudge counting tenants\' requests waiting',
      args: [count],
    );
  }

  /// `Salon`
  String get evidenceRoomLivingRoom {
    return Intl.message(
      'Salon',
      name: 'evidenceRoomLivingRoom',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `Chambre`
  String get evidenceRoomBedroom {
    return Intl.message(
      'Chambre',
      name: 'evidenceRoomBedroom',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `Cuisine`
  String get evidenceRoomKitchen {
    return Intl.message(
      'Cuisine',
      name: 'evidenceRoomKitchen',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `Salle de bain`
  String get evidenceRoomBathroom {
    return Intl.message(
      'Salle de bain',
      name: 'evidenceRoomBathroom',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `WC`
  String get evidenceRoomToilet {
    return Intl.message(
      'WC',
      name: 'evidenceRoomToilet',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `Extérieur`
  String get evidenceRoomOutdoor {
    return Intl.message(
      'Extérieur',
      name: 'evidenceRoomOutdoor',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `Autre`
  String get evidenceRoomOther {
    return Intl.message(
      'Autre',
      name: 'evidenceRoomOther',
      desc: 'Evidence room',
      args: [],
    );
  }

  /// `Entrée`
  String get evidencePhaseEntry {
    return Intl.message(
      'Entrée',
      name: 'evidencePhaseEntry',
      desc: 'Evidence phase',
      args: [],
    );
  }

  /// `Pendant le bail`
  String get evidencePhaseStay {
    return Intl.message(
      'Pendant le bail',
      name: 'evidencePhaseStay',
      desc: 'Evidence phase',
      args: [],
    );
  }

  /// `Sortie`
  String get evidencePhaseExit {
    return Intl.message(
      'Sortie',
      name: 'evidencePhaseExit',
      desc: 'Evidence phase',
      args: [],
    );
  }

  /// `Envoyer des photos`
  String get evidenceAdd {
    return Intl.message(
      'Envoyer des photos',
      name: 'evidenceAdd',
      desc: 'Evidence: the tenant\'s main action',
      args: [],
    );
  }

  /// `Aucune photo pour l'instant. À l'entrée, pendant le bail ou à la sortie : chaque envoi est horodaté par Mboa.`
  String get evidenceEmptyTenant {
    return Intl.message(
      'Aucune photo pour l\'instant. À l\'entrée, pendant le bail ou à la sortie : chaque envoi est horodaté par Mboa.',
      name: 'evidenceEmptyTenant',
      desc: 'Evidence: empty, tenant',
      args: [],
    );
  }

  /// `Aucune photo pour l'instant. Un locataire qui quitte Mboa emporte ses photos.`
  String get evidenceEmptyLandlord {
    return Intl.message(
      'Aucune photo pour l\'instant. Un locataire qui quitte Mboa emporte ses photos.',
      name: 'evidenceEmptyLandlord',
      desc: 'Evidence: empty, landlord',
      args: [],
    );
  }

  /// `Horodatées par Mboa à la réception, non modifiables et jamais publiques.`
  String get evidenceNotice {
    return Intl.message(
      'Horodatées par Mboa à la réception, non modifiables et jamais publiques.',
      name: 'evidenceNotice',
      desc: 'Evidence: what Mboa guarantees (RM-M30-12)',
      args: [],
    );
  }

  /// `{count, plural, =1{1 photo} other{{count} photos}}`
  String evidencePhotoCount(int count) {
    return Intl.plural(
      count,
      one: '1 photo',
      other: '$count photos',
      name: 'evidencePhotoCount',
      desc: 'Evidence: photos in a sending',
      args: [count],
    );
  }

  /// `Reçu par Mboa le {date}`
  String evidenceRecordedOn(String date) {
    return Intl.message(
      'Reçu par Mboa le $date',
      name: 'evidenceRecordedOn',
      desc: 'Evidence: the server\'s time',
      args: [date],
    );
  }

  /// `Vu par le propriétaire`
  String get evidenceSeen {
    return Intl.message(
      'Vu par le propriétaire',
      name: 'evidenceSeen',
      desc: 'Evidence: acknowledged',
      args: [],
    );
  }

  /// `Vu par le propriétaire le {date}`
  String evidenceSeenOn(String date) {
    return Intl.message(
      'Vu par le propriétaire le $date',
      name: 'evidenceSeenOn',
      desc: 'Evidence: acknowledged, with the day',
      args: [date],
    );
  }

  /// `Pas encore vu par le propriétaire`
  String get evidenceNotSeen {
    return Intl.message(
      'Pas encore vu par le propriétaire',
      name: 'evidenceNotSeen',
      desc: 'Evidence: not acknowledged',
      args: [],
    );
  }

  /// `Accuser réception`
  String get evidenceAcknowledge {
    return Intl.message(
      'Accuser réception',
      name: 'evidenceAcknowledge',
      desc: 'Evidence: the landlord\'s main action',
      args: [],
    );
  }

  /// `Accuser réception ?`
  String get evidenceAckTitle {
    return Intl.message(
      'Accuser réception ?',
      name: 'evidenceAckTitle',
      desc: 'Evidence: acknowledge dialog',
      args: [],
    );
  }

  /// `Un mot pour ton locataire (facultatif)`
  String get evidenceAckHint {
    return Intl.message(
      'Un mot pour ton locataire (facultatif)',
      name: 'evidenceAckHint',
      desc: 'Evidence: acknowledge note hint',
      args: [],
    );
  }

  /// `Réception confirmée`
  String get evidenceAckToast {
    return Intl.message(
      'Réception confirmée',
      name: 'evidenceAckToast',
      desc: 'Evidence: acknowledged toast',
      args: [],
    );
  }

  /// `Fermer`
  String get commonClose {
    return Intl.message(
      'Fermer',
      name: 'commonClose',
      desc: 'Close (a full-screen photo, a sheet)',
      args: [],
    );
  }

  /// `Une pièce par photo, et un mot si besoin. Mboa les horodate à la réception : elles ne pourront plus être modifiées.`
  String get evidenceSendHint {
    return Intl.message(
      'Une pièce par photo, et un mot si besoin. Mboa les horodate à la réception : elles ne pourront plus être modifiées.',
      name: 'evidenceSendHint',
      desc: 'Evidence send: hint',
      args: [],
    );
  }

  /// `Appareil photo`
  String get evidenceCamera {
    return Intl.message(
      'Appareil photo',
      name: 'evidenceCamera',
      desc: 'Evidence send: camera',
      args: [],
    );
  }

  /// `Galerie`
  String get evidenceGallery {
    return Intl.message(
      'Galerie',
      name: 'evidenceGallery',
      desc: 'Evidence send: gallery',
      args: [],
    );
  }

  /// `Ex. « Chambre 2 »`
  String get evidenceRoomLabelHint {
    return Intl.message(
      'Ex. « Chambre 2 »',
      name: 'evidenceRoomLabelHint',
      desc: 'Evidence send: room label',
      args: [],
    );
  }

  /// `Un mot (facultatif)`
  String get evidenceCommentHint {
    return Intl.message(
      'Un mot (facultatif)',
      name: 'evidenceCommentHint',
      desc: 'Evidence send: comment',
      args: [],
    );
  }

  /// `Retirer`
  String get evidenceRemove {
    return Intl.message(
      'Retirer',
      name: 'evidenceRemove',
      desc: 'Evidence send: remove a photo',
      args: [],
    );
  }

  /// `{count, plural, =1{Envoyer 1 photo} other{Envoyer {count} photos}}`
  String evidenceSend(int count) {
    return Intl.plural(
      count,
      one: 'Envoyer 1 photo',
      other: 'Envoyer $count photos',
      name: 'evidenceSend',
      desc: 'Evidence send: main action',
      args: [count],
    );
  }

  /// `Envoi… {done}/{total}`
  String evidenceSending(int done, int total) {
    return Intl.message(
      'Envoi… $done/$total',
      name: 'evidenceSending',
      desc: 'Evidence send: progress',
      args: [done, total],
    );
  }

  /// `Photos envoyées`
  String get evidenceSentTitle {
    return Intl.message(
      'Photos envoyées',
      name: 'evidenceSentTitle',
      desc: 'Evidence sent: toast',
      args: [],
    );
  }

  /// `Mboa les a horodatées, et ton propriétaire est prévenu.`
  String get evidenceSentBody {
    return Intl.message(
      'Mboa les a horodatées, et ton propriétaire est prévenu.',
      name: 'evidenceSentBody',
      desc: 'Evidence sent: toast body',
      args: [],
    );
  }

  /// `Fichier non envoyé, réessaie.`
  String get evidenceUploadFailed {
    return Intl.message(
      'Fichier non envoyé, réessaie.',
      name: 'evidenceUploadFailed',
      desc:
          'Evidence: a photo did not reach storage after three tries (CE-M30-01)',
      args: [],
    );
  }

  /// `20 photos au plus par envoi.`
  String get evidenceRefusedTooLarge {
    return Intl.message(
      '20 photos au plus par envoi.',
      name: 'evidenceRefusedTooLarge',
      desc: 'Evidence refused',
      args: [],
    );
  }

  /// `Ce logement a atteint ses 200 photos.`
  String get evidenceRefusedLimit {
    return Intl.message(
      'Ce logement a atteint ses 200 photos.',
      name: 'evidenceRefusedLimit',
      desc: 'Evidence refused',
      args: [],
    );
  }

  /// `Le bail est terminé : seules les photos de sortie sont encore possibles, 7 jours.`
  String get evidenceRefusedPhaseClosed {
    return Intl.message(
      'Le bail est terminé : seules les photos de sortie sont encore possibles, 7 jours.',
      name: 'evidenceRefusedPhaseClosed',
      desc: 'Evidence refused',
      args: [],
    );
  }

  /// `Ce logement est en lecture seule : plus d'envoi possible.`
  String get evidenceRefusedReadOnly {
    return Intl.message(
      'Ce logement est en lecture seule : plus d\'envoi possible.',
      name: 'evidenceRefusedReadOnly',
      desc: 'Evidence refused',
      args: [],
    );
  }

  /// `Une photo n'est pas arrivée entière : rien n'a été enregistré. Réessaie.`
  String get evidenceRefusedNotStored {
    return Intl.message(
      'Une photo n\'est pas arrivée entière : rien n\'a été enregistré. Réessaie.',
      name: 'evidenceRefusedNotStored',
      desc: 'Evidence refused',
      args: [],
    );
  }

  /// `Une de ces photos est déjà enregistrée.`
  String get evidenceRefusedAlready {
    return Intl.message(
      'Une de ces photos est déjà enregistrée.',
      name: 'evidenceRefusedAlready',
      desc: 'Evidence refused',
      args: [],
    );
  }

  /// `Contacts utiles`
  String get contactsUsefulTitle {
    return Intl.message(
      'Contacts utiles',
      name: 'contactsUsefulTitle',
      desc: 'M30 lot 3: useful contacts screen title',
      args: [],
    );
  }

  /// `Ton propriétaire n'a encore partagé aucun contact pour ce logement.`
  String get contactsEmptyTenant {
    return Intl.message(
      'Ton propriétaire n\'a encore partagé aucun contact pour ce logement.',
      name: 'contactsEmptyTenant',
      desc: 'Contacts: empty, tenant',
      args: [],
    );
  }

  /// `Aucun contact pour l'instant. Gardien, ménagère, plombier : note ici qui appeler, et partage-les avec tes locataires si tu veux.`
  String get contactsEmptyLandlord {
    return Intl.message(
      'Aucun contact pour l\'instant. Gardien, ménagère, plombier : note ici qui appeler, et partage-les avec tes locataires si tu veux.',
      name: 'contactsEmptyLandlord',
      desc: 'Contacts: empty, landlord',
      args: [],
    );
  }

  /// `Tes locataires ne voient que le nom, le rôle et le numéro des contacts que tu partages.`
  String get contactsLandlordHint {
    return Intl.message(
      'Tes locataires ne voient que le nom, le rôle et le numéro des contacts que tu partages.',
      name: 'contactsLandlordHint',
      desc: 'Contacts: what the tenant sees',
      args: [],
    );
  }

  /// `Hors ligne : tes contacts tels qu'à ta dernière connexion.`
  String get contactsOffline {
    return Intl.message(
      'Hors ligne : tes contacts tels qu\'à ta dernière connexion.',
      name: 'contactsOffline',
      desc: 'Contacts: offline',
      args: [],
    );
  }

  /// `Appeler`
  String get contactsCall {
    return Intl.message(
      'Appeler',
      name: 'contactsCall',
      desc: 'Contacts: call',
      args: [],
    );
  }

  /// `Ajouter un contact`
  String get contactsAdd {
    return Intl.message(
      'Ajouter un contact',
      name: 'contactsAdd',
      desc: 'Contacts: main action',
      args: [],
    );
  }

  /// `Modifier le contact`
  String get contactsEdit {
    return Intl.message(
      'Modifier le contact',
      name: 'contactsEdit',
      desc: 'Contacts: edit title',
      args: [],
    );
  }

  /// `15 contacts au plus.`
  String get contactsFull {
    return Intl.message(
      '15 contacts au plus.',
      name: 'contactsFull',
      desc: 'Contacts: the cap',
      args: [],
    );
  }

  /// `Vérifie le numéro : 9 chiffres après +237.`
  String get contactsInvalid {
    return Intl.message(
      'Vérifie le numéro : 9 chiffres après +237.',
      name: 'contactsInvalid',
      desc: 'Contacts refused: invalid',
      args: [],
    );
  }

  /// `Privé`
  String get contactsPrivate {
    return Intl.message(
      'Privé',
      name: 'contactsPrivate',
      desc: 'Contacts: not shared',
      args: [],
    );
  }

  /// `Tous mes biens`
  String get contactsSharedAll {
    return Intl.message(
      'Tous mes biens',
      name: 'contactsSharedAll',
      desc: 'Contacts: shared everywhere',
      args: [],
    );
  }

  /// `{count, plural, =1{Partagé sur 1 bien} other{Partagé sur {count} biens}}`
  String contactsSharedSome(int count) {
    return Intl.plural(
      count,
      one: 'Partagé sur 1 bien',
      other: 'Partagé sur $count biens',
      name: 'contactsSharedSome',
      desc: 'Contacts: shared on some',
      args: [count],
    );
  }

  /// `Nom`
  String get contactsName {
    return Intl.message(
      'Nom',
      name: 'contactsName',
      desc: 'Contact form',
      args: [],
    );
  }

  /// `Rôle`
  String get contactsRole {
    return Intl.message(
      'Rôle',
      name: 'contactsRole',
      desc: 'Contact form',
      args: [],
    );
  }

  /// `Téléphone`
  String get contactsPhone {
    return Intl.message(
      'Téléphone',
      name: 'contactsPhone',
      desc: 'Contact form',
      args: [],
    );
  }

  /// `Partager avec mes locataires`
  String get contactsShare {
    return Intl.message(
      'Partager avec mes locataires',
      name: 'contactsShare',
      desc: 'Contact form: share switch',
      args: [],
    );
  }

  /// `Sur tous tes biens, ou seulement ceux que tu choisis.`
  String get contactsShareHint {
    return Intl.message(
      'Sur tous tes biens, ou seulement ceux que tu choisis.',
      name: 'contactsShareHint',
      desc: 'Contact form: share hint',
      args: [],
    );
  }

  /// `Enregistrer`
  String get contactsSave {
    return Intl.message(
      'Enregistrer',
      name: 'contactsSave',
      desc: 'Contact form: main action',
      args: [],
    );
  }

  /// `Supprimer le contact`
  String get contactsDelete {
    return Intl.message(
      'Supprimer le contact',
      name: 'contactsDelete',
      desc: 'Contact form: delete (behind ⋯)',
      args: [],
    );
  }

  /// `Gardien`
  String get contactsRoleCaretaker {
    return Intl.message(
      'Gardien',
      name: 'contactsRoleCaretaker',
      desc: 'Contact role suggestion',
      args: [],
    );
  }

  /// `Ménagère`
  String get contactsRoleCleaner {
    return Intl.message(
      'Ménagère',
      name: 'contactsRoleCleaner',
      desc: 'Contact role suggestion',
      args: [],
    );
  }

  /// `Plombier`
  String get contactsRolePlumber {
    return Intl.message(
      'Plombier',
      name: 'contactsRolePlumber',
      desc: 'Contact role suggestion',
      args: [],
    );
  }

  /// `Électricien`
  String get contactsRoleElectrician {
    return Intl.message(
      'Électricien',
      name: 'contactsRoleElectrician',
      desc: 'Contact role suggestion',
      args: [],
    );
  }

  /// `Agent de sécurité`
  String get contactsRoleSecurity {
    return Intl.message(
      'Agent de sécurité',
      name: 'contactsRoleSecurity',
      desc: 'Contact role suggestion',
      args: [],
    );
  }

  /// `En cours`
  String get myHomesTabCurrent {
    return Intl.message(
      'En cours',
      name: 'myHomesTabCurrent',
      desc: 'M31 — Mes logements tab: tenancies running or to come',
      args: [],
    );
  }

  /// `Anciens`
  String get myHomesTabPast {
    return Intl.message(
      'Anciens',
      name: 'myHomesTabPast',
      desc: 'M31 — Mes logements tab: tenancies that are over',
      args: [],
    );
  }

  /// `Aucun ancien logement`
  String get pastHomesEmptyTitle {
    return Intl.message(
      'Aucun ancien logement',
      name: 'pastHomesEmptyTitle',
      desc: 'M31 — empty past list, title',
      args: [],
    );
  }

  /// `Quand une location se termine, tu la retrouves ici : ton contrat, tes dépenses et tes reçus.`
  String get pastHomesEmptyBody {
    return Intl.message(
      'Quand une location se termine, tu la retrouves ici : ton contrat, tes dépenses et tes reçus.',
      name: 'pastHomesEmptyBody',
      desc: 'M31 — empty past list, body',
      args: [],
    );
  }

  /// `Hors ligne : tes anciens logements tels qu'à ta dernière connexion.`
  String get pastHomesOffline {
    return Intl.message(
      'Hors ligne : tes anciens logements tels qu\'à ta dernière connexion.',
      name: 'pastHomesOffline',
      desc: 'M31 — past list offline',
      args: [],
    );
  }

  /// `Ancien logement`
  String get pastHomeTitle {
    return Intl.message(
      'Ancien logement',
      name: 'pastHomeTitle',
      desc: 'M31 — the sheet\'s title',
      args: [],
    );
  }

  /// `Du {from} au {to}`
  String pastHomeDates(String from, String to) {
    return Intl.message(
      'Du $from au $to',
      name: 'pastHomeDates',
      desc: 'M31 — the lease\'s dates as signed',
      args: [from, to],
    );
  }

  /// `Loyer`
  String get pastHomeRent {
    return Intl.message(
      'Loyer',
      name: 'pastHomeRent',
      desc: 'M31 — header: the rent as signed',
      args: [],
    );
  }

  /// `Voir l'annonce`
  String get pastHomeSeeListing {
    return Intl.message(
      'Voir l\'annonce',
      name: 'pastHomeSeeListing',
      desc: 'M31 — the listing is still online',
      args: [],
    );
  }

  /// `Payé pendant ce séjour`
  String get pastHomePaidTotal {
    return Intl.message(
      'Payé pendant ce séjour',
      name: 'pastHomePaidTotal',
      desc: 'M31 — the big figure: confirmed total',
      args: [],
    );
  }

  /// `Seuls les paiements confirmés par ton propriétaire comptent. La caution n'est pas une dépense.`
  String get pastHomeTotalNote {
    return Intl.message(
      'Seuls les paiements confirmés par ton propriétaire comptent. La caution n\'est pas une dépense.',
      name: 'pastHomeTotalNote',
      desc: 'M31 — under the total (RM-M31-03)',
      args: [],
    );
  }

  /// `Mes dépenses`
  String get pastHomeExpensesTitle {
    return Intl.message(
      'Mes dépenses',
      name: 'pastHomeExpensesTitle',
      desc: 'M31 — section title',
      args: [],
    );
  }

  /// `Aucun paiement confirmé.`
  String get pastHomeNoExpense {
    return Intl.message(
      'Aucun paiement confirmé.',
      name: 'pastHomeNoExpense',
      desc: 'M31 — no confirmed payment',
      args: [],
    );
  }

  /// `Non confirmés · hors total`
  String get pastHomeNotConfirmedTitle {
    return Intl.message(
      'Non confirmés · hors total',
      name: 'pastHomeNotConfirmedTitle',
      desc: 'M31 — declared, unanswered or contested payments',
      args: [],
    );
  }

  /// `Mon contrat`
  String get pastHomeContractTitle {
    return Intl.message(
      'Mon contrat',
      name: 'pastHomeContractTitle',
      desc: 'M31 — section title',
      args: [],
    );
  }

  /// `Voir le contrat signé`
  String get pastHomeContractOpen {
    return Intl.message(
      'Voir le contrat signé',
      name: 'pastHomeContractOpen',
      desc: 'M31 — opens the contract and its PDF',
      args: [],
    );
  }

  /// `Code de vérification : {code}`
  String pastHomeVerificationCode(String code) {
    return Intl.message(
      'Code de vérification : $code',
      name: 'pastHomeVerificationCode',
      desc: 'M31 — the contract\'s code',
      args: [code],
    );
  }

  /// `Note du bien aujourd'hui`
  String get pastHomeRatingTitle {
    return Intl.message(
      'Note du bien aujourd\'hui',
      name: 'pastHomeRatingTitle',
      desc: 'M31 — live rating (RM-M31-04)',
      args: [],
    );
  }

  /// `Mon avis`
  String get pastHomeReviewTitle {
    return Intl.message(
      'Mon avis',
      name: 'pastHomeReviewTitle',
      desc: 'M31 — section title',
      args: [],
    );
  }

  /// `Donner mon avis`
  String get pastHomeReviewWrite {
    return Intl.message(
      'Donner mon avis',
      name: 'pastHomeReviewWrite',
      desc: 'M31 — no review yet',
      args: [],
    );
  }

  /// `Ton expérience aide les prochains locataires.`
  String get pastHomeReviewWriteHint {
    return Intl.message(
      'Ton expérience aide les prochains locataires.',
      name: 'pastHomeReviewWriteHint',
      desc: 'M31 — under « Donner mon avis »',
      args: [],
    );
  }

  /// `Modifier mon avis`
  String get pastHomeReviewEdit {
    return Intl.message(
      'Modifier mon avis',
      name: 'pastHomeReviewEdit',
      desc: 'M31 — the review can still change',
      args: [],
    );
  }

  /// `Modifiable jusqu'au {date}`
  String pastHomeReviewEditUntil(String date) {
    return Intl.message(
      'Modifiable jusqu\'au $date',
      name: 'pastHomeReviewEditUntil',
      desc: 'M31 — editableUntil',
      args: [date],
    );
  }

  /// `Mon avis · {rating}/5`
  String pastHomeReviewMine(int rating) {
    return Intl.message(
      'Mon avis · $rating/5',
      name: 'pastHomeReviewMine',
      desc: 'M31 — a review that can no longer change',
      args: [rating],
    );
  }

  /// `Il n'est plus modifiable.`
  String get pastHomeReviewLocked {
    return Intl.message(
      'Il n\'est plus modifiable.',
      name: 'pastHomeReviewLocked',
      desc: 'M31 — locked review',
      args: [],
    );
  }

  /// `La vie du logement`
  String get pastHomeLifeTitle {
    return Intl.message(
      'La vie du logement',
      name: 'pastHomeLifeTitle',
      desc: 'M31 — section: requests, photos, schedule',
      args: [],
    );
  }

  /// `{count, plural, =0{Aucune demande} =1{1 demande} other{{count} demandes}}`
  String pastHomeRequests(int count) {
    return Intl.plural(
      count,
      zero: 'Aucune demande',
      one: '1 demande',
      other: '$count demandes',
      name: 'pastHomeRequests',
      desc: 'M31 — requests to the landlord',
      args: [count],
    );
  }

  /// `{count, plural, =1{dont 1 ouverte} other{dont {count} ouvertes}}`
  String pastHomeRequestsOpen(int count) {
    return Intl.plural(
      count,
      one: 'dont 1 ouverte',
      other: 'dont $count ouvertes',
      name: 'pastHomeRequestsOpen',
      desc: 'M31 — open requests',
      args: [count],
    );
  }

  /// `Photos de sortie possibles jusqu'au {date}`
  String pastHomeEvidenceOpen(String date) {
    return Intl.message(
      'Photos de sortie possibles jusqu\'au $date',
      name: 'pastHomeEvidenceOpen',
      desc: 'M31 — RM-M31-08, 7 days after the end',
      args: [date],
    );
  }

  /// `Tes photos d'entrée et de sortie`
  String get pastHomeEvidenceClosed {
    return Intl.message(
      'Tes photos d\'entrée et de sortie',
      name: 'pastHomeEvidenceClosed',
      desc: 'M31 — evidence, read only',
      args: [],
    );
  }

  /// `Échéancier et déclarations`
  String get pastHomeSpace {
    return Intl.message(
      'Échéancier et déclarations',
      name: 'pastHomeSpace',
      desc: 'M31 — opens the space, read only',
      args: [],
    );
  }

  /// `Télécharger le relevé des dépenses`
  String get pastHomeStatement {
    return Intl.message(
      'Télécharger le relevé des dépenses',
      name: 'pastHomeStatement',
      desc: 'M31 — the main action: the PDF',
      args: [],
    );
  }

  /// `Relevé des dépenses`
  String get pastHomeStatementName {
    return Intl.message(
      'Relevé des dépenses',
      name: 'pastHomeStatementName',
      desc: 'M31 — the PDF\'s file name',
      args: [],
    );
  }

  /// `Le relevé n'a pas pu être préparé. Vérifie ta connexion et réessaie.`
  String get pastHomeStatementFailed {
    return Intl.message(
      'Le relevé n\'a pas pu être préparé. Vérifie ta connexion et réessaie.',
      name: 'pastHomeStatementFailed',
      desc: 'M31 — the PDF failed',
      args: [],
    );
  }

  /// `Hors ligne : ce logement tel qu'à ta dernière connexion. Le relevé et les photos demandent une connexion.`
  String get pastHomeOffline {
    return Intl.message(
      'Hors ligne : ce logement tel qu\'à ta dernière connexion. Le relevé et les photos demandent une connexion.',
      name: 'pastHomeOffline',
      desc: 'M31 — the sheet offline',
      args: [],
    );
  }

  /// `Terminée le {date}`
  String myHomeEndedOn(String date) {
    return Intl.message(
      'Terminée le $date',
      name: 'myHomeEndedOn',
      desc: 'M31 — an ended tenancy in a list, with its end date',
      args: [date],
    );
  }

  /// `Avant / après`
  String get evidenceCompareTitle {
    return Intl.message(
      'Avant / après',
      name: 'evidenceCompareTitle',
      desc: 'M31 — CA-M31-04: entry and exit photos side by side',
      args: [],
    );
  }

  /// `L'entrée et la sortie, pièce par pièce`
  String get evidenceCompareHint {
    return Intl.message(
      'L\'entrée et la sortie, pièce par pièce',
      name: 'evidenceCompareHint',
      desc: 'M31 — under « Avant / après »',
      args: [],
    );
  }

  /// `La comparaison demande une connexion : les photos sont chargées à chaque fois.`
  String get evidenceCompareOffline {
    return Intl.message(
      'La comparaison demande une connexion : les photos sont chargées à chaque fois.',
      name: 'evidenceCompareOffline',
      desc: 'M31 — compare failed or offline',
      args: [],
    );
  }

  /// `Aucune photo à comparer pour l'instant.`
  String get evidenceCompareEmpty {
    return Intl.message(
      'Aucune photo à comparer pour l\'instant.',
      name: 'evidenceCompareEmpty',
      desc: 'M31 — compare, no room',
      args: [],
    );
  }

  /// `Pas de photo`
  String get evidenceCompareNone {
    return Intl.message(
      'Pas de photo',
      name: 'evidenceCompareNone',
      desc: 'M31 — a side with no photo',
      args: [],
    );
  }

  /// `Ce code ne marche plus : trop d’essais, ou il a expiré. Demande un nouveau code.`
  String get otpCodeBurnt {
    return Intl.message(
      'Ce code ne marche plus : trop d’essais, ou il a expiré. Demande un nouveau code.',
      name: 'otpCodeBurnt',
      desc:
          'OTP_MAX_ATTEMPTS / OTP_INVALID_OR_EXPIRED — the code is dead, a new one is needed',
      args: [],
    );
  }

  /// `Signaler un litige`
  String get disputeTitle {
    return Intl.message(
      'Signaler un litige',
      name: 'disputeTitle',
      desc: 'RM-M30-07 — the sheet\'s title and the ⋯ entry',
      args: [],
    );
  }

  /// `L'équipe Mboa examine les pièces gardées dans l'app (déclarations, justificatifs, photos), puis informe les deux parties de sa décision. Un litige ne vise personne : il ne retire aucun point de Mboa Score.`
  String get disputeBody {
    return Intl.message(
      'L\'équipe Mboa examine les pièces gardées dans l\'app (déclarations, justificatifs, photos), puis informe les deux parties de sa décision. Un litige ne vise personne : il ne retire aucun point de Mboa Score.',
      name: 'disputeBody',
      desc:
          'RM-M30-07 — what a dispute does (N-40: both parties hear the ruling)',
      args: [],
    );
  }

  /// `Ce qui s'est passé (facultatif)`
  String get disputeCommentLabel {
    return Intl.message(
      'Ce qui s\'est passé (facultatif)',
      name: 'disputeCommentLabel',
      desc: 'Dispute comment label',
      args: [],
    );
  }

  /// `Ex. : j'ai payé en espèces le 3, il dit n'avoir rien reçu.`
  String get disputeCommentHint {
    return Intl.message(
      'Ex. : j\'ai payé en espèces le 3, il dit n\'avoir rien reçu.',
      name: 'disputeCommentHint',
      desc: 'Dispute comment hint',
      args: [],
    );
  }

  /// `Envoyer le litige`
  String get disputeSend {
    return Intl.message(
      'Envoyer le litige',
      name: 'disputeSend',
      desc: 'Dispute sheet button',
      args: [],
    );
  }

  /// `Litige transmis à l'équipe Mboa`
  String get disputeSent {
    return Intl.message(
      'Litige transmis à l\'équipe Mboa',
      name: 'disputeSent',
      desc: 'Dispute sent toast',
      args: [],
    );
  }

  /// `Tu as déjà signalé ce litige : l'équipe Mboa s'en occupe.`
  String get disputeAlready {
    return Intl.message(
      'Tu as déjà signalé ce litige : l\'équipe Mboa s\'en occupe.',
      name: 'disputeAlready',
      desc: 'ALREADY_REPORTED on a dispute',
      args: [],
    );
  }

  /// `Tu l'as déjà signalé : l'équipe Mboa s'en occupe.`
  String get reportAlready {
    return Intl.message(
      'Tu l\'as déjà signalé : l\'équipe Mboa s\'en occupe.',
      name: 'reportAlready',
      desc: 'ALREADY_REPORTED on a report',
      args: [],
    );
  }

  /// `Un désaccord sur ce paiement ? Signale un litige : l'équipe Mboa examinera les pièces.`
  String get disputePrompt {
    return Intl.message(
      'Un désaccord sur ce paiement ? Signale un litige : l\'équipe Mboa examinera les pièces.',
      name: 'disputePrompt',
      desc: 'On a contested declaration',
      args: [],
    );
  }

  /// `dont {count} ces 7 jours`
  String annonceStatsViewsWeek(int count) {
    return Intl.message(
      'dont $count ces 7 jours',
      name: 'annonceStatsViewsWeek',
      desc: 'M14 — under a listing views figure',
      args: [count],
    );
  }

  /// `Pertinence`
  String get searchSortRelevance {
    return Intl.message(
      'Pertinence',
      name: 'searchSortRelevance',
      desc: 'RM-M04-08 — sort chip: the server\'s order',
      args: [],
    );
  }

  /// `Près de toi`
  String get searchSortNearby {
    return Intl.message(
      'Près de toi',
      name: 'searchSortNearby',
      desc:
          'RM-M04-08 — sort chip: nearest first (« Proche de vous », said with tu)',
      args: [],
    );
  }

  /// `Les plus proches à {city}`
  String searchNearbyTitle(String city) {
    return Intl.message(
      'Les plus proches à $city',
      name: 'searchNearbyTitle',
      desc: 'RM-M04-08 — list title when sorted by distance',
      args: [city],
    );
  }

  /// `à {km} km`
  String searchDistance(String km) {
    return Intl.message(
      'à $km km',
      name: 'searchDistance',
      desc: 'RM-M04-08 — on a card',
      args: [km],
    );
  }

  /// `{average} ({count})`
  String hitRating(String average, int count) {
    return Intl.message(
      '$average ($count)',
      name: 'hitRating',
      desc: 'RM-M04-08 — a card\'s rating: average and review count',
      args: [average, count],
    );
  }

  /// `Sans ta position, Mboa ne peut pas trier par distance.`
  String get searchLocationDenied {
    return Intl.message(
      'Sans ta position, Mboa ne peut pas trier par distance.',
      name: 'searchLocationDenied',
      desc: 'Position refused this time',
      args: [],
    );
  }

  /// `Ta position n'a pas pu être trouvée. Réessaie dans un instant.`
  String get searchLocationUnavailable {
    return Intl.message(
      'Ta position n\'a pas pu être trouvée. Réessaie dans un instant.',
      name: 'searchLocationUnavailable',
      desc: 'No fix in time',
      args: [],
    );
  }

  /// `Autorise ta position`
  String get searchLocationBlockedTitle {
    return Intl.message(
      'Autorise ta position',
      name: 'searchLocationBlockedTitle',
      desc: 'Position refused for good: sheet title',
      args: [],
    );
  }

  /// `Pour voir les biens les plus proches, autorise Mboa à utiliser ta position dans les réglages. Elle sert à la recherche et n'est jamais enregistrée.`
  String get searchLocationBlockedBody {
    return Intl.message(
      'Pour voir les biens les plus proches, autorise Mboa à utiliser ta position dans les réglages. Elle sert à la recherche et n\'est jamais enregistrée.',
      name: 'searchLocationBlockedBody',
      desc: 'Position refused for good: sheet body',
      args: [],
    );
  }

  /// `Active la localisation`
  String get searchLocationOffTitle {
    return Intl.message(
      'Active la localisation',
      name: 'searchLocationOffTitle',
      desc: 'Location off: sheet title',
      args: [],
    );
  }

  /// `La localisation de ton téléphone est désactivée. Active-la pour voir les biens les plus proches.`
  String get searchLocationOffBody {
    return Intl.message(
      'La localisation de ton téléphone est désactivée. Active-la pour voir les biens les plus proches.',
      name: 'searchLocationOffBody',
      desc: 'Location off: sheet body',
      args: [],
    );
  }

  /// `Ouvrir les réglages`
  String get searchLocationOpenSettings {
    return Intl.message(
      'Ouvrir les réglages',
      name: 'searchLocationOpenSettings',
      desc: 'Location sheet button',
      args: [],
    );
  }

  /// `Gestion financière`
  String get financeAddonName {
    return Intl.message(
      'Gestion financière',
      name: 'financeAddonName',
      desc: 'M24–M26 — the paid add-on (RM-M13-09), as a payment names it',
      args: [],
    );
  }

  /// `Tes factures, ton registre et tes intervenants : ce qui se paie et s'encaisse pour tes biens, au même endroit.`
  String get financeIntro {
    return Intl.message(
      'Tes factures, ton registre et tes intervenants : ce qui se paie et s\'encaisse pour tes biens, au même endroit.',
      name: 'financeIntro',
      desc: 'M24–M26 hub — what the add-on is',
      args: [],
    );
  }

  /// `Eau, électricité, charges : facture tes locataires et suis les règlements.`
  String get financeInvoicesHint {
    return Intl.message(
      'Eau, électricité, charges : facture tes locataires et suis les règlements.',
      name: 'financeInvoicesHint',
      desc: 'M24 row',
      args: [],
    );
  }

  /// `Registre`
  String get financeLedgerTitle {
    return Intl.message(
      'Registre',
      name: 'financeLedgerTitle',
      desc: 'M25 — the ledger',
      args: [],
    );
  }

  /// `Tes entrées et sorties, bien par bien, avec le solde et l'export CSV.`
  String get financeLedgerHint {
    return Intl.message(
      'Tes entrées et sorties, bien par bien, avec le solde et l\'export CSV.',
      name: 'financeLedgerHint',
      desc: 'M25 row',
      args: [],
    );
  }

  /// `Intervenants`
  String get financeProvidersTitle {
    return Intl.message(
      'Intervenants',
      name: 'financeProvidersTitle',
      desc: 'M26 — the service providers',
      args: [],
    );
  }

  /// `Plombier, ménage, électricien : ce que tu leur as payé, et pour quel bien.`
  String get financeProvidersHint {
    return Intl.message(
      'Plombier, ménage, électricien : ce que tu leur as payé, et pour quel bien.',
      name: 'financeProvidersHint',
      desc: 'M26 row',
      args: [],
    );
  }

  /// `Aucun argent ne transite par Mboa : tu notes ce qui se paie entre toi et tes locataires ou intervenants, Mboa tient le registre.`
  String get financeNoMoney {
    return Intl.message(
      'Aucun argent ne transite par Mboa : tu notes ce qui se paie entre toi et tes locataires ou intervenants, Mboa tient le registre.',
      name: 'financeNoMoney',
      desc: 'RM-M24-05 / RM-M25-01',
      args: [],
    );
  }

  /// `Ce qui est inclus`
  String get financeIncluded {
    return Intl.message(
      'Ce qui est inclus',
      name: 'financeIncluded',
      desc: 'Add-on: section title',
      args: [],
    );
  }

  /// `Hors ligne : la gestion financière telle qu'à ta dernière connexion.`
  String get financeOffline {
    return Intl.message(
      'Hors ligne : la gestion financière telle qu\'à ta dernière connexion.',
      name: 'financeOffline',
      desc: 'Finance offline',
      args: [],
    );
  }

  /// `Rien ici pour l'instant.`
  String get ownerInvoicesEmpty {
    return Intl.message(
      'Rien ici pour l\'instant.',
      name: 'ownerInvoicesEmpty',
      desc: 'M24 — an empty filter',
      args: [],
    );
  }

  /// `Nouvelle facture`
  String get ownerInvoiceNew {
    return Intl.message(
      'Nouvelle facture',
      name: 'ownerInvoiceNew',
      desc: 'M24 — the list\'s main action',
      args: [],
    );
  }

  /// `Marquer payée`
  String get ownerInvoiceMarkPaid {
    return Intl.message(
      'Marquer payée',
      name: 'ownerInvoiceMarkPaid',
      desc: 'M24 — the detail\'s main action',
      args: [],
    );
  }

  /// `Modifier`
  String get ownerInvoiceEdit {
    return Intl.message(
      'Modifier',
      name: 'ownerInvoiceEdit',
      desc: 'M24 — behind ⋯',
      args: [],
    );
  }

  /// `Annuler la facture`
  String get ownerInvoiceCancel {
    return Intl.message(
      'Annuler la facture',
      name: 'ownerInvoiceCancel',
      desc: 'M24 — behind ⋯, in red',
      args: [],
    );
  }

  /// `Annuler cette facture ? Elle reste dans l'historique, sans être due.`
  String get ownerInvoiceCancelConfirm {
    return Intl.message(
      'Annuler cette facture ? Elle reste dans l\'historique, sans être due.',
      name: 'ownerInvoiceCancelConfirm',
      desc: 'M24 — confirm a cancellation',
      args: [],
    );
  }

  /// `Retirer le paiement déclaré`
  String get ownerInvoiceReopen {
    return Intl.message(
      'Retirer le paiement déclaré',
      name: 'ownerInvoiceReopen',
      desc: 'M24 — behind ⋯ on an invoice paid by hand',
      args: [],
    );
  }

  /// `Retirer le paiement que tu as déclaré ? La facture redevient à payer.`
  String get ownerInvoiceReopenConfirm {
    return Intl.message(
      'Retirer le paiement que tu as déclaré ? La facture redevient à payer.',
      name: 'ownerInvoiceReopenConfirm',
      desc: 'M24 — confirm a reopening',
      args: [],
    );
  }

  /// `Payée le`
  String get ownerInvoicePaidOnTitle {
    return Intl.message(
      'Payée le',
      name: 'ownerInvoicePaidOnTitle',
      desc: 'M24 — the date asked when marking paid',
      args: [],
    );
  }

  /// `Échéance dépassée`
  String get ownerInvoicePastDue {
    return Intl.message(
      'Échéance dépassée',
      name: 'ownerInvoicePastDue',
      desc: 'M24 — before the 5 days that make it late (RM-M24-07)',
      args: [],
    );
  }

  /// `Réglée par les déclarations confirmées du locataire.`
  String get ownerInvoiceByDeclaration {
    return Intl.message(
      'Réglée par les déclarations confirmées du locataire.',
      name: 'ownerInvoiceByDeclaration',
      desc: 'M24 — paidVia DECLARED',
      args: [],
    );
  }

  /// `Déclarée payée par toi. Mboa ne vérifie pas ce paiement.`
  String get ownerInvoiceByHand {
    return Intl.message(
      'Déclarée payée par toi. Mboa ne vérifie pas ce paiement.',
      name: 'ownerInvoiceByHand',
      desc: 'M24 — paidVia MANUAL (RM-M24-05)',
      args: [],
    );
  }

  /// `Pour quel locataire ?`
  String get ownerInvoiceFormTenant {
    return Intl.message(
      'Pour quel locataire ?',
      name: 'ownerInvoiceFormTenant',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `Aucune location en cours : une facture s'adresse au locataire d'un Contrat Mboa actif.`
  String get ownerInvoiceFormNoTenant {
    return Intl.message(
      'Aucune location en cours : une facture s\'adresse au locataire d\'un Contrat Mboa actif.',
      name: 'ownerInvoiceFormNoTenant',
      desc: 'RM-M24-02',
      args: [],
    );
  }

  /// `Type de charge`
  String get ownerInvoiceFormKind {
    return Intl.message(
      'Type de charge',
      name: 'ownerInvoiceFormKind',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `Libellé`
  String get ownerInvoiceFormLabel {
    return Intl.message(
      'Libellé',
      name: 'ownerInvoiceFormLabel',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `Ex. : Électricité — septembre`
  String get ownerInvoiceFormLabelHint {
    return Intl.message(
      'Ex. : Électricité — septembre',
      name: 'ownerInvoiceFormLabelHint',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `Obligatoire pour une autre charge.`
  String get ownerInvoiceFormLabelRequired {
    return Intl.message(
      'Obligatoire pour une autre charge.',
      name: 'ownerInvoiceFormLabelRequired',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `Montant (FCFA)`
  String get ownerInvoiceFormAmount {
    return Intl.message(
      'Montant (FCFA)',
      name: 'ownerInvoiceFormAmount',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `À payer avant le`
  String get ownerInvoiceFormDue {
    return Intl.message(
      'À payer avant le',
      name: 'ownerInvoiceFormDue',
      desc: 'M24 form',
      args: [],
    );
  }

  /// `Créer la facture`
  String get ownerInvoiceCreate {
    return Intl.message(
      'Créer la facture',
      name: 'ownerInvoiceCreate',
      desc: 'M24 form button',
      args: [],
    );
  }

  /// `Enregistrer`
  String get ownerInvoiceSave {
    return Intl.message(
      'Enregistrer',
      name: 'ownerInvoiceSave',
      desc: 'M24 form button (edit)',
      args: [],
    );
  }

  /// `Facture créée. Ton locataire la voit dans son espace.`
  String get ownerInvoiceCreated {
    return Intl.message(
      'Facture créée. Ton locataire la voit dans son espace.',
      name: 'ownerInvoiceCreated',
      desc: 'M24 toast',
      args: [],
    );
  }

  /// `Facture modifiée`
  String get ownerInvoiceSaved {
    return Intl.message(
      'Facture modifiée',
      name: 'ownerInvoiceSaved',
      desc: 'M24 toast',
      args: [],
    );
  }

  /// `Facture marquée payée`
  String get ownerInvoicePaidToast {
    return Intl.message(
      'Facture marquée payée',
      name: 'ownerInvoicePaidToast',
      desc: 'M24 toast',
      args: [],
    );
  }

  /// `Facture annulée`
  String get ownerInvoiceCancelledToast {
    return Intl.message(
      'Facture annulée',
      name: 'ownerInvoiceCancelledToast',
      desc: 'M24 toast',
      args: [],
    );
  }

  /// `Paiement retiré : la facture est à payer`
  String get ownerInvoiceReopenedToast {
    return Intl.message(
      'Paiement retiré : la facture est à payer',
      name: 'ownerInvoiceReopenedToast',
      desc: 'M24 toast',
      args: [],
    );
  }

  /// `Cette facture est déjà payée ou annulée.`
  String get financeRefusedSettled {
    return Intl.message(
      'Cette facture est déjà payée ou annulée.',
      name: 'financeRefusedSettled',
      desc: 'INVOICE_SETTLED',
      args: [],
    );
  }

  /// `Réglée par les déclarations du locataire : il n'y a pas de paiement à retirer.`
  String get financeRefusedNotByHand {
    return Intl.message(
      'Réglée par les déclarations du locataire : il n\'y a pas de paiement à retirer.',
      name: 'financeRefusedNotByHand',
      desc: 'INVOICE_NOT_DECLARED',
      args: [],
    );
  }

  /// `Donne un libellé à cette charge.`
  String get financeRefusedLabel {
    return Intl.message(
      'Donne un libellé à cette charge.',
      name: 'financeRefusedLabel',
      desc: 'INVOICE_LABEL_REQUIRED',
      args: [],
    );
  }

  /// `Ce contrat n'est plus en cours.`
  String get financeRefusedContract {
    return Intl.message(
      'Ce contrat n\'est plus en cours.',
      name: 'financeRefusedContract',
      desc: 'CONTRACT_NOT_ACTIVE',
      args: [],
    );
  }

  /// `Cette ligne vient d'un paiement confirmé : elle se corrige à sa source.`
  String get financeRefusedReadOnly {
    return Intl.message(
      'Cette ligne vient d\'un paiement confirmé : elle se corrige à sa source.',
      name: 'financeRefusedReadOnly',
      desc: 'LEDGER_ENTRY_READ_ONLY',
      args: [],
    );
  }

  /// `Choisis un bien, une résidence, ou « non affecté » — pas plusieurs.`
  String get financeRefusedProperty {
    return Intl.message(
      'Choisis un bien, une résidence, ou « non affecté » — pas plusieurs.',
      name: 'financeRefusedProperty',
      desc: 'LEDGER_PROPERTY_CONFLICT',
      args: [],
    );
  }

  /// `Cet intervenant a des paiements : archive-le plutôt.`
  String get financeRefusedHasPayments {
    return Intl.message(
      'Cet intervenant a des paiements : archive-le plutôt.',
      name: 'financeRefusedHasPayments',
      desc: 'SERVICE_PROVIDER_HAS_PAYMENTS',
      args: [],
    );
  }

  /// `Cet intervenant est archivé : restaure-le pour lui déclarer un paiement.`
  String get financeRefusedArchived {
    return Intl.message(
      'Cet intervenant est archivé : restaure-le pour lui déclarer un paiement.',
      name: 'financeRefusedArchived',
      desc: 'SERVICE_PROVIDER_ARCHIVED',
      args: [],
    );
  }

  /// `Ce contact est déjà un de tes intervenants.`
  String get financeRefusedDuplicate {
    return Intl.message(
      'Ce contact est déjà un de tes intervenants.',
      name: 'financeRefusedDuplicate',
      desc: 'SERVICE_PROVIDER_DUPLICATE',
      args: [],
    );
  }

  /// `Entrées`
  String get ledgerIncome {
    return Intl.message(
      'Entrées',
      name: 'ledgerIncome',
      desc: 'M25 summary',
      args: [],
    );
  }

  /// `Sorties`
  String get ledgerExpense {
    return Intl.message(
      'Sorties',
      name: 'ledgerExpense',
      desc: 'M25 summary',
      args: [],
    );
  }

  /// `Solde`
  String get ledgerNet {
    return Intl.message(
      'Solde',
      name: 'ledgerNet',
      desc: 'M25 summary: income minus expenses (RM-M25-03)',
      args: [],
    );
  }

  /// `Par catégorie`
  String get ledgerByCategory {
    return Intl.message(
      'Par catégorie',
      name: 'ledgerByCategory',
      desc: 'M25 summary',
      args: [],
    );
  }

  /// `Ce mois-ci`
  String get ledgerPeriodThisMonth {
    return Intl.message(
      'Ce mois-ci',
      name: 'ledgerPeriodThisMonth',
      desc: 'M25 period',
      args: [],
    );
  }

  /// `3 derniers mois`
  String get ledgerPeriodThreeMonths {
    return Intl.message(
      '3 derniers mois',
      name: 'ledgerPeriodThreeMonths',
      desc: 'M25 period',
      args: [],
    );
  }

  /// `Cette année`
  String get ledgerPeriodThisYear {
    return Intl.message(
      'Cette année',
      name: 'ledgerPeriodThisYear',
      desc: 'M25 period',
      args: [],
    );
  }

  /// `Tout`
  String get ledgerPeriodAll {
    return Intl.message(
      'Tout',
      name: 'ledgerPeriodAll',
      desc: 'M25 period',
      args: [],
    );
  }

  /// `Tous les biens`
  String get ledgerAllProperties {
    return Intl.message(
      'Tous les biens',
      name: 'ledgerAllProperties',
      desc: 'M25 property filter',
      args: [],
    );
  }

  /// `Non affecté`
  String get ledgerUnassigned {
    return Intl.message(
      'Non affecté',
      name: 'ledgerUnassigned',
      desc: 'RM-M25-02 — a general expense',
      args: [],
    );
  }

  /// `Quel bien ?`
  String get ledgerPropertyTitle {
    return Intl.message(
      'Quel bien ?',
      name: 'ledgerPropertyTitle',
      desc: 'M25 property picker title',
      args: [],
    );
  }

  /// `Aucun mouvement sur cette période.`
  String get ledgerEmpty {
    return Intl.message(
      'Aucun mouvement sur cette période.',
      name: 'ledgerEmpty',
      desc: 'M25 empty list',
      args: [],
    );
  }

  /// `Ajouter un mouvement`
  String get ledgerAdd {
    return Intl.message(
      'Ajouter un mouvement',
      name: 'ledgerAdd',
      desc: 'M25 — the main action',
      args: [],
    );
  }

  /// `Exporter en CSV`
  String get ledgerExport {
    return Intl.message(
      'Exporter en CSV',
      name: 'ledgerExport',
      desc: 'RM-M25-05',
      args: [],
    );
  }

  /// `Registre Mboa`
  String get ledgerExportName {
    return Intl.message(
      'Registre Mboa',
      name: 'ledgerExportName',
      desc: 'M25 — the CSV\'s file name',
      args: [],
    );
  }

  /// `L'export n'a pas pu être préparé. Vérifie ta connexion et réessaie.`
  String get ledgerExportFailed {
    return Intl.message(
      'L\'export n\'a pas pu être préparé. Vérifie ta connexion et réessaie.',
      name: 'ledgerExportFailed',
      desc: 'M25 export failed',
      args: [],
    );
  }

  /// `Vient d'un paiement confirmé : se corrige à sa source.`
  String get ledgerReadOnly {
    return Intl.message(
      'Vient d\'un paiement confirmé : se corrige à sa source.',
      name: 'ledgerReadOnly',
      desc: 'RM-M30-08 — a kept line',
      args: [],
    );
  }

  /// `Loyer`
  String get ledgerCategoryRent {
    return Intl.message(
      'Loyer',
      name: 'ledgerCategoryRent',
      desc: 'M25 category',
      args: [],
    );
  }

  /// `Charges`
  String get ledgerCategoryCharges {
    return Intl.message(
      'Charges',
      name: 'ledgerCategoryCharges',
      desc: 'M25 category',
      args: [],
    );
  }

  /// `Travaux`
  String get ledgerCategoryWorks {
    return Intl.message(
      'Travaux',
      name: 'ledgerCategoryWorks',
      desc: 'M25 category',
      args: [],
    );
  }

  /// `Impôt foncier`
  String get ledgerCategoryTax {
    return Intl.message(
      'Impôt foncier',
      name: 'ledgerCategoryTax',
      desc: 'M25 category',
      args: [],
    );
  }

  /// `Intervenants`
  String get ledgerCategoryProviders {
    return Intl.message(
      'Intervenants',
      name: 'ledgerCategoryProviders',
      desc: 'M25 category (M26)',
      args: [],
    );
  }

  /// `Autre`
  String get ledgerCategoryOther {
    return Intl.message(
      'Autre',
      name: 'ledgerCategoryOther',
      desc: 'M25 category',
      args: [],
    );
  }

  /// `Nouveau mouvement`
  String get ledgerFormTitleNew {
    return Intl.message(
      'Nouveau mouvement',
      name: 'ledgerFormTitleNew',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Modifier le mouvement`
  String get ledgerFormTitleEdit {
    return Intl.message(
      'Modifier le mouvement',
      name: 'ledgerFormTitleEdit',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Catégorie`
  String get ledgerFormCategory {
    return Intl.message(
      'Catégorie',
      name: 'ledgerFormCategory',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Montant (FCFA)`
  String get ledgerFormAmount {
    return Intl.message(
      'Montant (FCFA)',
      name: 'ledgerFormAmount',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Date`
  String get ledgerFormDate {
    return Intl.message(
      'Date',
      name: 'ledgerFormDate',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Bien concerné`
  String get ledgerFormProperty {
    return Intl.message(
      'Bien concerné',
      name: 'ledgerFormProperty',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Note (facultatif)`
  String get ledgerFormNote {
    return Intl.message(
      'Note (facultatif)',
      name: 'ledgerFormNote',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Justificatif (facultatif)`
  String get ledgerFormAttachment {
    return Intl.message(
      'Justificatif (facultatif)',
      name: 'ledgerFormAttachment',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Ajouter une photo`
  String get ledgerFormAttachmentAdd {
    return Intl.message(
      'Ajouter une photo',
      name: 'ledgerFormAttachmentAdd',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Photo ajoutée`
  String get ledgerFormAttachmentAdded {
    return Intl.message(
      'Photo ajoutée',
      name: 'ledgerFormAttachmentAdded',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Voir la pièce jointe actuelle`
  String get ledgerFormAttachmentView {
    return Intl.message(
      'Voir la pièce jointe actuelle',
      name: 'ledgerFormAttachmentView',
      desc: 'M25 form',
      args: [],
    );
  }

  /// `Enregistrer`
  String get ledgerFormSave {
    return Intl.message(
      'Enregistrer',
      name: 'ledgerFormSave',
      desc: 'M25 form button',
      args: [],
    );
  }

  /// `Supprimer le mouvement`
  String get ledgerFormDelete {
    return Intl.message(
      'Supprimer le mouvement',
      name: 'ledgerFormDelete',
      desc: 'M25 — behind ⋯, in red',
      args: [],
    );
  }

  /// `Supprimer ce mouvement et sa pièce jointe ?`
  String get ledgerFormDeleteConfirm {
    return Intl.message(
      'Supprimer ce mouvement et sa pièce jointe ?',
      name: 'ledgerFormDeleteConfirm',
      desc: 'M25 confirm',
      args: [],
    );
  }

  /// `Mouvement enregistré`
  String get ledgerSavedToast {
    return Intl.message(
      'Mouvement enregistré',
      name: 'ledgerSavedToast',
      desc: 'M25 toast',
      args: [],
    );
  }

  /// `Mouvement supprimé`
  String get ledgerDeletedToast {
    return Intl.message(
      'Mouvement supprimé',
      name: 'ledgerDeletedToast',
      desc: 'M25 toast',
      args: [],
    );
  }

  /// `La photo n'a pas pu être envoyée. Réessaie.`
  String get ledgerUploadFailed {
    return Intl.message(
      'La photo n\'a pas pu être envoyée. Réessaie.',
      name: 'ledgerUploadFailed',
      desc: 'M25 upload failed',
      args: [],
    );
  }

  /// `Ménage`
  String get providerKindCleaning {
    return Intl.message(
      'Ménage',
      name: 'providerKindCleaning',
      desc: 'M26 kind',
      args: [],
    );
  }

  /// `Plomberie`
  String get providerKindPlumbing {
    return Intl.message(
      'Plomberie',
      name: 'providerKindPlumbing',
      desc: 'M26 kind',
      args: [],
    );
  }

  /// `Électricité`
  String get providerKindElectrical {
    return Intl.message(
      'Électricité',
      name: 'providerKindElectrical',
      desc: 'M26 kind',
      args: [],
    );
  }

  /// `Autre`
  String get providerKindOther {
    return Intl.message(
      'Autre',
      name: 'providerKindOther',
      desc: 'M26 kind',
      args: [],
    );
  }

  /// `Aucun intervenant pour l'instant. Ajoute le plombier, la ménagère ou l'électricien qui travaillent sur tes biens.`
  String get providersEmpty {
    return Intl.message(
      'Aucun intervenant pour l\'instant. Ajoute le plombier, la ménagère ou l\'électricien qui travaillent sur tes biens.',
      name: 'providersEmpty',
      desc: 'M26 empty list',
      args: [],
    );
  }

  /// `Afficher les archivés`
  String get providersShowArchived {
    return Intl.message(
      'Afficher les archivés',
      name: 'providersShowArchived',
      desc: 'M26 list toggle',
      args: [],
    );
  }

  /// `Ajouter un intervenant`
  String get providersAdd {
    return Intl.message(
      'Ajouter un intervenant',
      name: 'providersAdd',
      desc: 'M26 — the list\'s main action',
      args: [],
    );
  }

  /// `Sur Mboa`
  String get providerLinked {
    return Intl.message(
      'Sur Mboa',
      name: 'providerLinked',
      desc: 'M26 — linked to a Mboa account',
      args: [],
    );
  }

  /// `Archivé`
  String get providerArchivedBadge {
    return Intl.message(
      'Archivé',
      name: 'providerArchivedBadge',
      desc: 'M26 badge',
      args: [],
    );
  }

  /// `{count, plural, =0{Aucun paiement} =1{{total} · 1 paiement} other{{total} · {count} paiements}}`
  String providerTotalPaid(int count, String total) {
    return Intl.plural(
      count,
      zero: 'Aucun paiement',
      one: '$total · 1 paiement',
      other: '$total · $count paiements',
      name: 'providerTotalPaid',
      desc: 'M26 row',
      args: [count, total],
    );
  }

  /// `Payé au total`
  String get providerPaidTotalTitle {
    return Intl.message(
      'Payé au total',
      name: 'providerPaidTotalTitle',
      desc: 'M26 detail',
      args: [],
    );
  }

  /// `Paiements`
  String get providerPaymentsTitle {
    return Intl.message(
      'Paiements',
      name: 'providerPaymentsTitle',
      desc: 'M26 detail',
      args: [],
    );
  }

  /// `Aucun paiement déclaré.`
  String get providerNoPayment {
    return Intl.message(
      'Aucun paiement déclaré.',
      name: 'providerNoPayment',
      desc: 'M26 detail',
      args: [],
    );
  }

  /// `Déclarer un paiement`
  String get providerPay {
    return Intl.message(
      'Déclarer un paiement',
      name: 'providerPay',
      desc: 'M26 — the detail\'s main action (never paying in the app)',
      args: [],
    );
  }

  /// `Modifier`
  String get providerEdit {
    return Intl.message(
      'Modifier',
      name: 'providerEdit',
      desc: 'M26 ⋯',
      args: [],
    );
  }

  /// `Archiver`
  String get providerArchive {
    return Intl.message(
      'Archiver',
      name: 'providerArchive',
      desc: 'M26 ⋯, in red',
      args: [],
    );
  }

  /// `Archiver cet intervenant ? Il disparaît des listes, son historique reste.`
  String get providerArchiveConfirm {
    return Intl.message(
      'Archiver cet intervenant ? Il disparaît des listes, son historique reste.',
      name: 'providerArchiveConfirm',
      desc: 'M26 confirm',
      args: [],
    );
  }

  /// `Restaurer`
  String get providerRestore {
    return Intl.message(
      'Restaurer',
      name: 'providerRestore',
      desc: 'M26 — an archived one\'s main action',
      args: [],
    );
  }

  /// `Supprimer`
  String get providerDelete {
    return Intl.message(
      'Supprimer',
      name: 'providerDelete',
      desc: 'M26 ⋯, in red, without payments',
      args: [],
    );
  }

  /// `Supprimer cet intervenant ?`
  String get providerDeleteConfirm {
    return Intl.message(
      'Supprimer cet intervenant ?',
      name: 'providerDeleteConfirm',
      desc: 'M26 confirm',
      args: [],
    );
  }

  /// `Intervenant archivé`
  String get providerArchivedToast {
    return Intl.message(
      'Intervenant archivé',
      name: 'providerArchivedToast',
      desc: 'M26 toast',
      args: [],
    );
  }

  /// `Intervenant restauré`
  String get providerRestoredToast {
    return Intl.message(
      'Intervenant restauré',
      name: 'providerRestoredToast',
      desc: 'M26 toast',
      args: [],
    );
  }

  /// `Intervenant supprimé`
  String get providerDeletedToast {
    return Intl.message(
      'Intervenant supprimé',
      name: 'providerDeletedToast',
      desc: 'M26 toast',
      args: [],
    );
  }

  /// `Nouvel intervenant`
  String get providerFormTitleNew {
    return Intl.message(
      'Nouvel intervenant',
      name: 'providerFormTitleNew',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Modifier l'intervenant`
  String get providerFormTitleEdit {
    return Intl.message(
      'Modifier l\'intervenant',
      name: 'providerFormTitleEdit',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Parmi tes contacts Mboa`
  String get providerFormFromContacts {
    return Intl.message(
      'Parmi tes contacts Mboa',
      name: 'providerFormFromContacts',
      desc: 'M26 — people he has a thread with',
      args: [],
    );
  }

  /// `Son nom suit son profil ; son numéro n'est jamais repris.`
  String get providerFormContactsHint {
    return Intl.message(
      'Son nom suit son profil ; son numéro n\'est jamais repris.',
      name: 'providerFormContactsHint',
      desc: 'M26 / CA-M12-02',
      args: [],
    );
  }

  /// `Saisir un nom`
  String get providerFormTyped {
    return Intl.message(
      'Saisir un nom',
      name: 'providerFormTyped',
      desc: 'M26 — a free entry',
      args: [],
    );
  }

  /// `Nom`
  String get providerFormName {
    return Intl.message(
      'Nom',
      name: 'providerFormName',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Métier`
  String get providerFormKind {
    return Intl.message(
      'Métier',
      name: 'providerFormKind',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Lequel ?`
  String get providerFormKindLabel {
    return Intl.message(
      'Lequel ?',
      name: 'providerFormKindLabel',
      desc: 'M26 — kind OTHER',
      args: [],
    );
  }

  /// `Ex. : Gardien`
  String get providerFormKindLabelHint {
    return Intl.message(
      'Ex. : Gardien',
      name: 'providerFormKindLabelHint',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Note (facultatif)`
  String get providerFormNote {
    return Intl.message(
      'Note (facultatif)',
      name: 'providerFormNote',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Enregistrer`
  String get providerFormSave {
    return Intl.message(
      'Enregistrer',
      name: 'providerFormSave',
      desc: 'M26 form',
      args: [],
    );
  }

  /// `Intervenant enregistré`
  String get providerSavedToast {
    return Intl.message(
      'Intervenant enregistré',
      name: 'providerSavedToast',
      desc: 'M26 toast',
      args: [],
    );
  }

  /// `Déclarer un paiement`
  String get providerPaymentTitleNew {
    return Intl.message(
      'Déclarer un paiement',
      name: 'providerPaymentTitleNew',
      desc: 'M26 payment form',
      args: [],
    );
  }

  /// `Modifier le paiement`
  String get providerPaymentTitleEdit {
    return Intl.message(
      'Modifier le paiement',
      name: 'providerPaymentTitleEdit',
      desc: 'M26 payment form',
      args: [],
    );
  }

  /// `Payé hors de Mboa. Il s'ajoute à ton registre en Sortie · Intervenants.`
  String get providerPaymentHint {
    return Intl.message(
      'Payé hors de Mboa. Il s\'ajoute à ton registre en Sortie · Intervenants.',
      name: 'providerPaymentHint',
      desc: 'RM-M26-02 / RM-M26-04',
      args: [],
    );
  }

  /// `Payé le`
  String get providerPaymentDate {
    return Intl.message(
      'Payé le',
      name: 'providerPaymentDate',
      desc: 'M26 payment form',
      args: [],
    );
  }

  /// `Supprimer le paiement`
  String get providerPaymentDelete {
    return Intl.message(
      'Supprimer le paiement',
      name: 'providerPaymentDelete',
      desc: 'M26 ⋯',
      args: [],
    );
  }

  /// `Supprimer ce paiement et sa ligne du registre ?`
  String get providerPaymentDeleteConfirm {
    return Intl.message(
      'Supprimer ce paiement et sa ligne du registre ?',
      name: 'providerPaymentDeleteConfirm',
      desc: 'M26 confirm',
      args: [],
    );
  }

  /// `Paiement enregistré`
  String get providerPaymentSavedToast {
    return Intl.message(
      'Paiement enregistré',
      name: 'providerPaymentSavedToast',
      desc: 'M26 toast',
      args: [],
    );
  }

  /// `Paiement supprimé`
  String get providerPaymentDeletedToast {
    return Intl.message(
      'Paiement supprimé',
      name: 'providerPaymentDeletedToast',
      desc: 'M26 toast',
      args: [],
    );
  }

  /// `Étape {current} sur {total}`
  String commonStepOf(int current, int total) {
    return Intl.message(
      'Étape $current sur $total',
      name: 'commonStepOf',
      desc: 'A multi-step flow\'s progress',
      args: [current, total],
    );
  }

  /// `Continuer`
  String get commonContinue {
    return Intl.message(
      'Continuer',
      name: 'commonContinue',
      desc: 'A multi-step flow\'s main action, before the last step',
      args: [],
    );
  }

  /// `Quelle charge ?`
  String get ownerInvoiceStepCharge {
    return Intl.message(
      'Quelle charge ?',
      name: 'ownerInvoiceStepCharge',
      desc: 'M24 form — step 2\'s title',
      args: [],
    );
  }

  /// `Combien, et pour quand ?`
  String get ownerInvoiceStepAmount {
    return Intl.message(
      'Combien, et pour quand ?',
      name: 'ownerInvoiceStepAmount',
      desc: 'M24 form — step 3\'s title',
      args: [],
    );
  }

  /// `Nom du locataire ou du bien`
  String get ownerInvoiceSearchHint {
    return Intl.message(
      'Nom du locataire ou du bien',
      name: 'ownerInvoiceSearchHint',
      desc: 'M24 form — step 1\'s search',
      args: [],
    );
  }

  /// `Biens uniques ({count})`
  String ownerInvoiceGroupSingle(int count) {
    return Intl.message(
      'Biens uniques ($count)',
      name: 'ownerInvoiceGroupSingle',
      desc: 'M24 form — the standalone listings\' tab, with its matches',
      args: [count],
    );
  }

  /// `Biens multiples ({count})`
  String ownerInvoiceGroupMultiple(int count) {
    return Intl.message(
      'Biens multiples ($count)',
      name: 'ownerInvoiceGroupMultiple',
      desc: 'M24 form — the residences\' tab, with its matches',
      args: [count],
    );
  }

  /// `Aucun locataire ne correspond à « {query} » ici.`
  String ownerInvoiceSearchEmpty(String query) {
    return Intl.message(
      'Aucun locataire ne correspond à « $query » ici.',
      name: 'ownerInvoiceSearchEmpty',
      desc: 'M24 form — nothing found in this tab',
      args: [query],
    );
  }

  /// `Aucun locataire dans un bien unique.`
  String get ownerInvoiceGroupEmptySingle {
    return Intl.message(
      'Aucun locataire dans un bien unique.',
      name: 'ownerInvoiceGroupEmptySingle',
      desc: 'M24 form — the tab is empty',
      args: [],
    );
  }

  /// `Aucun locataire dans une résidence.`
  String get ownerInvoiceGroupEmptyMultiple {
    return Intl.message(
      'Aucun locataire dans une résidence.',
      name: 'ownerInvoiceGroupEmptyMultiple',
      desc: 'M24 form — the tab is empty',
      args: [],
    );
  }

  /// `Changer`
  String get ownerInvoiceChangeTenant {
    return Intl.message(
      'Changer',
      name: 'ownerInvoiceChangeTenant',
      desc: 'M24 form — back to the tenant from the recap',
      args: [],
    );
  }

  /// `Retirer la pièce jointe`
  String get ledgerFormAttachmentRemove {
    return Intl.message(
      'Retirer la pièce jointe',
      name: 'ledgerFormAttachmentRemove',
      desc: 'M25 form — the cross on the current attachment (§34)',
      args: [],
    );
  }

  /// `La pièce jointe sera retirée à l'enregistrement.`
  String get ledgerFormAttachmentRemoved {
    return Intl.message(
      'La pièce jointe sera retirée à l\'enregistrement.',
      name: 'ledgerFormAttachmentRemoved',
      desc: 'M25 form — the current attachment, asked to go (§34)',
      args: [],
    );
  }

  /// `Remplacer la photo`
  String get ledgerFormAttachmentReplace {
    return Intl.message(
      'Remplacer la photo',
      name: 'ledgerFormAttachmentReplace',
      desc: 'M25 form — a new photo over the current one (§34)',
      args: [],
    );
  }

  /// `Elle remplacera la pièce jointe actuelle.`
  String get ledgerFormAttachmentReplacing {
    return Intl.message(
      'Elle remplacera la pièce jointe actuelle.',
      name: 'ledgerFormAttachmentReplacing',
      desc: 'M25 form — a new photo while the line had one (§34)',
      args: [],
    );
  }

  /// `Quel est ce bien ?`
  String get annonceStepBasics {
    return Intl.message(
      'Quel est ce bien ?',
      name: 'annonceStepBasics',
      desc: 'M10 form — step 1\'s title',
      args: [],
    );
  }

  /// `Où se trouve-t-il ?`
  String get annonceStepPlace {
    return Intl.message(
      'Où se trouve-t-il ?',
      name: 'annonceStepPlace',
      desc: 'M10 form — step 2\'s title',
      args: [],
    );
  }

  /// `Comment est le logement ?`
  String get annonceStepDetails {
    return Intl.message(
      'Comment est le logement ?',
      name: 'annonceStepDetails',
      desc: 'M10 form — step 3\'s title (single)',
      args: [],
    );
  }

  /// `Quels logements contient-elle ?`
  String get annonceStepUnits {
    return Intl.message(
      'Quels logements contient-elle ?',
      name: 'annonceStepUnits',
      desc: 'M10bis form — step 3\'s title (residence)',
      args: [],
    );
  }

  /// `Combien, et à partir de quand ?`
  String get annonceStepRent {
    return Intl.message(
      'Combien, et à partir de quand ?',
      name: 'annonceStepRent',
      desc: 'M10 form — step 4\'s title (single)',
      args: [],
    );
  }

  /// `À quoi ressemble-t-il ?`
  String get annonceStepMedia {
    return Intl.message(
      'À quoi ressemble-t-il ?',
      name: 'annonceStepMedia',
      desc: 'M10 form — the last step\'s title',
      args: [],
    );
  }

  /// `Un appartement, un studio, une villa… loué d'un seul tenant.`
  String get annonceKindSingleHint {
    return Intl.message(
      'Un appartement, un studio, une villa… loué d\'un seul tenant.',
      name: 'annonceKindSingleHint',
      desc: 'M10 form — the single kind\'s card',
      args: [],
    );
  }

  /// `Une résidence, un immeuble : plusieurs logements loués séparément.`
  String get annonceKindMultipleHint {
    return Intl.message(
      'Une résidence, un immeuble : plusieurs logements loués séparément.',
      name: 'annonceKindMultipleHint',
      desc: 'M10bis form — the multiple kind\'s card',
      args: [],
    );
  }

  /// `Incluse dans ta formule {plan}`
  String financeIncludedIn(String plan) {
    return Intl.message(
      'Incluse dans ta formule $plan',
      name: 'financeIncludedIn',
      desc:
          'M24–M26 hub — the plan held includes the finance tools (RM-M13-09)',
      args: [plan],
    );
  }

  /// `Formule {plan} · jusqu'au {date}`
  String financeIncludedUntil(String plan, String date) {
    return Intl.message(
      'Formule $plan · jusqu\'au $date',
      name: 'financeIncludedUntil',
      desc: 'M24–M26 hub — the plan held, and its last day',
      args: [plan, date],
    );
  }

  /// `Le suivi financier est inclus dès la formule {plan}. Ce que tu as déjà noté reste consultable et exportable.`
  String financeNotIncludedBody(String plan) {
    return Intl.message(
      'Le suivi financier est inclus dès la formule $plan. Ce que tu as déjà noté reste consultable et exportable.',
      name: 'financeNotIncludedBody',
      desc: 'M24–M26 hub — the plan held does not include it',
      args: [plan],
    );
  }

  /// `Formule {plan} : {price} par mois`
  String financeFromPrice(String plan, String price) {
    return Intl.message(
      'Formule $plan : $price par mois',
      name: 'financeFromPrice',
      desc:
          'M24–M26 hub — the cheapest plan that includes it, the server\'s price',
      args: [plan, price],
    );
  }

  /// `Voir les formules`
  String get financeSeePlans {
    return Intl.message(
      'Voir les formules',
      name: 'financeSeePlans',
      desc: 'M24–M26 — the one action when the plan does not include it',
      args: [],
    );
  }

  /// `Le suivi financier est inclus dès la formule Pro : change de formule pour ajouter ou modifier.`
  String get financeRefusedPlan {
    return Intl.message(
      'Le suivi financier est inclus dès la formule Pro : change de formule pour ajouter ou modifier.',
      name: 'financeRefusedPlan',
      desc: 'FINANCE_PLAN_REQUIRED on a change',
      args: [],
    );
  }

  /// `Le suivi financier est inclus dès la formule Pro.`
  String get financePlanRequiredRead {
    return Intl.message(
      'Le suivi financier est inclus dès la formule Pro.',
      name: 'financePlanRequiredRead',
      desc: 'FINANCE_PLAN_REQUIRED on a read: never held',
      args: [],
    );
  }

  /// `Suivi financier inclus`
  String get plansFinanceIncluded {
    return Intl.message(
      'Suivi financier inclus',
      name: 'plansFinanceIncluded',
      desc: 'M13 — a plan card, when includesFinance',
      args: [],
    );
  }

  /// `Choisis ta formule`
  String get plansHeroTitle {
    return Intl.message(
      'Choisis ta formule',
      name: 'plansHeroTitle',
      desc: 'M13 — the plans\' header',
      args: [],
    );
  }

  /// `Sans engagement, payée par Mobile Money. Elle ne se renouvelle jamais toute seule.`
  String get plansHeroBody {
    return Intl.message(
      'Sans engagement, payée par Mobile Money. Elle ne se renouvelle jamais toute seule.',
      name: 'plansHeroBody',
      desc: 'M13 — RM-M13-01, said before choosing',
      args: [],
    );
  }

  /// `Ta formule · jusqu'au {date}`
  String plansCurrentUntil(String date) {
    return Intl.message(
      'Ta formule · jusqu\'au $date',
      name: 'plansCurrentUntil',
      desc: 'M13 — the plan held, and its last day',
      args: [date],
    );
  }

  /// `FCFA / mois`
  String get plansPriceUnit {
    return Intl.message(
      'FCFA / mois',
      name: 'plansPriceUnit',
      desc: 'M13 — beside a plan\'s price, set large',
      args: [],
    );
  }

  /// `Unités de résidence illimitées`
  String get plansResidenceUnlimited {
    return Intl.message(
      'Unités de résidence illimitées',
      name: 'plansResidenceUnlimited',
      desc: 'M13 — a plan without a residence allowance',
      args: [],
    );
  }

  /// `Passer à {plan}`
  String plansSwitchTo(String plan) {
    return Intl.message(
      'Passer à $plan',
      name: 'plansSwitchTo',
      desc: 'M13 — a plan card\'s one action',
      args: [plan],
    );
  }

  /// `Une formule supérieure prend effet tout de suite.`
  String get plansUpgradeNote {
    return Intl.message(
      'Une formule supérieure prend effet tout de suite.',
      name: 'plansUpgradeNote',
      desc: 'M13 — RM-M13-04',
      args: [],
    );
  }

  /// `Historique`
  String get historyTab {
    return Intl.message(
      'Historique',
      name: 'historyTab',
      desc: 'M06 — the Favoris screen\'s second tab',
      args: [],
    );
  }

  /// `Aucune fiche consultée`
  String get historyEmptyTitle {
    return Intl.message(
      'Aucune fiche consultée',
      name: 'historyEmptyTitle',
      desc: 'M06 — the history is empty',
      args: [],
    );
  }

  /// `Les biens que tu ouvres s'affichent ici, les 30 derniers.`
  String get historyEmptyBody {
    return Intl.message(
      'Les biens que tu ouvres s\'affichent ici, les 30 derniers.',
      name: 'historyEmptyBody',
      desc: 'M06 — RM-M06-05',
      args: [],
    );
  }

  /// `Aujourd'hui`
  String get historyToday {
    return Intl.message(
      'Aujourd\'hui',
      name: 'historyToday',
      desc: 'M06 — a day heading',
      args: [],
    );
  }

  /// `Hier`
  String get historyYesterday {
    return Intl.message(
      'Hier',
      name: 'historyYesterday',
      desc: 'M06 — a day heading',
      args: [],
    );
  }

  /// `Vu à {time}`
  String historyViewedAt(String time) {
    return Intl.message(
      'Vu à $time',
      name: 'historyViewedAt',
      desc: 'M06 — when the fiche was opened',
      args: [time],
    );
  }

  /// `Plus disponible`
  String get historyUnavailable {
    return Intl.message(
      'Plus disponible',
      name: 'historyUnavailable',
      desc: 'M06 — the listing was deleted',
      args: [],
    );
  }

  /// `Effacer l'historique`
  String get settingsClearHistory {
    return Intl.message(
      'Effacer l\'historique',
      name: 'settingsClearHistory',
      desc: 'M06 — RM-M06-05, tenant settings',
      args: [],
    );
  }

  /// `Effacer la liste des biens que tu as consultés ? Tes favoris ne sont pas touchés.`
  String get settingsClearHistoryConfirm {
    return Intl.message(
      'Effacer la liste des biens que tu as consultés ? Tes favoris ne sont pas touchés.',
      name: 'settingsClearHistoryConfirm',
      desc: 'M06 — asked once more',
      args: [],
    );
  }

  /// `Historique effacé`
  String get historyCleared {
    return Intl.message(
      'Historique effacé',
      name: 'historyCleared',
      desc: 'M06 — toast',
      args: [],
    );
  }

  /// `L'historique n'a pas pu être effacé. Réessaie une fois connecté.`
  String get historyClearFailed {
    return Intl.message(
      'L\'historique n\'a pas pu être effacé. Réessaie une fois connecté.',
      name: 'historyClearFailed',
      desc: 'M06 — offline or refused',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I18n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
