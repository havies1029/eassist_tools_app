import 'package:eassist_tools_app/pages/regrenewal/regrenewal2cari_list.dart';
import 'package:flutter/material.dart';

class Regrenewal2CariMainPage extends StatelessWidget {
  final String regrenew1Id;
  const Regrenewal2CariMainPage({super.key, required this.regrenew1Id});  

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Lacak Renewal'),
      ),
			backgroundColor: Colors.grey[100],
			body: Regrenewal2CariPage(regrenew1Id: regrenew1Id),
		);
	}
}
