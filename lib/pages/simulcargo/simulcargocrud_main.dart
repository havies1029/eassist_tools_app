import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargocrud_form.dart';

class SimulcargoCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulcargoCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi Cargo'),
				),
				body: SimulcargoCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
