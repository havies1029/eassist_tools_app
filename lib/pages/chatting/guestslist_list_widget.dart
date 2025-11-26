import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/chatting/guestslist_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/guestscrud_bloc.dart';
import 'package:eassist_tools_app/pages/chatting/guestslist_tile_widget.dart';

class GuestsListListWidget extends StatefulWidget {
	final String searchText;
	const GuestsListListWidget({super.key, required this.searchText});

	@override
	GuestsListListWidgetState createState() => GuestsListListWidgetState();
}

class GuestsListListWidgetState extends State<GuestsListListWidget> {
	late GuestsListBloc guestsListBloc;
	late GuestsCrudBloc guestsCrudBloc;
	final ScrollController _scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		_scrollController.addListener(_onScroll);
	}

	@override
	void dispose() {
		_scrollController
			..removeListener(_onScroll)
			..dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		guestsListBloc = BlocProvider.of<GuestsListBloc>(context);
		guestsCrudBloc = BlocProvider.of<GuestsCrudBloc>(context);
		return BlocConsumer<GuestsListBloc, GuestsListState>(
			builder: (context, state) {
			if (state.status == ListStatus.success) {
			return state.items.isNotEmpty
				? Flexible(
					child: ListView.builder(
						padding: EdgeInsets.zero,
						controller: _scrollController,
						itemCount: state.items.length,
						itemBuilder: (_, index) => Container(
							margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
							padding: const EdgeInsets.all(0.2),
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(15.0)),
							child: Column(
								children: <Widget>[
									Slidable(
										endActionPane: ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															guestsListBloc.add(
																UbahGuestsListEvent(
																	recordId: state
																		.items[index]
																		.guestsId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].guestsId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: GuestsListTileWidget(
												email: state.items[index].email,
												guestsId: state.items[index].guestsId,
												name: state.items[index].name,
												phone: state.items[index].phone,
												sessionToken: state.items[index].sessionToken,
											)),
							],
						),
					)),
				)
			: const Center(
				child: Padding(
					padding: EdgeInsets.only(top: 80.0),
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				),
			);
		} else {
			return const Center(
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				);
			}
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			guestsListBloc.add(FetchGuestsListEvent());
		}
	}

	onHapusFunction(String recordId) {
		guestsCrudBloc.add(GuestsCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			guestsListBloc.add(CloseDialogGuestsListEvent());
		});
	}

}
