import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulbon/simulbonlist_model.dart';
import 'package:eassist_tools_app/repositories/simulbon/simulbonlist_repository.dart';

part 'simulbonlist_event.dart';
part 'simulbonlist_state.dart';

class SimulbonListBloc extends Bloc<SimulbonListEvents, SimulbonListState> {
	SimulbonListBloc() : super(const SimulbonListState()) {
		on<FetchSimulbonListEvent>(onFetchSimulbonList);
		on<RefreshSimulbonListEvent>(onRefreshSimulbonList);
		on<UbahSimulbonListEvent>(onUbahSimulbonList);
		on<TambahSimulbonListEvent>(onTambahSimulbonList);
		on<HapusSimulbonListEvent>(onHapusSimulbonList);
		on<CloseDialogSimulbonListEvent>(onCloseDialogSimulbonList);
	}

	Future<void> onRefreshSimulbonList(
			RefreshSimulbonListEvent event, Emitter<SimulbonListState> emit) async {
		emit(const SimulbonListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulbonListEvent());
	}

	Future<void> onFetchSimulbonList(
			FetchSimulbonListEvent event, Emitter<SimulbonListState> emit) async {
		if (state.hasReachedMax) return;

		SimulbonListRepository repo = SimulbonListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulbonListModel> items = await repo.getSimulbonList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulbonListModel> items = await repo.getSimulbonList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulbonListModel> simulbonList = List.of(state.items)..addAll(items);

			final result = simulbonList
				.whereWithIndex((e, index) =>
					simulbonList.indexWhere((e2) => e2.simulbon1Id == e.simulbon1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulbonList(
		HapusSimulbonListEvent event, Emitter<SimulbonListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulbonList(
		CloseDialogSimulbonListEvent event, Emitter<SimulbonListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulbonList(
		TambahSimulbonListEvent event, Emitter<SimulbonListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulbonList(
		UbahSimulbonListEvent event, Emitter<SimulbonListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}