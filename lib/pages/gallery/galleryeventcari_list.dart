import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/pages/gallery/galleryeventcari_list_widget.dart';

class GalleryeventCariPage extends StatefulWidget {
	const GalleryeventCariPage({super.key});

	@override
	GalleryeventCariPageState createState() => GalleryeventCariPageState();
}

class GalleryeventCariPageState extends State<GalleryeventCariPage> {
	late GalleryeventCariBloc galleryeventCariBloc;
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
		galleryeventCariBloc = BlocProvider.of<GalleryeventCariBloc>(context);
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
		galleryeventCariBloc.add(
			RefreshGalleryeventCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			galleryeventCariBloc.add(RefreshGalleryeventCariEvent(
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[GalleryeventCariListWidget(searchText: _searchController.text)],
		));
	}

}
