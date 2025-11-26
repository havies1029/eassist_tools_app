import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulcar/simulcarlist_list.dart';

class SimulcarListMainPage extends StatelessWidget {
	const SimulcarListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulcarListPage(),
		);
	}
}
