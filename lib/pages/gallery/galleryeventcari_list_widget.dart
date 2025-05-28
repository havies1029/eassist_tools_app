import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/pages/gallery/galleryeventcari_tile_widget.dart';
import 'package:eassist_tools_app/models/gallery/galleryeventcari_model.dart';

class GalleryeventCariListWidget extends StatefulWidget {
	final String searchText;
	const GalleryeventCariListWidget({super.key, required this.searchText});

	@override
	GalleryeventCariListWidgetState createState() => GalleryeventCariListWidgetState();
}

class GalleryeventCariListWidgetState extends State<GalleryeventCariListWidget> {
	late GalleryeventCariBloc galleryeventCariBloc;
	List<GalleryeventCariModel> galleryeventCari = [];
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
		galleryeventCariBloc = BlocProvider.of<GalleryeventCariBloc>(context);
		return BlocConsumer<GalleryeventCariBloc, GalleryeventCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				galleryeventCari.addAll(state.items);
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
								GalleryeventCariTileWidget(
									eventDesc: state.items[index].eventDesc,
									eventNama: state.items[index].eventNama,
									galleryUrl: state.items[index].galleryUrl,
									galleryeventId: state.items[index].galleryeventId,
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
			galleryeventCariBloc.add(FetchGalleryeventCariEvent());
		}
	}

}
