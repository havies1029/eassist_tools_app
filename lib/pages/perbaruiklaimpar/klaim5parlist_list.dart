import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/perbaruiklaimpar/klaim5parlist_bloc.dart';
import 'package:eassist_tools_app/blocs/perbaruiklaimpar/klaim5parcrud_bloc.dart';
import 'package:eassist_tools_app/pages/perbaruiklaimpar/klaim5parcrud_form.dart';
import 'package:eassist_tools_app/pages/perbaruiklaimpar/klaim5parlist_list_widget.dart';

class Klaim5parListPage extends StatefulWidget {
	const Klaim5parListPage({super.key});

	@override
	Klaim5parListPageState createState() => Klaim5parListPageState();
}

class Klaim5parListPageState extends State<Klaim5parListPage> {
	late Klaim5parListBloc klaim5parListBloc;
	late Klaim5parCrudBloc klaim5parCrudBloc;
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
		klaim5parListBloc = BlocProvider.of<Klaim5parListBloc>(context);
		klaim5parCrudBloc = BlocProvider.of<Klaim5parCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<Klaim5parListBloc, Klaim5parListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<Klaim5parCrudBloc, Klaim5parCrudState>(
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
		klaim5parListBloc.add(
			RefreshKlaim5parListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		klaim5parListBloc.add(TambahKlaim5parListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			klaim5parListBloc.add(RefreshKlaim5parListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[Klaim5parListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return Klaim5parCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			klaim5parListBloc.add(CloseDialogKlaim5parListEvent());
		});
	}

}
