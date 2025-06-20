import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpiclist_tile_widget.dart';

class MRekanPicListListWidget extends StatefulWidget {
	const MRekanPicListListWidget({super.key});

	@override
	MRekanPicListListWidgetState createState() => MRekanPicListListWidgetState();
}

class MRekanPicListListWidgetState extends State<MRekanPicListListWidget> {
	late MRekanPicListBloc mRekanPicListBloc;
	late MRekanPicCrudBloc mRekanPicCrudBloc;
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
		mRekanPicListBloc = BlocProvider.of<MRekanPicListBloc>(context);
		mRekanPicCrudBloc = BlocProvider.of<MRekanPicCrudBloc>(context);
		return BlocConsumer<MRekanPicListBloc, MRekanPicListState>(
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
															mRekanPicListBloc.add(
																UbahMRekanPicListEvent(
																	recordId: state
																		.items[index]
																		.mrekanpicId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mrekanpicId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: MRekanPicListTileWidget(
												isDefault: state.items[index].isDefault,
												jabatanDesc: state.items[index].jabatanDesc,
												mrekanpicId: state.items[index].mrekanpicId,
												picEmail: state.items[index].picEmail,
												picHp: state.items[index].picHp,
												picNama: state.items[index].picNama,
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
			mRekanPicListBloc.add(FetchMRekanPicListEvent());
		}
	}

	onHapusFunction(String recordId) {
		mRekanPicCrudBloc.add(MRekanPicCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			mRekanPicListBloc.add(CloseDialogMRekanPicListEvent());
		});
	}

}
