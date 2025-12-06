part of 'regmv_upload_foto_acc_bloc.dart';

abstract class RegmvUploadFotoAccEvent extends Equatable {
  const RegmvUploadFotoAccEvent();

  @override
  List<Object?> get props => [];
}

class UploadFotoAccSelected extends RegmvUploadFotoAccEvent {
  final Uint8List imageBytes;
  final String fileName;
  const UploadFotoAccSelected(this.imageBytes, this.fileName);
  @override
  List<Object?> get props => [imageBytes, fileName];
}

class UploadFotoAccSubmitted extends RegmvUploadFotoAccEvent {
  final String regmv1Id;
  final String caption;

  const UploadFotoAccSubmitted({required this.regmv1Id, required this.caption});
  
  @override
  List<Object?> get props => [regmv1Id, caption];
}

