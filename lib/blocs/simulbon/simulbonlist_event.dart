part of 'simulbonlist_bloc.dart';

abstract class SimulbonListEvents extends Equatable {
	const SimulbonListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulbonListEvent extends SimulbonListEvents {}

class RefreshSimulbonListEvent extends SimulbonListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulbonListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulbonListEvent extends SimulbonListEvents {
	final String recordId;

	const UbahSimulbonListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulbonListEvent extends SimulbonListEvents{}
class HapusSimulbonListEvent extends SimulbonListEvents{}
class CloseDialogSimulbonListEvent extends SimulbonListEvents{}
