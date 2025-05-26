import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/chatting/messageslist_list.dart';

class MessagesListMainPage extends StatelessWidget {
	const MessagesListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const MessagesListPage(),
		);
	}
}
