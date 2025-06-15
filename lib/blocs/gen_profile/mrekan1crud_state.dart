part of 'mrekan1crud_bloc.dart';

class MRekan1CrudState extends Equatable {

	final MRekan1CrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboMTitleModel? comboMTitle;
	final ComboMJnsclientModel? comboMJnsclient;
	final ComboMBentukCstModel? comboMBentukCst;
	final ComboMBidangModel? comboMBidang;
	final ComboMJnskelModel? comboMJnskel;
	final ComboMPekerjaanModel? comboMPekerjaan;
	const MRekan1CrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboMTitle,
		this.comboMJnsclient,
		this.comboMBentukCst,
		this.comboMBidang,
		this.comboMJnskel,
		this.comboMPekerjaan,
});

	MRekan1CrudState copyWith({
		MRekan1CrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboMTitleModel? comboMTitle,
		ComboMJnsclientModel? comboMJnsclient,
		ComboMBentukCstModel? comboMBentukCst,
		ComboMBidangModel? comboMBidang,
		ComboMJnskelModel? comboMJnskel,
		ComboMPekerjaanModel? comboMPekerjaan,
	}){
		return MRekan1CrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			comboMTitle: comboMTitle?? this.comboMTitle,
			comboMJnsclient: comboMJnsclient?? this.comboMJnsclient,
			comboMBentukCst: comboMBentukCst?? this.comboMBentukCst,
			comboMBidang: comboMBidang?? this.comboMBidang,
			comboMJnskel: comboMJnskel?? this.comboMJnskel,
			comboMPekerjaan: comboMPekerjaan?? this.comboMPekerjaan,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
