part of 'rekanpiccobcari_bloc.dart';

abstract class RekanPicCobCariEvents extends Equatable {
	const RekanPicCobCariEvents();

	@override
	List<Object> get props => [];
}

class FetchRekanPicCobCariEvent extends RekanPicCobCariEvents {}

class RefreshRekanPicCobCariEvent extends RekanPicCobCariEvents {
  final String searchText;
  final String rekanPicId;
  const RefreshRekanPicCobCariEvent({required this.searchText, required this.rekanPicId});

  @override
  List<Object> get props => [searchText, rekanPicId];
}

