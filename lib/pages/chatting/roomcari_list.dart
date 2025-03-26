import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/chatting/roomcari_bloc.dart';
import 'package:eassist_tools_app/pages/chatting/roomcari_list_widget.dart';

class RoomCariPage extends StatefulWidget {
	const RoomCariPage({super.key});

	@override
	RoomCariPageState createState() => RoomCariPageState();
}

class RoomCariPageState extends State<RoomCariPage> {
	late RoomCariBloc roomCariBloc;
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
		roomCariBloc = BlocProvider.of<RoomCariBloc>(context);
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
		roomCariBloc.add(
			RefreshRoomCariEvent(searchText: _searchController.text, hal: 0));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			roomCariBloc.add(RefreshRoomCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[RoomCariListWidget(searchText: _searchController.text)],
		));
	}

}
