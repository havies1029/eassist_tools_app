import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanbanklist_list.dart';

class MRekanBankListMainPage extends StatelessWidget {
	const MRekanBankListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const MRekanBankListPage(),
		);
	}
}
