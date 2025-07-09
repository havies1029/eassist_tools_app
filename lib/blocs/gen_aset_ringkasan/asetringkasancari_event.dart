part of 'asetringkasancari_bloc.dart';

abstract class AsetRingkasanCariEvents extends Equatable {
	const AsetRingkasanCariEvents();

	@override
	List<Object> get props => [];
}

class FetchAsetRingkasanCariEvent extends AsetRingkasanCariEvents {}

class RefreshAsetRingkasanCariEvent extends AsetRingkasanCariEvents {
	final String searchText;

	const RefreshAsetRingkasanCariEvent({required this.searchText});

	@override
	List<Object> get props => [searchText];
}

