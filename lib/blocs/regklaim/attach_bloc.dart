import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:eassist_tools_app/models/regklaim/attachment_item.dart';
import 'package:eassist_tools_app/repositories/regklaim/picker_repository.dart';
import 'package:eassist_tools_app/repositories/regklaim/upload_repository.dart';

part 'attach_event.dart';
part 'attach_state.dart';

class AttachBloc extends Bloc<AttachEvent, AttachState> {
  final PickerRepository pickerRepo;
  final UploadRepository uploadRepo;

  final Map<String, CancelToken> _cancelTokens = {};

  AttachBloc({required this.pickerRepo, required this.uploadRepo})
      : super(const AttachState()) {
    on<PickImageFromCamera>(_onPickCamera);
    on<PickFilesFromStorage>(_onPickFiles);
    on<RemoveAttachment>(_onRemove);

    on<UploadOne>(_onUploadOne);
    on<RetryUpload>(_onRetry);
    on<CancelUpload>(_onCancel);
    on<_ProgressChanged>(_onProgressChanged);
  }

  Future<void> _onPickCamera(
      PickImageFromCamera event, Emitter<AttachState> emit) async {
    final item = await pickerRepo.pickFromCamera();
    if (item == null) return;
    emit(state.copyWith(items: [...state.items, item]));
  }

  Future<void> _onPickFiles(
      PickFilesFromStorage event, Emitter<AttachState> emit) async {
    final picked = await pickerRepo.pickFiles();
    if (picked.isEmpty) return;
    emit(state.copyWith(items: [...state.items, ...picked]));
  }

  void _onRemove(RemoveAttachment event, Emitter<AttachState> emit) {
    _cancelTokens.remove(event.localId)?.cancel("Removed by user");
    emit(state.copyWith(
      items: state.items.where((e) => e.localId != event.localId).toList(),
    ));
  }

  Future<void> _onUploadOne(UploadOne event, Emitter<AttachState> emit) async {
    final idx = state.items.indexWhere((e) => e.localId == event.localId);
    if (idx < 0) return;

    final current = state.items[idx];
    if (current.status == UploadStatus.uploading) return;

    _updateItem(
      emit,
      event.localId,
      (x) => x.copyWith(
        status: UploadStatus.uploading,
        progress: 0.0,
        errorMessage: null,
      ),
    );

    final cancelToken = CancelToken();
    _cancelTokens[event.localId] = cancelToken;

    try {
      final res = await uploadRepo.uploadAttachment(
        regklaim1Id: event.regklaim1Id,
        item: current,
        cancelToken: cancelToken,
        onProgress: (p) => add(_ProgressChanged(event.localId, p)),
      );

      _cancelTokens.remove(event.localId);

      _updateItem(
        emit,
        event.localId,
        (x) => x.copyWith(
          status: UploadStatus.success,
          progress: 1.0,
          serverId: res.serverId,
          serverUrl: res.serverUrl,
        ),
      );
    } catch (e) {
      _cancelTokens.remove(event.localId);
      _updateItem(
        emit,
        event.localId,
        (x) => x.copyWith(
          status: UploadStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onRetry(RetryUpload event, Emitter<AttachState> emit) {
    add(UploadOne(localId: event.localId, regklaim1Id: event.regklaim1Id));
  }

  void _onCancel(CancelUpload event, Emitter<AttachState> emit) {
    _cancelTokens.remove(event.localId)?.cancel("Canceled by user");
    _updateItem(
      emit,
      event.localId,
      (x) => x.copyWith(status: UploadStatus.canceled, errorMessage: "Canceled"),
    );
  }

  void _onProgressChanged(_ProgressChanged event, Emitter<AttachState> emit) {
    _updateItem(
      emit,
      event.localId,
      (x) => x.copyWith(status: UploadStatus.uploading, progress: event.progress),
    );
  }

  void _updateItem(
    Emitter<AttachState> emit,
    String localId,
    AttachmentItem Function(AttachmentItem) map,
  ) {
    final updated =
        state.items.map((e) => e.localId == localId ? map(e) : e).toList();
    emit(state.copyWith(items: updated));
  }

  @override
  Future<void> close() {
    for (final t in _cancelTokens.values) {
      t.cancel("Bloc disposed");
    }
    _cancelTokens.clear();
    return super.close();
  }
}
