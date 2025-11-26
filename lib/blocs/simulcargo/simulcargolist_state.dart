part of 'simulcargolist_bloc.dart';

class SimulcargoListState extends Equatable {

	final ListStatus status;
	final List<SimulcargoListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String searchText;
	final String recordId;

	const SimulcargoListState(
		{this.status = ListStatus.initial,
		this.items = const <SimulcargoListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.searchText = "",
		this.recordId = ""});

	SimulcargoListState copyWith(
		{List<SimulcargoListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? searchText,
		String? recordId}) {
		return SimulcargoListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			searchText: searchText ?? this.searchText,
			recordId: recordId ?? this.recordId);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, viewMode, recordId, searchText];
}
