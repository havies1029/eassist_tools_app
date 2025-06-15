import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvlist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralidvcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralidvlist_list_widget.dart';

class MRekanGeneralIdvListPage extends StatefulWidget {
	const MRekanGeneralIdvListPage({super.key});

	@override
	MRekanGeneralIdvListPageState createState() => MRekanGeneralIdvListPageState();
}

class MRekanGeneralIdvListPageState extends State<MRekanGeneralIdvListPage> {
	late MRekanGeneralIdvListBloc mRekanGeneralIdvListBloc;
	late MRekanGeneralIdvCrudBloc mRekanGeneralIdvCrudBloc;
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
		mRekanGeneralIdvListBloc = BlocProvider.of<MRekanGeneralIdvListBloc>(context);
		mRekanGeneralIdvCrudBloc = BlocProvider.of<MRekanGeneralIdvCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MRekanGeneralIdvListBloc, MRekanGeneralIdvListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MRekanGeneralIdvCrudBloc, MRekanGeneralIdvCrudState>(
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
		mRekanGeneralIdvListBloc.add(
			RefreshMRekanGeneralIdvListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		mRekanGeneralIdvListBloc.add(TambahMRekanGeneralIdvListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			mRekanGeneralIdvListBloc.add(RefreshMRekanGeneralIdvListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MRekanGeneralIdvListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MRekanGeneralIdvCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			mRekanGeneralIdvListBloc.add(CloseDialogMRekanGeneralIdvListEvent());
		});
	}

}
