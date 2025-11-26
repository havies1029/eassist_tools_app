import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekancontactlist_list.dart';

class MRekanContactListMainPage extends StatelessWidget {
	const MRekanContactListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const MRekanContactListPage(),
		);
	}
}
