import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/perbaruiklaimpar/klaim5parlist_bloc.dart';
import 'package:eassist_tools_app/blocs/perbaruiklaimpar/klaim5parcrud_bloc.dart';
import 'package:eassist_tools_app/pages/perbaruiklaimpar/klaim5parlist_tile_widget.dart';

class Klaim5parListListWidget extends StatefulWidget {
	final String searchText;
	const Klaim5parListListWidget({super.key, required this.searchText});

	@override
	Klaim5parListListWidgetState createState() => Klaim5parListListWidgetState();
}

class Klaim5parListListWidgetState extends State<Klaim5parListListWidget> {
	late Klaim5parListBloc klaim5parListBloc;
	late Klaim5parCrudBloc klaim5parCrudBloc;
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
		klaim5parListBloc = BlocProvider.of<Klaim5parListBloc>(context);
		klaim5parCrudBloc = BlocProvider.of<Klaim5parCrudBloc>(context);
		return BlocConsumer<Klaim5parListBloc, Klaim5parListState>(
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
															klaim5parListBloc.add(
																UbahKlaim5parListEvent(
																	recordId: state
																		.items[index]
																		.klaim5Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].klaim5Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: Klaim5parListTileWidget(
												caption: state.items[index].caption,
												jenisDocLain: state.items[index].jenisDocLain,
												jenisNama: state.items[index].jenisNama,
												klaim5Id: state.items[index].klaim5Id,
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
			klaim5parListBloc.add(FetchKlaim5parListEvent());
		}
	}

	onHapusFunction(String recordId) {
		klaim5parCrudBloc.add(Klaim5parCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			klaim5parListBloc.add(CloseDialogKlaim5parListEvent());
		});
	}

}
