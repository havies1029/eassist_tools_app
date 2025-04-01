import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulmb/simulmblist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmb/simulmbcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulmb/simulmbcrud_form.dart';
import 'package:eassist_tools_app/pages/simulmb/simulmblist_list_widget.dart';

class SimulmbListPage extends StatefulWidget {
	const SimulmbListPage({super.key});

	@override
	SimulmbListPageState createState() => SimulmbListPageState();
}

class SimulmbListPageState extends State<SimulmbListPage> {
	late SimulmbListBloc simulmbListBloc;
	late SimulmbCrudBloc simulmbCrudBloc;
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
		simulmbListBloc = BlocProvider.of<SimulmbListBloc>(context);
		simulmbCrudBloc = BlocProvider.of<SimulmbCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulmbListBloc, SimulmbListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulmbCrudBloc, SimulmbCrudState>(
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
		simulmbListBloc.add(
			RefreshSimulmbListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulmbListBloc.add(TambahSimulmbListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulmbListBloc.add(RefreshSimulmbListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulmbListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulmbCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulmbListBloc.add(CloseDialogSimulmbListEvent());
		});
	}

}
