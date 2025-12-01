import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final GlobalKey profileButtonKey;
  final bool isProfileMenuOpen;
  final VoidCallback onToggleProfileMenu;

  const ProfileSection({
    super.key,
    required this.profileButtonKey,
    required this.isProfileMenuOpen,
    required this.onToggleProfileMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: profileButtonKey,
      decoration: BoxDecoration(
        color: isProfileMenuOpen
            ? const Color(0xFF79AB43).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onToggleProfileMenu,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Picture dengan Status Indicator
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF79AB43),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/profile_placeholder.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, st) => Container(
                          color: const Color(0xFF79AB43).withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF79AB43),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Status Indicator Hijau
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // Nama User
              const Text(
                'Nadya Septrijayani',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5016),
                ),
              ),

              const SizedBox(width: 8),

              // Dropdown Arrow
              AnimatedRotation(
                turns: isProfileMenuOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF79AB43),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
