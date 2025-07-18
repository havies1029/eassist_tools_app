import 'package:eassist_tools_app/pages/gen_review/reviewcari_list.dart';
import 'package:flutter/material.dart';

class ReviewCariMainPage extends StatelessWidget {
	const ReviewCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('List Aset Property'),
      ),
			backgroundColor: Colors.grey[100],
			body: ReviewCariPage(),
		);
	}
}
