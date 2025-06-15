import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpajaklist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpajakcrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpajaklist_tile_widget.dart';

class MRekanPajakListListWidget extends StatefulWidget {
	final String searchText;
	const MRekanPajakListListWidget({super.key, required this.searchText});

	@override
	MRekanPajakListListWidgetState createState() => MRekanPajakListListWidgetState();
}

class MRekanPajakListListWidgetState extends State<MRekanPajakListListWidget> {
	late MRekanPajakListBloc mRekanPajakListBloc;
	late MRekanPajakCrudBloc mRekanPajakCrudBloc;
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
		mRekanPajakListBloc = BlocProvider.of<MRekanPajakListBloc>(context);
		mRekanPajakCrudBloc = BlocProvider.of<MRekanPajakCrudBloc>(context);
		return BlocConsumer<MRekanPajakListBloc, MRekanPajakListState>(
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
															mRekanPajakListBloc.add(
																UbahMRekanPajakListEvent(
																	recordId: state
																		.items[index]
																		.mrekanpajakId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mrekanpajakId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: MRekanPajakListTileWidget(
												alamat1: state.items[index].alamat1,
												kODEPOSNO: state.items[index].kODEPOSNO,
												mnegaraId: state.items[index].mnegaraId,
												mpropinsiId: state.items[index].mpropinsiId,
												mrekanpajakId: state.items[index].mrekanpajakId,
												npwpNo: state.items[index].npwpNo,
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
			mRekanPajakListBloc.add(FetchMRekanPajakListEvent());
		}
	}

	onHapusFunction(String recordId) {
		mRekanPajakCrudBloc.add(MRekanPajakCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			mRekanPajakListBloc.add(CloseDialogMRekanPajakListEvent());
		});
	}

}
