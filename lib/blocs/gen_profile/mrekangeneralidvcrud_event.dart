part of 'mrekangeneralidvcrud_bloc.dart';

abstract class MRekanGeneralIdvCrudEvents extends Equatable {
	const MRekanGeneralIdvCrudEvents();

	@override
	List<Object> get props => [];
}

class MRekanGeneralIdvCrudTambahEvent extends MRekanGeneralIdvCrudEvents {
	final MRekanGeneralIdvCrudModel record;
	const MRekanGeneralIdvCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MRekanGeneralIdvCrudUbahEvent extends MRekanGeneralIdvCrudEvents {
	final MRekanGeneralIdvCrudModel record;
	const MRekanGeneralIdvCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MRekanGeneralIdvCrudHapusEvent extends MRekanGeneralIdvCrudEvents {
	final String recordId;
	const MRekanGeneralIdvCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class MRekanGeneralIdvCrudLihatEvent extends MRekanGeneralIdvCrudEvents {
	final String recordId;
	const MRekanGeneralIdvCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboMPekerjaanChangedEvent extends MRekanGeneralIdvCrudEvents{
	final ComboMPekerjaanModel comboMPekerjaan;
	const ComboMPekerjaanChangedEvent({required this.comboMPekerjaan});

	@override	List<Object> get props => [comboMPekerjaan];}

