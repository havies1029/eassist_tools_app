import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulcar/simulcarlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulcar/simulcarcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulcar/simulcarcrud_form.dart';
import 'package:eassist_tools_app/pages/simulcar/simulcarlist_list_widget.dart';

class SimulcarListPage extends StatefulWidget {
	const SimulcarListPage({super.key});

	@override
	SimulcarListPageState createState() => SimulcarListPageState();
}

class SimulcarListPageState extends State<SimulcarListPage> {
	late SimulcarListBloc simulcarListBloc;
	late SimulcarCrudBloc simulcarCrudBloc;
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
		simulcarListBloc = BlocProvider.of<SimulcarListBloc>(context);
		simulcarCrudBloc = BlocProvider.of<SimulcarCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulcarListBloc, SimulcarListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulcarCrudBloc, SimulcarCrudState>(
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
		simulcarListBloc.add(
			RefreshSimulcarListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulcarListBloc.add(TambahSimulcarListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulcarListBloc.add(RefreshSimulcarListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulcarListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulcarCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulcarListBloc.add(CloseDialogSimulcarListEvent());
		});
	}

}
