import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpajaklist_list.dart';

class MRekanPajakListMainPage extends StatelessWidget {
	const MRekanPajakListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const MRekanPajakListPage(),
		);
	}
}
