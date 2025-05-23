import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/chatting/guestslist_list.dart';

class GuestsListMainPage extends StatelessWidget {
	const GuestsListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const GuestsListPage(),
		);
	}
}
