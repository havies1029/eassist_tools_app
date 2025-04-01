import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulcar/simulcarcrud_form.dart';

class SimulcarCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulcarCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} CAR / EAR'),
				),
				body: SimulcarCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
