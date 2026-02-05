import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/cobklaim/mcobklaimcari_bloc.dart';
import 'package:eassist_tools_app/pages/cobklaim/mcobklaimcari_tile_widget.dart';
import 'package:eassist_tools_app/models/cobklaim/mcobklaimcari_model.dart';

class McobklaimCariListWidget extends StatefulWidget {
	final String searchText;
	const McobklaimCariListWidget({super.key, required this.searchText});

	@override
	McobklaimCariListWidgetState createState() => McobklaimCariListWidgetState();
}

class McobklaimCariListWidgetState extends State<McobklaimCariListWidget> {
	late McobklaimCariBloc mcobklaimCariBloc;
	List<McobklaimCariModel> mcobklaimCari = [];
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
		mcobklaimCariBloc = BlocProvider.of<McobklaimCariBloc>(context);
		return BlocConsumer<McobklaimCariBloc, McobklaimCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				mcobklaimCari.addAll(state.items);
			}

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
								McobklaimCariTileWidget(
									cobIcon: state.items[index].cobIcon,
									cobNama: state.items[index].cobNama,
									isAktif: state.items[index].isAktif,
									mcobklaim1Id: state.items[index].mcobklaim1Id,
									noUrut: state.items[index].noUrut,
								)
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
			mcobklaimCariBloc.add(FetchMcobklaimCariEvent());
		}
	}

}
