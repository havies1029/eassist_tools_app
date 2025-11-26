import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita1cari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_berita/berita1cari_list_widget.dart';

class Berita1CariPage extends StatefulWidget {
  final int jenis;
	const Berita1CariPage({super.key, required this.jenis});

	@override
	Berita1CariPageState createState() => Berita1CariPageState();
}

class Berita1CariPageState extends State<Berita1CariPage> {
	late Berita1CariBloc berita1CariBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		berita1CariBloc = BlocProvider.of<Berita1CariBloc>(context);
		return Center(
			child: Berita1CariListWidget()
		);
	}
	void refreshData() {
		berita1CariBloc.add(
			RefreshBerita1CariEvent(widget.jenis));
	}

}
