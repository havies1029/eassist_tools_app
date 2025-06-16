import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanbankcrud_repository.dart';

part 'mrekanbankcrud_event.dart';
part 'mrekanbankcrud_state.dart';

class MRekanBankCrudBloc extends Bloc<MRekanBankCrudEvents, MRekanBankCrudState> {
	final MRekanBankCrudRepository repository;
	MRekanBankCrudBloc({required this.repository}) : super(const MRekanBankCrudState()) {
		on<MRekanBankCrudUbahEvent>(onUbahMRekanBankCrud);
		on<MRekanBankCrudTambahEvent>(onTambahMRekanBankCrud);
		on<MRekanBankCrudHapusEvent>(onHapusMRekanBankCrud);
		on<MRekanBankCrudLihatEvent>(onLihatMRekanBankCrud);
	}

	Future<void> onTambahMRekanBankCrud(
		MRekanBankCrudTambahEvent event, Emitter<MRekanBankCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.mRekanBankCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahMRekanBankCrud(
		MRekanBankCrudUbahEvent event, Emitter<MRekanBankCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekanBankCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusMRekanBankCrud(
		MRekanBankCrudHapusEvent event, Emitter<MRekanBankCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekanBankCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatMRekanBankCrud(
		MRekanBankCrudLihatEvent event, Emitter<MRekanBankCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MRekanBankCrudModel record = await repository.mRekanBankCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}