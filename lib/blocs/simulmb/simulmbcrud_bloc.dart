import 'package:equatable/equatable.dart';
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
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

}