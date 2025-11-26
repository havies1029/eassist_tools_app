import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/simultree/simultreelist_bloc.dart';
import 'package:eassist_tools_app/blocs/simultree/simultreecrud_bloc.dart';
import 'package:eassist_tools_app/pages/simultree/simultreelist_tile_widget.dart';

class SimultreeListListWidget extends StatefulWidget {
	final String searchText;
	const SimultreeListListWidget({super.key, required this.searchText});

	@override
	SimultreeListListWidgetState createState() => SimultreeListListWidgetState();
}

class SimultreeListListWidgetState extends State<SimultreeListListWidget> {
	late SimultreeListBloc simultreeListBloc;
	late SimultreeCrudBloc simultreeCrudBloc;
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
		simultreeListBloc = BlocProvider.of<SimultreeListBloc>(context);
		simultreeCrudBloc = BlocProvider.of<SimultreeCrudBloc>(context);
		return BlocConsumer<SimultreeListBloc, SimultreeListState>(
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
															simultreeListBloc.add(
																UbahSimultreeListEvent(
																	recordId: state
																		.items[index]
																		.simultreeId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].simultreeId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: SimultreeListTileWidget(
												coverBulan: state.items[index].coverBulan,
												premi: state.items[index].premi,
												rate: state.items[index].rate,
												rMATAUANGNAMA: state.items[index].rMATAUANGNAMA,
												simultreeId: state.items[index].simultreeId,
												tsi: state.items[index].tsi,
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
			simultreeListBloc.add(FetchSimultreeListEvent());
		}
	}

	onHapusFunction(String recordId) {
		simultreeCrudBloc.add(SimultreeCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			simultreeListBloc.add(CloseDialogSimultreeListEvent());
		});
	}

}
