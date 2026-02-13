part of 'klaim5parlist_bloc.dart';

class Klaim5parListState extends Equatable {
	final ListStatus status;
	final List<Klaim5parListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String searchText;
	final String recordId;
  final bool isComplete;

	const Klaim5parListState(
		{this.status = ListStatus.initial,
		this.items = const <Klaim5parListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.searchText = "",
		this.recordId = "",
    this.isComplete = false,
    });

	Klaim5parListState copyWith(
		{List<Klaim5parListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? searchText,
		String? recordId,
    bool? isComplete,
    }){ {
		return Klaim5parListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			searchText: searchText ?? this.searchText,
			recordId: recordId ?? this.recordId,
      isComplete: isComplete ?? this.isComplete,
	  );

    }
  }

  @override
  List<Object> get props => [status, items, hasReachedMax, hal, viewMode, searchText, recordId, isComplete];
}