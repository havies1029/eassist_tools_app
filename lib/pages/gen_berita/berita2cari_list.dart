import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita2cari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_berita/berita2cari_list_widget.dart';

class Berita2CariPage extends StatefulWidget {
  final String berita1Id;
  const Berita2CariPage({super.key, required this.berita1Id});

	@override
	Berita2CariPageState createState() => Berita2CariPageState();
}

class Berita2CariPageState extends State<Berita2CariPage> {
	late Berita2CariBloc berita2CariBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		berita2CariBloc = BlocProvider.of<Berita2CariBloc>(context);
		return Center(
			child: Berita2CariListWidget()
		);
	}
	void refreshData() {
		berita2CariBloc.add(
			RefreshBerita2CariEvent(berita1Id: widget.berita1Id));
	}

}
