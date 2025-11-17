import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/calpar/calpar2form_model.dart';
import 'package:eassist_tools_app/repositories/calpar/calpar2form_repository.dart';

part 'calpar2form_event.dart';
part 'calpar2form_state.dart';

class Calpar2FormBloc extends Bloc<Calpar2FormEvents, Calpar2FormState> {
	final Calpar2FormRepository repository;
	Calpar2FormBloc({required this.repository}) : super(const Calpar2FormState()) {
		on<Calpar2FormUbahEvent>(onUbahCalpar2Form);
		on<Calpar2FormTambahEvent>(onTambahCalpar2Form);
		on<Calpar2FormHapusEvent>(onHapusCalpar2Form);
		on<Calpar2FormLihatEvent>(onLihatCalpar2Form);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahCalpar2Form(
		Calpar2FormTambahEvent event, Emitter<Calpar2FormState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.calpar2FormTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahCalpar2Form(
		Calpar2FormUbahEvent event, Emitter<Calpar2FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.calpar2FormUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusCalpar2Form(
		Calpar2FormHapusEvent event, Emitter<Calpar2FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.calpar2FormHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatCalpar2Form(
		Calpar2FormLihatEvent event, Emitter<Calpar2FormState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Calpar2FormModel record = await repository.calpar2FormLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<Calpar2FormState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			comboRMatauang: comboRMatauang));
	}

}