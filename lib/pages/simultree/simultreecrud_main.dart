import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simultree/simultreecrud_form.dart';

class SimultreeCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimultreeCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi Growing Tree'),
				),
				body: SimultreeCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
