part of 'klaimmvdoccrud_bloc.dart';

class KlaimmvdoccrudState extends Equatable {

	final KlaimmvdoccrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
  final bool isComplete;
	const KlaimmvdoccrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
    this.isComplete = false,
});

	KlaimmvdoccrudState copyWith({
		KlaimmvdoccrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
    bool? isComplete,
	}){
		return KlaimmvdoccrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
      isComplete: isComplete ?? this.isComplete,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure, record ?? '', isComplete];
}
