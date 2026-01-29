import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/asettracking/asettrackcari_bloc.dart';
import 'package:eassist_tools_app/pages/asettracking/asettrackcari_list_widget.dart';

class AsettrackCariPage extends StatefulWidget {
	const AsettrackCariPage({super.key});

	@override
	AsettrackCariPageState createState() => AsettrackCariPageState();
}

class AsettrackCariPageState extends State<AsettrackCariPage> {
	late AsettrackCariBloc asettrackCariBloc;
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
		asettrackCariBloc = BlocProvider.of<AsettrackCariBloc>(context);
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
		asettrackCariBloc.add(
			RefreshAsettrackCariEvent(searchText: _searchController.text));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			asettrackCariBloc.add(RefreshAsettrackCariEvent(
				searchText: _searchController.text));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[AsettrackCariListWidget(searchText: _searchController.text)],
		));
	}

}
