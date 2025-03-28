import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitcrud_form.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitlist_list_widget.dart';

class SimulgitListPage extends StatefulWidget {
	const SimulgitListPage({super.key});

	@override
	SimulgitListPageState createState() => SimulgitListPageState();
}

class SimulgitListPageState extends State<SimulgitListPage> {
	late SimulgitListBloc simulgitListBloc;
	late SimulgitCrudBloc simulgitCrudBloc;
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
		simulgitListBloc = BlocProvider.of<SimulgitListBloc>(context);
		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SimulgitListBloc, SimulgitListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SimulgitCrudBloc, SimulgitCrudState>(
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
		simulgitListBloc.add(
			RefreshSimulgitListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		simulgitListBloc.add(TambahSimulgitListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			simulgitListBloc.add(RefreshSimulgitListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SimulgitListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return SimulgitCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			simulgitListBloc.add(CloseDialogSimulgitListEvent());
		});
	}

}
