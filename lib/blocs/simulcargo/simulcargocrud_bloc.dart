import 'package:eassist_tools_app/models/combobox/combomconveyby_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combommop_model.dart';
import 'package:eassist_tools_app/models/combobox/combomconveydetail_model.dart';
import 'package:eassist_tools_app/models/simulcargo/simulcargocrud_model.dart';
import 'package:eassist_tools_app/repositories/simulcargo/simulcargocrud_repository.dart';

part 'simulcargocrud_event.dart';
part 'simulcargocrud_state.dart';

class SimulcargoCrudBloc extends Bloc<SimulcargoCrudEvents, SimulcargoCrudState> {
	final SimulcargoCrudRepository repository;
	SimulcargoCrudBloc({required this.repository}) : super(const SimulcargoCrudState()) {
		on<SimulcargoCrudUbahEvent>(onUbahSimulcargoCrud);
		on<SimulcargoCrudTambahEvent>(onTambahSimulcargoCrud);
		on<SimulcargoCrudHapusEvent>(onHapusSimulcargoCrud);
		on<SimulcargoCrudLihatEvent>(onLihatSimulcargoCrud);
		on<ComboMMopChangedEvent>(onComboMMopChanged);
		on<ComboMMopChangedEvent>(onComboMMopChanged);
		on<ComboMConveyDetailChangedEvent>(onComboMConveyDetailChanged);
	}

	Future<void> onTambahSimulcargoCrud(
		SimulcargoCrudTambahEvent event, Emitter<SimulcargoCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulcargoCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulcargoCrud(
		SimulcargoCrudUbahEvent event, Emitter<SimulcargoCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulcargoCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulcargoCrud(
		SimulcargoCrudHapusEvent event, Emitter<SimulcargoCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulcargoCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulcargoCrud(
		SimulcargoCrudLihatEvent event, Emitter<SimulcargoCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulcargoCrudModel record = await repository.simulcargoCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboMMopChanged(
			ComboMMopChangedEvent event, Emitter<SimulcargoCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMMopModel comboMMop = event.comboMMop;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMMop: comboMMop));
	}

	Future<void> onComboMConveyDetailChanged(
			ComboMConveyDetailChangedEvent event, Emitter<SimulcargoCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMConveyDetailModel comboMConveyDetail = event.comboMConveyDetail;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMConveyDetail: comboMConveyDetail));
	}

  Future<void> onSimulCargoCrudInitValueEvent(
      SimulCargoCrudInitValueEvent event, Emitter<SimulcargoCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SimulcargoCrudModel record = await repository.simulCargoCrudInitValue();

    emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        record: record,
        comboRMatauang: record.comboRMatauang));
  }

  Future<void> onHitungPremiCargoEvent(
      HitungPremiCargoEvent event, Emitter<SimulcargoCrudState> emit) async {
    debugPrint("onHitungPremiCargoEvent");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    ReturnDataAPI returnData;
    bool isValid = true;
    List<String> errors = [];
    SimulcargoCrudModel record = state.record ?? SimulcargoCrudModel();

    if (record.tsi == null || record.tsi == 0) {
      isValid = false;
      errors.add("Field 'TSI' harus > 0.");
    }

    if (record.comboMMop?.mmopId == null || record.comboMMop?.mmopId == "") {
      isValid = false;
      errors.add("Field 'MOP' tidak boleh kosong.");
    }

    if (record.comboMConveyBy?.mconveybyId == null || record.comboMConveyBy?.mconveybyId == "") {
      isValid = false;
      errors.add("Field 'Convey By' tidak boleh kosong.");
    }

    if (record.comboMConveyDetail?.mconveydetailId == null || record.comboMConveyDetail?.mconveydetailId == "") {
      isValid = false;
      errors.add("Field 'Convey Detail' tidak boleh kosong.");
    }

    if (isValid) {
      returnData = await repository.simulBonCrudCalcPremi(record);
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