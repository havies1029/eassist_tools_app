part of 'regmv6form_bloc.dart';

abstract class Regmv6FormEvents extends Equatable {
	const Regmv6FormEvents();

	@override
	List<Object> get props => [];
}

class Regmv6FormTambahEvent extends Regmv6FormEvents {
	final Regmv6FormModel record;
	const Regmv6FormTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class Regmv6FormUbahEvent extends Regmv6FormEvents {
	final Regmv6FormModel record;
	const Regmv6FormUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class Regmv6FormHapusEvent extends Regmv6FormEvents {
	final String recordId;
	const Regmv6FormHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class Regmv6FormLihatEvent extends Regmv6FormEvents {
	final String recordId;
	const Regmv6FormLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class CalPremiRegMvEvent extends Regmv6FormEvents {
	final String recordId;
	const CalPremiRegMvEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

