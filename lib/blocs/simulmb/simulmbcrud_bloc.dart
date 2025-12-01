import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulmb/simulmbcrud_model.dart';
import 'package:eassist_tools_app/repositories/simulmb/simulmbcrud_repository.dart';

part 'simulmbcrud_event.dart';
part 'simulmbcrud_state.dart';

class SimulmbCrudBloc extends Bloc<SimulmbCrudEvents, SimulmbCrudState> {
	final SimulmbCrudRepository repository;
	SimulmbCrudBloc({required this.repository}) : super(const SimulmbCrudState()) {
		on<SimulmbCrudUbahEvent>(onUbahSimulmbCrud);
		on<SimulmbCrudTambahEvent>(onTambahSimulmbCrud);
		on<SimulmbCrudHapusEvent>(onHapusSimulmbCrud);
		on<SimulmbCrudLihatEvent>(onLihatSimulmbCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
		on<SimulMbCrudInitValueEvent>(onSimulMbCrudInitValueEvent);
		on<FieldTSIChangedEvent>(onFieldTSIChangedEvent);
		on<FieldBulanChangedEvent>(onFieldBulanChangedEvent);
		on<FieldRateChangedEvent>(onFieldRateChangedEvent);
		on<HitungPremiMbEvent>(onHitungPremiMbEvent);
	}

	Future<void> onTambahSimulmbCrud(
		SimulmbCrudTambahEvent event, Emitter<SimulmbCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulmbCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulmbCrud(
		SimulmbCrudUbahEvent event, Emitter<SimulmbCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulmbCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulmbCrud(
		SimulmbCrudHapusEvent event, Emitter<SimulmbCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulmbCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulmbCrud(
		SimulmbCrudLihatEvent event, Emitter<SimulmbCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulmbCrudModel record = await repository.simulmbCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulmbCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		SimulmbCrudModel record = state.record ?? SimulmbCrudModel();
		record.comboRMatauang = comboRMatauang;
		record.currDesc = comboRMatauang.rmatauangSimbol;

		record.tsi = record.tsi ?? 0;
		record.premi = record.premi ?? 0;

		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang,
			record: record,
		));
	}


	Future<void> onSimulMbCrudInitValueEvent(
			SimulMbCrudInitValueEvent event, Emitter<SimulmbCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));

		SimulmbCrudModel record = await repository.simulMbCrudInitValue();

		emit(state.copyWith(
				isLoading: false,
				isLoaded: true,
				record: record,
				comboRMatauang: record.comboRMatauang));
	}

	Future<void> onFieldTSIChangedEvent(
			FieldTSIChangedEvent event, Emitter<SimulmbCrudState> emit) async {
		SimulmbCrudModel record = state.record ?? SimulmbCrudModel();
		record.tsi = event.tsi;

		debugPrint("event.tsi : ${event.tsi}");

		emit(state.copyWith(record: record));
	}


	Future<void> onFieldRateChangedEvent(
			FieldRateChangedEvent event, Emitter<SimulmbCrudState> emit) async {
		SimulmbCrudModel record = state.record ?? SimulmbCrudModel();
		record.rate = event.rate;

		emit(state.copyWith(record: record));
	}

	Future<void> onFieldBulanChangedEvent(
			FieldBulanChangedEvent event, Emitter<SimulmbCrudState> emit) async {
		SimulmbCrudModel record = state.record ?? SimulmbCrudModel();
		record.coverBulan = event.bulan;

		emit(state.copyWith(record: record));
	}

	Future<void> onHitungPremiMbEvent(
			HitungPremiMbEvent event, Emitter<SimulmbCrudState> emit) async {
		debugPrint("onHitungPremimbEvent");

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ReturnDataAPI returnData;
		bool isValid = true;
		List<String> errors = [];
		SimulmbCrudModel record = state.record ?? SimulmbCrudModel();

		if ((record.coverBulan == null) || (record.coverBulan == 0)) {
			isValid = false;
			errors.add("Field 'Lama Cover' harus >= 1 bulan");
		}

		if (record.tsi == 0) {
			isValid = false;
			errors.add("Field 'TSI' harus > 0.");
		}

		if (isValid) {
			returnData = await repository.simulMbCrudCalcPremi(record);
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