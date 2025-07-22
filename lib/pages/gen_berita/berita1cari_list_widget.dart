import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita1cari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_berita/berita1cari_tile_widget.dart';
import 'package:eassist_tools_app/models/gen_berita/berita1cari_model.dart';

class Berita1CariListWidget extends StatefulWidget {
	const Berita1CariListWidget({super.key});

	@override
	Berita1CariListWidgetState createState() => Berita1CariListWidgetState();
}

class Berita1CariListWidgetState extends State<Berita1CariListWidget> {
	late Berita1CariBloc berita1CariBloc;
	List<Berita1CariModel> berita1Cari = [];
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
		berita1CariBloc = BlocProvider.of<Berita1CariBloc>(context);
		return BlocConsumer<Berita1CariBloc, Berita1CariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				berita1Cari.addAll(state.items);
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
							Berita1CariTileWidget(
								authorFoto: state.items[index].authorFoto,
								authorNama: state.items[index].authorNama,
								berita1Id: state.items[index].berita1Id,
								gambar: state.items[index].gambar,
								jenis: state.items[index].jenis,
								judul: state.items[index].judul,
								lamaBaca: state.items[index].lamaBaca,
								sumber: state.items[index].sumber,
								tema: state.items[index].tema,
								tglTerbit: state.items[index].tglTerbit,
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
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			berita1CariBloc.add(FetchBerita1CariEvent());
		}
	}

}
