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
	SimulbonCrudBloc({required this.repository}) : super(const SimulbonCrudState()) {
		on<SimulbonCrudUbahEvent>(onUbahSimulbonCrud);
		on<SimulbonCrudTambahEvent>(onTambahSimulbonCrud);
		on<SimulbonCrudHapusEvent>(onHapusSimulbonCrud);
		on<SimulbonCrudLihatEvent>(onLihatSimulbonCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahSimulbonCrud(
		SimulbonCrudTambahEvent event, Emitter<SimulbonCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulbonCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulbonCrud(
		SimulbonCrudUbahEvent event, Emitter<SimulbonCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulbonCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulbonCrud(
		SimulbonCrudHapusEvent event, Emitter<SimulbonCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulbonCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulbonCrud(
		SimulbonCrudLihatEvent event, Emitter<SimulbonCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulbonCrudModel record = await repository.simulbonCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulbonCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
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
        record.premiUangmuka = double.tryParse(listPremi[3]) ?? 0;
        record.premiPenawaran = double.tryParse(listPremi[4]) ?? 0;
        record.premiCar = double.tryParse(listPremi[5]) ?? 0;
        record.premiTotal = double.tryParse(listPremi[6]) ?? 0;
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