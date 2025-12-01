import 'package:flutter/material.dart';

import '../../../../pages/heropage/hero_main.dart';

class NavBar extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isMenuOpen;
  final GlobalKey menuButtonKey;
  final VoidCallback onHamburgerToggle;
  final Widget profileSection;

  const NavBar({
    super.key,
    required this.constraints,
    required this.isMenuOpen,
    required this.menuButtonKey,
    required this.onHamburgerToggle,
    required this.profileSection,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
    constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: SizedBox(
        width: maxWidth,
        child: Row(
          children: [
            // Logo
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HeroMain()),
                  );
                },
                child: Image.asset(
                  'assets/images/jps_logo.png',
                  height: 60.0,
                ),
              ),
            ),

            const Spacer(),

            // Profile Section (dari luar di-pass sebagai widget)
            profileSection,

            const SizedBox(width: 16),

            // Hamburger Menu Icon
            Container(
              key: menuButtonKey,
              decoration: BoxDecoration(
                color: isMenuOpen
                    ? const Color(0xFF79AB43).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: AnimatedRotation(
                  turns: isMenuOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isMenuOpen ? Icons.close : Icons.menu,
                    color: const Color(0xFF79AB43),
                    size: 24,
                  ),
                ),
                onPressed: onHamburgerToggle,
                tooltip: isMenuOpen ? 'Close menu' : 'Open navigation menu',
                splashRadius: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
