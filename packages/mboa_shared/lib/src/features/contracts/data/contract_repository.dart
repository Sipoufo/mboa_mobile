import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/contract.dart';

/// The Contrat Mboa (CDC M08), from either side.
///
/// Shared because the two parties call the **same** endpoints: the landlord
/// sends and answers objections, the tenant accepts and contests, and both
/// sign. The server decides who may do what — `awaiting` and `canSign` say so
/// — which is why nothing here branches on a role.
class ContractRepository {
  ContractRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 50;

  ContratsApi get _api => _dioClient.api.getContratsApi();

  /// Every contract the account is party to, as landlord or as tenant.
  Future<List<Contract>> list({ContractStatus? status}) async {
    final response = await _api.listMyContracts(
      status: status == null ? null : _statusParam(status),
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <ContractResponse>[])
        .map(Contract.fromResponse)
        .toList();
  }

  Future<Contract> one(String id) async {
    final response = await _api.getContract(id: id);
    final data = response.data;
    if (data == null) throw StateError('Contract $id not found');
    return Contract.fromResponse(data);
  }

  /// RM-M08-01 — only the prestataire may draw one up.
  ///
  /// CE-M08-01: when the tenant has no Mboa account the server sends an SMS
  /// invitation and **refuses to create the contract**, so a failure here can
  /// be an invitation rather than an error — the screen reads the error code.
  Future<Contract> create(ContractTerms terms) async {
    final response = await _api.createContract(
      createContractRequest: CreateContractRequest((b) => b
        ..annonceId = terms.annonceId
        ..tenantAccountId = terms.tenantAccountId
        ..tenantPhone = terms.tenantPhone
        ..price = terms.price
        ..rentalPeriod = terms.rentalPeriod.asContractCreate
        ..depositAmount = terms.depositAmount
        ..chargesIncluded = terms.chargesIncluded
        ..startDate = terms.startDate?.toDate()
        ..durationUnits = terms.durationUnits
        ..tacitRenewal = terms.tacitRenewal),
    );
    final data = response.data;
    if (data == null) throw StateError('create returned no contract');
    return Contract.fromResponse(data);
  }

  /// RM-M08-08 — amending is refused once the tenant has accepted, which the
  /// server enforces; the app hides the action but never relies on that alone.
  Future<Contract> amend(String id, ContractTerms terms) async {
    final response = await _api.updateContract(
      id: id,
      updateContractRequest: UpdateContractRequest((b) => b
        ..price = terms.price
        ..rentalPeriod = terms.rentalPeriod.asContractUpdate
        ..depositAmount = terms.depositAmount
        ..chargesIncluded = terms.chargesIncluded
        ..startDate = terms.startDate?.toDate()
        ..durationUnits = terms.durationUnits
        ..tacitRenewal = terms.tacitRenewal),
    );
    final data = response.data;
    if (data == null) throw StateError('amend returned no contract');
    return Contract.fromResponse(data);
  }

  /// Sends the draft to the tenant for signature (N-07).
  Future<Contract> send(String id) async =>
      _unwrap(await _api.sendContract(id: id), 'send');

  /// The tenant's move: accepting opens signing for both.
  Future<Contract> accept(String id) async =>
      _unwrap(await _api.acceptContract(id: id), 'accept');

  /// RM-M08-03 — the second signature locks it for good.
  ///
  /// [sessionId] is the only thing the request carries: the confirmation Doc 10
  /// asks for is a local gesture, and what reaches the server is the session it
  /// was made in.
  Future<Contract> sign(String id, {String? sessionId}) async => _unwrap(
        await _api.signContract(
          id: id,
          signContractRequest:
              SignContractRequest((b) => b..sessionId = sessionId),
        ),
        'sign',
      );

  /// CE-M08-03 — the tenant contests, naming the terms.
  Future<Contract> requestChanges(
    String id, {
    required String comment,
    List<ContestedTerm> terms = const [],
  }) async =>
      _unwrap(
        await _api.requestContractChanges(
          id: id,
          requestChangesRequest: RequestChangesRequest((b) => b
            ..comment = comment
            ..contestedTerms = ListBuilder<RequestChangesRequestContestedTermsEnum>(
              terms.map(_contestedParam),
            )),
        ),
        'requestChanges',
      );

  /// CE-M08-03 — one answer per objection, amended or not.
  Future<Contract> respondToChange(
    String id, {
    required String changeId,
    required String body,
  }) async =>
      _unwrap(
        await _api.respondToContractChange(
          id: id,
          changeId: changeId,
          respondToChangeRequest:
              RespondToChangeRequest((b) => b..body = body),
        ),
        'respondToChange',
      );

  /// Either party, up to the second signature.
  Future<void> cancel(String id) => _api.cancelContract(id: id);

  /// CA-M08-01 — a short-lived URL for the signed PDF.
  Future<String> pdfUrl(String id) async {
    final response = await _api.getContractPdf(id: id);
    final url = response.data?.downloadUrl;
    if (url == null || url.isEmpty) throw StateError('no PDF for $id');
    return url;
  }

  Contract _unwrap(Response<ContractResponse> response, String action) {
    final data = response.data;
    if (data == null) throw StateError('$action returned no contract');
    return Contract.fromResponse(data);
  }

  static BuiltList<String> _statusParam(ContractStatus status) =>
      BuiltList<String>([
        switch (status) {
          ContractStatus.draft => 'DRAFT',
          ContractStatus.sent => 'SENT',
          ContractStatus.changesRequested => 'CHANGES_REQUESTED',
          ContractStatus.accepted => 'ACCEPTED',
          ContractStatus.signed => 'SIGNED',
          ContractStatus.cancelled => 'CANCELLED',
          ContractStatus.unknown => '',
        },
      ]);

  static RequestChangesRequestContestedTermsEnum _contestedParam(
    ContestedTerm term,
  ) =>
      switch (term) {
        ContestedTerm.price => RequestChangesRequestContestedTermsEnum.PRICE,
        ContestedTerm.rentalPeriod =>
          RequestChangesRequestContestedTermsEnum.RENTAL_PERIOD,
        ContestedTerm.depositAmount =>
          RequestChangesRequestContestedTermsEnum.DEPOSIT_AMOUNT,
        ContestedTerm.chargesIncluded =>
          RequestChangesRequestContestedTermsEnum.CHARGES_INCLUDED,
        ContestedTerm.startDate =>
          RequestChangesRequestContestedTermsEnum.START_DATE,
        ContestedTerm.durationUnits =>
          RequestChangesRequestContestedTermsEnum.DURATION_UNITS,
        ContestedTerm.tacitRenewal =>
          RequestChangesRequestContestedTermsEnum.TACIT_RENEWAL,
      };
}
