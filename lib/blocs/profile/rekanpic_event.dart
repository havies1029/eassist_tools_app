part of 'rekanpic_bloc.dart';

abstract class RekanPicEvents extends Equatable {
	const RekanPicEvents();

	@override
	List<Object> get props => [];
}

class RekanPicTambahEvent extends RekanPicEvents {
	final RekanPicModel record;
	const RekanPicTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class RekanPicUbahEvent extends RekanPicEvents {
	final RekanPicModel record;
	const RekanPicUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class RekanPicHapusEvent extends RekanPicEvents {
	final String recordId;
	const RekanPicHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class RekanPicLihatEvent extends RekanPicEvents {
	final String recordId;
	const RekanPicLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

