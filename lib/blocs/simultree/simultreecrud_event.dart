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

class FieldBulanChangedEvent extends SimultreeCrudEvents {
	final int bulan;
	const FieldBulanChangedEvent({required this.bulan});

	@override
	List<Object> get props => [bulan];

}

class FieldTSIChangedEvent extends SimultreeCrudEvents {
	final double tsi;
	const FieldTSIChangedEvent({required this.tsi});

	@override
	List<Object> get props => [tsi];
}

class FieldRateChangedEvent extends SimultreeCrudEvents {
	final double rate;
	const FieldRateChangedEvent({required this.rate});

	@override
	List<Object> get props => [rate];
}

class SimultreeCrudInitValueEvent extends SimultreeCrudEvents{}

class HitungPremitreeEvent extends SimultreeCrudEvents{}



