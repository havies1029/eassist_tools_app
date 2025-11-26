part of 'berita1cari_bloc.dart';

class Berita1CariState extends Equatable {

	final ListStatus status;
	final List<Berita1CariModel> items;
	final bool hasReachedMax;
  final int jenis;
  final int hal;
	const Berita1CariState(
		{this.status = ListStatus.initial,
		this.items = const <Berita1CariModel>[],
		this.hasReachedMax = false,
    this.jenis = 1,
		this.hal = 0,
		});

	const Berita1CariState.success(List<Berita1CariModel> items)
			: this(status: ListStatus.success, items: items);

	const Berita1CariState.failure() : this(status: ListStatus.failure);

	Berita1CariState copyWith(
		{List<Berita1CariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
    int? jenis,
		int? hal,
		}){
		return Berita1CariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
      jenis: jenis ?? this.jenis,
			hal: hal ?? this.hal,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, jenis, hal];
}
