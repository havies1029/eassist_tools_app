import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'Satoshi-Regular';
  static const Color white = Colors.white;

  static double titleSize(bool isMobile) => isMobile ? 25 : 45;
  static double bodySize(bool isMobile) => isMobile ? 15 : 18;
  static double smallSize(bool isMobile) => isMobile ? 14 : 16;

  static EdgeInsets responsivePadding(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double horizontal = width > 1200
        ? 95
        : width > 992
        ? 64
        : width > 768
        ? 48
        : 24;
    final double vertical = width < 768 ? 24 : 40;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets responsiveMargin(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double top = width < 768 ? 30 : 60;
    return EdgeInsets.only(top: top);
  }
}

class CustomerServiceSection extends StatelessWidget {
  final BoxConstraints constraints;

  const CustomerServiceSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.95;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.responsivePadding(constraints),
      child: Container(
        width: maxWidth,
        margin: AppTheme.responsiveMargin(constraints),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainTitle(),
            const SizedBox(height: 20),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainTitle() {
    final data = _getHeaderData();

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: data['title_bold'],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: AppTheme.titleSize(isMobile),
              fontWeight: FontWeight.w700,
              color: AppTheme.white,
              height: 1.2,
            ),
          ),
          TextSpan(
            text: data['title_normal'],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: AppTheme.titleSize(isMobile),
              fontWeight: FontWeight.w400,
              color: AppTheme.white,
              height: 1.2,
            ),
          ),
        ],
      ),
      maxLines: 2,
    );
  }

  Widget _buildDescription() {
    final data = _getDescriptionData();

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: data['text_normal'],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: AppTheme.bodySize(isMobile),
              color: AppTheme.white.withOpacity(0.9),
              height: 1.6,
            ),
          ),
          TextSpan(
            text: data['text_bold'],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: AppTheme.smallSize(isMobile),
              fontWeight: FontWeight.w600,
              color: AppTheme.white,
              height: 1.6,
            ),
          ),
          TextSpan(
            text: data['text_normal_end'],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: AppTheme.smallSize(isMobile),
              color: AppTheme.white.withOpacity(0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  // ======================
  // DATA PLACEHOLDER (API)
  // ======================

  Map<String, String> _getHeaderData() {
    // TODO: Replace with API call
    return {
      'title_bold': 'Ada Pertanyaan? ',
      'title_normal': 'Kontak Kami Sekarang!',
    };
  }

  Map<String, String> _getDescriptionData() {
    // TODO: Replace with API call
    return {
      'text_normal': 'Jangan ragu untuk ',
      'text_bold': 'menghubungi kami',
      'text_normal_end': ' melalui form di bawah ini atau lewat kontak yang tersedia.',
    };
  }
}