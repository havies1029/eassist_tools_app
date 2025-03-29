part of 'simulgiscrud_bloc.dart';

abstract class SimulgisCrudEvents extends Equatable {
	const SimulgisCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulgisCrudTambahEvent extends SimulgisCrudEvents {
	final SimulgisCrudModel record;
	const SimulgisCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulgisCrudUbahEvent extends SimulgisCrudEvents {
	final SimulgisCrudModel record;
	const SimulgisCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulgisCrudHapusEvent extends SimulgisCrudEvents {
	final String recordId;
	const SimulgisCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulgisCrudLihatEvent extends SimulgisCrudEvents {
	final String recordId;
	const SimulgisCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimulgisCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];
}

class SimulGisCrudInitValueEvent extends SimulgisCrudEvents{}

class HitungPremiGisEvent extends SimulgisCrudEvents{}
