import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralidvcrud_form.dart';

class MRekanGeneralIdvCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const MRekanGeneralIdvCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Informasi General'),
				),
				body: MRekanGeneralIdvCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
