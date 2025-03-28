part of 'simulgitlist_bloc.dart';

abstract class SimulgitListEvents extends Equatable {
	const SimulgitListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimulgitListEvent extends SimulgitListEvents {}

class RefreshSimulgitListEvent extends SimulgitListEvents {
	final int hal;
	final String searchText;

	const RefreshSimulgitListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimulgitListEvent extends SimulgitListEvents {
	final String recordId;

	const UbahSimulgitListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimulgitListEvent extends SimulgitListEvents{}
class HapusSimulgitListEvent extends SimulgitListEvents{}
class CloseDialogSimulgitListEvent extends SimulgitListEvents{}
