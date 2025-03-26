import 'package:flutter/material.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/common/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required super.key,
    required this.text,
    required this.press,
  });
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: kPrimaryColor,
      padding: const EdgeInsets.all(0),
    );

    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: flatButtonStyle,
        onPressed: press,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),

/*
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
*/
    );
  }
}
