import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/pages/gallery/gallerytestimonycari_list_widget.dart';

class GallerytestimonyCariPage extends StatefulWidget {
	const GallerytestimonyCariPage({super.key});

	@override
	GallerytestimonyCariPageState createState() => GallerytestimonyCariPageState();
}

class GallerytestimonyCariPageState extends State<GallerytestimonyCariPage> {
	late GallerytestimonyCariBloc gallerytestimonyCariBloc;
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
		gallerytestimonyCariBloc = BlocProvider.of<GallerytestimonyCariBloc>(context);
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
		gallerytestimonyCariBloc.add(
			RefreshGallerytestimonyCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			gallerytestimonyCariBloc.add(RefreshGallerytestimonyCariEvent(
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[GallerytestimonyCariListWidget(searchText: _searchController.text)],
		));
	}

}
