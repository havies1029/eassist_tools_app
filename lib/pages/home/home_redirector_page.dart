import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/heropage/hero_main.dart';
import 'package:eassist_tools_app/pages/splash/splash_page.dart';

class HomeRedirectorPage extends StatelessWidget {
  const HomeRedirectorPage({super.key});

  bool get isMobilePlatform =>
      !kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Widget build(BuildContext context) {
    return isMobilePlatform ? const SplashPage() : const HeroMain();
  }
}
