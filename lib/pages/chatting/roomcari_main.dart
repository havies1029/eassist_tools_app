import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/chatting/roomcari_list.dart';

class RoomCariMainPage extends StatelessWidget {
	const RoomCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const RoomCariPage(),
		);
	}
}
