import 'package:eassist_tools_app/blocs/simulwp/simulwpcrud_bloc.dart';
// import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_form_page.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulwpCrudMainPage extends StatefulWidget {
	const SimulwpCrudMainPage({super.key});

	@override
	SimulwpCrudMainPageState createState() => SimulwpCrudMainPageState();
}

class SimulwpCrudMainPageState extends State<SimulwpCrudMainPage> {
	late SimulwpCrudBloc simulwpCrudBloc;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulwpCrudBloc = BlocProvider.of<SimulwpCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(				
				body: const SimulwpCrudMain2Page(viewMode: "tambah", recordId: ""),
			),
		);
	}

	void loadData() {
		simulwpCrudBloc.add(SimulWpCrudInitValueEvent());
	}
}
