part of 'simulmbcrud_bloc.dart';

abstract class SimulmbCrudEvents extends Equatable {
	const SimulmbCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulmbCrudTambahEvent extends SimulmbCrudEvents {
	final SimulmbCrudModel record;
	const SimulmbCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulmbCrudUbahEvent extends SimulmbCrudEvents {
	final SimulmbCrudModel record;
	const SimulmbCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulmbCrudHapusEvent extends SimulmbCrudEvents {
	final String recordId;
	const SimulmbCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulmbCrudLihatEvent extends SimulmbCrudEvents {
	final String recordId;
	const SimulmbCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimulmbCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];}

