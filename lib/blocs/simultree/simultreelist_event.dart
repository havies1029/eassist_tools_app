part of 'simultreelist_bloc.dart';

abstract class SimultreeListEvents extends Equatable {
	const SimultreeListEvents();

	@override
	List<Object> get props => [];
}

class FetchSimultreeListEvent extends SimultreeListEvents {}

class RefreshSimultreeListEvent extends SimultreeListEvents {
	final int hal;
	final String searchText;

	const RefreshSimultreeListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSimultreeListEvent extends SimultreeListEvents {
	final String recordId;

	const UbahSimultreeListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSimultreeListEvent extends SimultreeListEvents{}
class HapusSimultreeListEvent extends SimultreeListEvents{}
class CloseDialogSimultreeListEvent extends SimultreeListEvents{}
