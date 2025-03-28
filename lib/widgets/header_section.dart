import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                'assets/images/jps-image.png',
                width: 106,
                height: 109,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            width: 5,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFEBA2B),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                'assets/images/bsi-image.png',
                width: 116,
                height: 95,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
