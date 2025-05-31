import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/profile/rekanpiclist_list.dart';

class RekanPicListMainPage extends StatelessWidget {
	const RekanPicListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const RekanPicListPage(),
		);
	}
}
