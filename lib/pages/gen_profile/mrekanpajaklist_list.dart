import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpajaklist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpajakcrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpajakcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpajaklist_list_widget.dart';

class MRekanPajakListPage extends StatefulWidget {
	const MRekanPajakListPage({super.key});

	@override
	MRekanPajakListPageState createState() => MRekanPajakListPageState();
}

class MRekanPajakListPageState extends State<MRekanPajakListPage> {
	late MRekanPajakListBloc mRekanPajakListBloc;
	late MRekanPajakCrudBloc mRekanPajakCrudBloc;
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
		mRekanPajakListBloc = BlocProvider.of<MRekanPajakListBloc>(context);
		mRekanPajakCrudBloc = BlocProvider.of<MRekanPajakCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MRekanPajakListBloc, MRekanPajakListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MRekanPajakCrudBloc, MRekanPajakCrudState>(
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
		mRekanPajakListBloc.add(
			RefreshMRekanPajakListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		mRekanPajakListBloc.add(TambahMRekanPajakListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			mRekanPajakListBloc.add(RefreshMRekanPajakListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MRekanPajakListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MRekanPajakCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			mRekanPajakListBloc.add(CloseDialogMRekanPajakListEvent());
		});
	}

}
