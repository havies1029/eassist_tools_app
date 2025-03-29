import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulgit/simulgitcrud_model.dart';
import 'package:eassist_tools_app/repositories/simulgit/simulgitcrud_repository.dart';

part 'simulgitcrud_event.dart';
part 'simulgitcrud_state.dart';

class SimulgitCrudBloc extends Bloc<SimulgitCrudEvents, SimulgitCrudState> {
	final SimulgitCrudRepository repository;
	SimulgitCrudBloc({required this.repository}) : super(const SimulgitCrudState()) {
		on<SimulgitCrudUbahEvent>(onUbahSimulgitCrud);
		on<SimulgitCrudTambahEvent>(onTambahSimulgitCrud);
		on<SimulgitCrudHapusEvent>(onHapusSimulgitCrud);
		on<SimulgitCrudLihatEvent>(onLihatSimulgitCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahSimulgitCrud(
		SimulgitCrudTambahEvent event, Emitter<SimulgitCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulgitCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulgitCrud(
		SimulgitCrudUbahEvent event, Emitter<SimulgitCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulgitCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulgitCrud(
		SimulgitCrudHapusEvent event, Emitter<SimulgitCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulgitCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulgitCrud(
		SimulgitCrudLihatEvent event, Emitter<SimulgitCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulgitCrudModel record = await repository.simulgitCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulgitCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

  Future<void> onSimulGitCrudInitValueEvent(
      SimulGitCrudInitValueEvent event, Emitter<SimulgitCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulgitCrudModel record = await repository.simulGitCrudInitValue();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboRMatauang: record.comboRMatauang));
  }


  Future<void> onHitungPremiGitEvent(
      HitungPremiGitEvent event, Emitter<SimulgitCrudState> emit) async {
    debugPrint("onHitungPremiGitEvent");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ReturnDataAPI returnData;
    bool isValid = true;
    List<String> errors = [];
    SimulgitCrudModel record = state.record ?? SimulgitCrudModel();

    if ((record.coverBulan == null) || (record.coverBulan == 0)) {
      isValid = false;
      errors.add("Field 'Lama Cover' harus >= 1 bulan");
    }

    if (record.tsi == null || record.tsi == 0) {
      isValid = false;
      errors.add("Field 'TSI' harus > 0.");
    }

    if (isValid) {
      returnData = await repository.simulGitCrudCalcPremi(record);
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