import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/regreaktif/regreaktif2cari_bloc.dart';
import 'package:eassist_tools_app/pages/regreaktif/regreaktif2cari_tile_widget.dart';
import 'package:eassist_tools_app/models/regreaktif/regreaktif2cari_model.dart';

class Regreaktif2CariListWidget extends StatefulWidget {
	const Regreaktif2CariListWidget({super.key});

	@override
	Regreaktif2CariListWidgetState createState() => Regreaktif2CariListWidgetState();
}

class Regreaktif2CariListWidgetState extends State<Regreaktif2CariListWidget> {
	late Regreaktif2CariBloc regreaktif2CariBloc;
	List<Regreaktif2CariModel> regreaktif2Cari = [];
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
		regreaktif2CariBloc = BlocProvider.of<Regreaktif2CariBloc>(context);
		return BlocConsumer<Regreaktif2CariBloc, Regreaktif2CariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				regreaktif2Cari.addAll(state.items);
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
								Regreaktif2CariTileWidget(
									regreaktif2Id: state.items[index].regreaktif2Id,
									remarks: state.items[index].remarks,
									tglStatus: state.items[index].tglStatus,
                  progressNama: state.items[index].progressNama,
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
			regreaktif2CariBloc.add(FetchRegreaktif2CariEvent());
		}
	}

}
