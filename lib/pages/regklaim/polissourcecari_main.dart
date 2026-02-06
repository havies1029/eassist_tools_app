import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/regklaim/polissourcecari_list_widget.dart';

class PolissourcecariMainPage extends StatelessWidget {
	const PolissourcecariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Polissourcecari List'),
      ),
			backgroundColor: Colors.grey[100],
			body: const PolissourcecariListWidget()
		);
	}
}
