import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simultree/simultreecrud_model.dart';
import 'package:eassist_tools_app/repositories/simultree/simultreecrud_repository.dart';

part 'simultreecrud_event.dart';
part 'simultreecrud_state.dart';

class SimultreeCrudBloc extends Bloc<SimultreeCrudEvents, SimultreeCrudState> {
	final SimultreeCrudRepository repository;
	SimultreeCrudBloc({required this.repository}) : super(const SimultreeCrudState()) {
		on<SimultreeCrudUbahEvent>(onUbahSimultreeCrud);
		on<SimultreeCrudTambahEvent>(onTambahSimultreeCrud);
		on<SimultreeCrudHapusEvent>(onHapusSimultreeCrud);
		on<SimultreeCrudLihatEvent>(onLihatSimultreeCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
		on<FieldTSIChangedEvent>(onFieldTSIChangedEvent);
		on<FieldBulanChangedEvent>(onFieldBulanChangedEvent);
		on<FieldRateChangedEvent>(onFieldRateChangedEvent);
		on<HitungPremitreeEvent>(onHitungPremitreeEvent);
		on<SimultreeCrudInitValueEvent>(onSimultreeCrudInitValueEvent);

	}

	Future<void> onTambahSimultreeCrud(
		SimultreeCrudTambahEvent event, Emitter<SimultreeCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simultreeCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimultreeCrud(
		SimultreeCrudUbahEvent event, Emitter<SimultreeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simultreeCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimultreeCrud(
		SimultreeCrudHapusEvent event, Emitter<SimultreeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simultreeCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimultreeCrud(
		SimultreeCrudLihatEvent event, Emitter<SimultreeCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimultreeCrudModel record = await repository.simultreeCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimultreeCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		SimultreeCrudModel record = state.record ?? SimultreeCrudModel();
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


	Future<void> onSimultreeCrudInitValueEvent(
			SimultreeCrudInitValueEvent event, Emitter<SimultreeCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));

		SimultreeCrudModel record = await repository.simultreeCrudInitValue();

		emit(state.copyWith(
				isLoading: false,
				isLoaded: true,
				record: record,
				comboRMatauang: record.comboRMatauang));
	}

	Future<void> onFieldTSIChangedEvent(
			FieldTSIChangedEvent event, Emitter<SimultreeCrudState> emit) async {
		SimultreeCrudModel record = state.record ?? SimultreeCrudModel();
		record.tsi = event.tsi;

		debugPrint("event.tsi : ${event.tsi}");

		emit(state.copyWith(record: record));
	}


	Future<void> onFieldRateChangedEvent(
			FieldRateChangedEvent event, Emitter<SimultreeCrudState> emit) async {
		SimultreeCrudModel record = state.record ?? SimultreeCrudModel();
		record.rate = event.rate;

		emit(state.copyWith(record: record));
	}

	Future<void> onFieldBulanChangedEvent(
			FieldBulanChangedEvent event, Emitter<SimultreeCrudState> emit) async {
		SimultreeCrudModel record = state.record ?? SimultreeCrudModel();
		record.coverBulan = event.bulan;

		emit(state.copyWith(record: record));
	}

	Future<void> onHitungPremitreeEvent(
			HitungPremitreeEvent event, Emitter<SimultreeCrudState> emit) async {
		debugPrint("onHitungPremitreeEvent");

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ReturnDataAPI returnData;
		bool isValid = true;
		List<String> errors = [];
		SimultreeCrudModel record = state.record ?? SimultreeCrudModel();

		if ((record.coverBulan == null) || (record.coverBulan == 0)) {
			isValid = false;
			errors.add("Field 'Lama Cover' harus >= 1 bulan");
		}

		if (record.tsi == null || record.tsi == 0) {
			isValid = false;
			errors.add("Field 'TSI' harus > 0.");
		}

		if (isValid) {
			returnData = await repository.simultreeCrudCalcPremi(record);
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