part of 'simulcargocrud_bloc.dart';

class SimulcargoCrudState extends Equatable {

	final SimulcargoCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboMMopModel? comboMMop;
	final ComboMConveyDetailModel? comboMConveyDetail;
	const SimulcargoCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboMMop,
		this.comboMConveyDetail,
});

	SimulcargoCrudState copyWith({
		SimulcargoCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboMMopModel? comboMMop,
		ComboMConveyDetailModel? comboMConveyDetail,
	}){
		return SimulcargoCrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			comboMMop: comboMMop?? this.comboMMop,
			comboMConveyDetail: comboMConveyDetail?? this.comboMConveyDetail,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
