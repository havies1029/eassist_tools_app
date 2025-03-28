import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitcrud_form.dart';

class SimulgitCrudMainPage extends StatelessWidget {
	const SimulgitCrudMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('Calc. Premi GIT'),
				),
				body: SimulgitCrudFormPage(viewMode: "tambah", recordId: "")));
	}
}
