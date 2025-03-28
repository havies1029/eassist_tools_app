import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';

class SimulcargoListTileWidget extends StatelessWidget {
	final String conveybyNama;
	final String mmopId;
	final String mopName;
	final double premi;
	final double rate;
	final String simulcargoId;
	final double tsi;
	final double upliftPersen;

	const SimulcargoListTileWidget(
		{super.key,
		required this.conveybyNama, 
		required this.mmopId, 
		required this.mopName, 
		required this.premi, 
		required this.rate, 
		required this.simulcargoId, 
		required this.tsi, 
		required this.upliftPersen});

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
						Text("conveybyNama",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							conveybyNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("mmopId",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							mmopId,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("mopName",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							mopName,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("premi",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(premi),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("rate",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(rate),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("simulcargoId",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							simulcargoId,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("tsi",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(tsi),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("upliftPersen",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							NumberFormat("#,###").format(upliftPersen),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
				]),
			)
		);
	}
}
