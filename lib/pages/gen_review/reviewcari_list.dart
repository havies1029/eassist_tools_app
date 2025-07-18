import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/gen_review/reviewcari_bloc.dart';
import 'package:eassist_tools_app/pages/gen_review/reviewcari_list_widget.dart';

class ReviewCariPage extends StatefulWidget {
	const ReviewCariPage({super.key});

	@override
	ReviewCariPageState createState() => ReviewCariPageState();
}

class ReviewCariPageState extends State<ReviewCariPage> {
	late ReviewCariBloc reviewCariBloc;
	final TextEditingController _searchController = TextEditingController();
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		reviewCariBloc = BlocProvider.of<ReviewCariBloc>(context);
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: [					
					buildList()
				],

			),
		);
	}
	void refreshData() {
		reviewCariBloc.add(
			RefreshReviewCariEvent());
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[ReviewCariListWidget(searchText: _searchController.text)],
		));
	}

}
