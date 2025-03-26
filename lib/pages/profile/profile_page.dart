import 'package:flutter/material.dart';
import 'package:eassist_tools_app/common/size_config.dart';
import 'package:eassist_tools_app/pages/profile/profile_form.dart';
import 'package:eassist_tools_app/pages/profile/profile_pic.dart';

class ProfilePage extends StatelessWidget {  
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: const SingleChildScrollView(
                  child: Column(children: [
                    //SizedBox(height: SizeConfig.screenHeight! * 0.04), // 4%
                    SizedBox(height: 5,),
                    ProfilePic(),
                    //SizedBox(height: SizeConfig.screenHeight! * 0.08),
                    ProfileForm(),
                  ]),
                ))));
  }
}
