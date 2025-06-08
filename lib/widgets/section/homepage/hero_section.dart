import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;

  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

  double get sidePadding {
    if (isMobile) return 0;
    return constraints.maxWidth > 1200 ? 64.0 : 32.0;
  }

  TextStyle get heroHeadingStyle => TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: isMobile ? 24 : 40,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  TextStyle get heroBodyTextStyle => const TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
  }

  Widget _buildMobileLayout() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF79AB43),
        borderRadius: BorderRadius.zero,
      ),
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroText(TextAlign.left),
          const SizedBox(height: 20.0),
          _buildHeroImage(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Center(
        child: Container(
          width: maxWidth,
          margin: const EdgeInsets.only(top: 50),
          decoration: const BoxDecoration(
            color: Color(0xFF79AB43),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Transform.translate(
                    offset: const Offset(0, -20),
                    child: _buildHeroText(TextAlign.left),
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(width: 300, height: 250),
                  Positioned(
                    right: -40,
                    bottom: 0,
                    child: SizedBox(
                      width: 360,
                      child: _buildHeroImage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText(TextAlign align) {
    return Column(
      crossAxisAlignment: align == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          _heroTitle1,
          textAlign: align,
          style: heroHeadingStyle,
        ),
        const SizedBox(height: 6),
        Text(
          _heroTitle2,
          textAlign: align,
          style: heroHeadingStyle,
        ),
        const SizedBox(height: 10),
        Text(
          _heroDescriptionText,
          textAlign: align,
          maxLines: isMobile ? 4 : 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Align(
      alignment: isMobile ? Alignment.centerRight : Alignment.center,
      child: Image.asset(
        _heroImageUrl,
        width: isMobile ? 242 : null,
        height: isMobile ? 257 : null,
        fit: BoxFit.contain,
      ),
    );
  }

  // ================================
  // DATA YANG AKAN DISAMBUNGKAN API
  // ================================

  static const String _heroTitle1 = 'Klien Kami, Prioritas Kami:';
  static const String _heroTitle2 = 'Memberikan Solusi Terbaik untuk Anda!';
  String get _heroDescriptionText =>
      'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih, dan klaim asuransi hanya dalam hitungan menit cepat, aman, dan terdaftar OJK.';
  static const String _heroImageUrl = 'assets/images/human.png';
}
