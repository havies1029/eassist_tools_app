import 'package:eassist_tools_app/blocs/simulmb/simulmbcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulmb/simulmbcrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulmbCrudMainPage extends StatefulWidget {
	const SimulmbCrudMainPage({super.key});

	@override
	SimulmbCrudMainPageState createState() => SimulmbCrudMainPageState();
}

class SimulmbCrudMainPageState extends State<SimulmbCrudMainPage> {
	late SimulmbCrudBloc simulmbCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulmbCrudBloc = BlocProvider.of<SimulmbCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: const Text('Calc. Premi mb'),
				),
				body: const SimulmbCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulmbCrudBloc.add(SimulMbCrudInitValueEvent());
	}
}
