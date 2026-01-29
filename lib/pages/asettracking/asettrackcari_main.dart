import 'package:eassist_tools_app/pages/asettracking/asettrackcari_list.dart';
import 'package:flutter/material.dart';

class AsettrackCariMainPage extends StatelessWidget {
	const AsettrackCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Asettrack Cari'),
      ),
			backgroundColor: Colors.grey[100],
			body: const AsettrackCariPage(),
		);
	}
}
