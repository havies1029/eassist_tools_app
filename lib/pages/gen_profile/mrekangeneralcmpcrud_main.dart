import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmpcrud_form.dart';

class MRekanGeneralCmpCrudMainPage extends StatelessWidget {	
	const MRekanGeneralCmpCrudMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('Informasi Umum Company'),
				),
				body: MRekanGeneralCmpCrudFormPage()));
	}
}
