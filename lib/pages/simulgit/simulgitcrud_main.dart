import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitcrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulgitCrudMainPage extends StatefulWidget {
	const SimulgitCrudMainPage({super.key});

	@override
	SimulgitCrudMainPageState createState() => SimulgitCrudMainPageState();
}

class SimulgitCrudMainPageState extends State<SimulgitCrudMainPage> {
	late SimulgitCrudBloc simulgitCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				// appBar: AppBar(
				// 	title: const Text('Calc. Premi GIT'),
				// ),
				body: const SimulgitCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulgitCrudBloc.add(SimulGitCrudInitValueEvent());
	}
}
