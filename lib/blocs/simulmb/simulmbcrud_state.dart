part of 'simulmbcrud_bloc.dart';

class SimulmbCrudState extends Equatable {

	final SimulmbCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final List<String>? errors;
	final ComboRMatauangModel? comboRMatauang;
	const SimulmbCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboRMatauang,
		this.errors
});

	SimulmbCrudState copyWith({
		SimulmbCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		List<String>? errors,
		ComboRMatauangModel? comboRMatauang,
	}){
		return SimulmbCrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			comboRMatauang: comboRMatauang?? this.comboRMatauang,
			errors: errors?? this.errors
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
