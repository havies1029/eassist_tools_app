part of 'mcobklaimcari_bloc.dart';

abstract class McobklaimCariEvents extends Equatable {
	const McobklaimCariEvents();

	@override
	List<Object> get props => [];
}

class FetchMcobklaimCariEvent extends McobklaimCariEvents {}

class RefreshMcobklaimCariEvent extends McobklaimCariEvents {}

