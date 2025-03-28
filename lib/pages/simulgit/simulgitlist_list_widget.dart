import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitlist_tile_widget.dart';

class SimulgitListListWidget extends StatefulWidget {
	final String searchText;
	const SimulgitListListWidget({super.key, required this.searchText});

	@override
	SimulgitListListWidgetState createState() => SimulgitListListWidgetState();
}

class SimulgitListListWidgetState extends State<SimulgitListListWidget> {
	late SimulgitListBloc simulgitListBloc;
	late SimulgitCrudBloc simulgitCrudBloc;
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
		simulgitListBloc = BlocProvider.of<SimulgitListBloc>(context);
		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);
		return BlocConsumer<SimulgitListBloc, SimulgitListState>(
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
															simulgitListBloc.add(
																UbahSimulgitListEvent(
																	recordId: state
																		.items[index]
																		.simulgitId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].simulgitId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: SimulgitListTileWidget(
												coverBulan: state.items[index].coverBulan,
												premi: state.items[index].premi,
												rate: state.items[index].rate,
												rMATAUANGNAMA: state.items[index].rMATAUANGNAMA,
												simulgitId: state.items[index].simulgitId,
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
			simulgitListBloc.add(FetchSimulgitListEvent());
		}
	}

	onHapusFunction(String recordId) {
		simulgitCrudBloc.add(SimulgitCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			simulgitListBloc.add(CloseDialogSimulgitListEvent());
		});
	}

}
