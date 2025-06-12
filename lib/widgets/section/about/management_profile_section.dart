import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ManagementProfileSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ManagementProfileSection({super.key, required this.constraints});

  @override
  State<ManagementProfileSection> createState() => _ManagementProfileSectionState();
}
const _primaryColor = Color(0xFF79AB43);
class _ManagementProfileSectionState extends State<ManagementProfileSection> with TickerProviderStateMixin {
  // === CONSTANTS & STYLES ===
  static const _fontFamily = 'Satoshi-Regular';
  static const _secondaryColor = Color(0xFFFAA232);

  late final PageController _pageController;
  late final AnimationController _hoverAnimationController;
  late final Animation<double> _hoverAnimation;
  double _currentPageValue = 1000.0;
  bool _isHovering = false;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  TextStyle get titleStyle => TextStyle(fontSize: isMobile ? 20 : (isTablet ? 25 : 27), color: Colors.black87, fontFamily: _fontFamily);
  TextStyle get nameStyle => TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: _fontFamily);
  TextStyle get positionStyle => TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black54, fontFamily: _fontFamily);
  TextStyle get descriptionStyle => TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black54, fontFamily: _fontFamily, height: 1);

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializePageController();
    _setupPageListener();
  }

  void _initializeAnimations() {
    _hoverAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _hoverAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(CurvedAnimation(parent: _hoverAnimationController, curve: Curves.easeInOut));
  }

  void _initializePageController() {
    double maxWidth = widget.constraints.maxWidth;
    double fraction = maxWidth < 600 ? 0.85 : maxWidth < 900 ? 0.5 : maxWidth < 1200 ? 0.33 : 0.25;
    _pageController = PageController(initialPage: 500, viewportFraction: fraction);
  }

  void _setupPageListener() {
    _pageController.addListener(() {
      if (_pageController.hasClients) {
        setState(() => _currentPageValue = _pageController.page ?? 1000.0);
      }
    });
  }

  void _onHoverEnter() {
    setState(() => _isHovering = true);
    _hoverAnimationController.forward();
  }

  void _onHoverExit() {
    setState(() => _isHovering = false);
    _hoverAnimationController.reverse();
  }

  double _getScale(int index) => 0.95;
  double _getOpacity(int index) {
    final distance = (_currentPageValue - index).abs();
    return distance <= 1.0 ? 1.0 - (distance * 0.2) : 0.8;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 35 : (isTablet ? 40 : 80), vertical: isMobile ? 40 : 80),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: widget.constraints.maxWidth >= 1024 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: isMobile ? 40 : 60),
          _buildCarouselWithInteractions(),
          SizedBox(height: isMobile ? 20 : 30),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: widget.constraints.maxWidth >= 1024 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Dewan Direksi dan Komisaris ', style: titleStyle.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(text: 'J', style: titleStyle.copyWith(color: _primaryColor, fontWeight: FontWeight.bold)),
              TextSpan(text: 'P', style: titleStyle.copyWith(color: _secondaryColor, fontWeight: FontWeight.bold)),
              TextSpan(text: 'S', style: titleStyle.copyWith(color: _primaryColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text('Pemimpin yang menavigasi langkah kami menuju masa depan.', style: titleStyle.copyWith(fontWeight: FontWeight.w400, fontSize: isMobile ? 12 : 18)),
      ],
    );
  }

  Widget _buildCarouselWithInteractions() {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) => Transform.scale(scale: _hoverAnimation.value, child: _buildProfileCarousel()),
      ),
    );
  }

  Widget _buildProfileCarousel() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      child: SizedBox(
        height: isMobile ? 550 : 654,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final scale = _getScale(index);
              final opacity = _getOpacity(index);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12),
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: _buildProfileCard(profiles[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(ManagementProfile profile) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: SizedBox(
                height: isMobile ? 250 : 366,
                width: 305,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(profile.name, style: nameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(profile.position, style: positionStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 12),
                        Text(profile.experience, style: descriptionStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: profile.achievements.map((achievement) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 4, height: 4, margin: const EdgeInsets.only(top: 6, right: 8), decoration: BoxDecoration(color: Colors.grey[600], shape: BoxShape.circle)),
                                Expanded(child: Text(achievement, style: descriptionStyle, maxLines: isMobile? 4: 3, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                    Positioned(top: 0, right: 0, child: Icon(Icons.format_quote, size: 43, color: Colors.grey[200])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================
// === DATA / API LAYER ==== //
// ============================

class ManagementProfile {
  final String name;
  final String position;
  final String imageAsset;
  final Color roleColor;
  final String experience;
  final List<String> achievements;

  ManagementProfile({
    required this.name,
    required this.position,
    required this.imageAsset,
    required this.roleColor,
    required this.experience,
    required this.achievements,
  });
}

// TODO: Replace with API integration
final List<ManagementProfile> profiles = [
  ManagementProfile(
    name: 'Frans Lamury',
    position: 'Presiden Komisaris',
    imageAsset: 'assets/images/frans.jpg',
    roleColor: _primaryColor,
    experience: 'Pengalaman di industri asuransi 62 tahun',
    achievements: [
      'Ahli dalam asuransi umum',
      'Menjadi saksi ahli dalam asuransi umum',
      'Anggota tim evaluasi uji kelayakan dan kepatutan untuk eksekutif dan komisaris asuransi di Indonesia',
    ],
  ),
  ManagementProfile(
    name: 'Micky',
    position: 'Komisaris',
    imageAsset: 'assets/images/micky.jpg',
    roleColor: _primaryColor,
    experience: 'Pengalaman di industri asuransi 25 tahun',
    achievements: [
      '25 tahun pengalaman dalam pengembangan sistem',
      'Berpengalaman dalam pembuatan aplikasi dan sistem di sektor perbankan',
    ],
  ),
  ManagementProfile(
    name: 'Ruddy Sudjono',
    position: 'Direktur Utama',
    imageAsset: 'assets/images/ruddy.jpg',
    roleColor: _primaryColor,
    experience: 'Pengalaman di industri asuransi 30 tahun',
    achievements: [
      'Kreatif dalam pengembangan kebijakan di bidang asuransi',
      'Pemikir “out of the box” dalam penyelesaian klaim asuransi',
    ],
  ),
  ManagementProfile(
    name: 'Jeffry Stanley',
    position: 'Direktur Pemasaran',
    imageAsset: 'assets/images/jeffry.jpg',
    roleColor: _primaryColor,
    experience: 'Pengalaman di industri asuransi 20 tahun',
    achievements: [
      'Memulai karier di Asuransi Sinarmas',
      'Memiliki jaringan luas',
      'Dikenal sebagai individu kreatif di industri asuransi',
    ],
  ),
  ManagementProfile(
    name: 'Fendy',
    position: 'Direktur Keuangan',
    imageAsset: 'assets/images/fendy.jpg',
    roleColor: _primaryColor,
    experience: 'Pengalaman di industri asuransi selama 32 tahun',
    achievements: [
      '5 tahun pengalaman di bidang akuntansi publik',
      'Lebih dari 30 tahun di industri keuangan dan asuransi',
    ],
  ),
];