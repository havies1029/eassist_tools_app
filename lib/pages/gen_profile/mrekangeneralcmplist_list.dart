import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmplist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmpcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmplist_list_widget.dart';

class MRekanGeneralCmpListPage extends StatefulWidget {
	const MRekanGeneralCmpListPage({super.key});

	@override
	MRekanGeneralCmpListPageState createState() => MRekanGeneralCmpListPageState();
}

class MRekanGeneralCmpListPageState extends State<MRekanGeneralCmpListPage> {
	late MRekanGeneralCmpListBloc mRekanGeneralCmpListBloc;
	late MRekanGeneralCmpCrudBloc mRekanGeneralCmpCrudBloc;
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
		mRekanGeneralCmpListBloc = BlocProvider.of<MRekanGeneralCmpListBloc>(context);
		mRekanGeneralCmpCrudBloc = BlocProvider.of<MRekanGeneralCmpCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MRekanGeneralCmpListBloc, MRekanGeneralCmpListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MRekanGeneralCmpCrudBloc, MRekanGeneralCmpCrudState>(
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
		mRekanGeneralCmpListBloc.add(
			RefreshMRekanGeneralCmpListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		mRekanGeneralCmpListBloc.add(TambahMRekanGeneralCmpListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			mRekanGeneralCmpListBloc.add(RefreshMRekanGeneralCmpListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MRekanGeneralCmpListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MRekanGeneralCmpCrudFormPage();
			},
			useSafeArea: true)
		.then((value) {
			mRekanGeneralCmpListBloc.add(CloseDialogMRekanGeneralCmpListEvent());
		});
	}

}
