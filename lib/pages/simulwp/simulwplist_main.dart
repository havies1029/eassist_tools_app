import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwplist_list.dart';

class SimulwpListMainPage extends StatelessWidget {
	const SimulwpListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulwpListPage(),
		);
	}
}
