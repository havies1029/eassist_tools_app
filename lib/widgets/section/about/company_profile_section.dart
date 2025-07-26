import 'package:flutter/material.dart';

// =================== STYLES & CONSTANTS ===================
class AppColors {
  static const Color primaryGreen = Color(0xFF91C050);
  static const Color primaryOrange = Color(0xFFFAA232);
  static const Color backgroundLightGreen = Color(0xFFE8F5D8);
  static const Color textColor = Colors.black;
  static const Color textMuted = Color(0xFF636363);
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

class CompanyProfileSection extends StatelessWidget {
  final BoxConstraints constraints;

  const CompanyProfileSection({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxWidth = constraints.maxWidth;
    final bool isMobile = maxWidth < 768;
    final bool isTablet = maxWidth >= 768 && maxWidth < 1024;
    final bool isDesktop = maxWidth >= 1024;

    final double horizontalPadding = isMobile
        ? 20
        : isTablet
        ? 60
        : 105;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 40,
      ),
      color: AppColors.backgroundWhite,
      child: (isMobile)
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContent(isMobile: true, isTablet: false),
          const SizedBox(height: 10),
          _buildImage(isMobile: true, isTablet: false),
        ],
      )
          : _buildDesktopLayout(isTablet: isTablet),
    );
  }

  Widget _buildDesktopLayout({required bool isTablet}) {
    // Batasi lebar maksimum konten untuk layar yang sangat lebar
    final double maxContentWidth = isTablet ? 900 : 1200;
    final double actualWidth = constraints.maxWidth - (isTablet ? 120 : 210); // Kurangi padding horizontal
    final double contentWidth = actualWidth > maxContentWidth ? maxContentWidth : actualWidth;

    // Hitung spacing antara konten dan gambar berdasarkan lebar yang tersedia
    final double spacing = (contentWidth * 0.08).clamp(30.0, 80.0); // 8% dari lebar konten, minimum 30px, maksimum 80px

    return Center(
      child: Container(
        width: contentWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: _buildContent(isMobile: false, isTablet: isTablet)
            ),
            SizedBox(width: spacing),
            Expanded(
                flex: 2,
                child: _buildImage(isMobile: false, isTablet: isTablet)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({required bool isMobile, required bool isTablet}) {
    final double titleSize = isMobile
        ? 22
        : isTablet
        ? 26
        : 29.41;

    final double descSize = isMobile
        ? 15
        : isTablet
        ? 15
        : 15.13;

    final double spacing1 = isMobile
        ? 15
        : isTablet
        ? 20
        : 27;

    final double spacing2 = isMobile
        ? 25
        : isTablet
        ? 30
        : 34;

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
        SizedBox(height: spacing1),
        Text(descriptionText, style: AppStyles.subtitle(descSize)),
        SizedBox(height: spacing2),
        _buildDownloadButton(isMobile: isMobile, isTablet: isTablet),
      ],
    );
  }

  Widget _buildDownloadButton({required bool isMobile, required bool isTablet}) {
    final double fontSize = isMobile
        ? 10.22
        : isTablet
        ? 13
        : 15.13;

    final double iconSize = isMobile
        ? 8.17
        : isTablet
        ? 11
        : 13.45;

    final double circleSize = isMobile
        ? 20.44
        : isTablet
        ? 28
        : 33.61;

    final double paddingH = isMobile
        ? 8
        : isTablet
        ? 10
        : 12;

    final double paddingV = isMobile
        ? 5
        : isTablet
        ? 6
        : 7;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGreen, width: 1),
        borderRadius: BorderRadius.circular(33.61),
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
              horizontal: paddingH,
              vertical: paddingV,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Unduh Sekarang', style: AppStyles.downloadText(fontSize)),
                const SizedBox(width: 13),
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

  Widget _buildImage({required bool isMobile, required bool isTablet}) {
    final double size = isMobile
        ? 300
        : isTablet
        ? 310
        : 318.86;

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundLightGreen,
        ),
        child: Center(
          child: Image.asset(
            profileImagePath,
            width: size,
            height: size,
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