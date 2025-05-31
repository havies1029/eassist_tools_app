import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/profile/rekanpiccrud_form.dart';

class RekanPicCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const RekanPicCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Informasi PIC'),
				),
				body: RekanPicCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
