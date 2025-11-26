import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/gen_calmv/calmv3form_model.dart';
import 'package:eassist_tools_app/repositories/gen_calmv/calmv3form_repository.dart';

part 'calmv3form_event.dart';
part 'calmv3form_state.dart';

class Calmv3FormBloc extends Bloc<Calmv3FormEvents, Calmv3FormState> {
	final Calmv3FormRepository repository;
	Calmv3FormBloc({required this.repository}) : super(const Calmv3FormState()) {
		on<Calmv3FormUbahEvent>(onUbahCalmv3Form);
		on<Calmv3FormTambahEvent>(onTambahCalmv3Form);
		on<Calmv3FormHapusEvent>(onHapusCalmv3Form);
		on<Calmv3FormLihatEvent>(onLihatCalmv3Form);
	}

	Future<void> onTambahCalmv3Form(
		Calmv3FormTambahEvent event, Emitter<Calmv3FormState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.calmv3FormTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahCalmv3Form(
		Calmv3FormUbahEvent event, Emitter<Calmv3FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.calmv3FormUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusCalmv3Form(
		Calmv3FormHapusEvent event, Emitter<Calmv3FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.calmv3FormHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatCalmv3Form(
		Calmv3FormLihatEvent event, Emitter<Calmv3FormState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Calmv3FormModel record = await repository.calmv3FormLihat(event.calmv1Id);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onHitungPremiCalmv3Form(
		Calmv3FormLihatEvent event, Emitter<Calmv3FormState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Calmv3FormModel record = await repository.calmv3FormHitungPremi(event.calmv1Id);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}