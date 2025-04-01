import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulbon/simulboncrud_model.dart';
import 'package:eassist_tools_app/repositories/simulbon/simulboncrud_repository.dart';

part 'simulboncrud_event.dart';
part 'simulboncrud_state.dart';

class SimulbonCrudBloc extends Bloc<SimulbonCrudEvents, SimulbonCrudState> {
  final SimulbonCrudRepository repository;
  SimulbonCrudBloc({required this.repository})
      : super(const SimulbonCrudState()) {
    on<SimulbonCrudUbahEvent>(onUbahSimulbonCrud);
    on<SimulbonCrudTambahEvent>(onTambahSimulbonCrud);
    on<SimulbonCrudHapusEvent>(onHapusSimulbonCrud);
    on<SimulbonCrudLihatEvent>(onLihatSimulbonCrud);
    on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
    on<SimulBonCrudInitValueEvent>(onSimulBonCrudInitValueEvent);
    on<HitungPremiBonEvent>(onHitungPremiBonEvent);
    on<FieldLamaCoverChangedEvent>(onFieldLamaCoverChangedEvent);
    on<FieldNilaiKontrakChangedEvent>(onFieldNilaiKontrakChangedEvent);
    on<FieldIsPelaksanaanChangedEvent>(onFieldIsPelaksanaanChangedEvent);
    on<FieldIsPemeliharaanChangedEvent>(onFieldIsPemeliharaanChangedEvent);
    on<FieldIsUangMukaChangedEvent>(onFieldIsUangMukaChangedEvent);
    on<FieldIsPenawaranChangedEvent>(onFieldIsPenawaranChangedEvent);
    on<FieldIsCarChangedEvent>(onFieldIsCarChangedEvent);
    on<FieldPelaksanaanPersenChangedEvent>(
        onFieldPelaksanaanPersenChangedEvent);
    on<FieldPemeliharaanPersenChangedEvent>(
        onFieldPemeliharaanPersenChangedEvent);
    on<FieldUangMukaPersenChangedEvent>(onFieldUangMukaPersenChangedEvent);
    on<FieldPenawaranPersenChangedEvent>(onFieldPenawaranPersenChangedEvent);
    on<FieldCarPersenChangedEvent>(onFieldCarPersenChangedEvent);
  }

  Future<void> onTambahSimulbonCrud(
      SimulbonCrudTambahEvent event, Emitter<SimulbonCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.simulbonCrudTambah(event.record);
    hasFailure = !returnData.success;
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahSimulbonCrud(
      SimulbonCrudUbahEvent event, Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.simulbonCrudUbah(event.record);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusSimulbonCrud(
      SimulbonCrudHapusEvent event, Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.simulbonCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatSimulbonCrud(
      SimulbonCrudLihatEvent event, Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record =
        await repository.simulbonCrudLihat(event.recordId);
    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onComboRMatauangChanged(
      ComboRMatauangChangedEvent event, Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboRMatauangModel comboRMatauang = event.comboRMatauang;
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    record.currDesc = comboRMatauang.rmatauangSimbol;

    emit(state.copyWith(
        isLoading: false, isLoaded: true, comboRMatauang: comboRMatauang));
  }

  Future<void> onSimulBonCrudInitValueEvent(
      SimulBonCrudInitValueEvent event, Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulbonCrudModel record = await repository.simulBonCrudInitValue();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboRMatauang: record.comboRMatauang));
  }

  Future<void> onHitungPremiBonEvent(
      HitungPremiBonEvent event, Emitter<SimulbonCrudState> emit) async {
    debugPrint("onHitungPremiBonEvent");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ReturnDataAPI returnData;
    bool isValid = true;
    List<String> errors = [];
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();

    if ((record.coverBulan == null) || (record.coverBulan == 0)) {
      isValid = false;
      errors.add("Field 'Lama Cover' harus >= 1 bulan");
    }

    if (record.kontrakNilai == null || record.kontrakNilai == 0) {
      isValid = false;
      errors.add("Field 'Nilai Kontrak' harus > 0.");
    }

    if (isValid) {
      returnData = await repository.simulBonCrudCalcPremi(record);
      if (returnData.success) {
        List<String> listPremi = returnData.data.split(";");

        record.premiPelaksanaan = double.tryParse(listPremi[0]) ?? 0;
        record.premiPemeliharaan = double.tryParse(listPremi[1]) ?? 0;
        record.premiUangmuka = double.tryParse(listPremi[2]) ?? 0;
        record.premiPenawaran = double.tryParse(listPremi[3]) ?? 0;
        record.premiCar = double.tryParse(listPremi[4]) ?? 0;
        record.premiTotal = double.tryParse(listPremi[5]) ?? 0;
      }
    }

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        hasFailure: !isValid,
        record: record,
        errors: errors));
  }

  Future<void> onFieldLamaCoverChangedEvent(
      FieldLamaCoverChangedEvent event, Emitter<SimulbonCrudState> emit) async {
    SimulbonCrudModel record = await repository.simulBonCrudInitValue();
    record.coverBulan = event.lama;
    emit(state.copyWith(record: record));
  }

  Future<void> onFieldNilaiKontrakChangedEvent(
      FieldNilaiKontrakChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    record.kontrakNilai = event.nilaiKontrak;

    double carNilai = (record.isCar ?? false)
        ? (((record.carPersen ?? 0) / 100) * event.nilaiKontrak)
        : 0;
    double pelaksanaanNilai = (record.isPelaksanaan ?? false)
        ? (((record.pelaksanaanPersen ?? 0) / 100) * event.nilaiKontrak)
        : 0;
    double pemeliharaanNilai = (record.isPemeliharaan ?? false)
        ? (((record.pemeliharaanPersen ?? 0) / 100) * event.nilaiKontrak)
        : 0;
    double uangmukaNilai = (record.isUangmuka ?? false)
        ? (((record.uangmukaPersen ?? 0) / 100) * event.nilaiKontrak)
        : 0;
    double penawaranNilai = (record.isPenawaran ?? false)
        ? (((record.penawaranPersen ?? 0) / 100) * event.nilaiKontrak)
        : 0;

    //debugPrint("record.pelaksanaanPersen : ${record.pelaksanaanPersen}");
    //debugPrint("event.nilaiKontrak : ${event.nilaiKontrak}");

    record.carNilai = carNilai;
    record.pelaksanaanNilai = pelaksanaanNilai;
    record.pemeliharaanNilai = pemeliharaanNilai;
    record.uangmukaNilai = uangmukaNilai;
    record.penawaranNilai = penawaranNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldIsPelaksanaanChangedEvent(
      FieldIsPelaksanaanChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double pelaksanaanNilai =
        event.ya ? (((record.pelaksanaanPersen ?? 0) / 100) * nilaiKontrak) : 0;

    record.isPelaksanaan = event.ya;
    record.pelaksanaanNilai = pelaksanaanNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldIsPemeliharaanChangedEvent(
      FieldIsPemeliharaanChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double pemeliharaanNilai = event.ya
        ? (((record.pemeliharaanPersen ?? 0) / 100) * nilaiKontrak)
        : 0;

    record.isPemeliharaan = event.ya;
    record.pemeliharaanNilai = pemeliharaanNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldIsUangMukaChangedEvent(FieldIsUangMukaChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double uangmukaNilai =
        event.ya ? (((record.uangmukaPersen ?? 0) / 100) * nilaiKontrak) : 0;

    record.isUangmuka = event.ya;
    record.uangmukaNilai = uangmukaNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldIsPenawaranChangedEvent(
      FieldIsPenawaranChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double penawaranNilai =
        event.ya ? (((record.penawaranPersen ?? 0) / 100) * nilaiKontrak) : 0;

    record.isPenawaran = event.ya;
    record.penawaranNilai = penawaranNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldIsCarChangedEvent(
      FieldIsCarChangedEvent event, Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double carNilai =
        event.ya ? (((record.carPersen ?? 0) / 100) * nilaiKontrak) : 0;

    record.isCar = event.ya;
    record.carNilai = carNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldPelaksanaanPersenChangedEvent(
      FieldPelaksanaanPersenChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double pelaksanaanNilai = (record.isPelaksanaan ?? false)
        ? ((event.persen / 100) * nilaiKontrak)
        : 0;

    record.pelaksanaanPersen = event.persen;
    record.pelaksanaanNilai = pelaksanaanNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldPemeliharaanPersenChangedEvent(
      FieldPemeliharaanPersenChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double pemeliharaanNilai = (record.isPemeliharaan ?? false)
        ? ((event.persen / 100) * nilaiKontrak)
        : 0;

    record.pemeliharaanPersen = event.persen;
    record.pemeliharaanNilai = pemeliharaanNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldUangMukaPersenChangedEvent(
      FieldUangMukaPersenChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double uangmukaNilai = (record.isUangmuka ?? false)
        ? ((event.persen / 100) * nilaiKontrak)
        : 0;

    record.uangmukaPersen = event.persen;
    record.uangmukaNilai = uangmukaNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldPenawaranPersenChangedEvent(
      FieldPenawaranPersenChangedEvent event,
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double penawaranNilai = (record.isPenawaran ?? false)
        ? ((event.persen / 100) * nilaiKontrak)
        : 0;

    record.penawaranPersen = event.persen;
    record.penawaranNilai = penawaranNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onFieldCarPersenChangedEvent(FieldCarPersenChangedEvent event, 
      Emitter<SimulbonCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimulbonCrudModel record = state.record ?? SimulbonCrudModel();
    double nilaiKontrak = record.kontrakNilai ?? 0;
    double carNilai = (record.isCar ?? false)
        ? ((event.persen / 100) * nilaiKontrak)
        : 0;

    record.carPersen = event.persen;
    record.carNilai = carNilai;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }
}
