import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 270,
        height: 7,
        decoration: BoxDecoration(
          color: const Color(0xFF717171).withOpacity(0.72),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
