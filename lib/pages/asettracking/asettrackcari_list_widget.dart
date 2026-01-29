import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/asettracking/asettrackcari_bloc.dart';
import 'package:eassist_tools_app/pages/asettracking/asettrackcari_tile_widget.dart';
import 'package:eassist_tools_app/models/asettracking/asettrackcari_model.dart';

class AsettrackCariListWidget extends StatefulWidget {
	final String searchText;
	const AsettrackCariListWidget({super.key, required this.searchText});

	@override
	AsettrackCariListWidgetState createState() => AsettrackCariListWidgetState();
}

class AsettrackCariListWidgetState extends State<AsettrackCariListWidget> {
	late AsettrackCariBloc asettrackCariBloc;
	List<AsettrackCariModel> asettrackCari = [];
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
		asettrackCariBloc = BlocProvider.of<AsettrackCariBloc>(context);
		return BlocConsumer<AsettrackCariBloc, AsettrackCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				asettrackCari.addAll(state.items);
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
								AsettrackCariTileWidget(
									nomor: state.items[index].nomor,
									polisiNo: state.items[index].polisiNo,
									prosesId: state.items[index].prosesId,
									prosesRemarks: state.items[index].prosesRemarks,
									prosesSource: state.items[index].prosesSource,
									sppa1Id: state.items[index].sppa1Id,
									sppa2mvId: state.items[index].sppa2mvId,
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
			asettrackCariBloc.add(FetchAsettrackCariEvent());
		}
	}

}
