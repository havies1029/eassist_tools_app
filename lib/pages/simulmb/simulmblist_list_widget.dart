import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/simulmb/simulmblist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmb/simulmbcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulmb/simulmblist_tile_widget.dart';

class SimulmbListListWidget extends StatefulWidget {
	final String searchText;
	const SimulmbListListWidget({super.key, required this.searchText});

	@override
	SimulmbListListWidgetState createState() => SimulmbListListWidgetState();
}

class SimulmbListListWidgetState extends State<SimulmbListListWidget> {
	late SimulmbListBloc simulmbListBloc;
	late SimulmbCrudBloc simulmbCrudBloc;
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
		simulmbListBloc = BlocProvider.of<SimulmbListBloc>(context);
		simulmbCrudBloc = BlocProvider.of<SimulmbCrudBloc>(context);
		return BlocConsumer<SimulmbListBloc, SimulmbListState>(
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
															simulmbListBloc.add(
																UbahSimulmbListEvent(
																	recordId: state
																		.items[index]
																		.simulmbId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].simulmbId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: SimulmbListTileWidget(
												coverBulan: state.items[index].coverBulan,
												premi: state.items[index].premi,
												rate: state.items[index].rate,
												rMATAUANGNAMA: state.items[index].rMATAUANGNAMA,
												simulmbId: state.items[index].simulmbId,
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
			simulmbListBloc.add(FetchSimulmbListEvent());
		}
	}

	onHapusFunction(String recordId) {
		simulmbCrudBloc.add(SimulmbCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			simulmbListBloc.add(CloseDialogSimulmbListEvent());
		});
	}

}
