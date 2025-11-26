import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargolist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargocrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargocrud_form.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargolist_list_widget.dart';

class SimulcargoListPage extends StatefulWidget {
	const SimulcargoListPage({super.key});

	@override
	SimulcargoListPageState createState() => SimulcargoListPageState();
}

class SimulcargoListPageState extends State<SimulcargoListPage> {
	late SimulcargoListBloc simulcargoListBloc;
	late SimulcargoCrudBloc simulcargoCrudBloc;
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
		simulcargoListBloc = BlocProvider.of<SimulcargoListBloc>(context);
		simulcargoCrudBloc = BlocProvider.of<SimulcargoCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulcargoListBloc, SimulcargoListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulcargoCrudBloc, SimulcargoCrudState>(
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
		simulcargoListBloc.add(
			RefreshSimulcargoListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulcargoListBloc.add(TambahSimulcargoListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulcargoListBloc.add(RefreshSimulcargoListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulcargoListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulcargoCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulcargoListBloc.add(CloseDialogSimulcargoListEvent());
		});
	}

}
