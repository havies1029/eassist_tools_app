import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/reguser/reguser_model.dart';
import 'package:eassist_tools_app/repositories/reguser/reguser_repository.dart';

part 'reguser_event.dart';
part 'reguser_state.dart';

class RegUserBloc extends Bloc<RegUserEvents, RegUserState> {
	final RegUserRepository repository;
	RegUserBloc({required this.repository}) : super(const RegUserState()) {
		on<RegUserUbahEvent>(onUbahRegUser);
		on<RegUserTambahEvent>(onTambahRegUser);
		on<RegUserHapusEvent>(onHapusRegUser);
		on<RegUserLihatEvent>(onLihatRegUser);
	}

	Future<void> onTambahRegUser(
		RegUserTambahEvent event, Emitter<RegUserState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.regUserTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahRegUser(
		RegUserUbahEvent event, Emitter<RegUserState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regUserUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusRegUser(
		RegUserHapusEvent event, Emitter<RegUserState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regUserHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatRegUser(
		RegUserLihatEvent event, Emitter<RegUserState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		RegUserModel record = await repository.regUserLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}