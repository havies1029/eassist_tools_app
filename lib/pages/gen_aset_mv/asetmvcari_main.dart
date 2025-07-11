import 'package:eassist_tools_app/pages/gen_aset_mv/asetmvcari_list.dart';
import 'package:flutter/material.dart';

class AsetMVCariMainPage extends StatelessWidget {
	const AsetMVCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('List Ringkasan Aset'),
      ),
			backgroundColor: Colors.grey[100],
			body: AsetMvCariPage(),
		);
	}
}
