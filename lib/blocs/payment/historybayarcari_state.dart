part of 'historybayarcari_bloc.dart';

class HistorybayarCariState extends Equatable {

	final ListStatus status;
	final List<HistorybayarCariModel> items;
	final bool hasReachedMax;
	final int hal;
  final String statusId;
  final String searchText;
  final bool isDownloading;
  final String downloadPath;

	const HistorybayarCariState(
		{this.status = ListStatus.initial,
		this.items = const <HistorybayarCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
    this.statusId = '',
    this.searchText = '',
    this.isDownloading = false,
    this.downloadPath = ''});

	const HistorybayarCariState.success(List<HistorybayarCariModel> items)
			: this(status: ListStatus.success, items: items);

	const HistorybayarCariState.failure() : this(status: ListStatus.failure);

	HistorybayarCariState copyWith(
		{List<HistorybayarCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
    String? statusId,
    String? searchText,
    bool? isDownloading,
    String? downloadPath
    }) {

		return HistorybayarCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
      statusId: statusId ?? this.statusId,
      searchText: searchText ?? this.searchText,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadPath: downloadPath ?? this.downloadPath);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, statusId, searchText, isDownloading, downloadPath];
}
