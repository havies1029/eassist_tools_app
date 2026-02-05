import 'package:eassist_tools_app/pages/cobklaim/mcobklaimcari_list.dart';
import 'package:flutter/material.dart';

class McobklaimCariMainPage extends StatelessWidget {
	const McobklaimCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Cob Klaim List'),
      ),
			backgroundColor: Colors.grey[100],
			body: const McobklaimCariPage(),
		);
	}
}
