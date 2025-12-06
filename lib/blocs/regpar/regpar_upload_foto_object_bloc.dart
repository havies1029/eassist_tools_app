import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar_upload_fotoobject_repository.dart';
import 'package:equatable/equatable.dart';

part 'regpar_upload_foto_object_event.dart';
part 'regpar_upload_foto_object_state.dart';

class RegparUploadFotoObjectBloc
    extends Bloc<RegparUploadFotoObjectEvent, RegparUploadFotoObjectState> {
  final RegparUploadFotoObjectRepository repository;
  Uint8List? _selectedImage;
  String? _fileName;

  RegparUploadFotoObjectBloc({required this.repository})
      : super(UploadFotoObjectInitial()) {
    on<UploadFotoObjectSelected>((event, emit) {
      _selectedImage = event.imageBytes;
      _fileName = event.fileName;
      emit(UploadFotoObjectPreview(event.imageBytes, event.fileName));
    });

    on<UploadFotoObjectSubmitted>((event, emit) async {
      emit(UploadFotoObjectLoading());

      var success = await repository.uploadFotoObject(event.regpar1Id, event.caption, _selectedImage!, _fileName!);

      if (success){
        emit(UploadFotoObjectSuccess());
      }
      else {
        emit(UploadFotoObjectFailure('Upload gagal atau URL tidak ditemukan.'));
      }

    });
  }
}
