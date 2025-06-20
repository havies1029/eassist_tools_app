part of 'mrekan1crud_bloc.dart';

class MRekan1CrudState extends Equatable {

	final MRekan1CrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
  final bool isSetujuTC;
	const MRekan1CrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.isSetujuTC = false,
});

	MRekan1CrudState copyWith({
		MRekan1CrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		bool? isSetujuTC,
	}){
		return MRekan1CrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			isSetujuTC: isSetujuTC ?? this.isSetujuTC,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure, isSetujuTC];
}
