import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_form.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_main2.dart';

class SimulgisCrudMainPage extends StatelessWidget {
	const SimulgisCrudMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('Calc. Premi GIS'),
				),
				body: SimulgisCrudMain2Page(viewMode: "tambah", recordId: "")));
	}
}
