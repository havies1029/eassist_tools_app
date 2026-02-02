part of 'regklaim1list_bloc.dart';

abstract class Regklaim1ListEvents extends Equatable {
	const Regklaim1ListEvents();

	@override
	List<Object> get props => [];
}

class FetchRegklaim1ListEvent extends Regklaim1ListEvents {}

class RefreshRegklaim1ListEvent extends Regklaim1ListEvents {
	final int hal;
	final String searchText;

	const RefreshRegklaim1ListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahRegklaim1ListEvent extends Regklaim1ListEvents {
	final String recordId;

	const UbahRegklaim1ListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahRegklaim1ListEvent extends Regklaim1ListEvents{}
class HapusRegklaim1ListEvent extends Regklaim1ListEvents{}
class CloseDialogRegklaim1ListEvent extends Regklaim1ListEvents{}
