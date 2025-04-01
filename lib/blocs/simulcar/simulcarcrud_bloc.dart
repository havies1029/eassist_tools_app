import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/simulcar/simulcarcrud_model.dart';
import 'package:eassist_tools_app/repositories/simulcar/simulcarcrud_repository.dart';

part 'simulcarcrud_event.dart';
part 'simulcarcrud_state.dart';

class SimulcarCrudBloc extends Bloc<SimulcarCrudEvents, SimulcarCrudState> {
	final SimulcarCrudRepository repository;
	SimulcarCrudBloc({required this.repository}) : super(const SimulcarCrudState()) {
		on<SimulcarCrudUbahEvent>(onUbahSimulcarCrud);
		on<SimulcarCrudTambahEvent>(onTambahSimulcarCrud);
		on<SimulcarCrudHapusEvent>(onHapusSimulcarCrud);
		on<SimulcarCrudLihatEvent>(onLihatSimulcarCrud);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahSimulcarCrud(
		SimulcarCrudTambahEvent event, Emitter<SimulcarCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.simulcarCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahSimulcarCrud(
		SimulcarCrudUbahEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulcarCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusSimulcarCrud(
		SimulcarCrudHapusEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.simulcarCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatSimulcarCrud(
		SimulcarCrudLihatEvent event, Emitter<SimulcarCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		SimulcarCrudModel record = await repository.simulcarCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<SimulcarCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

}