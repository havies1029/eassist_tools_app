import 'package:eassist_tools_app/blocs/simulcar/simulcarcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulcar/simulcarcrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulcarCrudMainPage extends StatefulWidget {
	const SimulcarCrudMainPage({super.key});

	@override
	SimulcarCrudMainPageState createState() => SimulcarCrudMainPageState();
}

class SimulcarCrudMainPageState extends State<SimulcarCrudMainPage> {
	late SimulcarCrudBloc simulcarCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulcarCrudBloc = BlocProvider.of<SimulcarCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				// appBar: AppBar(
				// 	title: const Text('Calc. Premi car'),
				// ),
				body: const SimulcarCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulcarCrudBloc.add(SimulcarCrudInitValueEvent());
	}
}
