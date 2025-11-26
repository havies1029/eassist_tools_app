import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulcargo/simulcargolist_model.dart';
import 'package:eassist_tools_app/repositories/simulcargo/simulcargolist_repository.dart';

part 'simulcargolist_event.dart';
part 'simulcargolist_state.dart';

class SimulcargoListBloc extends Bloc<SimulcargoListEvents, SimulcargoListState> {
	SimulcargoListBloc() : super(const SimulcargoListState()) {
		on<FetchSimulcargoListEvent>(onFetchSimulcargoList);
		on<RefreshSimulcargoListEvent>(onRefreshSimulcargoList);
		on<UbahSimulcargoListEvent>(onUbahSimulcargoList);
		on<TambahSimulcargoListEvent>(onTambahSimulcargoList);
		on<HapusSimulcargoListEvent>(onHapusSimulcargoList);
		on<CloseDialogSimulcargoListEvent>(onCloseDialogSimulcargoList);
	}

	Future<void> onRefreshSimulcargoList(
			RefreshSimulcargoListEvent event, Emitter<SimulcargoListState> emit) async {
		emit(const SimulcargoListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulcargoListEvent());
	}

	Future<void> onFetchSimulcargoList(
			FetchSimulcargoListEvent event, Emitter<SimulcargoListState> emit) async {
		if (state.hasReachedMax) return;

		SimulcargoListRepository repo = SimulcargoListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulcargoListModel> items = await repo.getSimulcargoList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulcargoListModel> items = await repo.getSimulcargoList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulcargoListModel> simulcargoList = List.of(state.items)..addAll(items);

			final result = simulcargoList
				.whereWithIndex((e, index) =>
					simulcargoList.indexWhere((e2) => e2.simulcargoId == e.simulcargoId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulcargoList(
		HapusSimulcargoListEvent event, Emitter<SimulcargoListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulcargoList(
		CloseDialogSimulcargoListEvent event, Emitter<SimulcargoListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulcargoList(
		TambahSimulcargoListEvent event, Emitter<SimulcargoListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulcargoList(
		UbahSimulcargoListEvent event, Emitter<SimulcargoListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}