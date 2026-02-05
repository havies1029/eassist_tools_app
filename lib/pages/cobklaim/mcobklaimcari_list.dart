import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/cobklaim/mcobklaimcari_bloc.dart';
import 'package:eassist_tools_app/pages/cobklaim/mcobklaimcari_list_widget.dart';

class McobklaimCariPage extends StatefulWidget {
	const McobklaimCariPage({super.key});

	@override
	McobklaimCariPageState createState() => McobklaimCariPageState();
}

class McobklaimCariPageState extends State<McobklaimCariPage> {
	late McobklaimCariBloc mcobklaimCariBloc;
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
		mcobklaimCariBloc = BlocProvider.of<McobklaimCariBloc>(context);
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
		mcobklaimCariBloc.add(
			RefreshMcobklaimCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			mcobklaimCariBloc.add(RefreshMcobklaimCariEvent(
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[McobklaimCariListWidget(searchText: _searchController.text)],
		));
	}

}
