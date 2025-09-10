import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';

class TrslogCariTileWidget extends StatelessWidget {
	final String keterangan;
	final double nilaiTrs;
	final String curr;
	final String trsNoref;
	final DateTime trsTgl;
	final String trslogId;
  final String jenis_trs;
  final String status_nama;
  final String mjnstrsId;

	const TrslogCariTileWidget(
		{super.key,
		required this.keterangan, 
		required this.nilaiTrs, 
		required this.curr, 
		required this.trsNoref, 
		required this.trsTgl, 
		required this.trslogId,
    required this.jenis_trs,
    required this.status_nama,
    required this.mjnstrsId
    });

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
						Text("keterangan",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							keterangan,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("nilaiTrs",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(nilaiTrs),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("curr",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							curr,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("trsNoref",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							trsNoref,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("trsTgl",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							DateFormat("dd/MM/yyyy").format(trsTgl),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("trslogId",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							trslogId,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            Text("jenis_trs",
              style: MyText.bodyLarge(context)!
                .copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							jenis_trs,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("status_nama",
              style: MyText.bodyLarge(context)!
                .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(
              status_nama,
              style: MyText.bodyLarge(context)!
                .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("mjnstrsId",
              style: MyText.bodyLarge(context)!
                .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(
              mjnstrsId,
              style: MyText.bodyLarge(context)!
                .copyWith(color: MyColors.grey_80)),
				]),
			)
		);
	}
}
