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

class ComboRMatauangChangedEvent extends SimulbonCrudEvents {
  final ComboRMatauangModel comboRMatauang;
  const ComboRMatauangChangedEvent({required this.comboRMatauang});

  @override
  List<Object> get props => [comboRMatauang];
}

class SimulBonCrudInitValueEvent extends SimulbonCrudEvents {}

class HitungPremiBonEvent extends SimulbonCrudEvents {}

class FieldLamaCoverChangedEvent extends SimulbonCrudEvents {
  final int lama;

  const FieldLamaCoverChangedEvent({required this.lama});

  @override
  List<Object> get props => [lama];

}

class FieldNilaiKontrakChangedEvent extends SimulbonCrudEvents {
  final double nilaiKontrak;

  const FieldNilaiKontrakChangedEvent({required this.nilaiKontrak});

  @override
  List<Object> get props => [nilaiKontrak];
}

class FieldIsPelaksanaanChangedEvent extends SimulbonCrudEvents {
  final bool ya;

  const FieldIsPelaksanaanChangedEvent({required this.ya});

  @override
  List<Object> get props => [ya];
}

class FieldIsPemeliharaanChangedEvent extends SimulbonCrudEvents {
  final bool ya;

  const FieldIsPemeliharaanChangedEvent({required this.ya});

  @override
  List<Object> get props => [ya];
}

class FieldIsUangMukaChangedEvent extends SimulbonCrudEvents {
  final bool ya;

  const FieldIsUangMukaChangedEvent({required this.ya});

  @override
  List<Object> get props => [ya];
}

class FieldIsPenawaranChangedEvent extends SimulbonCrudEvents {
  final bool ya;

  const FieldIsPenawaranChangedEvent({required this.ya});

  @override
  List<Object> get props => [ya];
}

class FieldIsCarChangedEvent extends SimulbonCrudEvents {
  final bool ya;

  const FieldIsCarChangedEvent({required this.ya});

  @override
  List<Object> get props => [ya];
}

class FieldPelaksanaanPersenChangedEvent extends SimulbonCrudEvents {
  final double persen;

  const FieldPelaksanaanPersenChangedEvent({required this.persen});

  @override
  List<Object> get props => [persen];
}

class FieldPemeliharaanPersenChangedEvent extends SimulbonCrudEvents {
  final double persen;

  const FieldPemeliharaanPersenChangedEvent({required this.persen});

  @override
  List<Object> get props => [persen];
}

class FieldUangMukaPersenChangedEvent extends SimulbonCrudEvents {
  final double persen;

  const FieldUangMukaPersenChangedEvent({required this.persen});

  @override
  List<Object> get props => [persen];
}

class FieldPenawaranPersenChangedEvent extends SimulbonCrudEvents {
  final double persen;

  const FieldPenawaranPersenChangedEvent({required this.persen});

  @override
  List<Object> get props => [persen];
}

class FieldCarPersenChangedEvent extends SimulbonCrudEvents {
  final double persen;

  const FieldCarPersenChangedEvent({required this.persen});

  @override
  List<Object> get props => [persen];
}

