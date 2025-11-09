import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/gen_regmv/regmv1crud_model.dart';
import 'package:eassist_tools_app/repositories/gen_regmv/regmv1crud_repository.dart';

part 'regmv1crud_event.dart';
part 'regmv1crud_state.dart';

class Regmv1CrudBloc extends Bloc<Regmv1CrudEvents, Regmv1CrudState> {
	final Regmv1CrudRepository repository;
	Regmv1CrudBloc({required this.repository}) : super(const Regmv1CrudState()) {
		on<Regmv1CrudUbahEvent>(onUbahRegmv1Crud);
		on<Regmv1CrudTambahEvent>(onTambahRegmv1Crud);
		on<Regmv1CrudHapusEvent>(onHapusRegmv1Crud);
		on<Regmv1CrudLihatEvent>(onLihatRegmv1Crud);
	}

	Future<void> onTambahRegmv1Crud(
		Regmv1CrudTambahEvent event, Emitter<Regmv1CrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.regmv1CrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahRegmv1Crud(
		Regmv1CrudUbahEvent event, Emitter<Regmv1CrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv1CrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusRegmv1Crud(
		Regmv1CrudHapusEvent event, Emitter<Regmv1CrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv1CrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatRegmv1Crud(
		Regmv1CrudLihatEvent event, Emitter<Regmv1CrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Regmv1CrudModel record = await repository.regmv1CrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}