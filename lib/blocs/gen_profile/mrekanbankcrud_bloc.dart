import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanbankcrud_repository.dart';

part 'mrekanbankcrud_event.dart';
part 'mrekanbankcrud_state.dart';

class MRekanBankCrudBloc extends Bloc<MRekanBankCrudEvents, MRekanBankCrudState> {
	final MRekanBankCrudRepository repository;
	MRekanBankCrudBloc({required this.repository}) : super(const MRekanBankCrudState()) {
		on<MRekanBankCrudUbahEvent>(onUbahMRekanBankCrud);
		on<MRekanBankCrudLihatEvent>(onLihatMRekanBankCrud);
	}

	
	Future<void> onUbahMRekanBankCrud(
		MRekanBankCrudUbahEvent event, Emitter<MRekanBankCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mRekanBankCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure, record: event.record));
	}

	Future<void> onLihatMRekanBankCrud(
		MRekanBankCrudLihatEvent event, Emitter<MRekanBankCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MRekanBankCrudModel record = await repository.mRekanBankCrudLihat();
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}