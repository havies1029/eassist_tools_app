import 'package:eassist_tools_app/blocs/simultree/simultreecrud_bloc.dart';
import 'package:eassist_tools_app/pages/simultree/simultreecrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimultreeCrudMainPage extends StatefulWidget {
	const SimultreeCrudMainPage({super.key});

	@override
	SimultreeCrudMainPageState createState() => SimultreeCrudMainPageState();
}

class SimultreeCrudMainPageState extends State<SimultreeCrudMainPage> {
	late SimultreeCrudBloc simultreeCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simultreeCrudBloc = BlocProvider.of<SimultreeCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				// appBar: AppBar(
				// 	title: const Text('Calc. Premi tree'),
				// ),
				body: const SimultreeCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simultreeCrudBloc.add(SimultreeCrudInitValueEvent());
	}
}
