import 'package:flutter/material.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargocrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargocrud_main2.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulcargoCrudMainPage extends StatefulWidget {
	const SimulcargoCrudMainPage({super.key});

	@override
	SimulcargoCrudMainPageState createState() => SimulcargoCrudMainPageState();
}

class SimulcargoCrudMainPageState extends State<SimulcargoCrudMainPage> {
	late SimulcargoCrudBloc simulcargoCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulcargoCrudBloc = BlocProvider.of<SimulcargoCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: const Text('Calc. Premi Cargo'),
				),
				body: SimulcargoCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulcargoCrudBloc.add(SimulCargoCrudInitValueEvent());
	}
}
