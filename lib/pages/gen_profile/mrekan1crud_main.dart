import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekan1crud_form.dart';

class MRekan1CrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const MRekan1CrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Informasi Umum Company'),
				),
				body: MRekan1CrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
