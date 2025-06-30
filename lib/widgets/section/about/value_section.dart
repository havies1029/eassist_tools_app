import 'package:flutter/material.dart';

// =================== STYLES & CONSTANTS ===================
class AppColors {
  static const Color primaryGreen = Color(0xFF79AB43);
  static const Color primaryOrange = Color(0xFFFAA232);
  static const Color backgroundLightGreen = Color(0xFFE8F5D8);
  static const Color textColor = Colors.black;
  static const Color textMuted = Color(0xFF585858);
}

class AppStyles {
  static const String fontFamily = 'Satoshi-Regular';

  static final TextStyle header = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static final TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textColor,
  );

  static final TextStyle number = TextStyle(
    fontFamily: fontFamily,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle valueItem = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );
}

// =================== DATA MODEL ===================
class ValueItem {
  final String number;
  final String title;
  final Color color;

  const ValueItem({
    required this.number,
    required this.title,
    required this.color,
  });

  // ==================== API INTEGRATION ====================
  // TODO: Replace with API data parsing when available
  factory ValueItem.fromJson(Map<String, dynamic> json) {
    return ValueItem(
      number: json['number'].toString(),
      title: json['title'],
      color: _colorFromString(json['color']),
    );
  }

  static Color _colorFromString(String colorStr) {
    switch (colorStr.toLowerCase()) {
      case 'orange':
        return AppColors.primaryOrange;
      case 'green':
      default:
        return AppColors.primaryGreen;
    }
  }
}

// Hardcoded for now; will be replaced by API data
final List<ValueItem> valueItems = [
  const ValueItem(number: '1', title: 'Sistem Terintegrasi', color: AppColors.primaryGreen),
  const ValueItem(number: '2', title: 'Digitalisasi Sistem', color: AppColors.primaryOrange),
  const ValueItem(number: '3', title: 'Solusi Satu Pintu', color: AppColors.primaryOrange),
  const ValueItem(number: '4', title: 'Kemampuan Proses Klaim yang Efisien', color: AppColors.primaryOrange),
];

// =================== MAIN WIDGET ===================
class ValueSection extends StatelessWidget {
  final BoxConstraints constraints;

  const ValueSection({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          _buildTitle(isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildTitle(bool isMobile) {
    final size = isMobile ? 20.0 : 27.0;
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppStyles.header.copyWith(fontSize: size),
            children: [
              const TextSpan(text: 'Value '),
              TextSpan(text: 'J', style: AppStyles.header.copyWith(color: AppColors.primaryGreen)),
              TextSpan(text: 'P', style: AppStyles.header.copyWith(color: AppColors.primaryOrange)),
              TextSpan(text: 'S', style: AppStyles.header.copyWith(color: AppColors.primaryGreen)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mengedepankan sistem terintegrasi untuk layanan klaim yang efisien.',
          textAlign: TextAlign.center,
          style: AppStyles.subtitle.copyWith(fontSize: isMobile ? 15 : 18),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildImage(true),
        const SizedBox(height: 40),
        _buildPoints(true),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildImage(false)),
        const SizedBox(width: 60),
        Expanded(child: _buildPoints(false)),
      ],
    );
  }

  Widget _buildImage(bool isMobile) {
    final double w = isMobile ? 376.5 : 378;
    final double h = isMobile ? 313.8 : 378;
    return Center(
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundLightGreen,
        ),
        child: Center(
          child: Image.asset(
            'assets/images/value.png',
            width: w,
            height: h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildPoints(bool isMobile) {
    final image = Image.asset(
      'assets/images/points_value.png',
      width: isMobile ? 367.6 : 527,
      height: isMobile ? 302.6 : 434,
      fit: BoxFit.contain,
    );

    return isMobile
        ? Column(mainAxisSize: MainAxisSize.min, children: [image])
        : Row(children: [image]);
  }
}
