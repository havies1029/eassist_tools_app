part of 'simulcargolist_bloc.dart';

abstract class SimulcargoListEvents extends Equatable {
	const SimulcargoListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulcargoListEvent extends SimulcargoListEvents {}

class RefreshSimulcargoListEvent extends SimulcargoListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulcargoListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulcargoListEvent extends SimulcargoListEvents {
	final String recordId;

	const UbahSimulcargoListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulcargoListEvent extends SimulcargoListEvents{}
class HapusSimulcargoListEvent extends SimulcargoListEvents{}
class CloseDialogSimulcargoListEvent extends SimulcargoListEvents{}
