import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/profile/rekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/rekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/pages/profile/rekanpiccrud_form.dart';
import 'package:eassist_tools_app/pages/profile/rekanpiclist_list_widget.dart';

class RekanPicListPage extends StatefulWidget {
	const RekanPicListPage({super.key});

	@override
	RekanPicListPageState createState() => RekanPicListPageState();
}

class RekanPicListPageState extends State<RekanPicListPage> {
	late RekanPicListBloc rekanPicListBloc;
	late RekanPicCrudBloc rekanPicCrudBloc;
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
		rekanPicListBloc = BlocProvider.of<RekanPicListBloc>(context);
		rekanPicCrudBloc = BlocProvider.of<RekanPicCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<RekanPicListBloc, RekanPicListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<RekanPicCrudBloc, RekanPicCrudState>(
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
		rekanPicListBloc.add(
			RefreshRekanPicListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		rekanPicListBloc.add(TambahRekanPicListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			rekanPicListBloc.add(RefreshRekanPicListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[RekanPicListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return RekanPicCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			rekanPicListBloc.add(CloseDialogRekanPicListEvent());
		});
	}

}
