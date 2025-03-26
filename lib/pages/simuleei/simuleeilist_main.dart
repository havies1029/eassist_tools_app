import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeilist_list.dart';

class SimuleeiListMainPage extends StatelessWidget {
	const SimuleeiListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimuleeiListPage(),
		);
	}
}
