import 'package:eassist_tools_app/pages/gen_berita/berita2cari_list.dart';
import 'package:flutter/material.dart';

class DaftarIsiMainPage extends StatelessWidget {
  final String berita1Id;
	const DaftarIsiMainPage({super.key, required this.berita1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Isi $berita1Id'),
      ),
			backgroundColor: Colors.grey[100],
			body: Berita2CariPage(berita1Id: berita1Id),
		);
	}
}
