import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitlist_list.dart';

class SimulgitListMainPage extends StatelessWidget {
	const SimulgitListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SimulgitListPage(),
		);
	}
}
