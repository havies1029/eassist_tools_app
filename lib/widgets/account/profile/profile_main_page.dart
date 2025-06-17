import 'package:flutter/material.dart';
import 'profile_form.dart';

class ProfileMainPage extends StatelessWidget {
  final int userid;
  final String selectedChoice;

  const ProfileMainPage({
    super.key,
    required this.userid,
    required this.selectedChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ProfileFormSection(
          selectedChoice: selectedChoice,
          editSection: {},
          controllers: {},
          toggleEdit: (key) {},
        ),
      ),
    );
  }
}
