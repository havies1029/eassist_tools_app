import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simuleei/simuleeicrud_model.dart';
import 'package:eassist_tools_app/repositories/simuleei/simuleeicrud_repository.dart';

part 'simuleeicrud_event.dart';
part 'simuleeicrud_state.dart';

class SimuleeiCrudBloc extends Bloc<SimuleeiCrudEvents, SimuleeiCrudState> {
  final SimuleeiCrudRepository repository;
  SimuleeiCrudBloc({required this.repository})
      : super(const SimuleeiCrudState()) {
    on<SimuleeiCrudUbahEvent>(onUbahSimuleeiCrud);
    on<SimuleeiCrudTambahEvent>(onTambahSimuleeiCrud);
    on<SimuleeiCrudHapusEvent>(onHapusSimuleeiCrud);
    on<SimuleeiCrudLihatEvent>(onLihatSimuleeiCrud);
    on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
    on<SimuleeiCrudInitValueEvent>(onSimuleeiCrudInitValueEvent);
    on<FieldTSIChangedEvent>(onFieldTSIChangedEvent);
    on<FieldBulanChangedEvent>(onFieldBulanChangedEvent);
    on<FieldRateChangedEvent>(onFieldRateChangedEvent);
    on<HitungPremiEEIEvent>(onHitungPremiEEIEvent);
  }

  Future<void> onTambahSimuleeiCrud(
      SimuleeiCrudTambahEvent event, Emitter<SimuleeiCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.simuleeiCrudTambah(event.record);
    hasFailure = !returnData.success;
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahSimuleeiCrud(
      SimuleeiCrudUbahEvent event, Emitter<SimuleeiCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.simuleeiCrudUbah(event.record);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusSimuleeiCrud(
      SimuleeiCrudHapusEvent event, Emitter<SimuleeiCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.simuleeiCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatSimuleeiCrud(
      SimuleeiCrudLihatEvent event, Emitter<SimuleeiCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    SimuleeiCrudModel record =
        await repository.simuleeiCrudLihat(event.recordId);
    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

  Future<void> onComboRMatauangChanged(
      ComboRMatauangChangedEvent event, Emitter<SimuleeiCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboRMatauangModel comboRMatauang = event.comboRMatauang;
    SimuleeiCrudModel record = state.record ?? SimuleeiCrudModel();
    record.comboRMatauang = comboRMatauang;
    record.currDesc = comboRMatauang.rmatauangSimbol;

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        comboRMatauang: comboRMatauang,
        record: record));
  }

  Future<void> onSimuleeiCrudInitValueEvent(
      SimuleeiCrudInitValueEvent event, Emitter<SimuleeiCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimuleeiCrudModel record = await repository.simulEEICrudInitValue();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboRMatauang: record.comboRMatauang));
  }

  Future<void> onFieldBulanChangedEvent(
      FieldBulanChangedEvent event, Emitter<SimuleeiCrudState> emit) async {
    SimuleeiCrudModel record = state.record ?? SimuleeiCrudModel();
    record.coverBulan = event.bulan;

    emit(state.copyWith(record: record));
  }

  Future<void> onFieldTSIChangedEvent(
      FieldTSIChangedEvent event, Emitter<SimuleeiCrudState> emit) async {
    SimuleeiCrudModel record = state.record ?? SimuleeiCrudModel();
    record.tsi = event.tsi;

    debugPrint("event.tsi : ${event.tsi}");

    emit(state.copyWith(record: record));
  }

  Future<void> onFieldRateChangedEvent(
      FieldRateChangedEvent event, Emitter<SimuleeiCrudState> emit) async {
    SimuleeiCrudModel record = state.record ?? SimuleeiCrudModel();
    record.rate = event.rate;

    emit(state.copyWith(record: record));
  }

  Future<void> onHitungPremiEEIEvent(
      HitungPremiEEIEvent event, Emitter<SimuleeiCrudState> emit) async {
    debugPrint("onHitungPremiEEIEvent");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ReturnDataAPI returnData;
    bool isValid = true;
    List<String> errors = [];
    SimuleeiCrudModel record = state.record ?? SimuleeiCrudModel();

    if ((record.coverBulan == null) || (record.coverBulan == 0)) {
      isValid = false;
      errors.add("Field 'Lama Cover' harus >= 1 bulan");
    }

    if (record.tsi == null || record.tsi == 0) {
      isValid = false;
      errors.add("Field 'TSI' harus > 0.");
    }

    if (isValid) {
      returnData = await repository.simuleeiCrudCalcPremi(record);
      if (returnData.success) {
        record.premi = double.tryParse(returnData.data) ?? 0;
      }
    }

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        hasFailure: !isValid,
        record: record,
        errors: errors));
  }
}
