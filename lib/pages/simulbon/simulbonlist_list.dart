import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulbonlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulbon/simulboncrud_form.dart';
import 'package:eassist_tools_app/pages/simulbon/simulbonlist_list_widget.dart';

class SimulbonListPage extends StatefulWidget {
	const SimulbonListPage({super.key});

	@override
	SimulbonListPageState createState() => SimulbonListPageState();
}

class SimulbonListPageState extends State<SimulbonListPage> {
	late SimulbonListBloc simulbonListBloc;
	late SimulbonCrudBloc simulbonCrudBloc;
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
		simulbonListBloc = BlocProvider.of<SimulbonListBloc>(context);
		simulbonCrudBloc = BlocProvider.of<SimulbonCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulbonListBloc, SimulbonListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulbonCrudBloc, SimulbonCrudState>(
					listener: (context, state) {
						if (state.isSaved) {
							refreshData();
						}
				}, listenWhen: (previous, current) {
					return previous.isSaved != current.isSaved;
				}),
			],
			child: Scaffold(
				floatingActionButton: FloatingMenuMasterWidget(
					onTambah: onTambahData),
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: [
							// ListPageFilterBarUIWidget(
							// 	searchController: _searchController,
							// 	searchButton: buildSearchButton()),
							buildList()
						],

					),
				),
			));
	}

	void refreshData() {
		simulbonListBloc.add(
			RefreshSimulbonListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulbonListBloc.add(TambahSimulbonListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulbonListBloc.add(RefreshSimulbonListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulbonListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulbonCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulbonListBloc.add(CloseDialogSimulbonListEvent());
		});
	}

}
