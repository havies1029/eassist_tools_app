import 'package:equatable/equatable.dart';
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
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

}