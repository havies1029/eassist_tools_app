part of 'dnrekapcobcari_bloc.dart';

class DnrekapcobCariState extends Equatable {

	final ListStatus status;
	final List<DnrekapcobCariModel> items;
	final bool hasReachedMax;
	const DnrekapcobCariState(
		{this.status = ListStatus.initial,
		this.items = const <DnrekapcobCariModel>[],
		this.hasReachedMax = false,
		});

	const DnrekapcobCariState.success(List<DnrekapcobCariModel> items)
			: this(status: ListStatus.success, items: items);

	const DnrekapcobCariState.failure() : this(status: ListStatus.failure);

	DnrekapcobCariState copyWith(
		{List<DnrekapcobCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return DnrekapcobCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
