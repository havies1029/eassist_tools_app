import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulcar/simulcarlist_model.dart';
import 'package:eassist_tools_app/repositories/simulcar/simulcarlist_repository.dart';

part 'simulcarlist_event.dart';
part 'simulcarlist_state.dart';

class SimulcarListBloc extends Bloc<SimulcarListEvents, SimulcarListState> {
	SimulcarListBloc() : super(const SimulcarListState()) {
		on<FetchSimulcarListEvent>(onFetchSimulcarList);
		on<RefreshSimulcarListEvent>(onRefreshSimulcarList);
		on<UbahSimulcarListEvent>(onUbahSimulcarList);
		on<TambahSimulcarListEvent>(onTambahSimulcarList);
		on<HapusSimulcarListEvent>(onHapusSimulcarList);
		on<CloseDialogSimulcarListEvent>(onCloseDialogSimulcarList);
	}

	Future<void> onRefreshSimulcarList(
			RefreshSimulcarListEvent event, Emitter<SimulcarListState> emit) async {
		emit(const SimulcarListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulcarListEvent());
	}

	Future<void> onFetchSimulcarList(
			FetchSimulcarListEvent event, Emitter<SimulcarListState> emit) async {
		if (state.hasReachedMax) return;

		SimulcarListRepository repo = SimulcarListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulcarListModel> items = await repo.getSimulcarList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulcarListModel> items = await repo.getSimulcarList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulcarListModel> simulcarList = List.of(state.items)..addAll(items);

			final result = simulcarList
				.whereWithIndex((e, index) =>
					simulcarList.indexWhere((e2) => e2.simulcarId == e.simulcarId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulcarList(
		HapusSimulcarListEvent event, Emitter<SimulcarListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulcarList(
		CloseDialogSimulcarListEvent event, Emitter<SimulcarListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulcarList(
		TambahSimulcarListEvent event, Emitter<SimulcarListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulcarList(
		UbahSimulcarListEvent event, Emitter<SimulcarListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}