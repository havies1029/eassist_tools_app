import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/chatting/messagescrud_form.dart';

class MessagesCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const MessagesCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Chatting'),
				),
				body: MessagesCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}
