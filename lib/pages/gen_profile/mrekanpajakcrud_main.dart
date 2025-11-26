import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpajakcrud_form.dart';

class MRekanPajakCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const MRekanPajakCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Informasi Pajak'),
				),
				body: MRekanPajakCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
