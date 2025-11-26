import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/repositories/profile/userfoto_repository.dart';

part 'profile_download_foto_event.dart';
part 'profile_download_foto_state.dart';

class ProfileDownloadFotoBloc
    extends Bloc<ProfileDownloadFotoEvent, ProfileDownloadFotoState> {
  final UserFotoRepository repository;

  ProfileDownloadFotoBloc({required this.repository})
      : super(ProfileDownloadFotoInitial()) {
    on<LoadSecureImage>(_onLoadSecureImage);
  }

  Future<void> _onLoadSecureImage(
      LoadSecureImage event, Emitter<ProfileDownloadFotoState> emit) async {
    debugPrint("_onLoadSecureImage");

    emit(ProfileDownloadFotoLoading());

    try {
      final bytes = await repository.getUserProfileFotoImageBytes();
      if (bytes != null) {
        emit(ProfileDownloadFotoLoaded(bytes));
      } else {
        emit(ProfileDownloadFotoError("Gagal load gambar."));
      }
    } catch (e) {
      emit(ProfileDownloadFotoError(e.toString()));
    }
  }
}
