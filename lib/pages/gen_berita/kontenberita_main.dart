import 'package:eassist_tools_app/pages/gen_berita/berita3cari_list.dart';
import 'package:flutter/material.dart';

class KontenberitaMainPage extends StatelessWidget {
  final String berita1Id;
	const KontenberitaMainPage({super.key, required this.berita1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: Text('Konten Berita $berita1Id'),
      ),
			backgroundColor: Colors.grey[100],
			body: Berita3CariPage(berita1Id: berita1Id),
		);
	}
}
