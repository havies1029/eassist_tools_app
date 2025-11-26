import 'package:eassist_tools_app/pages/gen_berita/daftarisi_main.dart';
import 'package:eassist_tools_app/pages/gen_berita/kontenberita_main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';

class Berita1CariTileWidget extends StatelessWidget {
	final String authorFoto;
	final String authorNama;
	final String berita1Id;
	final String gambar;
	final int jenis;
	final String judul;
	final int lamaBaca;
	final String sumber;
	final String tema;
	final DateTime tglTerbit;

	const Berita1CariTileWidget(
		{super.key,
		required this.authorFoto, 
		required this.authorNama, 
		required this.berita1Id, 
		required this.gambar, 
		required this.jenis, 
		required this.judul, 
		required this.lamaBaca, 
		required this.sumber, 
		required this.tema, 
		required this.tglTerbit});

	@override
	Widget build(BuildContext context) {
		return Card(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(15),
			),
			color: Colors.white,
			margin: const EdgeInsets.symmetric(horizontal: 10),
			elevation: 2,
			clipBehavior: Clip.antiAliasWithSaveLayer,
			child: Container(
				alignment: Alignment.topLeft,
				padding: const EdgeInsets.all(15),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text("authorFoto",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							authorFoto,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("authorNama",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							authorNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("berita1Id",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							berita1Id,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("gambar",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							gambar,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("jenis",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(jenis),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("judul",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							judul,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("lamaBaca",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(lamaBaca),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("sumber",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							sumber,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("tema",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							tema,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("tglTerbit",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							DateFormat("dd/MM/yyyy").format(tglTerbit),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DaftarIsiMainPage(berita1Id: berita1Id)),
                );
              },
              child: Text("Click -> Daftar Isi",
                style: MyText.bodyLarge(context)!
                  .copyWith(color: MyColors.primary))),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          KontenberitaMainPage(berita1Id: berita1Id)),
                );
              },
              child: Text("Click -> Konten Berita",
                style: MyText.bodyLarge(context)!
                  .copyWith(color: MyColors.primary))),
				]),
			)
		);
	}
}
