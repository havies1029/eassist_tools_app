import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/gen_trslog/trslogcari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_trslog/trslogcari_list_widget.dart';

class TrslogCariPage extends StatefulWidget {
	const TrslogCariPage({super.key});

	@override
	TrslogCariPageState createState() => TrslogCariPageState();
}

class TrslogCariPageState extends State<TrslogCariPage> {
	late TrslogCariBloc trslogCariBloc;
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
		trslogCariBloc = BlocProvider.of<TrslogCariBloc>(context);
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
		trslogCariBloc.add(
			RefreshTrslogCariEvent(searchText: _searchController.text));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			trslogCariBloc.add(RefreshTrslogCariEvent(
				searchText: _searchController.text));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[TrslogCariListWidget(searchText: _searchController.text)],
		));
	}

}
