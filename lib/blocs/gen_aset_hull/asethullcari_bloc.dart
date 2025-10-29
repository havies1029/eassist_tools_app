import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/gen_aset_hull/asethullcari_model.dart';
import 'package:eassist_tools_app/repositories/gen_aset_hull/asethullcari_repository.dart';

part 'asethullcari_event.dart';
part 'asethullcari_state.dart';

class AsethullCariBloc extends Bloc<AsethullCariEvents, AsethullCariState> {
	AsethullCariBloc() : super(const AsethullCariState()) {
		on<FetchAsethullCariEvent>(onFetchAsethullCari);
		on<RefreshAsethullCariEvent>(onRefreshAsethullCari);
	}

Future<void> onRefreshAsethullCari(
		RefreshAsethullCariEvent event, Emitter<AsethullCariState> emit) async {
	emit(const AsethullCariState());
  
  emit(state.copyWith(statusId: event.statusId, searchText: event.searchText));

	add(FetchAsethullCariEvent());
}

Future<void> onFetchAsethullCari(
		FetchAsethullCariEvent event, Emitter<AsethullCariState> emit) async {
	if (state.hasReachedMax) return;

	AsethullCariRepository repo = AsethullCariRepository();
	if (state.status == ListStatus.initial) {
		List<AsethullCariModel> items = await repo.getAsethullCari(state.statusId, state.searchText, 0);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
      hal: 1
			));
	}
	List<AsethullCariModel> items = await repo.getAsethullCari(state.statusId, state.searchText, state.hal);
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<AsethullCariModel> asethullCari = List.of(state.items)..addAll(items);

		final result = asethullCari
			.whereWithIndex((e, index) =>
				asethullCari.indexWhere((e2) => e2.asetHullId == e.asetHullId) ==
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