part of 'simuleeicrud_bloc.dart';

abstract class SimuleeiCrudEvents extends Equatable {
	const SimuleeiCrudEvents();

	@override
	List<Object> get props => [];
}

class SimuleeiCrudTambahEvent extends SimuleeiCrudEvents {
	final SimuleeiCrudModel record;
	const SimuleeiCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimuleeiCrudUbahEvent extends SimuleeiCrudEvents {
	final SimuleeiCrudModel record;
	const SimuleeiCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class SimuleeiCrudHapusEvent extends SimuleeiCrudEvents {
	final String recordId;
	const SimuleeiCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class SimuleeiCrudLihatEvent extends SimuleeiCrudEvents {
	final String recordId;
	const SimuleeiCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboRMatauangChangedEvent extends SimuleeiCrudEvents{
	final ComboRMatauangModel comboRMatauang;
	const ComboRMatauangChangedEvent({required this.comboRMatauang});

	@override	List<Object> get props => [comboRMatauang];
}

class SimuleeiCrudInitValueEvent extends SimuleeiCrudEvents {}

class FieldBulanChangedEvent extends SimuleeiCrudEvents {
  final int bulan;
  const FieldBulanChangedEvent({required this.bulan});

  @override
  List<Object> get props => [bulan];

}

class FieldTSIChangedEvent extends SimuleeiCrudEvents {
  final double tsi;
  const FieldTSIChangedEvent({required this.tsi});

  @override
  List<Object> get props => [tsi];
}

class FieldRateChangedEvent extends SimuleeiCrudEvents {
  final double rate;
  const FieldRateChangedEvent({required this.rate});

  @override
  List<Object> get props => [rate];
}


class HitungPremiEEIEvent extends SimuleeiCrudEvents{}