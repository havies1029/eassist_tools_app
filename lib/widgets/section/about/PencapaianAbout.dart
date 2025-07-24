import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PencapaianSection extends StatelessWidget {
  final BoxConstraints constraints;

  const PencapaianSection({super.key, required this.constraints});

  // Color Constants
  static const Color _primaryGreen = Color(0xFF91C050);
  static const Color _primaryOrange = Color(0xFFFAA232);

  // Responsive helper
  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
  bool get isDesktop => constraints.maxWidth >= 1024;

  // Font size helpers
  double get _headerFontSize =>
      isMobile ? 20 : isTablet ? 24 : 27;

  double get _subtitleFontSize =>
      isMobile ? 15 : isTablet ? 16 : 17;

  // Padding & Spacing
  double get _horizontalPadding =>
      isMobile ? 16 : isTablet ? 32 : 40;

  double get _verticalPadding =>
      isMobile ? 20 : isTablet ? 30 : 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile? 0: _horizontalPadding,
              vertical: _verticalPadding,
            ),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: isMobile ? 0 : 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile? _horizontalPadding : 0),
                  child: Text(
                    'Terpercaya sebagai broker asuransi unggulan dengan pertumbuhan dan kemitraan nasional yang konsisten.',
                    style: TextStyle(
                      fontSize: _subtitleFontSize,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: isMobile ? 10 : isTablet ? 10 : 20),
                _buildVerticalMilestone(), // tetap seperti sebelumnya
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    double iconSize = isMobile ? 40 : isTablet ? 45 : 50;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile? _horizontalPadding : 0),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/trophy.svg',
            width: iconSize,
            height: iconSize,
          ),
          SizedBox(height: isMobile ? 8 : 15),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: _headerFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Satoshi-Regular',
              ),
              children: [
                const TextSpan(text: 'Pencapaian '),
                TextSpan(
                  text: 'J',
                  style: TextStyle(
                    color: _primaryGreen,
                    fontSize: _headerFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'P',
                  style: TextStyle(
                    color: _primaryOrange,
                    fontSize: _headerFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'S',
                  style: TextStyle(
                    color: _primaryGreen,
                    fontSize: _headerFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalMilestone() {
    final bool isMobile = constraints.maxWidth < 768;
    final String svgPath = isMobile
        ? 'assets/icons/Milestone_mobile.svg'
        : 'assets/icons/Milestone.svg';

    final double svgWidth = isMobile ? 440.86 : 987;
    final double svgHeight = isMobile ? 439.43 : 549.35;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : _horizontalPadding),
      child: SvgPicture.asset(
        svgPath,
        width: svgWidth,
        height: svgHeight,
      ),
    );
  }
}