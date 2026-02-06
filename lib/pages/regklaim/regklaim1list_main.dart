import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/regklaim/regklaim1list_list.dart';

class Regklaim1ListMainPage extends StatelessWidget {
	const Regklaim1ListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Regklaim1 List'),
      ),
			backgroundColor: Colors.grey[100],
			body: const Regklaim1ListPage()
		);
	}
}
