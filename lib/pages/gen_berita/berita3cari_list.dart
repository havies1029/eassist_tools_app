import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita3cari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_berita/berita3cari_list_widget.dart';

class Berita3CariPage extends StatefulWidget {
  final String berita1Id;
	const Berita3CariPage({super.key, required this.berita1Id});

	@override
	Berita3CariPageState createState() => Berita3CariPageState();
}

class Berita3CariPageState extends State<Berita3CariPage> {
	late Berita3CariBloc berita3CariBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		berita3CariBloc = BlocProvider.of<Berita3CariBloc>(context);
		return Center(
			child: Berita3CariListWidget()
		);
	}
	void refreshData() {
		berita3CariBloc.add(
				RefreshBerita3CariEvent(berita1Id: widget.berita1Id));
	}

}
