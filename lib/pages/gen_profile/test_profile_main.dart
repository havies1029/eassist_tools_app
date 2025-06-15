import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/test_profile_page.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralcmpcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralidvcrud_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestProfileMain extends StatelessWidget {  
  const TestProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestProfilePage(),
    );
  }
}
