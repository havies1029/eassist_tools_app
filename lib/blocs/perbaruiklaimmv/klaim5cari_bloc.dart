
import 'package:eassist_tools_app/repositories/perbaruiklaimmv/klaim5upload_repository.dart';
import 'package:eassist_tools_app/repositories/perbaruiklaimmv/klaimmvdoccrud_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaim5cari_model.dart';
import 'package:eassist_tools_app/repositories/perbaruiklaimmv/klaim5cari_repository.dart';

part 'klaim5cari_event.dart';
part 'klaim5cari_state.dart';

class Klaim5cariBloc extends Bloc<Klaim5cariEvents, Klaim5cariState> {
	Klaim5cariBloc() : super(const Klaim5cariState()) {
		on<FetchKlaim5cariEvent>(onFetchKlaim5cari);
		on<RefreshKlaim5cariEvent>(onRefreshKlaim5cari);
    on<Klaim5LocalFileSetEvent>(onKlaim5LocalFileSet);
    on<Klaim5DeleteRequestedEvent>(onKlaim5DeleteRequested);
    on<Klaim5UploadRequestedEvent>(onKlaim5UploadRequested);
	}

Future<void> onRefreshKlaim5cari(
		RefreshKlaim5cariEvent event, Emitter<Klaim5cariState> emit) async {
	emit(const Klaim5cariState());
  emit(state.copyWith(klaim1Id: event.klaim1Id));
	add(FetchKlaim5cariEvent());
}

Future<void> onFetchKlaim5cari(
		FetchKlaim5cariEvent event, Emitter<Klaim5cariState> emit) async {
	if (state.hasReachedMax) return;

	Klaim5cariRepository repo = Klaim5cariRepository();
	if (state.status == ListStatus.initial) {
		List<Klaim5cariModel> items = await repo.getKlaim5cari(state.klaim1Id);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: true,
			status: ListStatus.success,
			));
	  }
  }

  Future<void> onKlaim5LocalFileSet(Klaim5LocalFileSetEvent event, Emitter<Klaim5cariState> emit) async {
    final idx = state.items.indexWhere((x) => x.mjenisdocId == event.mjenisdocId);
    if (idx < 0) return;

    final oldItem = state.items[idx];

    final newItem = oldItem.copyWith(
      localPath: event.localPath,
      fileName: event.fileName,
      mimeType: event.mimeType,
      fileSizeBytes: event.fileSizeBytes,
      uploadProgress: 0.0,
      uploadStatus: 'idle',
      clearError: true,
    );

    final newItems = List<Klaim5cariModel>.from(state.items);
    newItems[idx] = newItem;

    emit(state.copyWith(items: newItems));
  }

  Future<void> onKlaim5DeleteRequested(Klaim5DeleteRequestedEvent event, Emitter<Klaim5cariState> emit) async {
    final idx = state.items.indexWhere((x) => x.mjenisdocId == event.mjenisdocId);
    if (idx < 0) return;

    // 1) Clear lokal dulu (optimistic) + status deleting

    final oldItem = state.items[idx];

    final newItem = oldItem.copyWith(
      localPath: '',
      fileName: '',
      mimeType: '',
      fileSizeBytes: 0,
      uploadProgress: 0.0,
      uploadStatus: 'deleted',
      clearError: true,
    );

    final newItems = List<Klaim5cariModel>.from(state.items);
    newItems[idx] = newItem;

    emit(state.copyWith(items: newItems));

    // 2) Hapus di server jika klaim5Id != ''
    if (oldItem.klaim5Id.isNotEmpty) {
      KlaimmvdoccrudRepository repository = KlaimmvdoccrudRepository();
      if (event.mjenisdocId.isNotEmpty) {
        final success = await repository.klaimmvdoccrudHapus(oldItem.klaim5Id);
        if (!success) {
          // jika gagal, kembalikan item lama
          final revertItems = List<Klaim5cariModel>.from(state.items);
          revertItems[idx] = oldItem;
          emit(state.copyWith(items: revertItems));
        }
      }
    }
  }

  Future<void> onKlaim5UploadRequested(Klaim5UploadRequestedEvent event, Emitter<Klaim5cariState> emit) async {
    final idx = state.items.indexWhere((x) => x.mjenisdocId == event.mjenisdocId);
    if (idx < 0) return;

    final item = state.items[idx];
    if (item.localPath == '') return;

    final newItems = List<Klaim5cariModel>.from(state.items);

    // set status uploading
    var newItem = item.copyWith(
      uploadStatus: 'uploading',
      uploadProgress: 0.0,
      clearError: true,
    );
    newItems[idx] = newItem;
    emit(state.copyWith(items: newItems));

    // mulai upload
    Klaim5uploadRepository repository = Klaim5uploadRepository();
    try {
      await repository.uploadFile(state.klaim1Id, newItem);

      // jika sukses
      newItem = newItem.copyWith(
        uploadStatus: 'uploaded',
        uploadProgress: 1.0,
      );
      newItems[idx] = newItem;
      emit(state.copyWith(items: newItems));
    } catch (e) {
      // jika gagal
      newItem = newItem.copyWith(
        uploadStatus: 'error',
        clearError: false,
      );
      newItems[idx] = newItem;
      emit(state.copyWith(items: newItems));
    }
  }

}