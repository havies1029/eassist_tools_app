part of 'simuleeilist_bloc.dart';

abstract class SimuleeiListEvents extends Equatable {
	const SimuleeiListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimuleeiListEvent extends SimuleeiListEvents {}

class RefreshSimuleeiListEvent extends SimuleeiListEvents {
	final int hal;
	final String searchText;

	const RefreshSimuleeiListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimuleeiListEvent extends SimuleeiListEvents {
	final String recordId;

	const UbahSimuleeiListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimuleeiListEvent extends SimuleeiListEvents{}
class HapusSimuleeiListEvent extends SimuleeiListEvents{}
class CloseDialogSimuleeiListEvent extends SimuleeiListEvents{}
