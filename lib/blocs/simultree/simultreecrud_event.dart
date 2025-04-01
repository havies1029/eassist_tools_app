part of 'simultreecrud_bloc.dart';

abstract class SimultreeCrudEvents extends Equatable {
	const SimultreeCrudEvents();

	@override
	List<Object> get props => [];
}

class SimultreeCrudTambahEvent extends SimultreeCrudEvents {
	final SimultreeCrudModel record;
	const SimultreeCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimultreeCrudUbahEvent extends SimultreeCrudEvents {
	final SimultreeCrudModel record;
	const SimultreeCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimultreeCrudHapusEvent extends SimultreeCrudEvents {
	final String recordId;
	const SimultreeCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimultreeCrudLihatEvent extends SimultreeCrudEvents {
	final String recordId;
	const SimultreeCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimultreeCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];}

