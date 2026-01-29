import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/regrenewal/regrenewal2cari_bloc.dart';
import 'package:eassist_tools_app/pages/regrenewal/regrenewal2cari_list_widget.dart';

class Regrenewal2CariPage extends StatefulWidget {
  final String regrenew1Id;
	const Regrenewal2CariPage({super.key, required this.regrenew1Id});

	@override
	Regrenewal2CariPageState createState() => Regrenewal2CariPageState();
}

class Regrenewal2CariPageState extends State<Regrenewal2CariPage> {
	late Regrenewal2CariBloc regrenewal2CariBloc;
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
		regrenewal2CariBloc = BlocProvider.of<Regrenewal2CariBloc>(context);
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
		regrenewal2CariBloc.add(
			RefreshRegrenewal2CariEvent(regrenew1Id: widget.regrenew1Id));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			regrenewal2CariBloc.add(RefreshRegrenewal2CariEvent(
				regrenew1Id: widget.regrenew1Id));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[Regrenewal2CariListWidget(searchText: _searchController.text)],
		));
	}

}
