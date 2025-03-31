part of 'simulcargocrud_bloc.dart';

abstract class SimulcargoCrudEvents extends Equatable {
	const SimulcargoCrudEvents();

	@override
	List<Object> get props => [];
}

class SimulcargoCrudTambahEvent extends SimulcargoCrudEvents {
	final SimulcargoCrudModel record;
	const SimulcargoCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulcargoCrudUbahEvent extends SimulcargoCrudEvents {
	final SimulcargoCrudModel record;
	const SimulcargoCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimulcargoCrudHapusEvent extends SimulcargoCrudEvents {
	final String recordId;
	const SimulcargoCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimulcargoCrudLihatEvent extends SimulcargoCrudEvents {
	final String recordId;
	const SimulcargoCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboMMopChangedEvent extends SimulcargoCrudEvents{
	final ComboMMopModel comboMMop;
	const ComboMMopChangedEvent({required this.comboMMop});

	@override	List<Object> get props => [comboMMop];
}

class ComboMConveyByChangedEvent extends SimulcargoCrudEvents{
	final ComboMConveybyModel comboMConveyBy;
	const ComboMConveyByChangedEvent({required this.comboMConveyBy});

	@override	List<Object> get props => [comboMConveyBy];
}

class ComboMConveyDetailChangedEvent extends SimulcargoCrudEvents{
	final ComboMConveyDetailModel comboMConveyDetail;
	const ComboMConveyDetailChangedEvent({required this.comboMConveyDetail});

	@override	List<Object> get props => [comboMConveyDetail];
}

class SimulCargoCrudInitValueEvent extends SimulcargoCrudEvents{}

class HitungPremiCargoEvent extends SimulcargoCrudEvents{}

class ComboRMatauangChangedEvent extends SimulcargoCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];
}