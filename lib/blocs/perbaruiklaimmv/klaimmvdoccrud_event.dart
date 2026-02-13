part of 'klaimmvdoccrud_bloc.dart';

abstract class KlaimmvdoccrudEvents extends Equatable {
	const KlaimmvdoccrudEvents();

	@override
	List<Object> get props => [];
}

class KlaimmvdoccrudTambahEvent extends KlaimmvdoccrudEvents {
	final KlaimmvdoccrudModel record;
	const KlaimmvdoccrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class KlaimmvdoccrudUbahEvent extends KlaimmvdoccrudEvents {
	final KlaimmvdoccrudModel record;
	const KlaimmvdoccrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class KlaimmvdoccrudHapusEvent extends KlaimmvdoccrudEvents {
	final String recordId;
	const KlaimmvdoccrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class KlaimmvdoccrudLihatEvent extends KlaimmvdoccrudEvents {
	final String recordId;
	const KlaimmvdoccrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

