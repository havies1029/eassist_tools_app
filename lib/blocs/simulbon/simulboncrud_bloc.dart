import 'package:equatable/equatable.dart';
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

}