import 'package:eassist_tools_app/widgets/components/navbar/navbar_widget.dart';
import 'package:flutter/material.dart';

class FixedNavbarOverlay extends StatelessWidget {
  const FixedNavbarOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none, // agar pop-up bisa muncul di luar batas
        children: [
          Material(
            color: Colors.transparent,
            elevation: 20,
            child: NavbarWidget(
              hideProfile: true,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}