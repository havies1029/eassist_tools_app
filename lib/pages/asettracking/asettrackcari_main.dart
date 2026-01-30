import 'dart:convert';

import 'package:eassist_tools_app/blocs/asettracking/asettrackcari_bloc.dart';
import 'package:eassist_tools_app/models/asettracking/asettrackcari_model.dart';
import 'package:eassist_tools_app/pages/asettracking/asettrackcari_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsettrackCariMainPage extends StatelessWidget {
	const AsettrackCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: const Text('Asettrack Cari'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AsettrackCariModel? selectedAsettrackCari = 
											context.read<AsettrackCariBloc>().state.selectedAsettrackCari;
          debugPrint('Selected AsettrackCari: ${jsonEncode(selectedAsettrackCari?.toJson())}');
        },
        child: const Icon(Icons.search),
      ),
			backgroundColor: Colors.grey[100],
			body: const AsettrackCariPage(),
		);
	}
}
