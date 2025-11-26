import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/klaim/klaim1list_list.dart';

class Klaim1ListMainPage extends StatelessWidget {
	const Klaim1ListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Klaim 1 List'),        
      ),
			backgroundColor: Colors.grey[100],
			body: const Klaim1ListPage(),
		);
	}
}