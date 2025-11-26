part of 'simulcarcrud_bloc.dart';

class SimulcarCrudState extends Equatable {

	final SimulcarCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final bool isFieldOpsiChanged;
	final bool isFieldCascoChanged;
	final List<String> errors;
	final ComboRMatauangModel? comboRMatauang;
	const SimulcarCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.isFieldOpsiChanged = false,
		this.isFieldCascoChanged = false,
		this.errors = const [],
		this.comboRMatauang,
});

	SimulcarCrudState copyWith({
		SimulcarCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		bool? isFieldCascoChanged,
		List<String>? errors,
		ComboRMatauangModel? comboRMatauang,
	}){
		return SimulcarCrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			isFieldCascoChanged: isFieldCascoChanged ?? this.isFieldCascoChanged,
			hasFailure: hasFailure ?? this.hasFailure,
			errors: errors ?? this.errors,
			comboRMatauang: comboRMatauang?? this.comboRMatauang,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure, isFieldCascoChanged];
}
