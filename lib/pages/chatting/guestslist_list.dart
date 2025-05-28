import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/chatting/guestslist_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/guestscrud_bloc.dart';
import 'package:eassist_tools_app/pages/chatting/guestscrud_form.dart';
import 'package:eassist_tools_app/pages/chatting/guestslist_list_widget.dart';

class GuestsListPage extends StatefulWidget {
	const GuestsListPage({super.key});

	@override
	GuestsListPageState createState() => GuestsListPageState();
}

class GuestsListPageState extends State<GuestsListPage> {
	late GuestsListBloc guestsListBloc;
	late GuestsCrudBloc guestsCrudBloc;
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
		guestsListBloc = BlocProvider.of<GuestsListBloc>(context);
		guestsCrudBloc = BlocProvider.of<GuestsCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<GuestsListBloc, GuestsListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<GuestsCrudBloc, GuestsCrudState>(
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
		guestsListBloc.add(
			RefreshGuestsListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		guestsListBloc.add(TambahGuestsListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			guestsListBloc.add(RefreshGuestsListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[GuestsListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return GuestsCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			guestsListBloc.add(CloseDialogGuestsListEvent());
		});
	}

}
