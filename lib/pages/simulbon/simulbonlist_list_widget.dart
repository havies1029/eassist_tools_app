import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulbonlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulbon/simulbonlist_tile_widget.dart';

class SimulbonListListWidget extends StatefulWidget {
	final String searchText;
	const SimulbonListListWidget({super.key, required this.searchText});

	@override
	SimulbonListListWidgetState createState() => SimulbonListListWidgetState();
}

class SimulbonListListWidgetState extends State<SimulbonListListWidget> {
	late SimulbonListBloc simulbonListBloc;
	late SimulbonCrudBloc simulbonCrudBloc;
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
		simulbonListBloc = BlocProvider.of<SimulbonListBloc>(context);
		simulbonCrudBloc = BlocProvider.of<SimulbonCrudBloc>(context);
		return BlocConsumer<SimulbonListBloc, SimulbonListState>(
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
															simulbonListBloc.add(
																UbahSimulbonListEvent(
																	recordId: state
																		.items[index]
																		.simulbon1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].simulbon1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: SimulbonListTileWidget(
												carNilai: state.items[index].carNilai,
												carPersen: state.items[index].carPersen,
												coverBulan: state.items[index].coverBulan,
												isCar: state.items[index].isCar,
												isPelaksanaan: state.items[index].isPelaksanaan,
												isPemeliharaan: state.items[index].isPemeliharaan,
												isPenawaran: state.items[index].isPenawaran,
												isUangmuka: state.items[index].isUangmuka,
												kontrakNilai: state.items[index].kontrakNilai,
												pelaksanaanNilai: state.items[index].pelaksanaanNilai,
												pelaksanaanPersen: state.items[index].pelaksanaanPersen,
												pemeliharaanNilai: state.items[index].pemeliharaanNilai,
												pemeliharaanPersen: state.items[index].pemeliharaanPersen,
												penawaranNilai: state.items[index].penawaranNilai,
												penawaranPersen: state.items[index].penawaranPersen,
												premiCar: state.items[index].premiCar,
												premiPelaksanaan: state.items[index].premiPelaksanaan,
												premiPemeliharaan: state.items[index].premiPemeliharaan,
												premiPenawaran: state.items[index].premiPenawaran,
												premiUangmuka: state.items[index].premiUangmuka,
												rateBond: state.items[index].rateBond,
												rateCar: state.items[index].rateCar,
												rMATAUANGNAMA: state.items[index].rMATAUANGNAMA,
												simulbon1Id: state.items[index].simulbon1Id,
												uangmukaNilai: state.items[index].uangmukaNilai,
												uangmukaPersen: state.items[index].uangmukaPersen,
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
			simulbonListBloc.add(FetchSimulbonListEvent());
		}
	}

	onHapusFunction(String recordId) {
		simulbonCrudBloc.add(SimulbonCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			simulbonListBloc.add(CloseDialogSimulbonListEvent());
		});
	}

}
