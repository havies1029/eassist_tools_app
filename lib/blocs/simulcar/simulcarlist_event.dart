part of 'simulcarlist_bloc.dart';

abstract class SimulcarListEvents extends Equatable {
	const SimulcarListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulcarListEvent extends SimulcarListEvents {}

class RefreshSimulcarListEvent extends SimulcarListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulcarListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulcarListEvent extends SimulcarListEvents {
	final String recordId;

	const UbahSimulcarListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulcarListEvent extends SimulcarListEvents{}
class HapusSimulcarListEvent extends SimulcarListEvents{}
class CloseDialogSimulcarListEvent extends SimulcarListEvents{}
