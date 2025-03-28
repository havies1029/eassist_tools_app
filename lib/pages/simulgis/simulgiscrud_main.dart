import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_form.dart';

class SimulgisCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulgisCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi GIS'),
				),
				body: SimulgisCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
