part of 'simulwpcrud_bloc.dart';

class SimulwpCrudState extends Equatable {

	final SimulwpCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboRMatauangModel? comboRMatauang;
  final List<String>? errors;
	const SimulwpCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboRMatauang,
    this.errors
});

	SimulwpCrudState copyWith({
		SimulwpCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboRMatauangModel? comboRMatauang,
    List<String>? errors
	}){
		return SimulwpCrudState(
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
