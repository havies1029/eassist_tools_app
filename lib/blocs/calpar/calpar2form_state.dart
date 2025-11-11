part of 'calpar2form_bloc.dart';

class Calpar2FormState extends Equatable {

	final Calpar2FormModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboRMatauangModel? comboRMatauang;
	final ComboMBiindemnityOjkModel? comboMBiindemnityOjk;
	const Calpar2FormState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboRMatauang,
		this.comboMBiindemnityOjk,
});

	Calpar2FormState copyWith({
		Calpar2FormModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboRMatauangModel? comboRMatauang,
		ComboMBiindemnityOjkModel? comboMBiindemnityOjk,
	}){
		return Calpar2FormState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			comboRMatauang: comboRMatauang?? this.comboRMatauang,
			comboMBiindemnityOjk: comboMBiindemnityOjk?? this.comboMBiindemnityOjk,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
