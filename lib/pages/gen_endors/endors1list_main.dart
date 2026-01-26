import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/gen_endors/endors1list_list.dart';

class Endors1ListMainPage extends StatelessWidget {
	const Endors1ListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('List Endorsement'),
      ),
			backgroundColor: Colors.grey[100],
			body: const Endors1ListPage(),
		);
	}
}
