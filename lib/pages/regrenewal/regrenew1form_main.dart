import 'package:eassist_tools_app/pages/regrenewal/regrenew1form_form.dart';
import 'package:flutter/material.dart';

class RegRenew1FormMainPage extends StatelessWidget {
	final String sppa1Id;
	const RegRenew1FormMainPage({super.key, required this.sppa1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
				appBar: AppBar(
					title: Text('Tambah Endorsement'),
				),
				body: Regrenew1FormFormPage(sppa1Id: sppa1Id),);
	}
}
