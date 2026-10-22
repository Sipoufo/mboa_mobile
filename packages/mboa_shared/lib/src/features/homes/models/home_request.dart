import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../contracts/models/contract.dart';
import '../../profile/models/base_profile.dart';

/// What the tenant asks the landlord (CDC M30, RM-M30-09): a remark, a
/// problem to fix, a question. A maintenance request is what M28's tickets
/// will build on (RM-M30-10).
enum HomeRequestType {
  remark,
  maintenance,
  question;

  String get wire => switch (this) {
        HomeRequestType.remark => 'REMARK',
        HomeRequestType.maintenance => 'MAINTENANCE',
        HomeRequestType.question => 'QUESTION',
      };

  static HomeRequestType fromWire(String? name) => switch (name) {
        'MAINTENANCE' => HomeRequestType.maintenance,
        'QUESTION' => HomeRequestType.question,
        _ => HomeRequestType.remark,
      };
}

/// Where a request stands (RM-M30-09) — the server moves it; the screens
/// read `can*` for what may be done.
enum HomeRequestStatus {
  sent,

  /// The landlord's first look — nothing to call, the read sets it.
  seen,
  inProgress,
  resolved,

  /// Final.
  closed,
  unknown;

  String get wire => switch (this) {
        HomeRequestStatus.sent => 'SENT',
        HomeRequestStatus.seen => 'SEEN',
        HomeRequestStatus.inProgress => 'IN_PROGRESS',
        HomeRequestStatus.resolved => 'RESOLVED',
        HomeRequestStatus.closed => 'CLOSED',
        HomeRequestStatus.unknown => 'UNKNOWN',
      };

  static HomeRequestStatus fromWire(String? name) => switch (name) {
        'SENT' => HomeRequestStatus.sent,
        'SEEN' => HomeRequestStatus.seen,
        'IN_PROGRESS' => HomeRequestStatus.inProgress,
        'RESOLVED' => HomeRequestStatus.resolved,
        'CLOSED' => HomeRequestStatus.closed,
        _ => HomeRequestStatus.unknown,
      };

  /// Still the landlord's to act on: the inbox's.
  bool get isOpen =>
      this == HomeRequestStatus.sent || this == HomeRequestStatus.seen || this == HomeRequestStatus.inProgress;
}

/// One step of a request's history: who moved it, to where, with what word.
class HomeRequestStep extends Equatable {
  const HomeRequestStep({required this.status, this.byLandlord = false, this.note, this.at});

  final HomeRequestStatus status;
  final bool byLandlord;
  final String? note;
  final DateTime? at;

  @override
  List<Object?> get props => [status, byLandlord, note, at];
}

/// A request to the landlord. It lives in the property's thread (RM-M12-02):
/// Mboa writes its opening and each step there, and replies can be attached
/// to it.
class HomeRequest extends Equatable {
  const HomeRequest({
    required this.id,
    this.contractId,
    this.annonceTitle,
    this.tenant,
    this.conversationId,
    this.type = HomeRequestType.remark,
    this.title = '',
    this.description,
    this.status = HomeRequestStatus.unknown,
    this.photoKeys = const [],
    this.photoUrls = const [],
    this.history = const [],
    this.createdAt,
    this.updatedAt,
    this.canStart = false,
    this.canResolve = false,
    this.canClose = false,
    this.canReopen = false,
  });

  final String id;
  final String? contractId;
  final String? annonceTitle;
  final ContractParticipant? tenant;

  /// The property's thread, where its replies live.
  final String? conversationId;
  final HomeRequestType type;
  final String title;
  final String? description;
  final HomeRequestStatus status;
  final List<String> photoKeys;

  /// Short-lived links — the detail only.
  final List<String> photoUrls;

  /// Oldest first — the detail only.
  final List<HomeRequestStep> history;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// The landlord's.
  final bool canStart;
  final bool canResolve;

  /// The tenant's.
  final bool canClose;
  final bool canReopen;

  /// Its photos: the detail's links, else the public media keys.
  List<String> get photos =>
      photoUrls.isNotEmpty ? photoUrls : [for (final key in photoKeys) ?BaseProfile.mediaUrl(key)];

  static HomeRequest fromResponse(HomeRequestResponse response) => HomeRequest(
        id: response.id ?? '',
        contractId: response.contractId,
        annonceTitle: response.annonceTitle,
        tenant: response.tenant == null ? null : ContractParticipant.fromResponse(response.tenant!),
        conversationId: response.conversationId,
        type: HomeRequestType.fromWire(response.type?.name),
        title: response.title ?? '',
        description: _blank(response.description),
        status: HomeRequestStatus.fromWire(response.status?.name),
        photoKeys: response.photoKeys?.toList() ?? const [],
        photoUrls: response.photoUrls?.toList() ?? const [],
        history: [
          for (final step in response.history?.toList() ?? const <HomeRequestEventResponse>[])
            HomeRequestStep(
              status: HomeRequestStatus.fromWire(step.status?.name),
              byLandlord: step.byLandlord ?? false,
              note: _blank(step.note),
              at: step.at?.toLocal(),
            ),
        ],
        createdAt: response.createdAt?.toLocal(),
        updatedAt: response.updatedAt?.toLocal(),
        canStart: response.canStart ?? false,
        canResolve: response.canResolve ?? false,
        canClose: response.canClose ?? false,
        canReopen: response.canReopen ?? false,
      );

  /// What a list row draws, for the offline copy.
  Map<String, dynamic> toCache() => {
        'id': id,
        'contractId': contractId,
        'annonceTitle': annonceTitle,
        'tenant': tenant?.displayName,
        'type': type.name,
        'title': title,
        'status': status.name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  static HomeRequest? fromCache(Object? raw) {
    if (raw is! Map) return null;
    final json = Map<String, dynamic>.from(raw);
    final id = json['id'];
    if (id is! String) return null;
    DateTime? date(Object? value) => value is String ? DateTime.tryParse(value) : null;
    return HomeRequest(
      id: id,
      contractId: json['contractId'] as String?,
      annonceTitle: json['annonceTitle'] as String?,
      tenant: json['tenant'] is String ? ContractParticipant(displayName: json['tenant'] as String) : null,
      type: HomeRequestType.values.where((t) => t.name == json['type']).firstOrNull ?? HomeRequestType.remark,
      title: json['title'] as String? ?? '',
      status: HomeRequestStatus.values.where((s) => s.name == json['status']).firstOrNull ?? HomeRequestStatus.unknown,
      createdAt: date(json['createdAt']),
      updatedAt: date(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        contractId,
        annonceTitle,
        tenant,
        conversationId,
        type,
        title,
        description,
        status,
        photoKeys,
        photoUrls,
        history,
        createdAt,
        updatedAt,
        canStart,
        canResolve,
        canClose,
        canReopen,
      ];
}

String? _blank(String? value) => (value == null || value.trim().isEmpty) ? null : value.trim();
