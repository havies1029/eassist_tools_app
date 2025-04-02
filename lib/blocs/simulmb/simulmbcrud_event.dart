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


class FieldBulanChangedEvent extends SimulmbCrudEvents {
	final int bulan;
	const FieldBulanChangedEvent({required this.bulan});

	@override
	List<Object> get props => [bulan];

}

class FieldTSIChangedEvent extends SimulmbCrudEvents {
	final double tsi;
	const FieldTSIChangedEvent({required this.tsi});

	@override
	List<Object> get props => [tsi];
}

class FieldRateChangedEvent extends SimulmbCrudEvents {
	final double rate;
	const FieldRateChangedEvent({required this.rate});

	@override
	List<Object> get props => [rate];
}

class SimulMbCrudInitValueEvent extends SimulmbCrudEvents{}

class HitungPremiMbEvent extends SimulmbCrudEvents{}