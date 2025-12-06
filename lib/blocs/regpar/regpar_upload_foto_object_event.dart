part of 'regpar_upload_foto_object_bloc.dart';

abstract class RegparUploadFotoObjectEvent extends Equatable {
  const RegparUploadFotoObjectEvent();

  @override
  List<Object?> get props => [];
}

class UploadFotoObjectSelected extends RegparUploadFotoObjectEvent {
  final Uint8List imageBytes;
  final String fileName;
  const UploadFotoObjectSelected(this.imageBytes, this.fileName);
  @override
  List<Object?> get props => [imageBytes, fileName];
}

class UploadFotoObjectSubmitted extends RegparUploadFotoObjectEvent {
  final String regpar1Id;
  final String caption;

  const UploadFotoObjectSubmitted({required this.regpar1Id, required this.caption});
  
  @override
  List<Object?> get props => [regpar1Id, caption];
}

