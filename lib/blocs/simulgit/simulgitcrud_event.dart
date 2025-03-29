part of 'simulgitcrud_bloc.dart';

abstract class SimulgitCrudEvents extends Equatable {
	const SimulgitCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulgitCrudTambahEvent extends SimulgitCrudEvents {
	final SimulgitCrudModel record;
	const SimulgitCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulgitCrudUbahEvent extends SimulgitCrudEvents {
	final SimulgitCrudModel record;
	const SimulgitCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulgitCrudHapusEvent extends SimulgitCrudEvents {
	final String recordId;
	const SimulgitCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulgitCrudLihatEvent extends SimulgitCrudEvents {
	final String recordId;
	const SimulgitCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimulgitCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];
}

class SimulGitCrudInitValueEvent extends SimulgitCrudEvents{}

class HitungPremiGitEvent extends SimulgitCrudEvents{}

