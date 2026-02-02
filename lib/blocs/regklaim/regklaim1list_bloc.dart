import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/regklaim/regklaim1list_model.dart';
import 'package:eassist_tools_app/repositories/regklaim/regklaim1list_repository.dart';

part 'regklaim1list_event.dart';
part 'regklaim1list_state.dart';

class Regklaim1ListBloc extends Bloc<Regklaim1ListEvents, Regklaim1ListState> {
	Regklaim1ListBloc() : super(const Regklaim1ListState()) {
		on<FetchRegklaim1ListEvent>(onFetchRegklaim1List);
		on<RefreshRegklaim1ListEvent>(onRefreshRegklaim1List);
		on<UbahRegklaim1ListEvent>(onUbahRegklaim1List);
		on<TambahRegklaim1ListEvent>(onTambahRegklaim1List);
		on<HapusRegklaim1ListEvent>(onHapusRegklaim1List);
		on<CloseDialogRegklaim1ListEvent>(onCloseDialogRegklaim1List);
	}

	Future<void> onRefreshRegklaim1List(
			RefreshRegklaim1ListEvent event, Emitter<Regklaim1ListState> emit) async {
		emit(const Regklaim1ListState());

		emit(state.copyWith(searchText: event.searchText));
		add(FetchRegklaim1ListEvent());
	}

	Future<void> onFetchRegklaim1List(
			FetchRegklaim1ListEvent event, Emitter<Regklaim1ListState> emit) async {
		if (state.hasReachedMax) return;

		Regklaim1ListRepository repo = Regklaim1ListRepository();
		if (state.status == ListStatus.initial) {
			List<Regklaim1ListModel> items = await repo.getRegklaim1List(state.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<Regklaim1ListModel> items = await repo.getRegklaim1List(state.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<Regklaim1ListModel> regklaim1List = List.of(state.items)..addAll(items);

			final result = regklaim1List
				.whereWithIndex((e, index) =>
					regklaim1List.indexWhere((e2) => e2.regklaim1Id == e.regklaim1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusRegklaim1List(
		HapusRegklaim1ListEvent event, Emitter<Regklaim1ListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogRegklaim1List(
		CloseDialogRegklaim1ListEvent event, Emitter<Regklaim1ListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahRegklaim1List(
		TambahRegklaim1ListEvent event, Emitter<Regklaim1ListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahRegklaim1List(
		UbahRegklaim1ListEvent event, Emitter<Regklaim1ListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}