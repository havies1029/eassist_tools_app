part of 'berita2cari_bloc.dart';

abstract class Berita2CariEvents extends Equatable {
	const Berita2CariEvents();

	@override
	List<Object> get props => [];
}

class FetchBerita2CariEvent extends Berita2CariEvents {}

class RefreshBerita2CariEvent extends Berita2CariEvents {
  final String berita1Id;

  const RefreshBerita2CariEvent(this.berita1Id);

  @override
  List<Object> get props => [berita1Id];
}

