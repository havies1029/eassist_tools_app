import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/profile/profile_perusahaan/profile_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

class ProfileMainPage extends StatelessWidget {
  final int userid;
  final UserRepository userRepository;

  const ProfileMainPage({
    super.key,
    required this.userid,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: ProfilePage(userid: 0)),
    );
  }
}
