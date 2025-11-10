import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/gen_regmv/regmv6form_model.dart';
import 'package:eassist_tools_app/repositories/gen_regmv/regmv6form_repository.dart';

part 'regmv6form_event.dart';
part 'regmv6form_state.dart';

class Regmv6FormBloc extends Bloc<Regmv6FormEvents, Regmv6FormState> {
	final Regmv6FormRepository repository;
	Regmv6FormBloc({required this.repository}) : super(const Regmv6FormState()) {
		on<Regmv6FormUbahEvent>(onUbahRegmv6Form);
		on<Regmv6FormTambahEvent>(onTambahRegmv6Form);
		on<Regmv6FormHapusEvent>(onHapusRegmv6Form);
		on<Regmv6FormLihatEvent>(onLihatRegmv6Form);
    on<CalPremiRegMvEvent>(onCalPremiRegMv);
	}

	Future<void> onTambahRegmv6Form(
		Regmv6FormTambahEvent event, Emitter<Regmv6FormState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.regmv6FormTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahRegmv6Form(
		Regmv6FormUbahEvent event, Emitter<Regmv6FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv6FormUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusRegmv6Form(
		Regmv6FormHapusEvent event, Emitter<Regmv6FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv6FormHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatRegmv6Form(
		Regmv6FormLihatEvent event, Emitter<Regmv6FormState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		Regmv6FormModel record = await repository.regmv6FormLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}
  
  Future<void> onCalPremiRegMv(
    CalPremiRegMvEvent event, Emitter<Regmv6FormState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    Regmv6FormModel record = await repository.calPremiRegMv(event.recordId);
    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

}