import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/regklaim/polissourcecari_bloc.dart';
import 'package:eassist_tools_app/pages/regklaim/polissourcecari_list_widget.dart';

class PolissourcecariPage extends StatefulWidget {
	const PolissourcecariPage({super.key});

	@override
	PolissourcecariPageState createState() => PolissourcecariPageState();
}

class PolissourcecariPageState extends State<PolissourcecariPage> {
	late PolissourcecariBloc polissourcecariBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		polissourcecariBloc = BlocProvider.of<PolissourcecariBloc>(context);
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
		polissourcecariBloc.add(
			RefreshPolissourcecariEvent());
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[PolissourcecariListWidget()],
		));
	}

}
