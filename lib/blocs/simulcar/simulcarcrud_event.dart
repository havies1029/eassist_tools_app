part of 'simulcarcrud_bloc.dart';

abstract class SimulcarCrudEvents extends Equatable {
	const SimulcarCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulcarCrudTambahEvent extends SimulcarCrudEvents {
	final SimulcarCrudModel record;
	const SimulcarCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulcarCrudUbahEvent extends SimulcarCrudEvents {
	final SimulcarCrudModel record;
	const SimulcarCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulcarCrudHapusEvent extends SimulcarCrudEvents {
	final String recordId;
	const SimulcarCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulcarCrudLihatEvent extends SimulcarCrudEvents {
	final String recordId;
	const SimulcarCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimulcarCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];}

