import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulwp/simulwplist_model.dart';
import 'package:eassist_tools_app/repositories/simulwp/simulwplist_repository.dart';

part 'simulwplist_event.dart';
part 'simulwplist_state.dart';

class SimulwpListBloc extends Bloc<SimulwpListEvents, SimulwpListState> {
	SimulwpListBloc() : super(const SimulwpListState()) {
		on<FetchSimulwpListEvent>(onFetchSimulwpList);
		on<RefreshSimulwpListEvent>(onRefreshSimulwpList);
		on<UbahSimulwpListEvent>(onUbahSimulwpList);
		on<TambahSimulwpListEvent>(onTambahSimulwpList);
		on<HapusSimulwpListEvent>(onHapusSimulwpList);
		on<CloseDialogSimulwpListEvent>(onCloseDialogSimulwpList);
	}

	Future<void> onRefreshSimulwpList(
			RefreshSimulwpListEvent event, Emitter<SimulwpListState> emit) async {
		emit(const SimulwpListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulwpListEvent());
	}

	Future<void> onFetchSimulwpList(
			FetchSimulwpListEvent event, Emitter<SimulwpListState> emit) async {
		if (state.hasReachedMax) return;

		SimulwpListRepository repo = SimulwpListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulwpListModel> items = await repo.getSimulwpList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulwpListModel> items = await repo.getSimulwpList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulwpListModel> simulwpList = List.of(state.items)..addAll(items);

			final result = simulwpList
				.whereWithIndex((e, index) =>
					simulwpList.indexWhere((e2) => e2.simulwp1Id == e.simulwp1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulwpList(
		HapusSimulwpListEvent event, Emitter<SimulwpListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulwpList(
		CloseDialogSimulwpListEvent event, Emitter<SimulwpListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulwpList(
		TambahSimulwpListEvent event, Emitter<SimulwpListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulwpList(
		UbahSimulwpListEvent event, Emitter<SimulwpListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}