import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api_error.dart';
import '../../../api/otp_guard.dart';
import '../data/account_repository.dart';

/// §40 A — adding or changing the account's email (App Mboa): the address,
/// then its code — and the phone's, when the account has a phone (the
/// server checks it is the owner asking).
class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  ChangeEmailBloc({required AccountRepository repository})
      : _repository = repository,
        super(const ChangeEmailEnterAddress()) {
    on<ChangeEmailRequested>(_onRequested);
    on<ChangeEmailResent>(_onResent);
    on<ChangeEmailConfirmed>(_onConfirmed);
  }

  final AccountRepository _repository;

  String? _email;
  bool _withPhoneCode = false;

  Future<void> _onRequested(ChangeEmailRequested event, Emitter<ChangeEmailState> emit) async {
    _email = event.newEmail;
    _withPhoneCode = event.hasPhone;
    emit(const ChangeEmailEnterAddress(loading: true));
    try {
      await _repository.requestEmailChange(event.newEmail);
      emit(ChangeEmailEnterCodes(newEmail: event.newEmail, withPhoneCode: event.hasPhone));
    } catch (error) {
      emit(ChangeEmailEnterAddress(error: _requestError(error)));
    }
  }

  Future<void> _onResent(ChangeEmailResent event, Emitter<ChangeEmailState> emit) async {
    final email = _email;
    if (email == null) return;
    emit(ChangeEmailEnterCodes(newEmail: email, withPhoneCode: _withPhoneCode, loading: true));
    try {
      await _repository.requestEmailChange(email);
      emit(ChangeEmailEnterCodes(newEmail: email, withPhoneCode: _withPhoneCode, justResent: true));
    } catch (_) {
      emit(ChangeEmailEnterCodes(newEmail: email, withPhoneCode: _withPhoneCode, error: ChangeEmailError.requestFailed));
    }
  }

  Future<void> _onConfirmed(ChangeEmailConfirmed event, Emitter<ChangeEmailState> emit) async {
    final email = _email;
    if (email == null) return;
    emit(ChangeEmailEnterCodes(newEmail: email, withPhoneCode: _withPhoneCode, loading: true));
    try {
      await _repository.confirmEmailChange(newEmail: email, oldCode: event.phoneCode, newCode: event.emailCode);
      emit(const ChangeEmailSuccess());
    } on OtpCodeBurnt {
      emit(ChangeEmailEnterCodes(newEmail: email, withPhoneCode: _withPhoneCode, error: ChangeEmailError.codeBurnt));
    } catch (_) {
      emit(ChangeEmailEnterCodes(newEmail: email, withPhoneCode: _withPhoneCode, error: ChangeEmailError.invalidCode));
    }
  }

  /// The refusals about the address, said under it; anything else is a
  /// failure to retry.
  static ChangeEmailError _requestError(Object error) {
    final api = ApiError.from(error);
    if (api.hasCode('EMAIL_UNCHANGED')) return ChangeEmailError.unchanged;
    if (api.hasCode('EMAIL_ALREADY_USED')) return ChangeEmailError.alreadyUsed;
    return ChangeEmailError.requestFailed;
  }
}

sealed class ChangeEmailEvent extends Equatable {
  const ChangeEmailEvent();

  @override
  List<Object?> get props => [];
}

/// The new address; [hasPhone] says whether the phone gets a code too.
final class ChangeEmailRequested extends ChangeEmailEvent {
  const ChangeEmailRequested({required this.newEmail, required this.hasPhone});

  final String newEmail;
  final bool hasPhone;

  @override
  List<Object?> get props => [newEmail, hasPhone];
}

final class ChangeEmailResent extends ChangeEmailEvent {
  const ChangeEmailResent();
}

final class ChangeEmailConfirmed extends ChangeEmailEvent {
  const ChangeEmailConfirmed({required this.emailCode, this.phoneCode});

  final String emailCode;

  /// Null when the account has no phone.
  final String? phoneCode;

  @override
  List<Object?> get props => [emailCode, phoneCode];
}

enum ChangeEmailError {
  requestFailed,

  /// `EMAIL_UNCHANGED` — it is already the account's.
  unchanged,

  /// `EMAIL_ALREADY_USED` — another account holds it, whatever its case.
  alreadyUsed,
  invalidCode,

  /// Three wrong tries, or expired: only new codes help.
  codeBurnt,
}

sealed class ChangeEmailState extends Equatable {
  const ChangeEmailState();

  @override
  List<Object?> get props => [];
}

final class ChangeEmailEnterAddress extends ChangeEmailState {
  const ChangeEmailEnterAddress({this.loading = false, this.error});

  final bool loading;
  final ChangeEmailError? error;

  @override
  List<Object?> get props => [loading, error];
}

final class ChangeEmailEnterCodes extends ChangeEmailState {
  const ChangeEmailEnterCodes({
    required this.newEmail,
    required this.withPhoneCode,
    this.loading = false,
    this.error,
    this.justResent = false,
  });

  final String newEmail;
  final bool withPhoneCode;
  final bool loading;
  final ChangeEmailError? error;
  final bool justResent;

  @override
  List<Object?> get props => [newEmail, withPhoneCode, loading, error, justResent];
}

final class ChangeEmailSuccess extends ChangeEmailState {
  const ChangeEmailSuccess();
}
