import 'package:eassist_tools_app/pages/regreaktif/regreaktif2cari_list.dart';
import 'package:flutter/material.dart';

class Regreaktif2CariMainPage extends StatelessWidget {
  final String regreaktif1Id;
  const Regreaktif2CariMainPage({super.key, required this.regreaktif1Id});  

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Lacak Reaktif'),
      ),
			backgroundColor: Colors.grey[100],
			body: Regreaktif2CariPage(regreaktif1Id: regreaktif1Id),
		);
	}
}
