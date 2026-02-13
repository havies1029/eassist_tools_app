//generate from : usp_flutter_crud_bloc

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaimmvdoccrud_model.dart';
import 'package:eassist_tools_app/repositories/perbaruiklaimmv/klaimmvdoccrud_repository.dart';

part 'klaimmvdoccrud_event.dart';
part 'klaimmvdoccrud_state.dart';

class KlaimmvdoccrudBloc extends Bloc<KlaimmvdoccrudEvents, KlaimmvdoccrudState> {
	final KlaimmvdoccrudRepository repository;
	KlaimmvdoccrudBloc({required this.repository}) : super(const KlaimmvdoccrudState()) {
		on<KlaimmvdoccrudUbahEvent>(onUbahKlaimmvdoccrud);
		on<KlaimmvdoccrudTambahEvent>(onTambahKlaimmvdoccrud);
		on<KlaimmvdoccrudHapusEvent>(onHapusKlaimmvdoccrud);
		on<KlaimmvdoccrudLihatEvent>(onLihatKlaimmvdoccrud);
	}

	Future<void> onTambahKlaimmvdoccrud(
		KlaimmvdoccrudTambahEvent event, Emitter<KlaimmvdoccrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.klaimmvdoccrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahKlaimmvdoccrud(
		KlaimmvdoccrudUbahEvent event, Emitter<KlaimmvdoccrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.klaimmvdoccrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusKlaimmvdoccrud(
		KlaimmvdoccrudHapusEvent event, Emitter<KlaimmvdoccrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.klaimmvdoccrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatKlaimmvdoccrud(
		KlaimmvdoccrudLihatEvent event, Emitter<KlaimmvdoccrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		KlaimmvdoccrudModel? record = await repository.klaimmvdoccrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}