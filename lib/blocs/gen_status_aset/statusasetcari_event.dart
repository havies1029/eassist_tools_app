part of 'statusasetcari_bloc.dart';

abstract class StatusAsetCariEvents extends Equatable {
	const StatusAsetCariEvents();

	@override
	List<Object> get props => [];
}

class FetchStatusAsetCariEvent extends StatusAsetCariEvents {}

class RefreshStatusAsetCariEvent extends StatusAsetCariEvents {}

