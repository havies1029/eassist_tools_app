import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulmb/simulmblist_list.dart';

class SimulmbListMainPage extends StatelessWidget {
	const SimulmbListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulmbListPage(),
		);
	}
}
