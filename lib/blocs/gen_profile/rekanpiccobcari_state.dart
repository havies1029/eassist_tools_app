part of 'rekanpiccobcari_bloc.dart';

class RekanPicCobCariState extends Equatable {
  final ListStatus status;
  final List<RekanPicCobCariModel> items;
  final bool hasReachedMax;
  final String searchText;
  final String rekanPicId;
  final int hal;
  const RekanPicCobCariState(
      {this.status = ListStatus.initial,
      this.items = const <RekanPicCobCariModel>[],
      this.hasReachedMax = false,
      this.searchText = "",
      this.rekanPicId = "",
      this.hal = 0});

  const RekanPicCobCariState.success(List<RekanPicCobCariModel> items)
      : this(status: ListStatus.success, items: items);

  const RekanPicCobCariState.failure() : this(status: ListStatus.failure);

  RekanPicCobCariState copyWith(
      {List<RekanPicCobCariModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      String? searchText,
      String? rekanPicId,
      int? hal}) {
    return RekanPicCobCariState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        searchText: searchText ?? this.searchText,
        rekanPicId: rekanPicId ?? this.rekanPicId,
        hal: hal ?? this.hal);
  }

  @override
  List<Object> get props =>
      [status, items, hasReachedMax, searchText, rekanPicId, hal];
}
