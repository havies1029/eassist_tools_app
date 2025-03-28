import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulgis/simulgislist_model.dart';
import 'package:eassist_tools_app/repositories/simulgis/simulgislist_repository.dart';

part 'simulgislist_event.dart';
part 'simulgislist_state.dart';

class SimulgisListBloc extends Bloc<SimulgisListEvents, SimulgisListState> {
	SimulgisListBloc() : super(const SimulgisListState()) {
		on<FetchSimulgisListEvent>(onFetchSimulgisList);
		on<RefreshSimulgisListEvent>(onRefreshSimulgisList);
		on<UbahSimulgisListEvent>(onUbahSimulgisList);
		on<TambahSimulgisListEvent>(onTambahSimulgisList);
		on<HapusSimulgisListEvent>(onHapusSimulgisList);
		on<CloseDialogSimulgisListEvent>(onCloseDialogSimulgisList);
	}

	Future<void> onRefreshSimulgisList(
			RefreshSimulgisListEvent event, Emitter<SimulgisListState> emit) async {
		emit(const SimulgisListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulgisListEvent());
	}

	Future<void> onFetchSimulgisList(
			FetchSimulgisListEvent event, Emitter<SimulgisListState> emit) async {
		if (state.hasReachedMax) return;

		SimulgisListRepository repo = SimulgisListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulgisListModel> items = await repo.getSimulgisList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulgisListModel> items = await repo.getSimulgisList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulgisListModel> simulgisList = List.of(state.items)..addAll(items);

			final result = simulgisList
				.whereWithIndex((e, index) =>
					simulgisList.indexWhere((e2) => e2.simulgisId == e.simulgisId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulgisList(
		HapusSimulgisListEvent event, Emitter<SimulgisListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulgisList(
		CloseDialogSimulgisListEvent event, Emitter<SimulgisListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulgisList(
		TambahSimulgisListEvent event, Emitter<SimulgisListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulgisList(
		UbahSimulgisListEvent event, Emitter<SimulgisListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}