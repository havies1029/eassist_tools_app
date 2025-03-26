import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulbon/simulbonlist_list.dart';

class SimulbonListMainPage extends StatelessWidget {
	const SimulbonListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulbonListPage(),
		);
	}
}
