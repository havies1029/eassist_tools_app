import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:eassist_tools_app/pages/splash/splash_page.dart';

import '../heropage/hero_page.dart';

class HomeRedirectorPage extends StatelessWidget {
  const HomeRedirectorPage({super.key});

  bool isMobilePlatform() {
    return !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);
  }

  bool isSmallScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 768; // Threshold mobile width
  }

  @override
  Widget build(BuildContext context) {
    // Jika native Android/iOS ATAU layar kecil (<768), tampilkan Splash
    // if (isMobilePlatform() || isSmallScreen(context)) {
    //   return const SplashPage();
    // } else {
    //   return const HeroMain();
    // }
    if (isMobilePlatform()) {
      return const SplashPage();
    } else {
      // return const HeroMain();
      return const HeroPage();
    }
  }
}
