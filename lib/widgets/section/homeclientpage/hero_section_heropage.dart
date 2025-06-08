import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => isMobile ? 0 : (constraints.maxWidth > 1200 ? 64.0 : 32.0);

  // ===========
  // TEXT STYLES
  // ===========

  TextStyle get boldHeading => TextStyle(
    fontFamily: _fontFamily,
    fontSize: isMobile ? 22 : 40,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  TextStyle get lightHeading => TextStyle(
    fontFamily: _fontFamily,
    fontSize: isMobile ? 22 : 40,
    fontWeight: FontWeight.w200,
    color: Colors.white,
  );

  TextStyle get bodyText => const TextStyle(
    fontFamily: _fontFamily,
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
      height: 300,
      margin: const EdgeInsets.only(top: 0, left: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF79AB43),
        borderRadius: BorderRadius.zero,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 20,
            top: 110,
            child: _buildHeroImage(),
          ),
          Positioned(
            left: 16,
            top: 60,
            right: 80,
            child: _buildHeroText(TextAlign.left),
          ),
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
                    child: SizedBox(width: 360, child: _buildHeroImage()),
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
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_mobileTitle1, textAlign: align, style: boldHeading),
          const SizedBox(height: 6),
          Text(_mobileTitle2, textAlign: align, style: boldHeading, maxLines: 1),
          const SizedBox(height: 10),
          Text(_mobileDescription, textAlign: align, style: bodyText),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_desktopTitle1, textAlign: align, style: boldHeading),
          const SizedBox(height: 6),
          Text(_desktopTitle2, textAlign: align, style: lightHeading),
          const SizedBox(height: 20),
          RichText(
            textAlign: align,
            text: TextSpan(
              style: bodyText,
              children: const [
                TextSpan(text: 'JPS ', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: _desktopDescription1),
                TextSpan(text: 'cepat', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: ', '),
                TextSpan(text: 'aman', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: ', dan '),
                TextSpan(text: 'terdaftar OJK', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Image.asset(
      _imageUrl,
      width: isMobile ? 260 : null,
      height: isMobile ? 280 : null,
      fit: BoxFit.contain,
    );
  }

  // =====
  // DATA
  // =====

  static const String _fontFamily = 'Satoshi-Regular';

  static const String _mobileTitle1 = 'Klien Kami, Prioritas Kami:';
  static const String _mobileTitle2 = 'Memberikan Solusi Terbaik untuk Anda!';
  static const String _mobileDescription =
      'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih '
      'dan klaim asuransi hanya dalam hitungan menit cepat, aman, dan terdaftar OJK.';

  static const String _desktopTitle1 = 'Selamat Datang, [Nama User]';
  static const String _desktopTitle2 = 'Berikut ringkasan polis Anda Hari ini:';
  static const String _desktopDescription1 =
      'adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\ndan klaim asuransi hanya dalam hitungan menit ';

  static const String _imageUrl = 'assets/images/human.png';
}
