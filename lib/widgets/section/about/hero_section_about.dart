import 'package:flutter/material.dart';

//====================[ GLOBAL STYLE CONSTANTS ]=====================//
const _primaryColor = Color(0xFF79AB43);
const _fontFamily = 'Satoshi-Regular';
const _whiteColor = Colors.white;

const _titleStyle = TextStyle(
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: 22,
  color: _whiteColor,
);

const _subtitleStyle = TextStyle(
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w400,
  fontSize: 15,
  height: 1.6,
  color: _whiteColor,
);

const _desktopTitleStyle = TextStyle(
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w700,
  fontSize: 40,
  color: _whiteColor,
);

const _desktopSubtitleStyle = TextStyle(
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w200,
  fontSize: 40,
  color: _whiteColor,
);

//====================[ HERO SECTION ]=====================//
class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;
  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => isMobile ? 0 : (constraints.maxWidth > 1200 ? 64.0 : 32.0);

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(
        width: double.infinity,
        height: 300,
        margin: const EdgeInsets.only(top: 0, left: 10),
        decoration: const BoxDecoration(color: _primaryColor),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(right: 20, top: 110, child: _buildHeroImage()),
            Positioned(left: 16, top: 60, right: 80, child: _buildMobileHeroText()),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Center(
        child: Container(
          width: maxWidth,
          margin: const EdgeInsets.only(top: 50),
          decoration: const BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Transform.translate(
                      offset: const Offset(0, -20),
                      child: _buildDesktopHeroText(TextAlign.left),
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
      ),
    );
  }

  Widget _buildMobileHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Klien Kami, Prioritas Kami:', style: _titleStyle),
        const SizedBox(height: 6),
        const Text('Memberikan Solusi Terbaik untuk Anda!', style: _titleStyle, maxLines: 1),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: _subtitleStyle,
            children: _descriptionText,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeroText(TextAlign align) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Column(
        crossAxisAlignment: align == TextAlign.left ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text('Selamat Datang, $namaUser', textAlign: align, style: _desktopTitleStyle),
          const SizedBox(height: 6),
          Text('Berikut ringkasan polis Anda Hari ini:', textAlign: align, style: _desktopSubtitleStyle),
          const SizedBox(height: 20),
          RichText(
            textAlign: align,
            text: TextSpan(
              style: _subtitleStyle,
              children: _descriptionText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Image.asset(
      'assets/images/human.png',
      width: isMobile ? 260 : null,
      height: isMobile ? 280 : null,
      fit: BoxFit.contain,
    );
  }
}

//====================[ API or dynamic data section ]=====================//
const String namaUser = "[Nama User]";

const List<TextSpan> _descriptionText = [
  TextSpan(text: 'JPS', style: TextStyle(fontWeight: FontWeight.w700)),
  TextSpan(text: ' adalah platform asuransi pintar yang memudahkan kamu mencari, memilih'),
  TextSpan(text: ' dan klaim asuransi hanya dalam hitungan menit '),
  TextSpan(text: 'cepat', style: TextStyle(fontWeight: FontWeight.w700)),
  TextSpan(text: ', '),
  TextSpan(text: 'aman', style: TextStyle(fontWeight: FontWeight.w700)),
  TextSpan(text: ', dan '),
  TextSpan(text: 'terdaftar OJK', style: TextStyle(fontWeight: FontWeight.w700)),
  TextSpan(text: '.'),
];