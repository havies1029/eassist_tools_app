part of 'klaim5cari_bloc.dart';

abstract class Klaim5cariEvents extends Equatable {
	const Klaim5cariEvents();

	@override
	List<Object> get props => [];
}

class FetchKlaim5cariEvent extends Klaim5cariEvents {}

class RefreshKlaim5cariEvent extends Klaim5cariEvents {
  final String klaim1Id;
  const RefreshKlaim5cariEvent({required this.klaim1Id});

  @override
  List<Object> get props => [klaim1Id];
}

class Klaim5LocalFileSetEvent extends Klaim5cariEvents {
  final String mjenisdocId;
  final String localPath;
  final String fileName;
  final String? mimeType;
  final int? fileSizeBytes;

  const Klaim5LocalFileSetEvent({
    required this.mjenisdocId,
    required this.localPath,
    required this.fileName,
    this.mimeType,
    this.fileSizeBytes,
  });

  @override
  List<Object> get props => [mjenisdocId, localPath, fileName, mimeType ?? '', fileSizeBytes ?? 0];
}

class Klaim5DeleteRequestedEvent extends Klaim5cariEvents {
  final String mjenisdocId;

  const Klaim5DeleteRequestedEvent({
    required this.mjenisdocId,
  });

  @override
  List<Object> get props => [mjenisdocId];
}

class Klaim5UploadRequestedEvent extends Klaim5cariEvents {
  final String mjenisdocId;      // id row dokumen (bisa kosong kalau belum created)

  const Klaim5UploadRequestedEvent({
    required this.mjenisdocId,
  });

  @override
  List<Object> get props => [mjenisdocId];
}