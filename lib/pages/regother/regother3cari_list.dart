import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/regother/regother3cari_bloc.dart';
import 'package:eassist_tools_app/pages/regother/regother3cari_list_widget.dart';

class Regother3cariPage extends StatefulWidget {
  final String regother1Id;
	const Regother3cariPage({super.key, required this.regother1Id});

	@override
	Regother3cariPageState createState() => Regother3cariPageState();
}

class Regother3cariPageState extends State<Regother3cariPage> {
	late Regother3cariBloc regother3cariBloc;
	final TextEditingController _searchController = TextEditingController();
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		regother3cariBloc = BlocProvider.of<Regother3cariBloc>(context);
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: [
					ListPageFilterBarUIWidget(
						searchController: _searchController,
						searchButton: buildSearchButton()),
					buildList()
				],

			),
		);
	}
	void refreshData() {
		regother3cariBloc.add(
			RefreshRegother3cariEvent(regother1Id: widget.regother1Id));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			regother3cariBloc.add(RefreshRegother3cariEvent(
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[Regother3cariListWidget(searchText: _searchController.text)],
		));
	}

}
