import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1list_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekan1crud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekan1list_list_widget.dart';

class MRekan1ListPage extends StatefulWidget {
	const MRekan1ListPage({super.key});

	@override
	MRekan1ListPageState createState() => MRekan1ListPageState();
}

class MRekan1ListPageState extends State<MRekan1ListPage> {
	late MRekan1ListBloc mRekan1ListBloc;
	late MRekan1CrudBloc mRekan1CrudBloc;
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
		mRekan1ListBloc = BlocProvider.of<MRekan1ListBloc>(context);
		mRekan1CrudBloc = BlocProvider.of<MRekan1CrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MRekan1ListBloc, MRekan1ListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MRekan1CrudBloc, MRekan1CrudState>(
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
		mRekan1ListBloc.add(
			RefreshMRekan1ListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		mRekan1ListBloc.add(TambahMRekan1ListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			mRekan1ListBloc.add(RefreshMRekan1ListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MRekan1ListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MRekan1CrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			mRekan1ListBloc.add(CloseDialogMRekan1ListEvent());
		});
	}

}
