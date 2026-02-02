import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/regklaim/regklaim1list_bloc.dart';
import 'package:eassist_tools_app/blocs/regklaim/regklaim1crud_bloc.dart';
import 'package:eassist_tools_app/pages/regklaim/regklaim1crud_form.dart';
import 'package:eassist_tools_app/pages/regklaim/regklaim1list_list_widget.dart';

class Regklaim1ListPage extends StatefulWidget {
	const Regklaim1ListPage({super.key});

	@override
	Regklaim1ListPageState createState() => Regklaim1ListPageState();
}

class Regklaim1ListPageState extends State<Regklaim1ListPage> {
	late Regklaim1ListBloc regklaim1ListBloc;
	late Regklaim1CrudBloc regklaim1CrudBloc;
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
		regklaim1ListBloc = BlocProvider.of<Regklaim1ListBloc>(context);
		regklaim1CrudBloc = BlocProvider.of<Regklaim1CrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<Regklaim1ListBloc, Regklaim1ListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<Regklaim1CrudBloc, Regklaim1CrudState>(
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
		regklaim1ListBloc.add(
			RefreshRegklaim1ListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		regklaim1ListBloc.add(TambahRegklaim1ListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			regklaim1ListBloc.add(RefreshRegklaim1ListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[Regklaim1ListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return Regklaim1CrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			regklaim1ListBloc.add(CloseDialogRegklaim1ListEvent());
		});
	}

}
