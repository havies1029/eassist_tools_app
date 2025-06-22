import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpiclist_list.dart';

class MRekanPicListMainPage extends StatelessWidget {
	const MRekanPicListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Profile - PIC'),
      ),
			backgroundColor: Colors.grey[100],
			body: const MRekanPicListPage(),
		);
	}
}
