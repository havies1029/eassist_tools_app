import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/gen_profile/rekanpiccobcari_model.dart';
import 'package:eassist_tools_app/repositories/gen_profile/rekanpiccobcari_repository.dart';

part 'rekanpiccobcari_event.dart';
part 'rekanpiccobcari_state.dart';

class RekanPicCobCariBloc extends Bloc<RekanPicCobCariEvents, RekanPicCobCariState> {
	RekanPicCobCariBloc() : super(const RekanPicCobCariState()) {
		on<FetchRekanPicCobCariEvent>(onFetchRekanPicCobCari);
		on<RefreshRekanPicCobCariEvent>(onRefreshRekanPicCobCari);
	}

Future<void> onRefreshRekanPicCobCari(
		RefreshRekanPicCobCariEvent event, Emitter<RekanPicCobCariState> emit) async {
	emit(const RekanPicCobCariState());

  emit(state.copyWith(rekanPicId: event.rekanPicId, searchText: event.searchText));

	add(FetchRekanPicCobCariEvent());
}

Future<void> onFetchRekanPicCobCari(
		FetchRekanPicCobCariEvent event, Emitter<RekanPicCobCariState> emit) async {
	if (state.hasReachedMax) return;

	RekanPicCobCariRepository repo = RekanPicCobCariRepository();
	if (state.status == ListStatus.initial) {
		List<RekanPicCobCariModel> items = await repo.getRekanPicCobCari(state.rekanPicId, state.searchText, 0);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
      hal: 1
			));
	}
	List<RekanPicCobCariModel> items = await repo.getRekanPicCobCari(state.rekanPicId, state.searchText, state.hal);
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<RekanPicCobCariModel> rekanPicCobCari = List.of(state.items)..addAll(items);

		final result = rekanPicCobCari
			.whereWithIndex((e, index) =>
				rekanPicCobCari.indexWhere((e2) => e2.mrekanpiccobId == e.mrekanpiccobId) ==
				index)
			.toList();

		return emit(state.copyWith(
			items: result,
			hasReachedMax: false,
			status: ListStatus.success,
      hal: state.hal + 1
			));
		}

	}
}