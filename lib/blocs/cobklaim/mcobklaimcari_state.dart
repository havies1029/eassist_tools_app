part of 'mcobklaimcari_bloc.dart';

class McobklaimCariState extends Equatable {

	final ListStatus status;
	final List<McobklaimCariModel> items;
	final bool hasReachedMax;
	const McobklaimCariState(
		{this.status = ListStatus.initial,
		this.items = const <McobklaimCariModel>[],
		this.hasReachedMax = false,
		});

	const McobklaimCariState.success(List<McobklaimCariModel> items)
			: this(status: ListStatus.success, items: items);

	const McobklaimCariState.failure() : this(status: ListStatus.failure);

	McobklaimCariState copyWith(
		{List<McobklaimCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return McobklaimCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
