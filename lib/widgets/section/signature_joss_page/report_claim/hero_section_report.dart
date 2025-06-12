import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  // =========================
  // RESPONSIVE CONFIGURATION
  // =========================
  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => isMobile ? 0 : (constraints.maxWidth > 1200 ? 50.0 : 32.0);

  // =========================
  // STYLE CONSTANTS
  // =========================
  static const _primaryColor = Color(0xFF79AB43);
  static const _whiteColor = Colors.white;
  static const _fontFamily = 'Satoshi-Regular';

  TextStyle get _boldHeading => TextStyle(
    fontFamily: _fontFamily,
    fontSize: isMobile ? 20 : 45,
    fontWeight: FontWeight.w700,
    color: _whiteColor,
  );

  TextStyle get _lightHeading => TextStyle(
    fontFamily: _fontFamily,
    fontSize: isMobile ? 22 : 40,
    fontWeight: FontWeight.w200,
    color: _whiteColor,
  );

  TextStyle get _bodyText => TextStyle(
    fontFamily: _fontFamily,
    fontSize: isMobile ? 12 : 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: _whiteColor,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Center(
        child: Container(
          width: maxWidth,
          margin: EdgeInsets.only(top: isMobile ? 0 : 50),
          height: isMobile ? 200 : null,
          padding: isMobile
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: isMobile
                ? BorderRadius.zero
                : const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: isMobile ? _buildMobileContent() : _buildDesktopContent(),
        ),
      ),
    );
  }

  Widget _buildMobileContent() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 0,
          top: 90,
          child: _buildHeroImage(),
        ),
        Positioned(
          left: 16,
          top: 60,
          right: 80,
          child: _buildTextBlock(TextAlign.left),
        ),
      ],
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: _buildTextBlock(TextAlign.left),
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
    );
  }

  Widget _buildTextBlock(TextAlign align) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : maxWidth * 0.65,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _desktopTitle1,
            textAlign: align,
            style: _boldHeading,
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: _bodyText,
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
      width: isMobile ? 200 : null,
      height: isMobile ? 200 : null,
      fit: BoxFit.contain,
    );
  }

  // ============================================================
  // 🔌 DATA DINAMIS (Sementara hardcoded, siap dihubungkan ke API)
  // ============================================================

  static const String _desktopTitle1 = 'Selamat Datang, [Nama User]! Berikut ringkasan polis Anda Hari ini:';
  static const String _desktopDescription1 =
      'adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\ndan klaim asuransi hanya dalam hitungan menit ';

  static const String _imageUrl = 'assets/images/human.png';
}