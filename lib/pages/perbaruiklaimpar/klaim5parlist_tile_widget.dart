import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';

class Klaim5parListTileWidget extends StatelessWidget {
	final String caption;
	final String jenisDocLain;
	final String jenisNama;
	final String klaim5Id;

	const Klaim5parListTileWidget(
		{super.key,
		required this.caption, 
		required this.jenisDocLain, 
		required this.jenisNama, 
		required this.klaim5Id});

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
						Text("caption",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							caption,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("jenisDocLain",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							jenisDocLain,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("jenisNama",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							jenisNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("klaim5Id",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							klaim5Id,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
				]),
			)
		);
	}
}
