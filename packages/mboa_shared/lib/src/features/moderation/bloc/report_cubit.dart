import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/report_repository.dart';
import '../models/report_target.dart';

sealed class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportIdle extends ReportState {
  const ReportIdle();
}

class ReportSending extends ReportState {
  const ReportSending();
}

/// RM-M23-05 — received, and that is all the reporter is ever told.
class ReportSent extends ReportState {
  const ReportSent();
}

class ReportFailed extends ReportState {
  const ReportFailed({this.alreadyReported = false});

  /// Already in the team's hands — said as such, not as an error to retry.
  final bool alreadyReported;

  @override
  List<Object?> get props => [alreadyReported];
}

/// Sending one report (CDC M23).
///
/// A cubit rather than a bloc: there is one action, it takes its arguments
/// with it, and there is no state to accumulate between them. Sealed events
/// would be ceremony around a single verb.
class ReportCubit extends Cubit<ReportState> {
  ReportCubit({required ReportRepository repository})
      : _repository = repository,
        super(const ReportIdle());

  final ReportRepository _repository;

  Future<void> send(
    ReportTarget target, {
    required ReportReason reason,
    String? comment,
  }) async {
    if (state is ReportSending) return;
    emit(const ReportSending());

    try {
      await _repository.report(target, reason: reason, comment: comment);
      emit(const ReportSent());
    } on AlreadyReported {
      emit(const ReportFailed(alreadyReported: true));
    } catch (_) {
      emit(const ReportFailed());
    }
  }
}
