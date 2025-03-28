import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitcrud_form.dart';

class SimulgitCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulgitCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi GIT'),
				),
				body: SimulgitCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
