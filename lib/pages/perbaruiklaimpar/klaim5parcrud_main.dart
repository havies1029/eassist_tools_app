import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/perbaruiklaimpar/klaim5parcrud_form.dart';

class Klaim5parCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const Klaim5parCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Dokumen Klaim'),
				),
				body: Klaim5parCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
