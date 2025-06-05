import 'package:flutter/material.dart';

class ManagementProfileSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ManagementProfileSection({
    super.key,
    required this.constraints,
  });

  @override
  State<ManagementProfileSection> createState() =>
      _ManagementProfileSectionState();
}

class _ManagementProfileSectionState extends State<ManagementProfileSection> {
  late final PageController _pageController;
  int _currentIndex = 0;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet =>
      widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  TextStyle get titleStyle => TextStyle(
    fontSize: isMobile ? 20 : (isTablet ? 25 : 27),
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    fontFamily: 'Satoshi-Regular',
  );

  TextStyle get nameStyle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
    fontFamily: 'Satoshi-Regular',
  );

  TextStyle get positionStyle => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    fontFamily: 'Satoshi-Regular',
  );

  @override
  void initState() {
    super.initState();

    double fraction;
    double maxWidth = widget.constraints.maxWidth;

    if (maxWidth < 600) {
      fraction = 360 / maxWidth;
    } else if (maxWidth < 900) {
      fraction = 360 * 2 / maxWidth;
    } else if (maxWidth < 1200) {
      fraction = 360 * 3 / maxWidth;
    } else {
      fraction = 0.25;
    }

    _pageController = PageController(
      initialPage: 1000,
      viewportFraction: fraction > 1 ? 1 : fraction,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = profiles.length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 35 : (isTablet ? 40 : 80),
        vertical: isMobile ? 40 : 80,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment:
        widget.constraints.maxWidth >= 1024 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text('Profil Manajemen', style: titleStyle),
          SizedBox(height: isMobile ? 40 : 60),

          // Carousel Profil
          Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SizedBox(
              height: isMobile ? 400 : (isTablet ? 500 : 400),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index % totalItems;
                      });
                    },
                    itemBuilder: (context, index) {
                      final realIndex = index % totalItems;
                      return Center(
                        child: Container(
                          width: 360,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: _buildProfileCard(profiles[realIndex]),
                        ),
                      );
                    },
                  ),

                  if (widget.constraints.maxWidth >= 1200)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _buildNavigationButton(
                          icon: Icons.chevron_left,
                          onPressed: () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                    ),

                  if (widget.constraints.maxWidth >= 1200)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _buildNavigationButton(
                          icon: Icons.chevron_right,
                          onPressed: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFF79AB43),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onPressed,
          child: const Icon(Icons.chevron_right, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildProfileCard(ManagementProfile profile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 300,
              width: 350,
              child: Image.asset(
                profile.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 65, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text('Photo', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Nama & Posisi
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name, style: nameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                Text(
                  profile.position,
                  style: positionStyle.copyWith(color: profile.roleColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================
// === API or dynamic data section ===
// ============================

class ManagementProfile {
  final String name;
  final String position;
  final String imageAsset;
  final Color roleColor;

  ManagementProfile({
    required this.name,
    required this.position,
    required this.imageAsset,
    required this.roleColor,
  });
}

// Hardcoded sementara, nanti ganti fetch dari API
final List<ManagementProfile> profiles = [
  ManagementProfile(
    name: 'Frans Lamury, ANZIIF (Snr.Assoc)',
    position: 'President Commissioner',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
  ManagementProfile(
    name: 'Ruddy Sudjono',
    position: 'President Director',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
  ManagementProfile(
    name: 'Jeffry Stanley, CIIB, CIP',
    position: 'Director',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
  ManagementProfile(
    name: 'Sarah Michelle, MBA',
    position: 'Finance Director',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
  ManagementProfile(
    name: 'Michael Chen, CPA',
    position: 'Operations Director',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
  ManagementProfile(
    name: 'Lisa Anderson, CPCU',
    position: 'Risk Management Director',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
  ManagementProfile(
    name: 'David Rodriguez, ARM',
    position: 'Claims Director',
    imageAsset: 'assets/images/profil1.png',
    roleColor: Color(0xFF79AB43),
  ),
];