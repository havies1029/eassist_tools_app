import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simuleei/simuleeilist_model.dart';
import 'package:eassist_tools_app/repositories/simuleei/simuleeilist_repository.dart';

part 'simuleeilist_event.dart';
part 'simuleeilist_state.dart';

class SimuleeiListBloc extends Bloc<SimuleeiListEvents, SimuleeiListState> {
	SimuleeiListBloc() : super(const SimuleeiListState()) {
		on<FetchSimuleeiListEvent>(onFetchSimuleeiList);
		on<RefreshSimuleeiListEvent>(onRefreshSimuleeiList);
		on<UbahSimuleeiListEvent>(onUbahSimuleeiList);
		on<TambahSimuleeiListEvent>(onTambahSimuleeiList);
		on<HapusSimuleeiListEvent>(onHapusSimuleeiList);
		on<CloseDialogSimuleeiListEvent>(onCloseDialogSimuleeiList);
	}

	Future<void> onRefreshSimuleeiList(
			RefreshSimuleeiListEvent event, Emitter<SimuleeiListState> emit) async {
		emit(const SimuleeiListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimuleeiListEvent());
	}

	Future<void> onFetchSimuleeiList(
			FetchSimuleeiListEvent event, Emitter<SimuleeiListState> emit) async {
		if (state.hasReachedMax) return;

		SimuleeiListRepository repo = SimuleeiListRepository();
		if (state.status == ListStatus.initial) {
			List<SimuleeiListModel> items = await repo.getSimuleeiList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimuleeiListModel> items = await repo.getSimuleeiList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimuleeiListModel> simuleeiList = List.of(state.items)..addAll(items);

			final result = simuleeiList
				.whereWithIndex((e, index) =>
					simuleeiList.indexWhere((e2) => e2.simuleei1Id == e.simuleei1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimuleeiList(
		HapusSimuleeiListEvent event, Emitter<SimuleeiListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimuleeiList(
		CloseDialogSimuleeiListEvent event, Emitter<SimuleeiListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimuleeiList(
		TambahSimuleeiListEvent event, Emitter<SimuleeiListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimuleeiList(
		UbahSimuleeiListEvent event, Emitter<SimuleeiListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}