import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargolist_list.dart';

class SimulcargoListMainPage extends StatelessWidget {
	const SimulcargoListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulcargoListPage(),
		);
	}
}
