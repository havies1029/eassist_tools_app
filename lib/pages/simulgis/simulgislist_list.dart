import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulgis/simulgislist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulgis/simulgiscrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_form.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgislist_list_widget.dart';

class SimulgisListPage extends StatefulWidget {
	const SimulgisListPage({super.key});

	@override
	SimulgisListPageState createState() => SimulgisListPageState();
}

class SimulgisListPageState extends State<SimulgisListPage> {
	late SimulgisListBloc simulgisListBloc;
	late SimulgisCrudBloc simulgisCrudBloc;
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
		simulgisListBloc = BlocProvider.of<SimulgisListBloc>(context);
		simulgisCrudBloc = BlocProvider.of<SimulgisCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulgisListBloc, SimulgisListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulgisCrudBloc, SimulgisCrudState>(
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
							ListPageFilterBarUIWidget(
								searchController: _searchController,
								searchButton: buildSearchButton()),
							buildList()
						],

					),
				),
			));
	}

	void refreshData() {
		simulgisListBloc.add(
			RefreshSimulgisListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulgisListBloc.add(TambahSimulgisListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulgisListBloc.add(RefreshSimulgisListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulgisListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulgisCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulgisListBloc.add(CloseDialogSimulgisListEvent());
		});
	}

}
