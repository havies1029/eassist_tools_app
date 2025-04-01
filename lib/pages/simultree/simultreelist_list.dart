import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simultree/simultreelist_bloc.dart';
import 'package:eassist_tools_app/blocs/simultree/simultreecrud_bloc.dart';
import 'package:eassist_tools_app/pages/simultree/simultreecrud_form.dart';
import 'package:eassist_tools_app/pages/simultree/simultreelist_list_widget.dart';

class SimultreeListPage extends StatefulWidget {
	const SimultreeListPage({super.key});

	@override
	SimultreeListPageState createState() => SimultreeListPageState();
}

class SimultreeListPageState extends State<SimultreeListPage> {
	late SimultreeListBloc simultreeListBloc;
	late SimultreeCrudBloc simultreeCrudBloc;
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
		simultreeListBloc = BlocProvider.of<SimultreeListBloc>(context);
		simultreeCrudBloc = BlocProvider.of<SimultreeCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimultreeListBloc, SimultreeListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimultreeCrudBloc, SimultreeCrudState>(
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
		simultreeListBloc.add(
			RefreshSimultreeListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simultreeListBloc.add(TambahSimultreeListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simultreeListBloc.add(RefreshSimultreeListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimultreeListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimultreeCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simultreeListBloc.add(CloseDialogSimultreeListEvent());
		});
	}

}
