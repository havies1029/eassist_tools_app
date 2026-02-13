import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/perbaruiklaimpar/klaim5parlist_model.dart';
import 'package:eassist_tools_app/repositories/perbaruiklaimpar/klaim5parlist_repository.dart';

part 'klaim5parlist_event.dart';
part 'klaim5parlist_state.dart';

class Klaim5parListBloc extends Bloc<Klaim5parListEvents, Klaim5parListState> {
	Klaim5parListBloc() : super(const Klaim5parListState()) {
		on<FetchKlaim5parListEvent>(onFetchKlaim5parList);
		on<RefreshKlaim5parListEvent>(onRefreshKlaim5parList);
		on<UbahKlaim5parListEvent>(onUbahKlaim5parList);
		on<TambahKlaim5parListEvent>(onTambahKlaim5parList);
		on<HapusKlaim5parListEvent>(onHapusKlaim5parList);
		on<CloseDialogKlaim5parListEvent>(onCloseDialogKlaim5parList);
	}

	Future<void> onRefreshKlaim5parList(
			RefreshKlaim5parListEvent event, Emitter<Klaim5parListState> emit) async {
		emit(const Klaim5parListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchKlaim5parListEvent());
	}

	Future<void> onFetchKlaim5parList(
			FetchKlaim5parListEvent event, Emitter<Klaim5parListState> emit) async {
		if (state.hasReachedMax) return;

		Klaim5parListRepository repo = Klaim5parListRepository();
		if (state.status == ListStatus.initial) {
			List<Klaim5parListModel> items = await repo.getKlaim5parList(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<Klaim5parListModel> items = await repo.getKlaim5parList(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<Klaim5parListModel> klaim5parList = List.of(state.items)..addAll(items);

			final result = klaim5parList
				.whereWithIndex((e, index) =>
					klaim5parList.indexWhere((e2) => e2.klaim5Id == e.klaim5Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusKlaim5parList(
		HapusKlaim5parListEvent event, Emitter<Klaim5parListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogKlaim5parList(
		CloseDialogKlaim5parListEvent event, Emitter<Klaim5parListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahKlaim5parList(
		TambahKlaim5parListEvent event, Emitter<Klaim5parListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahKlaim5parList(
		UbahKlaim5parListEvent event, Emitter<Klaim5parListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}