import 'package:flutter/material.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulbon/simulboncrud_main2.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulbonCrudMainPage extends StatefulWidget {
	const SimulbonCrudMainPage({super.key});

	@override
	SimulbonCrudMainPageState createState() => SimulbonCrudMainPageState();
}

class SimulbonCrudMainPageState extends State<SimulbonCrudMainPage> {
	late SimulbonCrudBloc simulbonCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulbonCrudBloc = BlocProvider.of<SimulbonCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(				
				body: SimulbonCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulbonCrudBloc.add(SimulBonCrudInitValueEvent());
	}
}