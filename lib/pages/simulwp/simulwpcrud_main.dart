import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_form.dart';

class SimulwpCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulwpCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi Wanprestasi'),
				),
				body: SimulwpCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
