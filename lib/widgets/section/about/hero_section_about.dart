import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final double horizontalMargin = _calculateHorizontalMargin();
    final double verticalMargin = isMobile ? 20 : 30;
    final double horizontalPadding = isMobile ? 16.0 : 32.0;
    final double verticalPadding = isMobile ? 24.0 : 48.0;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(
          vertical: verticalMargin,
          horizontal: horizontalMargin,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: _buildHeroText(),
      ),
    );
  }

  Widget _buildHeroText() {
    final double titleSize = isMobile ? 25 : 45;
    final double descSize = 15;
    final double spacing = isMobile ? 14 : 22;

    final titleStyle = TextStyle(
      fontFamily: 'Satoshi-Regular',
      fontSize: titleSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.3,
    );

    final boldTitleStyle = titleStyle.copyWith(fontWeight: FontWeight.w700);

    final descStyle = TextStyle(
      fontFamily: 'Satoshi-Regular',
      fontSize: descSize,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: Colors.white.withOpacity(0.85),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: titleStyle,
            children: isMobile
                ? [
              TextSpan(text: 'Mengenal JPS: ', style: boldTitleStyle),
              TextSpan(text: 'Klaim mudah, perlindungan aman'),
            ]
                : [
              TextSpan(text: 'Mengenal JPS: ', style: boldTitleStyle),
              TextSpan(text: 'Klaim mudah, perlindungan \naman'),
            ],
          ),
        ),
        SizedBox(height: spacing),
        Text(
          heroDescription,
          style: descStyle,
        ),
      ],
    );
  }

  // ===== Layout & Responsive Helper =====
  bool get isMobile => constraints.maxWidth < 768;
  bool get isSmallMobile => constraints.maxWidth < 400;

  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.95;

  double _calculateHorizontalMargin() {
    if (isSmallMobile) {
      return 12.0;
    } else if (isMobile) {
      return constraints.maxWidth * 0.04;
    } else if (constraints.maxWidth < 1000) {
      return constraints.maxWidth * 0.08;
    } else {
      return 135.0;
    }
  }

  // === API or dynamic data section ===
  // Simulasi sementara, nanti bisa diganti ambil dari API
  final String heroDescription =
      'JPS hadir memberikan informasi yang jelas, layanan yang praktis, '
      'dan solusi yang tepat untuk membantu Anda memilih perlindungan\n'
      'terbaik dengan cara paling mudah';
}