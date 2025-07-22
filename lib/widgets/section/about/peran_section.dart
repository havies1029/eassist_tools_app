import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// =================== STYLES & CONSTANTS ===================

class AppStyles {
  static const String fontFamily = 'Satoshi';

  static TextStyle headerStyle(bool isMobile) => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
      fontSize: isMobile? 20: 27
  );

  static const TextStyle subtitleStyle=TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    color: AppColors.colorMuted,
  );

  static TextStyle descriptionStyle(bool isMobile) =>TextStyle(
    fontFamily: fontFamily,
    fontSize: isMobile? 15 : 20,
    color: AppColors.textColor,
  );
}

class AppColors {
  static const Color primaryGreen = Color(0xFF91C050);
  static const Color primaryOrange = Color(0xFFFAA232);
  static const Color textColor = Colors.black;
  static const Color colorMuted = Color(0xFFCACED8);
}

class PeranJpsSection extends StatefulWidget {
  final BoxConstraints constraints;

  const PeranJpsSection({Key? key, required this.constraints})
      : super(key: key);

  @override
  State<PeranJpsSection> createState() => _PeranJpsSectionState();
}

class _PeranJpsSectionState extends State<PeranJpsSection>
    with TickerProviderStateMixin {
  int selectedTabIndex = 0;
  late PageController _pageController;
  late AnimationController _tabAnimationController;
  late AnimationController _contentAnimationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _contentAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabAnimationController.dispose();
    _contentAnimationController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index != selectedTabIndex) {
      setState(() {
        selectedTabIndex = index;
      });

      // Animate page transition
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );

      // Animate tab selection
      _tabAnimationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.constraints.maxWidth < 768;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 5 : 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // ===== HEADER =====
              _buildHeader(isMobile),
              const SizedBox(height: 10),
              Text(
                'Sebagai pusat peran strategis JPS, Broker membawahi empat peran utama berikut:',
                style: AppStyles.subtitleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 20 : 34),

              // ===== TAB NAVIGATION =====
              _buildTabNavigation(isMobile),
              SizedBox(height: isMobile ? 16 : 34),

              // ===== CONTENT AREA =====
              _buildContentArea(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        // Broker icon at the top
        SvgPicture.asset(
          'assets/icons/user_roles.svg',
          width: isMobile? 40:60,
          height: isMobile? 40:60,
          // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 15),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppStyles.headerStyle(isMobile),
            children: [
              const TextSpan(text: 'Peran '),
              TextSpan(
                text: 'J',
                style: AppStyles.headerStyle(isMobile).copyWith(
                  color: AppColors.primaryGreen,
                ),
              ),
              TextSpan(
                text: 'P',
                style: AppStyles.headerStyle(isMobile).copyWith(
                  color: AppColors.primaryOrange,
                ),
              ),
              TextSpan(
                text: 'S',
                style: AppStyles.headerStyle(isMobile).copyWith(
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabNavigation(bool isMobile) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.colorMuted,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(roleItems.length, (index) {
          final role = roleItems[index];
          final isSelected = selectedTabIndex == index;
          return Container(
            margin: EdgeInsets.only(right: index < roleItems.length - 1 ? (isMobile ? 5 : 10) : 0),
            child: GestureDetector(
              onTap: () => _onTabSelected(index),
              child: AnimatedBuilder(
                animation: _tabAnimationController,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 8 : 12,
                        horizontal: isMobile ? 8 : 20
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFE2FFC2) : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: isSelected
                          ? const Border(
                        bottom: BorderSide(
                          color: AppColors.primaryGreen,
                          width: 2.0,
                        ),
                      )
                          : null,
                    ),
                    child: isMobile?
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          child: SvgPicture.asset(
                            role.svgAsset,
                            width: isMobile ? 25 : 27,
                            height: isMobile ? 25 : 27,
                            colorFilter: ColorFilter.mode(
                              isSelected ? AppColors.primaryGreen : AppColors.colorMuted,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: isMobile ? 10 : 12),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: isSelected? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primaryGreen : AppColors.colorMuted,
                          ),
                          child: Text(
                            role.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ) :
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          child: SvgPicture.asset(
                            role.svgAsset,
                            width: isMobile ? 18 : 27,
                            height: isMobile ? 18 : 27,
                            colorFilter: ColorFilter.mode(
                              isSelected ? AppColors.primaryGreen : AppColors.colorMuted,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: isMobile ? 6 : 12),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: isSelected? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primaryGreen : AppColors.colorMuted,
                          ),
                          child: Text(
                            role.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContentArea(bool isMobile) {
    return Container(
      height: isMobile ? 320 : 250, // Slightly taller for mobile
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedTabIndex = index;
          });
        },
        itemCount: roleItems.length,
        itemBuilder: (context, index) {
          return _buildContentPage(roleItems[index], isMobile);
        },
      ),
    );
  }

  Widget _buildContentPage(RoleData role, bool isMobile) {
    return AnimatedBuilder(
      animation: _contentAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _contentAnimationController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _contentAnimationController,
              curve: Curves.easeInOutCubic,
            )),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 40 : 100, // Reduced padding for mobile
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: role.descriptions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final description = entry.value;

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    curve: Curves.easeInOutCubic,
                    child: TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeInOutCubic,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, (1 - value) * 20),
                          child: Opacity(
                            opacity: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: isMobile ? 18 : 22.45, // Reduced spacing for mobile
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/check.svg',
                                    width: isMobile ? 23.39 : 28.07,
                                    height: isMobile ? 23.39 : 28.07,
                                  ),
                                  SizedBox(width: isMobile ? 12 : 18.71), // Reduced spacing for mobile
                                  Expanded(
                                    child: Text(
                                      description,
                                      style: AppStyles.descriptionStyle(isMobile),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

// =================== DATA MODELS ===================

class RoleData {
  final Color bgColor;
  final String svgAsset;
  final String title;
  final List<String> descriptions;

  const RoleData({
    required this.bgColor,
    required this.svgAsset,
    required this.title,
    required this.descriptions,
  });

  factory RoleData.fromJson(Map<String, dynamic> json) {
    return RoleData(
      bgColor: _getColorFromString(json['bgColor']),
      svgAsset: _getSvgAssetFromString(json['icon']),
      title: json['title'],
      descriptions: List<String>.from(json['descriptions']),
    );
  }

  static Color _getColorFromString(String colorStr) {
    switch (colorStr) {
      case 'assessment':
        return AppColors.primaryGreen;
      case 'architect':
        return AppColors.primaryGreen;
      case 'consultant':
        return AppColors.primaryGreen;
      case 'lawyer':
        return AppColors.primaryGreen;
      default:
        return AppColors.primaryGreen;
    }
  }

  static String _getSvgAssetFromString(String iconStr) {
    switch (iconStr) {
      case 'assessment':
        return 'assets/icons/penilaian.svg';
      case 'architecture':
        return 'assets/icons/arsitek.svg';
      case 'headset_mic':
        return 'assets/icons/konsultan.svg';
      case 'balance':
        return 'assets/icons/pengacara.svg';
      default:
        return 'assets/icons/penilaian.svg';
    }
  }
}

// =================== SAMPLE DATA ===================

final List<RoleData> roleItems = [
  RoleData(
    bgColor: AppColors.primaryGreen,
    svgAsset: 'assets/icons/penilaian.svg',
    title: 'Penilaian',
    descriptions: [
      'Mengumpulkan informasi yang relevan dan mendalam',
      'Mengidentifikasi kebutuhan dan potensi risiko klien',
      'Menganalisis kondisi dan eksposur aset yang dimiliki',
      'Menyusun ringkasan data sebagai dasar program asuransi',
    ],
  ),
  RoleData(
    bgColor: AppColors.primaryGreen,
    svgAsset: 'assets/icons/arsitek.svg',
    title: 'Arsitek',
    descriptions: [
      'Merancang syarat dan ketentuan perlindungan',
      'Menyusun struktur program asuransi secara menyeluruh',
      'Menempatkan polis ke perusahaan asuransi yang tepat',
      'Memberikan saran opsi terbaik dan mengelola perpanjangan',
    ],
  ),
  RoleData(
    bgColor: AppColors.primaryGreen,
    svgAsset: 'assets/icons/konsultan.svg',
    title: 'Konsultan',
    descriptions: [
      'Memberikan rekomendasi strategi perlindungan risiko',
      'Menjadi pendamping diskusi antara klien dan asuransi',
      'Menyampaikan hasil analisis risiko secara terbuka',
      'Membantu pengambilan keputusan berbasis data',
    ],
  ),
  RoleData(
    bgColor: AppColors.primaryGreen,
    svgAsset: 'assets/icons/pengacara.svg',
    title: 'Pengacara',
    descriptions: [
      'Memberikan masukan hukum demi hasil terbaik',
      'Memberikan masukan hukum demi hasil terbaik',
      'Menyusun dokumentasi pendukung klaim yang akurat',
      'Menjaga kelancaran proses klaim agar efisien dan adil',
    ],
  ),
];