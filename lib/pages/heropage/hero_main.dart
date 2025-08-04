import 'package:flutter/material.dart';
import 'hero_page.dart';

class HeroMain extends StatelessWidget {
  const HeroMain({super.key});

  @override
  Widget build(BuildContext context) {
    // Listener auth sekarang global di App (root), bukan di sini.
    return const HeroPage();
  }
}
