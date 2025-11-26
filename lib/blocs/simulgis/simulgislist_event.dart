part of 'simulgislist_bloc.dart';

abstract class SimulgisListEvents extends Equatable {
	const SimulgisListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulgisListEvent extends SimulgisListEvents {}

class RefreshSimulgisListEvent extends SimulgisListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulgisListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulgisListEvent extends SimulgisListEvents {
	final String recordId;

	const UbahSimulgisListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulgisListEvent extends SimulgisListEvents{}
class HapusSimulgisListEvent extends SimulgisListEvents{}
class CloseDialogSimulgisListEvent extends SimulgisListEvents{}
