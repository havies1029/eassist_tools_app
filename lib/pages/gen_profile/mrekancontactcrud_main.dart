import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekancontactcrud_form.dart';

class MRekanContactCrudMainPage extends StatelessWidget {	
	const MRekanContactCrudMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('Informasi Contact'),
				),
				body: MRekanContactCrudFormPage()));
	}
}
