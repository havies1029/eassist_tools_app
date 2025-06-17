import 'package:eassist_tools_app/pages/gen_profile/mrekancontactcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmpcrud_form.dart';

import 'package:flutter/material.dart';

class TestProfilePage extends StatefulWidget {
  const TestProfilePage({super.key});

  @override
  State<TestProfilePage> createState() => _TestProfilePageState();
}

class _TestProfilePageState extends State<TestProfilePage> {    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),  
          child: Column(
            children: [
        
              MRekanGeneralCmpCrudFormPage(),
              const SizedBox(height: 24),            
              MRekanContactCrudFormPage(),
              const SizedBox(height: 24),   
              ElevatedButton(
                onPressed: () {
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}