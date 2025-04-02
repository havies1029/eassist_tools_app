import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulcar/simulcarcrud_model.dart';
import 'package:eassist_tools_app/repositories/simulcar/simulcarcrud_repository.dart';

part 'simulcarcrud_event.dart';
part 'simulcarcrud_state.dart';

class SimulcarCrudBloc extends Bloc<SimulcarCrudEvents, SimulcarCrudState> {
	final SimulcarCrudRepository repository;
	SimulcarCrudBloc({required this.repository})
			: super(const SimulcarCrudState()) {
		on<SimulcarCrudUbahEvent>(onUbahSimulcarCrud);
		on<SimulcarCrudTambahEvent>(onTambahSimulcarCrud);
		on<SimulcarCrudHapusEvent>(onHapusSimulcarCrud);
		on<SimulcarCrudLihatEvent>(onLihatSimulcarCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
		on<SimulcarCrudInitValueEvent>(onSimulcarCrudInitValueEvent);
		on<FieldTSIChangedEvent>(onFieldTSIChangedEvent);
		on<FieldBulanChangedEvent>(onFieldBulanChangedEvent);
		on<FieldRateChangedEvent>(onFieldRateChangedEvent);
		on<HitungPremicarEvent>(onHitungPremiCAREvent);
	}

	Future<void> onTambahSimulcarCrud(
			SimulcarCrudTambahEvent event, Emitter<SimulcarCrudState> emit) async {
		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulcarCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(
				state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onUbahSimulcarCrud(
			SimulcarCrudUbahEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulcarCrudUbah(event.record);
		emit(
				state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulcarCrud(
			SimulcarCrudHapusEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulcarCrudHapus(event.recordId);
		emit(
				state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulcarCrud(
			SimulcarCrudLihatEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulcarCrudModel record =
		await repository.simulcarCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		SimulcarCrudModel record = state.record ?? SimulcarCrudModel();
		record.comboRMatauang = comboRMatauang;
		record.currDesc = comboRMatauang.rmatauangSimbol;

		emit(state.copyWith(
				isLoading: false,
				isLoaded: true,
				comboRMatauang: comboRMatauang,
				record: record));
	}



	Future<void> onSimulcarCrudInitValueEvent(
			SimulcarCrudInitValueEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));

		SimulcarCrudModel record = await repository.simulcarCrudInitValue();

		emit(state.copyWith(
				isLoading: false,
				isLoaded: true,
				record: record,
				comboRMatauang: record.comboRMatauang));
	}

	Future<void> onFieldBulanChangedEvent(
			FieldBulanChangedEvent event, Emitter<SimulcarCrudState> emit) async {
		SimulcarCrudModel record = state.record ?? SimulcarCrudModel();
		record.coverBulan = event.bulan;

		emit(state.copyWith(record: record));
	}

	Future<void> onFieldTSIChangedEvent(
			FieldTSIChangedEvent event, Emitter<SimulcarCrudState> emit) async {
		SimulcarCrudModel record = state.record ?? SimulcarCrudModel();
		record.tsi = event.tsi;

		debugPrint("event.tsi : ${event.tsi}");

		emit(state.copyWith(record: record));
	}

	Future<void> onFieldRateChangedEvent(
			FieldRateChangedEvent event, Emitter<SimulcarCrudState> emit) async {
		SimulcarCrudModel record = state.record ?? SimulcarCrudModel();
		record.rate = event.rate;

		emit(state.copyWith(record: record));
	}


	Future<void> onHitungPremiCAREvent(
			HitungPremicarEvent event, Emitter<SimulcarCrudState> emit) async {
		debugPrint("onHitungPremicarEvent");

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ReturnDataAPI returnData;
		bool isValid = true;
		List<String> errors = [];
		SimulcarCrudModel record = state.record ?? SimulcarCrudModel();

		if ((record.coverBulan == null) || (record.coverBulan == 0)) {
			isValid = false;
			errors.add("Field 'Lama Cover' harus >= 1 bulan");
		}

		if (record.tsi == null || record.tsi == 0) {
			isValid = false;
			errors.add("Field 'TSI' harus > 0.");
		}

		if (isValid) {
			returnData = await repository.simulcarCrudCalcPremi(record);
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