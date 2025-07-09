part of 'asetmvcari_bloc.dart';

abstract class AsetMvCariEvents extends Equatable {
	const AsetMvCariEvents();

	@override
	List<Object> get props => [];
}

class FetchAsetMvCariEvent extends AsetMvCariEvents {}

class RefreshAsetMvCariEvent extends AsetMvCariEvents {
	final String searchText;

	const RefreshAsetMvCariEvent({required this.searchText});

	@override
	List<Object> get props => [searchText];
}

