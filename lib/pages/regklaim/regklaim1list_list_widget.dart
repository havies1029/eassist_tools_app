import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/regklaim/regklaim1list_bloc.dart';
import 'package:eassist_tools_app/blocs/regklaim/regklaim1crud_bloc.dart';
import 'package:eassist_tools_app/pages/regklaim/regklaim1list_tile_widget.dart';

class Regklaim1ListListWidget extends StatefulWidget {
	final String searchText;
	const Regklaim1ListListWidget({super.key, required this.searchText});

	@override
	Regklaim1ListListWidgetState createState() => Regklaim1ListListWidgetState();
}

class Regklaim1ListListWidgetState extends State<Regklaim1ListListWidget> {
	late Regklaim1ListBloc regklaim1ListBloc;
	late Regklaim1CrudBloc regklaim1CrudBloc;
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
		regklaim1ListBloc = BlocProvider.of<Regklaim1ListBloc>(context);
		regklaim1CrudBloc = BlocProvider.of<Regklaim1CrudBloc>(context);
		return BlocConsumer<Regklaim1ListBloc, Regklaim1ListState>(
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
															regklaim1ListBloc.add(
																UbahRegklaim1ListEvent(
																	recordId: state
																		.items[index]
																		.regklaim1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].regklaim1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: Regklaim1ListTileWidget(
												insuranceName: state.items[index].insuranceName,
												insuredNama: state.items[index].insuredNama,
												isPolisJps: state.items[index].isPolisJps,
												polisAkhir: state.items[index].polisAkhir,
												polisMulai: state.items[index].polisMulai,
												polisNo: state.items[index].polisNo,
												regTgl: state.items[index].regTgl,
												regklaim1Id: state.items[index].regklaim1Id,
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
			regklaim1ListBloc.add(FetchRegklaim1ListEvent());
		}
	}

	onHapusFunction(String recordId) {
		regklaim1CrudBloc.add(Regklaim1CrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			regklaim1ListBloc.add(CloseDialogRegklaim1ListEvent());
		});
	}

}
