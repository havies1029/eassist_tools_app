import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita2cari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_berita/berita2cari_tile_widget.dart';
import 'package:eassist_tools_app/models/gen_berita/berita2cari_model.dart';

class Berita2CariListWidget extends StatefulWidget {
	const Berita2CariListWidget({super.key});

	@override
	Berita2CariListWidgetState createState() => Berita2CariListWidgetState();
}

class Berita2CariListWidgetState extends State<Berita2CariListWidget> {
	late Berita2CariBloc berita2CariBloc;
	List<Berita2CariModel> berita2Cari = [];
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
		berita2CariBloc = BlocProvider.of<Berita2CariBloc>(context);
		return BlocConsumer<Berita2CariBloc, Berita2CariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				berita2Cari.addAll(state.items);
			}

		return state.items.isNotEmpty
			? ListView.builder(
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
							Berita2CariTileWidget(
								noUrut: state.items[index].noUrut,
								subjudul: state.items[index].subjudul,
							)
						],
					),
				))
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
	}

}
