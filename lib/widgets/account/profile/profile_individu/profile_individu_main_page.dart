import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_individu/profile_individu_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

class ProfileIndividuMainPage extends StatelessWidget {
  final int userid;
  final UserRepository userRepository;

  const ProfileIndividuMainPage({
    super.key,
    required this.userid,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ProfileIndividuPage(userid: userid),
      ),
    );
  }
}

