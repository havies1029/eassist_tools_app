import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulbon/simulboncrud_form.dart';

class SimulbonCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulbonCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi Bonding'),
				),
				body: SimulbonCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
