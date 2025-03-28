import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgislist_list.dart';

class SimulgisListMainPage extends StatelessWidget {
	const SimulgisListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulgisListPage(),
		);
	}
}
