import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/profile/rekanpic_model.dart';
import 'package:eassist_tools_app/repositories/profile/rekanpic_repository.dart';

part 'rekanpic_event.dart';
part 'rekanpic_state.dart';

class RekanPicBloc extends Bloc<RekanPicEvents, RekanPicState> {
	final RekanPicRepository repository;
	RekanPicBloc({required this.repository}) : super(const RekanPicState()) {
		on<RekanPicUbahEvent>(onUbahRekanPic);
		on<RekanPicTambahEvent>(onTambahRekanPic);
		on<RekanPicHapusEvent>(onHapusRekanPic);
		on<RekanPicLihatEvent>(onLihatRekanPic);
	}

	Future<void> onTambahRekanPic(
		RekanPicTambahEvent event, Emitter<RekanPicState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.rekanPicTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahRekanPic(
		RekanPicUbahEvent event, Emitter<RekanPicState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.rekanPicUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusRekanPic(
		RekanPicHapusEvent event, Emitter<RekanPicState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.rekanPicHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatRekanPic(
		RekanPicLihatEvent event, Emitter<RekanPicState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		RekanPicModel record = await repository.rekanPicLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}