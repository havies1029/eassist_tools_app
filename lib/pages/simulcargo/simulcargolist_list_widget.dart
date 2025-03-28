import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargolist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargocrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargolist_tile_widget.dart';

class SimulcargoListListWidget extends StatefulWidget {
	final String searchText;
	const SimulcargoListListWidget({super.key, required this.searchText});

	@override
	SimulcargoListListWidgetState createState() => SimulcargoListListWidgetState();
}

class SimulcargoListListWidgetState extends State<SimulcargoListListWidget> {
	late SimulcargoListBloc simulcargoListBloc;
	late SimulcargoCrudBloc simulcargoCrudBloc;
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
		simulcargoListBloc = BlocProvider.of<SimulcargoListBloc>(context);
		simulcargoCrudBloc = BlocProvider.of<SimulcargoCrudBloc>(context);
		return BlocConsumer<SimulcargoListBloc, SimulcargoListState>(
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
															simulcargoListBloc.add(
																UbahSimulcargoListEvent(
																	recordId: state
																		.items[index]
																		.simulcargoId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].simulcargoId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: SimulcargoListTileWidget(
												conveybyNama: state.items[index].conveybyNama,
												mmopId: state.items[index].mmopId,
												mopName: state.items[index].mopName,
												premi: state.items[index].premi,
												rate: state.items[index].rate,
												simulcargoId: state.items[index].simulcargoId,
												tsi: state.items[index].tsi,
												upliftPersen: state.items[index].upliftPersen,
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
			simulcargoListBloc.add(FetchSimulcargoListEvent());
		}
	}

	onHapusFunction(String recordId) {
		simulcargoCrudBloc.add(SimulcargoCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			simulcargoListBloc.add(CloseDialogSimulcargoListEvent());
		});
	}

}
