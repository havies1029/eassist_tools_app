import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulmb/simulmblist_model.dart';
import 'package:eassist_tools_app/repositories/simulmb/simulmblist_repository.dart';

part 'simulmblist_event.dart';
part 'simulmblist_state.dart';

class SimulmbListBloc extends Bloc<SimulmbListEvents, SimulmbListState> {
	SimulmbListBloc() : super(const SimulmbListState()) {
		on<FetchSimulmbListEvent>(onFetchSimulmbList);
		on<RefreshSimulmbListEvent>(onRefreshSimulmbList);
		on<UbahSimulmbListEvent>(onUbahSimulmbList);
		on<TambahSimulmbListEvent>(onTambahSimulmbList);
		on<HapusSimulmbListEvent>(onHapusSimulmbList);
		on<CloseDialogSimulmbListEvent>(onCloseDialogSimulmbList);
	}

	Future<void> onRefreshSimulmbList(
			RefreshSimulmbListEvent event, Emitter<SimulmbListState> emit) async {
		emit(const SimulmbListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulmbListEvent());
	}

	Future<void> onFetchSimulmbList(
			FetchSimulmbListEvent event, Emitter<SimulmbListState> emit) async {
		if (state.hasReachedMax) return;

		SimulmbListRepository repo = SimulmbListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulmbListModel> items = await repo.getSimulmbList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulmbListModel> items = await repo.getSimulmbList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulmbListModel> simulmbList = List.of(state.items)..addAll(items);

			final result = simulmbList
				.whereWithIndex((e, index) =>
					simulmbList.indexWhere((e2) => e2.simulmbId == e.simulmbId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulmbList(
		HapusSimulmbListEvent event, Emitter<SimulmbListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulmbList(
		CloseDialogSimulmbListEvent event, Emitter<SimulmbListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulmbList(
		TambahSimulmbListEvent event, Emitter<SimulmbListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulmbList(
		UbahSimulmbListEvent event, Emitter<SimulmbListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}