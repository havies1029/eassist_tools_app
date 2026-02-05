import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/cobklaim/mcobklaimcari_model.dart';
import 'package:eassist_tools_app/repositories/cobklaim/mcobklaimcari_repository.dart';

part 'mcobklaimcari_event.dart';
part 'mcobklaimcari_state.dart';

class McobklaimCariBloc extends Bloc<McobklaimCariEvents, McobklaimCariState> {
	McobklaimCariBloc() : super(const McobklaimCariState()) {
		on<FetchMcobklaimCariEvent>(onFetchMcobklaimCari);
		on<RefreshMcobklaimCariEvent>(onRefreshMcobklaimCari);
	}

Future<void> onRefreshMcobklaimCari(
		RefreshMcobklaimCariEvent event, Emitter<McobklaimCariState> emit) async {
	emit(const McobklaimCariState());

	add(FetchMcobklaimCariEvent());
}

Future<void> onFetchMcobklaimCari(
		FetchMcobklaimCariEvent event, Emitter<McobklaimCariState> emit) async {
	if (state.hasReachedMax) return;

	McobklaimCariRepository repo = McobklaimCariRepository();
	if (state.status == ListStatus.initial) {
		List<McobklaimCariModel> items = await repo.getMcobklaimCari();
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			));
	}
	List<McobklaimCariModel> items = await repo.getMcobklaimCari();
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<McobklaimCariModel> mcobklaimCari = List.of(state.items)..addAll(items);

		final result = mcobklaimCari
			.whereWithIndex((e, index) =>
				mcobklaimCari.indexWhere((e2) => e2.mcobklaim1Id == e.mcobklaim1Id) ==
				index)
			.toList();

		return emit(state.copyWith(
			items: result,
			hasReachedMax: false,
			status: ListStatus.success,
			));
		}

	}
}