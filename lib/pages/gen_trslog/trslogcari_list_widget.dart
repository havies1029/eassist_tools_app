import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_trslog/trslogcari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_trslog/trslogcari_tile_widget.dart';
import 'package:eassist_tools_app/models/gen_trslog/trslogcari_model.dart';

class TrslogCariListWidget extends StatefulWidget {
	final String searchText;
	const TrslogCariListWidget({super.key, required this.searchText});

	@override
	TrslogCariListWidgetState createState() => TrslogCariListWidgetState();
}

class TrslogCariListWidgetState extends State<TrslogCariListWidget> {
	late TrslogCariBloc trslogCariBloc;
	List<TrslogCariModel> trslogCari = [];
	final ScrollController _scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		_scrollController.addListener(_onScroll);
	}

	@override
	void dispose() {
		_scrollController
			..removeListener(_onScroll)
			..dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		trslogCariBloc = BlocProvider.of<TrslogCariBloc>(context);
		return BlocConsumer<TrslogCariBloc, TrslogCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				trslogCari.addAll(state.items);
			}

		return state.items.isNotEmpty
			? Flexible(
				child: ListView.builder(
					padding: EdgeInsets.zero,
					controller: _scrollController,
					itemCount: state.items.length,
					itemBuilder: (_, index) => Container(
						margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
						padding: const EdgeInsets.all(0.2),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(15.0)),
						child: Column(
							children: <Widget>[
								TrslogCariTileWidget(
									keterangan: state.items[index].keterangan,
									curr: state.items[index].curr,
                  jenis_trs: state.items[index].jenis_trs,
                  status_nama: state.items[index].status_nama,
                  mjnstrsId: state.items[index].mjnstrsId,
									nilaiTrs: state.items[index].nilaiTrs,
									trsNoref: state.items[index].trsNoref,
									trsTgl: state.items[index].trsTgl,
									trslogId: state.items[index].trslogId,
								)
							],
						),
					)),
				)
			: const Center(
				child: Padding(
					padding: EdgeInsets.only(top: 80.0),
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				),
			);
		} else {
			return const Center(
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				);
			}
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			trslogCariBloc.add(FetchTrslogCariEvent());
		}
	}

}
