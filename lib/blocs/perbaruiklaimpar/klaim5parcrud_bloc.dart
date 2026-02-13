//generate from : usp_flutter_crud_bloc

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/perbaruiklaimpar/klaim5parcrud_model.dart';
import 'package:eassist_tools_app/repositories/perbaruiklaimpar/klaim5parcrud_repository.dart';

part 'klaim5parcrud_event.dart';
part 'klaim5parcrud_state.dart';

class Klaim5parCrudBloc extends Bloc<Klaim5parCrudEvents, Klaim5parCrudState> {
	final Klaim5parCrudRepository repository;
	Klaim5parCrudBloc({required this.repository}) : super(const Klaim5parCrudState()) {
		on<Klaim5parCrudUbahEvent>(onUbahKlaim5parCrud);
		on<Klaim5parCrudTambahEvent>(onTambahKlaim5parCrud);
		on<Klaim5parCrudHapusEvent>(onHapusKlaim5parCrud);
		on<Klaim5parCrudLihatEvent>(onLihatKlaim5parCrud);
	}

	Future<void> onTambahKlaim5parCrud(
		Klaim5parCrudTambahEvent event, Emitter<Klaim5parCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.klaim5parCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahKlaim5parCrud(
		Klaim5parCrudUbahEvent event, Emitter<Klaim5parCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.klaim5parCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusKlaim5parCrud(
		Klaim5parCrudHapusEvent event, Emitter<Klaim5parCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.klaim5parCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatKlaim5parCrud(
		Klaim5parCrudLihatEvent event, Emitter<Klaim5parCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Klaim5parCrudModel? record = await repository.klaim5parCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}