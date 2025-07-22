import 'package:eassist_tools_app/pages/gen_berita/berita1cari_list.dart';
import 'package:flutter/material.dart';

class BeritaSampinganMainPage extends StatelessWidget {
  final int jenis;
  const BeritaSampinganMainPage({super.key, required this.jenis});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jenis == 1 ? 'List Berita Utama' : jenis == 2 ? 'List Berita Lainnya' : 'Artikel'),
      ),
      backgroundColor: Colors.grey[100],
      body: Berita1CariPage(jenis: jenis),
    );
  }
}
