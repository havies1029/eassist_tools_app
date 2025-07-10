part of 'cobcari_bloc.dart';

class CobCariState extends Equatable {

	final ListStatus status;
	final List<CobCariModel> items;
	final bool hasReachedMax;
	const CobCariState(
		{this.status = ListStatus.initial,
		this.items = const <CobCariModel>[],
		this.hasReachedMax = false,
		});

	const CobCariState.success(List<CobCariModel> items)
			: this(status: ListStatus.success, items: items);

	const CobCariState.failure() : this(status: ListStatus.failure);

	CobCariState copyWith(
		{List<CobCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return CobCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
