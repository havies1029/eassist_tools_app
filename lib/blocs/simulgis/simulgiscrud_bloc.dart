import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulgis/simulgiscrud_model.dart';
import 'package:eassist_tools_app/repositories/simulgis/simulgiscrud_repository.dart';

part 'simulgiscrud_event.dart';
part 'simulgiscrud_state.dart';

class SimulgisCrudBloc extends Bloc<SimulgisCrudEvents, SimulgisCrudState> {
	final SimulgisCrudRepository repository;
	SimulgisCrudBloc({required this.repository}) : super(const SimulgisCrudState()) {
		on<SimulgisCrudUbahEvent>(onUbahSimulgisCrud);
		on<SimulgisCrudTambahEvent>(onTambahSimulgisCrud);
		on<SimulgisCrudHapusEvent>(onHapusSimulgisCrud);
		on<SimulgisCrudLihatEvent>(onLihatSimulgisCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahSimulgisCrud(
		SimulgisCrudTambahEvent event, Emitter<SimulgisCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulgisCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulgisCrud(
		SimulgisCrudUbahEvent event, Emitter<SimulgisCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulgisCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulgisCrud(
		SimulgisCrudHapusEvent event, Emitter<SimulgisCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulgisCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulgisCrud(
		SimulgisCrudLihatEvent event, Emitter<SimulgisCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulgisCrudModel record = await repository.simulgisCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulgisCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

  Future<void> onSimulGisCrudInitValueEvent(
      SimulGisCrudInitValueEvent event, Emitter<SimulgisCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulgisCrudModel record = await repository.simulGisCrudInitValue();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboRMatauang: record.comboRMatauang));
  }

  Future<void> onHitungPremiGisEvent(
      HitungPremiGisEvent event, Emitter<SimulgisCrudState> emit) async {
    debugPrint("onHitungPremiGisEvent");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ReturnDataAPI returnData;
    bool isValid = true;
    List<String> errors = [];
    SimulgisCrudModel record = state.record ?? SimulgisCrudModel();

    if ((record.coverBulan == null) || (record.coverBulan == 0)) {
      isValid = false;
      errors.add("Field 'Lama Cover' harus >= 1 bulan");
    }

    if (record.tsi == null || record.tsi == 0) {
      isValid = false;
      errors.add("Field 'TSI' harus > 0.");
    }

    if (isValid) {
      returnData = await repository.simulGisCrudCalcPremi(record);
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