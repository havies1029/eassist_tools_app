import 'package:flutter/material.dart';

// =================== STYLES & CONSTANTS ===================
class AppColors {
  static const Color primaryGreen = Color(0xFF79AB43);
  static const Color primaryOrange = Color(0xFFFAA232);
  static const Color backgroundLightGreen = Color(0xFFE8F5D8);
  static const Color textColor = Colors.black;
  static const Color textMuted = Color(0xFF585858);
  static const Color backgroundWhite = Colors.white;
}

class AppStyles {
  static const String fontFamily = 'Satoshi-Regular';

  static TextStyle header(double fontSize, {Color? color}) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: fontSize,
    color: color ?? AppColors.textColor,
  );

  static TextStyle subtitle(double fontSize) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    color: AppColors.textMuted,
    height: 1.5,
  );

  static TextStyle downloadText(double fontSize) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryGreen,
  );

  static TextStyle logoText(double fontSize) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
  );

  static TextStyle mutedText(double fontSize) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    color: AppColors.textMuted,
  );
}

// =================== MAIN WIDGET ===================
class CompanyProfileSection extends StatelessWidget {
  final BoxConstraints constraints;

  const CompanyProfileSection({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.backgroundWhite,
      child: isMobile ? _buildMobileLayout(isMobile) : _buildDesktopLayout(isMobile),
    );
  }

  Widget _buildMobileLayout(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContent(isMobile),
        const SizedBox(height: 40),
        _buildImage(isMobile),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: _buildContent(isMobile)),
        const SizedBox(width: 60),
        Expanded(flex: 1, child: _buildImage(isMobile)),
      ],
    );
  }

  Widget _buildContent(bool isMobile) {
    final double  titleSize = isMobile ? 23 : 45;
    final double descSize = isMobile ? 9.2 : 18;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: AppStyles.header(titleSize),
            children: [
              const TextSpan(text: 'Kenali kami lebih dekat unduh\n'),
              TextSpan(text: 'Company ', style: AppStyles.header(titleSize, color: AppColors.primaryGreen)),
              TextSpan(text: 'Profile ', style: AppStyles.header(titleSize, color: AppColors.primaryOrange)),
              const TextSpan(text: 'sekarang!'),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 16 : 20),
        Text(descriptionText, style: AppStyles.subtitle(descSize)),
        SizedBox(height: isMobile ? 24 : 32),
        _buildDownloadButton(isMobile),
      ],
    );
  }

  Widget _buildDownloadButton(bool isMobile) {
    final double fontSize = isMobile ? 10 : 20;
    final double iconSize = isMobile ? 8 : 16;
    final double circleSize = isMobile ? 20 : 40;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGreen, width: 1.5),
        borderRadius: BorderRadius.circular(32),
        color: Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('Download Company Profile');
          },
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 15,
              vertical: isMobile ? 5 : 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Unduh Sekarang', style: AppStyles.downloadText(fontSize)),
                const SizedBox(width: 12),
                Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryGreen,
                  ),
                  child: Icon(Icons.north_east, size: iconSize, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(bool isMobile) {
    final double w = isMobile ? 300 : 378;
    final double h = isMobile ? 300 : 378;

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
            profileImagePath,
            width: w,
            height: h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// =================== DATA (SAMBUNGKAN DENGAN API) ===================

// TODO: Replace these hardcoded values with data from an API response
const String profileImagePath = 'assets/images/value.png';

const String descriptionText = 'Temukan siapa kami, apa yang kami tawarkan, dan mengapa kami pilihan terbaik semua dalam satu file praktis.';