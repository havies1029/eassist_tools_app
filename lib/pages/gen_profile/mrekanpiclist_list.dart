import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpiccrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpiclist_list_widget.dart';

class MRekanPicListPage extends StatefulWidget {
	const MRekanPicListPage({super.key});

	@override
	MRekanPicListPageState createState() => MRekanPicListPageState();
}

class MRekanPicListPageState extends State<MRekanPicListPage> {
	late MRekanPicListBloc mRekanPicListBloc;
	late MRekanPicCrudBloc mRekanPicCrudBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		mRekanPicListBloc = BlocProvider.of<MRekanPicListBloc>(context);
		mRekanPicCrudBloc = BlocProvider.of<MRekanPicCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MRekanPicListBloc, MRekanPicListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MRekanPicCrudBloc, MRekanPicCrudState>(
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
							buildList()
						],

					),
				),
			));
	}

	void refreshData() {
		mRekanPicListBloc.add(
			RefreshMRekanPicListEvent());
	}

	void onTambahData() {
		mRekanPicListBloc.add(TambahMRekanPicListEvent());
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MRekanPicListListWidget()],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MRekanPicCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			mRekanPicListBloc.add(CloseDialogMRekanPicListEvent());
		});
	}

}
