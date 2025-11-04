import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combommvjnscover_model.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayah_model.dart';
import 'package:eassist_tools_app/models/combobox/combommvgrupojk_model.dart';
import 'package:eassist_tools_app/models/gen_calmv/calmv1crud_model.dart';
import 'package:eassist_tools_app/repositories/gen_calmv/calmv1crud_repository.dart';

part 'calmv1crud_event.dart';
part 'calmv1crud_state.dart';

class Calmv1CrudBloc extends Bloc<Calmv1CrudEvents, Calmv1CrudState> {
	final Calmv1CrudRepository repository;
	Calmv1CrudBloc({required this.repository}) : super(const Calmv1CrudState()) {
		on<Calmv1CrudUbahEvent>(onUbahCalmv1Crud);
		on<Calmv1CrudTambahEvent>(onTambahCalmv1Crud);
		on<Calmv1CrudHapusEvent>(onHapusCalmv1Crud);
		on<Calmv1CrudLihatEvent>(onLihatCalmv1Crud);
		on<ComboMMvjnscoverChangedEvent>(onComboMMvjnscoverChanged);
		on<ComboMWilayahChangedEvent>(onComboMWilayahChanged);
		on<ComboMMvgrupOjkChangedEvent>(onComboMMvgrupOjkChanged);
	}

	Future<void> onTambahCalmv1Crud(
		Calmv1CrudTambahEvent event, Emitter<Calmv1CrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.calmv1CrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahCalmv1Crud(
		Calmv1CrudUbahEvent event, Emitter<Calmv1CrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.calmv1CrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusCalmv1Crud(
		Calmv1CrudHapusEvent event, Emitter<Calmv1CrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.calmv1CrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatCalmv1Crud(
		Calmv1CrudLihatEvent event, Emitter<Calmv1CrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Calmv1CrudModel record = await repository.calmv1CrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboMMvjnscoverChanged(
			ComboMMvjnscoverChangedEvent event, Emitter<Calmv1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMMvjnscoverModel comboMMvjnscover = event.comboMMvjnscover;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMMvjnscover: comboMMvjnscover));
	}

	Future<void> onComboMWilayahChanged(
			ComboMWilayahChangedEvent event, Emitter<Calmv1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMWilayahModel comboMWilayah = event.comboMWilayah;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMWilayah: comboMWilayah));
	}

	Future<void> onComboMMvgrupOjkChanged(
			ComboMMvgrupOjkChangedEvent event, Emitter<Calmv1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMMvgrupOjkModel comboMMvgrupOjk = event.comboMMvgrupOjk;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMMvgrupOjk: comboMMvgrupOjk));
	}

}