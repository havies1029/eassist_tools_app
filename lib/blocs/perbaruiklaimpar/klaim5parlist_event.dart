part of 'klaim5parlist_bloc.dart';

abstract class Klaim5parListEvents extends Equatable {
	const Klaim5parListEvents();

	@override
	List<Object> get props => [];
}

class FetchKlaim5parListEvent extends Klaim5parListEvents {}

class RefreshKlaim5parListEvent extends Klaim5parListEvents {
	final int hal;
	final String searchText;

	const RefreshKlaim5parListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahKlaim5parListEvent extends Klaim5parListEvents {
	final String recordId;

	const UbahKlaim5parListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahKlaim5parListEvent extends Klaim5parListEvents{}
class HapusKlaim5parListEvent extends Klaim5parListEvents{}
class CloseDialogKlaim5parListEvent extends Klaim5parListEvents{}
