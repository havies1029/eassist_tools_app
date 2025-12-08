part of 'dnrekapcobcari_bloc.dart';

abstract class DnrekapcobCariEvents extends Equatable {
	const DnrekapcobCariEvents();

	@override
	List<Object> get props => [];
}

class FetchDnrekapcobCariEvent extends DnrekapcobCariEvents {}

class RefreshDnrekapcobCariEvent extends DnrekapcobCariEvents {}

