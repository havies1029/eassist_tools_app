import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/list_extension.dart';
import 'package:eassist_tools_app/models/gen_dn1/dn1cari_model.dart';
import 'package:eassist_tools_app/repositories/gen_dn1/dn1cari_repository.dart';

part 'dn1cari_event.dart';
part 'dn1cari_state.dart';

class Dn1CariBloc extends Bloc<Dn1CariEvents, Dn1CariState> {
	Dn1CariBloc() : super(const Dn1CariState()) {
		on<FetchDn1CariEvent>(onFetchDn1Cari);
		on<RefreshDn1CariEvent>(onRefreshDn1Cari);
	}

Future<void> onRefreshDn1Cari(
		RefreshDn1CariEvent event, Emitter<Dn1CariState> emit) async {
	emit(const Dn1CariState());

  emit(state.copyWith(sppa1Id: event.sppa1Id));

	add(FetchDn1CariEvent());
}

Future<void> onFetchDn1Cari(
		FetchDn1CariEvent event, Emitter<Dn1CariState> emit) async {
	if (state.hasReachedMax) return;

	Dn1CariRepository repo = Dn1CariRepository();
	if (state.status == ListStatus.initial) {
		List<Dn1CariModel> items = await repo.getDn1Cari(state.sppa1Id);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			));
	}
	List<Dn1CariModel> items = await repo.getDn1Cari(state.sppa1Id);
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<Dn1CariModel> dn1Cari = List.of(state.items)..addAll(items);

		final result = dn1Cari
			.whereWithIndex((e, index) =>
				dn1Cari.indexWhere((e2) => e2.dn1Id == e.dn1Id) ==
				index)
			.toList();

		return emit(state.copyWith(
			items: result,
			hasReachedMax: false,
			status: ListStatus.success,
			));
		}

	}
}