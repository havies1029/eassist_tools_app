import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_review/reviewcari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_review/reviewcari_tile_widget.dart';
import 'package:eassist_tools_app/models/gen_review/reviewcari_model.dart';

class ReviewCariListWidget extends StatefulWidget {
	final String searchText;
	const ReviewCariListWidget({super.key, required this.searchText});

	@override
	ReviewCariListWidgetState createState() => ReviewCariListWidgetState();
}

class ReviewCariListWidgetState extends State<ReviewCariListWidget> {
	late ReviewCariBloc reviewCariBloc;
	List<ReviewCariModel> reviewCari = [];
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
		reviewCariBloc = BlocProvider.of<ReviewCariBloc>(context);
		return BlocConsumer<ReviewCariBloc, ReviewCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				reviewCari.addAll(state.items);
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
								ReviewCariTileWidget(
									instansi: state.items[index].instansi,
									isAktif: state.items[index].isAktif,
									komentar: state.items[index].komentar,
									nilai: state.items[index].nilai,
									reviewTgl: state.items[index].reviewTgl,
									review1Id: state.items[index].review1Id,
									reviewer: state.items[index].reviewer,
									skala: state.items[index].skala,
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
			reviewCariBloc.add(FetchReviewCariEvent());
		}
	}

}
