part of 'asetparcari_bloc.dart';

abstract class AsetParCariEvents extends Equatable {
	const AsetParCariEvents();

	@override
	List<Object> get props => [];
}

class FetchAsetParCariEvent extends AsetParCariEvents {}

class RefreshAsetParCariEvent extends AsetParCariEvents {
  final String searchText;

  const RefreshAsetParCariEvent({required this.searchText});

  @override
  List<Object> get props => [searchText];
}

