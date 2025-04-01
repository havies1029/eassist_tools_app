import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simultree/simultreelist_model.dart';
import 'package:eassist_tools_app/repositories/simultree/simultreelist_repository.dart';

part 'simultreelist_event.dart';
part 'simultreelist_state.dart';

class SimultreeListBloc extends Bloc<SimultreeListEvents, SimultreeListState> {
	SimultreeListBloc() : super(const SimultreeListState()) {
		on<FetchSimultreeListEvent>(onFetchSimultreeList);
		on<RefreshSimultreeListEvent>(onRefreshSimultreeList);
		on<UbahSimultreeListEvent>(onUbahSimultreeList);
		on<TambahSimultreeListEvent>(onTambahSimultreeList);
		on<HapusSimultreeListEvent>(onHapusSimultreeList);
		on<CloseDialogSimultreeListEvent>(onCloseDialogSimultreeList);
	}

	Future<void> onRefreshSimultreeList(
			RefreshSimultreeListEvent event, Emitter<SimultreeListState> emit) async {
		emit(const SimultreeListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimultreeListEvent());
	}

	Future<void> onFetchSimultreeList(
			FetchSimultreeListEvent event, Emitter<SimultreeListState> emit) async {
		if (state.hasReachedMax) return;

		SimultreeListRepository repo = SimultreeListRepository();
		if (state.status == ListStatus.initial) {
			List<SimultreeListModel> items = await repo.getSimultreeList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimultreeListModel> items = await repo.getSimultreeList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimultreeListModel> simultreeList = List.of(state.items)..addAll(items);

			final result = simultreeList
				.whereWithIndex((e, index) =>
					simultreeList.indexWhere((e2) => e2.simultreeId == e.simultreeId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimultreeList(
		HapusSimultreeListEvent event, Emitter<SimultreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimultreeList(
		CloseDialogSimultreeListEvent event, Emitter<SimultreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimultreeList(
		TambahSimultreeListEvent event, Emitter<SimultreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimultreeList(
		UbahSimultreeListEvent event, Emitter<SimultreeListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}