import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/regrenewal/regrenewal2cari_bloc.dart';
import 'package:eassist_tools_app/pages/regrenewal/regrenewal2cari_tile_widget.dart';
import 'package:eassist_tools_app/models/regrenewal/regrenewal2cari_model.dart';

class Regrenewal2CariListWidget extends StatefulWidget {
	final String searchText;
	const Regrenewal2CariListWidget({super.key, required this.searchText});

	@override
	Regrenewal2CariListWidgetState createState() => Regrenewal2CariListWidgetState();
}

class Regrenewal2CariListWidgetState extends State<Regrenewal2CariListWidget> {
	late Regrenewal2CariBloc regrenewal2CariBloc;
	List<Regrenewal2CariModel> regrenewal2Cari = [];
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
		regrenewal2CariBloc = BlocProvider.of<Regrenewal2CariBloc>(context);
		return BlocConsumer<Regrenewal2CariBloc, Regrenewal2CariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				regrenewal2Cari.addAll(state.items);
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
								Regrenewal2CariTileWidget(
									regrenew2Id: state.items[index].regrenew2Id,
									remaks: state.items[index].remaks,
									tglStatus: state.items[index].tglStatus,
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
			regrenewal2CariBloc.add(FetchRegrenewal2CariEvent());
		}
	}

}
