part of 'klaim5parcrud_bloc.dart';

abstract class Klaim5parCrudEvents extends Equatable {
	const Klaim5parCrudEvents();

	@override
	List<Object> get props => [];
}

class Klaim5parCrudTambahEvent extends Klaim5parCrudEvents {
	final Klaim5parCrudModel record;
	const Klaim5parCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class Klaim5parCrudUbahEvent extends Klaim5parCrudEvents {
	final Klaim5parCrudModel record;
	const Klaim5parCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class Klaim5parCrudHapusEvent extends Klaim5parCrudEvents {
	final String recordId;
	const Klaim5parCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class Klaim5parCrudLihatEvent extends Klaim5parCrudEvents {
	final String recordId;
	const Klaim5parCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

