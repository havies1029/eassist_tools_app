part of 'simulmblist_bloc.dart';

abstract class SimulmbListEvents extends Equatable {
	const SimulmbListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulmbListEvent extends SimulmbListEvents {}

class RefreshSimulmbListEvent extends SimulmbListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulmbListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulmbListEvent extends SimulmbListEvents {
	final String recordId;

	const UbahSimulmbListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulmbListEvent extends SimulmbListEvents{}
class HapusSimulmbListEvent extends SimulmbListEvents{}
class CloseDialogSimulmbListEvent extends SimulmbListEvents{}
