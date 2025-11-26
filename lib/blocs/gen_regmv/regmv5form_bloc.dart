import 'dart:convert';
import 'dart:typed_data';

import 'package:eassist_tools_app/helper/image_helper.dart';
import 'package:eassist_tools_app/models/image/downloadfileinfo64.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/repositories/gen_regmv/regmv5form_repository.dart';

part 'regmv5form_event.dart';
part 'regmv5form_state.dart';

class Regmv5FormBloc extends Bloc<Regmv5FormEvents, Regmv5FormState> {
	final Regmv5FormRepository repository;
	Regmv5FormBloc({required this.repository}) : super(const Regmv5FormState()) {
		on<UploadFileFotoEvent>(onUploadFile);
    on<UploadBinaryFotoEvent>(onUploadFileBytes);
    on<DownloadFotoEvent>(onDownloadFile);
    on<Regmv5FormHapusEvent>(onHapusRegmv5Form);       
    on<HapusFotoStateEvent>(onHapusFotoState); 
    on<ResetStateFotoEvent>(onResetState);
    on<Save2StateFileFotoEvent>(onSaveFotoLocalPath2State);
    on<Save2StateBinaryFotoEvent>(onSaveFotoBinary2State);
    on<SetErrorFotoEvent>(onSetError);
	}

	Future<void> onResetState(
      ResetStateFotoEvent event, Emitter<Regmv5FormState> emit) async {
    emit(state.copyWith(
        isUploaded: false,
        isUploading: false,
        isDownloaded: false,
        isDownloading: false,
        isDeleted: false,
        isDeleting: false,
        hasFailure: false,
        fotoPath: "",
        isPendingUpload: false,
        imageSource: ""));

    emit(Regmv5FormState.reset());
  }

  Future<void> onSetError(
      SetErrorFotoEvent event, Emitter<Regmv5FormState> emit) async {
    debugPrint("onSetError");
    emit(state.copyWith(hasFailure: false));
    emit(state.copyWith(hasFailure: true));
  }

  Future<void> onSaveFotoLocalPath2State(
      Save2StateFileFotoEvent event,
      Emitter<Regmv5FormState> emit) async {
    emit(state.copyWith(
        isUploading: true, isUploaded: false, isPendingUpload: false));

    emit(state.copyWith(
        isUploading: false,
        isUploaded: true,
        fotoPath: event.filePath,
        isPendingUpload: true,
        imageSource: event.imageSource));
  }

  Future<void> onSaveFotoBinary2State(Save2StateBinaryFotoEvent event,
      Emitter<Regmv5FormState> emit) async {
    emit(state.copyWith(
        isUploading: true, isUploaded: false, isPendingUpload: false));

    emit(state.copyWith(
        isUploading: false,
        isUploaded: true,
        fotoBytes: event.fotoBytes,
        isPendingUpload: true,
        imageSource: event.imageSource,
        fileName: event.fileName));
  }

  Future<void> onUploadFile(
      UploadFileFotoEvent event, Emitter<Regmv5FormState> emit) async {
    debugPrint("JobRealFotoBloc -> onUploadFile");
    emit(state.copyWith(
        isUploading: true, isUploaded: false, hasFailure: false));

    ReturnDataAPI returnData =
        await repository.uploadFileFotoMobil(event.regmv5Id, event.filePath);
    debugPrint("event.filePath : ${event.filePath}");
    emit(state.copyWith(
        isUploading: false,
        isUploaded: true,
        fotoPath: event.filePath,
        isPendingUpload: false,
        hasFailure: !returnData.success,
        imageSource: event.imageSource));
  }

  Future<void> onUploadFileBytes(
      UploadBinaryFotoEvent event, Emitter<Regmv5FormState> emit) async {
    emit(state.copyWith(
        isUploading: true, isUploaded: false, hasFailure: false));

    ReturnDataAPI result = await repository.uploadBinaryFotoMobil(
        event.regmv5Id, event.fileName, event.bytes);
    //debugPrint("event.filePath : ${event.bytes}");
    emit(state.copyWith(
        isUploading: false,
        isUploaded: true,
        hasFailure: !result.success,        
        isPendingUpload: false,
        imageSource: event.imageSource));
  }

  Future<void> onDownloadFile(
      DownloadFotoEvent event, Emitter<Regmv5FormState> emit) async {
    debugPrint("onDownloadFile #10");

    emit(state.copyWith(isDownloading: true, isDownloaded: false));

    DownloadFileInfo64Model? fileInfo =
        await repository.downloadFotoMobilAPI(event.regmv5Id);

    //debugPrint("fileInfo : ${fileInfo.toString()}");

    debugPrint("onDownloadFile #20");

    if (fileInfo != null) {
      //debugPrint("fileInfo.datafile64! : ${fileInfo.datafile64}");

      ImageHelper helper = ImageHelper();
      Uint8List bytes = base64Decode(fileInfo.datafile64!);

      debugPrint("onDownloadFile #30");

      String filePath = await helper.convertBytes2LocalImage(
          fileName: fileInfo.namafile, bytes: bytes);

      debugPrint("onDownloadFile #40");

      debugPrint("event.filePath : $filePath");

      emit(state.copyWith(
          isDownloading: false,
          isDownloaded: true,
          //fileFoto: fileFoto,
          fotoPath: filePath));
    } else {
      emit(state.copyWith(
          isDownloading: false, isDownloaded: false, fotoPath: ""));
    }
  }


	Future<void> onHapusRegmv5Form(
		Regmv5FormHapusEvent event, Emitter<Regmv5FormState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.regmv5FormHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusFotoState(HapusFotoStateEvent event,
      Emitter<Regmv5FormState> emit) async {
    emit(state.copyWith(isDeleting: true, isDeleted: false));

    emit(state.copyWith(isDeleting: false, isDeleted: true, fotoPath: ""));
  }

}