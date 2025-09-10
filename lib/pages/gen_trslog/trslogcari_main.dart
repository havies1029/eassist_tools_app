import 'package:eassist_tools_app/pages/gen_trslog/trslogcari_list.dart';
import 'package:flutter/material.dart';

class TrslogcariMain extends StatelessWidget {
	const TrslogcariMain({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('List Log Transaksi'),
      ),
			backgroundColor: Colors.grey[100],
			body: const TrslogCariPage(),
		);
	}
}
