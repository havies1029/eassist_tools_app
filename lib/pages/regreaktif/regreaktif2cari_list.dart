import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/regreaktif/regreaktif2cari_bloc.dart';
import 'package:eassist_tools_app/pages/regreaktif/regreaktif2cari_list_widget.dart';

class Regreaktif2CariPage extends StatefulWidget {
  final String regreaktif1Id;
	const Regreaktif2CariPage({super.key, required this.regreaktif1Id});

	@override
	Regreaktif2CariPageState createState() => Regreaktif2CariPageState();
}

class Regreaktif2CariPageState extends State<Regreaktif2CariPage> {
	late Regreaktif2CariBloc regreaktif2CariBloc;
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
		regreaktif2CariBloc = BlocProvider.of<Regreaktif2CariBloc>(context);
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
		regreaktif2CariBloc.add(
			RefreshRegreaktif2CariEvent(regreaktif1Id: widget.regreaktif1Id));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			regreaktif2CariBloc.add(RefreshRegreaktif2CariEvent(
        regreaktif1Id: widget.regreaktif1Id));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[Regreaktif2CariListWidget()],
		));
	}

}
