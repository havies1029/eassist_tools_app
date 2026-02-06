import 'package:eassist_tools_app/pages/regother/regother3cari_list.dart';
import 'package:flutter/material.dart';

class Regother3cariListMainPage extends StatelessWidget {
  final String regother1Id;
	const Regother3cariListMainPage({super.key, required this.regother1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Reg Others'),
      ),
			backgroundColor: Colors.grey[100],
			body: Regother3cariPage(regother1Id: regother1Id),
		);
	}
}
