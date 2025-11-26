import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulwp/simulwplist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulwp/simulwpcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_form.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwplist_list_widget.dart';

class SimulwpListPage extends StatefulWidget {
	const SimulwpListPage({super.key});

	@override
	SimulwpListPageState createState() => SimulwpListPageState();
}

class SimulwpListPageState extends State<SimulwpListPage> {
	late SimulwpListBloc simulwpListBloc;
	late SimulwpCrudBloc simulwpCrudBloc;
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
		simulwpListBloc = BlocProvider.of<SimulwpListBloc>(context);
		simulwpCrudBloc = BlocProvider.of<SimulwpCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulwpListBloc, SimulwpListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulwpCrudBloc, SimulwpCrudState>(
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
		simulwpListBloc.add(
			RefreshSimulwpListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulwpListBloc.add(TambahSimulwpListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulwpListBloc.add(RefreshSimulwpListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulwpListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulwpCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulwpListBloc.add(CloseDialogSimulwpListEvent());
		});
	}

}
