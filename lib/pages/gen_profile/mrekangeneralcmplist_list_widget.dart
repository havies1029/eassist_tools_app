import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmplist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmplist_tile_widget.dart';

class MRekanGeneralCmpListListWidget extends StatefulWidget {
	final String searchText;
	const MRekanGeneralCmpListListWidget({super.key, required this.searchText});

	@override
	MRekanGeneralCmpListListWidgetState createState() => MRekanGeneralCmpListListWidgetState();
}

class MRekanGeneralCmpListListWidgetState extends State<MRekanGeneralCmpListListWidget> {
	late MRekanGeneralCmpListBloc mRekanGeneralCmpListBloc;
	late MRekanGeneralCmpCrudBloc mRekanGeneralCmpCrudBloc;
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
		mRekanGeneralCmpListBloc = BlocProvider.of<MRekanGeneralCmpListBloc>(context);
		mRekanGeneralCmpCrudBloc = BlocProvider.of<MRekanGeneralCmpCrudBloc>(context);
		return BlocConsumer<MRekanGeneralCmpListBloc, MRekanGeneralCmpListState>(
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
															mRekanGeneralCmpListBloc.add(
																UbahMRekanGeneralCmpListEvent(
																	recordId: state
																		.items[index]
																		.mrekan1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mrekan1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: MRekanGeneralCmpListTileWidget(
												bentukNama: state.items[index].bentukNama,
												bidangNama: state.items[index].bidangNama,
												mrekan1Id: state.items[index].mrekan1Id,
												rekanNama: state.items[index].rekanNama,
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
			mRekanGeneralCmpListBloc.add(FetchMRekanGeneralCmpListEvent());
		}
	}

	onHapusFunction(String recordId) {
		//mRekanGeneralCmpCrudBloc.add(MRekanGeneralCmpCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			mRekanGeneralCmpListBloc.add(CloseDialogMRekanGeneralCmpListEvent());
		});
	}

}
