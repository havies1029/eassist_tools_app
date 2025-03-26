part of 'simulboncrud_bloc.dart';

abstract class SimulbonCrudEvents extends Equatable {
	const SimulbonCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulbonCrudTambahEvent extends SimulbonCrudEvents {
	final SimulbonCrudModel record;
	const SimulbonCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulbonCrudUbahEvent extends SimulbonCrudEvents {
	final SimulbonCrudModel record;
	const SimulbonCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulbonCrudHapusEvent extends SimulbonCrudEvents {
	final String recordId;
	const SimulbonCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulbonCrudLihatEvent extends SimulbonCrudEvents {
	final String recordId;
	const SimulbonCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimulbonCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];}

