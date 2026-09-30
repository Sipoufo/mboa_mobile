part of 'listing_detail_bloc.dart';

sealed class ListingDetailEvent extends Equatable {
  const ListingDetailEvent();

  @override
  List<Object?> get props => [];
}

class ListingRequested extends ListingDetailEvent {
  const ListingRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class ListingRefreshed extends ListingDetailEvent {
  const ListingRefreshed();
}
