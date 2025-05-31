import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/profile/rekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/rekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/pages/profile/rekanpiclist_tile_widget.dart';

class RekanPicListListWidget extends StatefulWidget {
	final String searchText;
	const RekanPicListListWidget({super.key, required this.searchText});

	@override
	RekanPicListListWidgetState createState() => RekanPicListListWidgetState();
}

class RekanPicListListWidgetState extends State<RekanPicListListWidget> {
	late RekanPicListBloc rekanPicListBloc;
	late RekanPicCrudBloc rekanPicCrudBloc;
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
		rekanPicListBloc = BlocProvider.of<RekanPicListBloc>(context);
		rekanPicCrudBloc = BlocProvider.of<RekanPicCrudBloc>(context);
		return BlocConsumer<RekanPicListBloc, RekanPicListState>(
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
															rekanPicListBloc.add(
																UbahRekanPicListEvent(
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
											child: RekanPicListTileWidget(
												isDefault: state.items[index].isDefault,
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
			rekanPicListBloc.add(FetchRekanPicListEvent());
		}
	}

	onHapusFunction(String recordId) {
		rekanPicCrudBloc.add(RekanPicCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			rekanPicListBloc.add(CloseDialogRekanPicListEvent());
		});
	}

}
