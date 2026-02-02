import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/regklaim/regklaim1crud_form.dart';

class Regklaim1CrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const Regklaim1CrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Registrasi Klaim'),
				),
				body: Regklaim1CrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
