import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekan1crud_model.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekan1crud_repository.dart';

part 'mrekan1crud_event.dart';
part 'mrekan1crud_state.dart';

class MRekan1CrudBloc extends Bloc<MRekan1CrudEvents, MRekan1CrudState> {
	final MRekan1CrudRepository repository;
	MRekan1CrudBloc({required this.repository}) : super(const MRekan1CrudState()) {
		on<MRekan1CrudUbahEvent>(onUbahMRekan1Crud);
		on<MRekan1CrudTambahEvent>(onTambahMRekan1Crud);
		on<MRekan1CrudHapusEvent>(onHapusMRekan1Crud);
		on<MRekan1CrudLihatEvent>(onLihatMRekan1Crud);
		on<ComboMTitleChangedEvent>(onComboMTitleChanged);
		on<ComboMJnsclientChangedEvent>(onComboMJnsclientChanged);
		on<ComboMBentukCstChangedEvent>(onComboMBentukCstChanged);
		on<ComboMBidangChangedEvent>(onComboMBidangChanged);
		on<ComboMJnskelChangedEvent>(onComboMJnskelChanged);
		on<ComboMPekerjaanChangedEvent>(onComboMPekerjaanChanged);
	}

	Future<void> onTambahMRekan1Crud(
		MRekan1CrudTambahEvent event, Emitter<MRekan1CrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.mRekan1CrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahMRekan1Crud(
		MRekan1CrudUbahEvent event, Emitter<MRekan1CrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekan1CrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusMRekan1Crud(
		MRekan1CrudHapusEvent event, Emitter<MRekan1CrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekan1CrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatMRekan1Crud(
		MRekan1CrudLihatEvent event, Emitter<MRekan1CrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MRekan1CrudModel record = await repository.mRekan1CrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboMTitleChanged(
			ComboMTitleChangedEvent event, Emitter<MRekan1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMTitleModel comboMTitle = event.comboMTitle;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMTitle: comboMTitle));
	}

	Future<void> onComboMJnsclientChanged(
			ComboMJnsclientChangedEvent event, Emitter<MRekan1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMJnsclientModel comboMJnsclient = event.comboMJnsclient;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMJnsclient: comboMJnsclient));
	}

	Future<void> onComboMBentukCstChanged(
			ComboMBentukCstChangedEvent event, Emitter<MRekan1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMBentukCstModel comboMBentukCst = event.comboMBentukCst;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMBentukCst: comboMBentukCst));
	}

	Future<void> onComboMBidangChanged(
			ComboMBidangChangedEvent event, Emitter<MRekan1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMBidangModel comboMBidang = event.comboMBidang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMBidang: comboMBidang));
	}

	Future<void> onComboMJnskelChanged(
			ComboMJnskelChangedEvent event, Emitter<MRekan1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMJnskelModel comboMJnskel = event.comboMJnskel;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMJnskel: comboMJnskel));
	}

	Future<void> onComboMPekerjaanChanged(
			ComboMPekerjaanChangedEvent event, Emitter<MRekan1CrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboMPekerjaanModel comboMPekerjaan = event.comboMPekerjaan;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboMPekerjaan: comboMPekerjaan));
	}

}