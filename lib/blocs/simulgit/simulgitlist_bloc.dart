import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/simulgit/simulgitlist_model.dart';
import 'package:eassist_tools_app/repositories/simulgit/simulgitlist_repository.dart';

part 'simulgitlist_event.dart';
part 'simulgitlist_state.dart';

class SimulgitListBloc extends Bloc<SimulgitListEvents, SimulgitListState> {
	SimulgitListBloc() : super(const SimulgitListState()) {
		on<FetchSimulgitListEvent>(onFetchSimulgitList);
		on<RefreshSimulgitListEvent>(onRefreshSimulgitList);
		on<UbahSimulgitListEvent>(onUbahSimulgitList);
		on<TambahSimulgitListEvent>(onTambahSimulgitList);
		on<HapusSimulgitListEvent>(onHapusSimulgitList);
		on<CloseDialogSimulgitListEvent>(onCloseDialogSimulgitList);
	}

	Future<void> onRefreshSimulgitList(
			RefreshSimulgitListEvent event, Emitter<SimulgitListState> emit) async {
		emit(const SimulgitListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchSimulgitListEvent());
	}

	Future<void> onFetchSimulgitList(
			FetchSimulgitListEvent event, Emitter<SimulgitListState> emit) async {
		if (state.hasReachedMax) return;

		SimulgitListRepository repo = SimulgitListRepository();
		if (state.status == ListStatus.initial) {
			List<SimulgitListModel> items = await repo.getSimulgitList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SimulgitListModel> items = await repo.getSimulgitList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SimulgitListModel> simulgitList = List.of(state.items)..addAll(items);

			final result = simulgitList
				.whereWithIndex((e, index) =>
					simulgitList.indexWhere((e2) => e2.simulgitId == e.simulgitId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSimulgitList(
		HapusSimulgitListEvent event, Emitter<SimulgitListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSimulgitList(
		CloseDialogSimulgitListEvent event, Emitter<SimulgitListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSimulgitList(
		TambahSimulgitListEvent event, Emitter<SimulgitListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSimulgitList(
		UbahSimulgitListEvent event, Emitter<SimulgitListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}