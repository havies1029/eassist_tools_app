import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/regother/regother3cari_bloc.dart';
import 'package:eassist_tools_app/pages/regother/regother3cari_tile_widget.dart';
import 'package:eassist_tools_app/models/regother/regother3cari_model.dart';

class Regother3cariListWidget extends StatefulWidget {
	final String searchText;
	const Regother3cariListWidget({super.key, required this.searchText});

	@override
	Regother3cariListWidgetState createState() => Regother3cariListWidgetState();
}

class Regother3cariListWidgetState extends State<Regother3cariListWidget> {
	late Regother3cariBloc regother3cariBloc;
	List<Regother3cariModel> regother3cari = [];
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
		regother3cariBloc = BlocProvider.of<Regother3cariBloc>(context);
		return BlocConsumer<Regother3cariBloc, Regother3cariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				regother3cari.addAll(state.items);
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
								Regother3cariTileWidget(
									regother3Id: state.items[index].regother3Id,
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
			regother3cariBloc.add(FetchRegother3cariEvent());
		}
	}

}
