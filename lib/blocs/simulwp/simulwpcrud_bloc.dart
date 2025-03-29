import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulwp/simulwpcrud_model.dart';
import 'package:eassist_tools_app/repositories/simulwp/simulwpcrud_repository.dart';

part 'simulwpcrud_event.dart';
part 'simulwpcrud_state.dart';

class SimulwpCrudBloc extends Bloc<SimulwpCrudEvents, SimulwpCrudState> {
	final SimulwpCrudRepository repository;
	SimulwpCrudBloc({required this.repository}) : super(const SimulwpCrudState()) {
		on<SimulwpCrudUbahEvent>(onUbahSimulwpCrud);
		on<SimulwpCrudTambahEvent>(onTambahSimulwpCrud);
		on<SimulwpCrudHapusEvent>(onHapusSimulwpCrud);
		on<SimulwpCrudLihatEvent>(onLihatSimulwpCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahSimulwpCrud(
		SimulwpCrudTambahEvent event, Emitter<SimulwpCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulwpCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulwpCrud(
		SimulwpCrudUbahEvent event, Emitter<SimulwpCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulwpCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulwpCrud(
		SimulwpCrudHapusEvent event, Emitter<SimulwpCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulwpCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulwpCrud(
		SimulwpCrudLihatEvent event, Emitter<SimulwpCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulwpCrudModel record = await repository.simulwpCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulwpCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

  Future<void> onSimulWpCrudInitValueEvent(
      SimulWpCrudInitValueEvent event, Emitter<SimulwpCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulwpCrudModel record = await repository.simulWpCrudInitValue();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboRMatauang: record.comboRMatauang));
  }

  Future<void> onHitungPremiWpEvent(
      HitungPremiWpEvent event, Emitter<SimulwpCrudState> emit) async {
    debugPrint("onHitungPremiWpEvent");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ReturnDataAPI returnData;
    bool isValid = true;
    List<String> errors = [];
    SimulwpCrudModel record = state.record ?? SimulwpCrudModel();

    if ((record.coverBulan == null) || (record.coverBulan == 0)) {
      isValid = false;
      errors.add("Field 'Lama Cover' harus >= 1 bulan");
    }

    if (record.plafond == null || record.plafond == 0) {
      isValid = false;
      errors.add("Field 'Plafond' harus > 0.");
    }

    if (record.usia == null || record.usia == 0) {
      isValid = false;
      errors.add("Field 'Usia' harus > 0.");
    }

    if (isValid) {
      returnData = await repository.simulWpCrudCalcPremi(record);
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