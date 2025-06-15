part of 'mrekan1crud_bloc.dart';

abstract class MRekan1CrudEvents extends Equatable {
	const MRekan1CrudEvents();

	@override
	List<Object> get props => [];
}

class MRekan1CrudTambahEvent extends MRekan1CrudEvents {
	final MRekan1CrudModel record;
	const MRekan1CrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MRekan1CrudUbahEvent extends MRekan1CrudEvents {
	final MRekan1CrudModel record;
	const MRekan1CrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MRekan1CrudHapusEvent extends MRekan1CrudEvents {
	final String recordId;
	const MRekan1CrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class MRekan1CrudLihatEvent extends MRekan1CrudEvents {
	final String recordId;
	const MRekan1CrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboMTitleChangedEvent extends MRekan1CrudEvents{
	final ComboMTitleModel comboMTitle;
	const ComboMTitleChangedEvent({required this.comboMTitle});

	@override	List<Object> get props => [comboMTitle];}

class ComboMJnsclientChangedEvent extends MRekan1CrudEvents{
	final ComboMJnsclientModel comboMJnsclient;
	const ComboMJnsclientChangedEvent({required this.comboMJnsclient});

	@override	List<Object> get props => [comboMJnsclient];}

class ComboMBentukCstChangedEvent extends MRekan1CrudEvents{
	final ComboMBentukCstModel comboMBentukCst;
	const ComboMBentukCstChangedEvent({required this.comboMBentukCst});

	@override	List<Object> get props => [comboMBentukCst];}

class ComboMBidangChangedEvent extends MRekan1CrudEvents{
	final ComboMBidangModel comboMBidang;
	const ComboMBidangChangedEvent({required this.comboMBidang});

	@override	List<Object> get props => [comboMBidang];}

class ComboMJnskelChangedEvent extends MRekan1CrudEvents{
	final ComboMJnskelModel comboMJnskel;
	const ComboMJnskelChangedEvent({required this.comboMJnskel});

	@override	List<Object> get props => [comboMJnskel];}

class ComboMPekerjaanChangedEvent extends MRekan1CrudEvents{
	final ComboMPekerjaanModel comboMPekerjaan;
	const ComboMPekerjaanChangedEvent({required this.comboMPekerjaan});

	@override	List<Object> get props => [comboMPekerjaan];}

