import 'package:eassist_tools_app/pages/simulmv/simulmvcrud_formv2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';

class SimulmvCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const SimulmvCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Premi MV'),
				),
				body: SimulmvCrudFormV2Page(viewMode: viewMode, recordId: recordId)));
	}
}
