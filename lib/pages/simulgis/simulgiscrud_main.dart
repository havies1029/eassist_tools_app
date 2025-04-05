import 'package:eassist_tools_app/blocs/simulgis/simulgiscrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulgisCrudMainPage extends StatefulWidget {
	const SimulgisCrudMainPage({super.key});

	@override
	SimulgisCrudMainPageState createState() => SimulgisCrudMainPageState();
}

class SimulgisCrudMainPageState extends State<SimulgisCrudMainPage> {
	late SimulgisCrudBloc simulgisCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulgisCrudBloc = BlocProvider.of<SimulgisCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				// appBar: AppBar(
				// 	title: const Text('Calc. Premi GIS'),
				// ),
				body: const SimulgisCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulgisCrudBloc.add(SimulGisCrudInitValueEvent());
	}
}