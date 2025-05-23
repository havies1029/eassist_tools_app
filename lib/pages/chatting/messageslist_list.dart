import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/widgets/floatingmenumaster_widget.dart';
import 'package:eassist_tools_app/blocs/chatting/messageslist_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/messagescrud_bloc.dart';
import 'package:eassist_tools_app/pages/chatting/messagescrud_form.dart';
import 'package:eassist_tools_app/pages/chatting/messageslist_list_widget.dart';

class MessagesListPage extends StatefulWidget {
	const MessagesListPage({super.key});

	@override
	MessagesListPageState createState() => MessagesListPageState();
}

class MessagesListPageState extends State<MessagesListPage> {
	late MessagesListBloc messagesListBloc;
	late MessagesCrudBloc messagesCrudBloc;
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
		messagesListBloc = BlocProvider.of<MessagesListBloc>(context);
		messagesCrudBloc = BlocProvider.of<MessagesCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MessagesListBloc, MessagesListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MessagesCrudBloc, MessagesCrudState>(
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
		messagesListBloc.add(
			RefreshMessagesListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		messagesListBloc.add(TambahMessagesListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			messagesListBloc.add(RefreshMessagesListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MessagesListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MessagesCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			messagesListBloc.add(CloseDialogMessagesListEvent());
		});
	}

}
