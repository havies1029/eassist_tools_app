import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/chatting/guestscrud_form.dart';

class GuestsCrudMainPage extends StatelessWidget {
	const GuestsCrudMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('Start Chat'),
				),
				body: GuestsCrudFormPage(viewMode: "tambah", recordId: "")));
	}
}
