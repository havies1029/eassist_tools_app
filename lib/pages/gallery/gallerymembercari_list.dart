import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:eassist_tools_app/pages/gallery/gallerymembercari_list_widget.dart';

class GallerymemberCariPage extends StatefulWidget {
	const GallerymemberCariPage({super.key});

	@override
	GallerymemberCariPageState createState() => GallerymemberCariPageState();
}

class GallerymemberCariPageState extends State<GallerymemberCariPage> {
	late GallerymemberCariBloc gallerymemberCariBloc;
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
		gallerymemberCariBloc = BlocProvider.of<GallerymemberCariBloc>(context);
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
		gallerymemberCariBloc.add(
			RefreshGallerymemberCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			gallerymemberCariBloc.add(RefreshGallerymemberCariEvent(
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[GallerymemberCariListWidget(searchText: _searchController.text)],
		));
	}

}
