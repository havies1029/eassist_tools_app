import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:eassist_tools_app/pages/gallery/gallerymembercari_tile_widget.dart';
import 'package:eassist_tools_app/models/gallery/gallerymembercari_model.dart';

class GallerymemberCariListWidget extends StatefulWidget {
	final String searchText;
	const GallerymemberCariListWidget({super.key, required this.searchText});

	@override
	GallerymemberCariListWidgetState createState() => GallerymemberCariListWidgetState();
}

class GallerymemberCariListWidgetState extends State<GallerymemberCariListWidget> {
	late GallerymemberCariBloc gallerymemberCariBloc;
	List<GallerymemberCariModel> gallerymemberCari = [];
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
		gallerymemberCariBloc = BlocProvider.of<GallerymemberCariBloc>(context);
		return BlocConsumer<GallerymemberCariBloc, GallerymemberCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				gallerymemberCari.addAll(state.items);
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
								GallerymemberCariTileWidget(
									gallerymemberId: state.items[index].gallerymemberId,
									image1Url: state.items[index].image1Url,
									text1: state.items[index].text1,
									text2: state.items[index].text2,
									urutan: state.items[index].urutan,
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
			gallerymemberCariBloc.add(FetchGallerymemberCariEvent());
		}
	}

}
