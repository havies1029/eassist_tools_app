import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  bool get isSmallMobile => constraints.maxWidth < 400;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.centerLeft,
      child: Container(
        width: maxWidth,
        margin: EdgeInsets.only(top: isMobile ? 30 : 50),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? (isSmallMobile ? 16.0 : 20.0) : 40.0,
          vertical: isMobile ? (isSmallMobile ? 16.0 : 20.0) : 50.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: _buildHeroText(
          isMobile ? TextAlign.center : TextAlign.left,
          paddingLeft: isMobile ? 0 : 320,
          paddingBottom: isMobile ? (isSmallMobile ? 16 : 20) : 40,
        ),
      ),
    );
  }

  Widget _buildHeroText(TextAlign align, {double paddingLeft = 0, double paddingBottom = 0}) {
    // Responsive font size dengan gradasi yang lebih halus
    final double titleSize = isMobile
        ? (isSmallMobile ? 22 : 26)
        : 40;
    final double subtitleSize = isMobile
        ? (isSmallMobile ? 14 : 16)
        : 23;
    final double descSize = isMobile
        ? (isSmallMobile ? 12 : 13)
        : 15;
    final double spacing = isMobile
        ? (isSmallMobile ? 8 : 12)
        : 20;

    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, bottom: paddingBottom),
      child: Column(
        crossAxisAlignment: align == TextAlign.left
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          // Judul dengan improved mobile typography
          Text(
            'Selamat Datang, [Nama User]',
            textAlign: align,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: isMobile
                  ? (isSmallMobile ? 1.25 : 1.3)
                  : 1.18,
              letterSpacing: isMobile ? -0.5 : 0,
            ),
          ),
          SizedBox(height: isMobile ? 6 : 4),
          // Subjudul dengan better mobile spacing
          Text(
            'Berikut ringkasan polis Anda hari ini:',
            textAlign: align,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: subtitleSize,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.9),
              height: isMobile
                  ? (isSmallMobile ? 1.4 : 1.35)
                  : 1.25,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(height: spacing),
          // Deskripsi dengan improved mobile readability
          Container(
            width: isMobile ? double.infinity : 520,
            constraints: isMobile
                ? BoxConstraints(maxWidth: constraints.maxWidth - 40)
                : null,
            child: RichText(
              textAlign: align,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: descSize,
                  fontWeight: FontWeight.w400,
                  height: isMobile
                      ? (isSmallMobile ? 1.6 : 1.65)
                      : 1.65,
                  color: Colors.white.withOpacity(0.85),
                  letterSpacing: isMobile ? 0.2 : 0,
                ),
                children: [
                  TextSpan(
                    text: 'JPS',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(
                    text: ' adalah platform asuransi pintar yang memudahkan kamu mencari, memilih, dan klaim asuransi hanya dalam hitungan menit ',
                  ),
                  TextSpan(
                    text: 'cepat',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(text: ', '),
                  TextSpan(
                    text: 'aman',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(text: ', dan '),
                  TextSpan(
                    text: 'terdaftar OJK',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}