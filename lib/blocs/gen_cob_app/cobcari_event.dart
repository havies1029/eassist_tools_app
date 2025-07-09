part of 'cobcari_bloc.dart';

abstract class CobCariEvents extends Equatable {
	const CobCariEvents();

	@override
	List<Object> get props => [];
}

class FetchCobCariEvent extends CobCariEvents {}

class RefreshCobCariEvent extends CobCariEvents {}

