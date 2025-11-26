import 'package:eassist_tools_app/pages/simuleei/simuleeicrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeilist_bloc.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeicrud_bloc.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeicrud_form.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeilist_list_widget.dart';

class SimuleeiListPage extends StatefulWidget {
	const SimuleeiListPage({super.key});

	@override
	SimuleeiListPageState createState() => SimuleeiListPageState();
}

class SimuleeiListPageState extends State<SimuleeiListPage> {
	late SimuleeiListBloc simuleeiListBloc;
	late SimuleeiCrudBloc simuleeiCrudBloc;
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
		simuleeiListBloc = BlocProvider.of<SimuleeiListBloc>(context);
		simuleeiCrudBloc = BlocProvider.of<SimuleeiCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimuleeiListBloc, SimuleeiListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimuleeiCrudBloc, SimuleeiCrudState>(
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
		simuleeiListBloc.add(
			RefreshSimuleeiListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simuleeiListBloc.add(TambahSimuleeiListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simuleeiListBloc.add(RefreshSimuleeiListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimuleeiListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SimuleeiCrudMainPage();
    }));
		
	}

}
