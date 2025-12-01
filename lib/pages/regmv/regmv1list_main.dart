import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/regmv/regmv1list_list.dart';

class Regmv1ListMainPage extends StatelessWidget {
	const Regmv1ListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Regmv List'),
      ),
			backgroundColor: Colors.grey[100],
			body: const Regmv1ListPage(),
		);
	}
}
