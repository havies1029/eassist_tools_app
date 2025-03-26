part of 'simulwplist_bloc.dart';

abstract class SimulwpListEvents extends Equatable {
	const SimulwpListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulwpListEvent extends SimulwpListEvents {}

class RefreshSimulwpListEvent extends SimulwpListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulwpListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulwpListEvent extends SimulwpListEvents {
	final String recordId;

	const UbahSimulwpListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulwpListEvent extends SimulwpListEvents{}
class HapusSimulwpListEvent extends SimulwpListEvents{}
class CloseDialogSimulwpListEvent extends SimulwpListEvents{}
