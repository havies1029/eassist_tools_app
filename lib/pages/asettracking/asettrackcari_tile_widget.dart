import 'dart:convert';

import 'package:eassist_tools_app/blocs/asettracking/asettrackcari_bloc.dart';
import 'package:eassist_tools_app/models/asettracking/asettrackcari_model.dart';
import 'package:eassist_tools_app/pages/regendors/regendors2cari_main.dart';
import 'package:eassist_tools_app/pages/regreaktif/regreaktif2cari_main.dart';
import 'package:eassist_tools_app/pages/regrenewal/regrenewal2cari_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';

class AsettrackCariTileWidget extends StatelessWidget {
	final bool isSelected;
	final int nomor;
	final String polisiNo;
	final String prosesId;
	final String prosesRemarks;
	final String prosesSource;
	final String sppa1Id;
	final String sppa2mvId;

	const AsettrackCariTileWidget(
		{super.key,
		required this.nomor, 
		required this.polisiNo, 
		required this.prosesId, 
		required this.prosesRemarks, 
		required this.prosesSource, 
		required this.sppa1Id, 
		required this.sppa2mvId,
		required this.isSelected,
		});

	@override
	Widget build(BuildContext context) {
		return Card(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(15),
				side: BorderSide(
				color: isSelected ? Colors.blue : Colors.transparent,
				width: 2,
        ),
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
						Text("nomor",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(nomor),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("polisiNo",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							polisiNo,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("prosesId",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							prosesId,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("prosesRemarks",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							prosesRemarks,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("prosesSource",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							prosesSource,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("sppa1Id",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							sppa1Id,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("sppa2mvId",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							sppa2mvId,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						if (prosesSource == "E" || prosesSource == "R" || prosesSource == "A")
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.5,
								height: 60,
								child: Padding(
								padding: const EdgeInsets.only(top: 30.0),
								child: ElevatedButton(
									onPressed: () {
									Navigator.push(
										context,
										MaterialPageRoute(
											builder: (context) {
											if (prosesSource == "E"){
												return Regendors2CariMainPage(regendors1Id: prosesId);
											}
											else if (prosesSource == "R"){
												return Regrenewal2CariMainPage(regrenew1Id: prosesId);
											}
											else if (prosesSource == "A"){
												return Regreaktif2CariMainPage(regreaktif1Id: prosesId);
											}
											return Container();
											}),
									);
									},
									child: const Text(
									'Tracking Progress',
									style: TextStyle(fontSize: 13.0),
									),
								),
								),
							),
              SizedBox(
								width: MediaQuery.of(context).size.width * 0.5,
								height: 60,
								child: Padding(
								padding: const EdgeInsets.only(top: 30.0),
								child: ElevatedButton(
									onPressed: () {
										AsettrackCariModel? selectedAsettrackCari = 
											context.read<AsettrackCariBloc>().state.selectedAsettrackCari;
										debugPrint('Selected AsettrackCari: ${jsonEncode(selectedAsettrackCari?.toJson())}');
									},
									child: const Text(
									'debugPrint Selected',
									style: TextStyle(fontSize: 13.0),
									),
								),
								),
							),
				]),
			)
		);
	}
}
