part of 'klaim5parcrud_bloc.dart';

class Klaim5parCrudState extends Equatable {

	final Klaim5parCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	const Klaim5parCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
});

	Klaim5parCrudState copyWith({
		Klaim5parCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
	}){
		return Klaim5parCrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
