import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralidvcrud_repository.dart';

part 'mrekangeneralidvcrud_event.dart';
part 'mrekangeneralidvcrud_state.dart';

class MRekanGeneralIdvCrudBloc extends Bloc<MRekanGeneralIdvCrudEvents, MRekanGeneralIdvCrudState> {
	final MRekanGeneralIdvCrudRepository repository;
	MRekanGeneralIdvCrudBloc({required this.repository}) : super(const MRekanGeneralIdvCrudState()) {
		on<MRekanGeneralIdvCrudUbahEvent>(onUbahMRekanGeneralIdvCrud);
		on<MRekanGeneralIdvCrudTambahEvent>(onTambahMRekanGeneralIdvCrud);
		on<MRekanGeneralIdvCrudHapusEvent>(onHapusMRekanGeneralIdvCrud);
		on<MRekanGeneralIdvCrudLihatEvent>(onLihatMRekanGeneralIdvCrud);
		on<ComboMPekerjaanChangedEvent>(onComboMPekerjaanChanged);
	}

	Future<void> onTambahMRekanGeneralIdvCrud(
		MRekanGeneralIdvCrudTambahEvent event, Emitter<MRekanGeneralIdvCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.mRekanGeneralIdvCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahMRekanGeneralIdvCrud(
		MRekanGeneralIdvCrudUbahEvent event, Emitter<MRekanGeneralIdvCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekanGeneralIdvCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusMRekanGeneralIdvCrud(
		MRekanGeneralIdvCrudHapusEvent event, Emitter<MRekanGeneralIdvCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekanGeneralIdvCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatMRekanGeneralIdvCrud(
		MRekanGeneralIdvCrudLihatEvent event, Emitter<MRekanGeneralIdvCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MRekanGeneralIdvCrudModel record = await repository.mRekanGeneralIdvCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboMPekerjaanChanged(
			ComboMPekerjaanChangedEvent event, Emitter<MRekanGeneralIdvCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMPekerjaanModel comboMPekerjaan = event.comboMPekerjaan;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMPekerjaan: comboMPekerjaan));
	}

}