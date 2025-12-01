import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/combobox/combommvjnscover_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/regmv/regmv2form_model.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv2form_repository.dart';

part 'regmv2form_event.dart';
part 'regmv2form_state.dart';

class Regmv2FormBloc extends Bloc<Regmv2FormEvents, Regmv2FormState> {
	final Regmv2FormRepository repository;
	Regmv2FormBloc({required this.repository}) : super(const Regmv2FormState()) {
		on<Regmv2FormUbahEvent>(onUbahRegmv2Form);
		on<Regmv2FormTambahEvent>(onTambahRegmv2Form);
		on<Regmv2FormHapusEvent>(onHapusRegmv2Form);
		on<Regmv2FormLihatEvent>(onLihatRegmv2Form);
		on<ComboMMvjnscoverChangedEvent>(onComboMMvjnscoverChanged);
		on<ComboRMatauangChangedEvent>(onComboRMatauangChanged);
	}

	Future<void> onTambahRegmv2Form(
		Regmv2FormTambahEvent event, Emitter<Regmv2FormState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.regmv2FormTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahRegmv2Form(
		Regmv2FormUbahEvent event, Emitter<Regmv2FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv2FormUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusRegmv2Form(
		Regmv2FormHapusEvent event, Emitter<Regmv2FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv2FormHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatRegmv2Form(
		Regmv2FormLihatEvent event, Emitter<Regmv2FormState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Regmv2FormModel record = await repository.regmv2FormLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record, comboMMvjnscover: record.comboMMvjnscover, comboRMatauang: record.comboRMatauang));
	}

	Future<void> onComboMMvjnscoverChanged(
			ComboMMvjnscoverChangedEvent event, Emitter<Regmv2FormState> emit) async {

		ComboMMvjnscoverModel comboMMvjnscover = event.comboMMvjnscover;
		emit(state.copyWith(
			comboMMvjnscover: comboMMvjnscover));
	}

	Future<void> onComboRMatauangChanged(
			ComboRMatauangChangedEvent event, Emitter<Regmv2FormState> emit) async {

		ComboRMatauangModel comboRMatauang = event.comboRMatauang;
		emit(state.copyWith(
			comboRMatauang: comboRMatauang));
	}

}