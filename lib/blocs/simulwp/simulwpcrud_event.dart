part of 'simulwpcrud_bloc.dart';

abstract class SimulwpCrudEvents extends Equatable {
	const SimulwpCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulwpCrudTambahEvent extends SimulwpCrudEvents {
	final SimulwpCrudModel record;
	const SimulwpCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulwpCrudUbahEvent extends SimulwpCrudEvents {
	final SimulwpCrudModel record;
	const SimulwpCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulwpCrudHapusEvent extends SimulwpCrudEvents {
	final String recordId;
	const SimulwpCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulwpCrudLihatEvent extends SimulwpCrudEvents {
	final String recordId;
	const SimulwpCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimulwpCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];
}

class SimulWpCrudInitValueEvent extends SimulwpCrudEvents{}

class HitungPremiWpEvent extends SimulwpCrudEvents{}


