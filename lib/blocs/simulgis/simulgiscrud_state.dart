part of 'simulgiscrud_bloc.dart';

class SimulgisCrudState extends Equatable {

	final SimulgisCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboRMatauangModel? comboRMatauang;
  final List<String>? errors;
	const SimulgisCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboRMatauang,
    this.errors
});

	SimulgisCrudState copyWith({
		SimulgisCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboRMatauangModel? comboRMatauang,
    List<String>? errors
	}){
		return SimulgisCrudState(
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
