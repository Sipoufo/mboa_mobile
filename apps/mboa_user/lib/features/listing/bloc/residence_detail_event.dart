part of 'residence_detail_bloc.dart';

sealed class ResidenceDetailEvent extends Equatable {
  const ResidenceDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Read it — on opening, and again from « Réessayer ».
class ResidenceRequested extends ResidenceDetailEvent {
  const ResidenceRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
