import 'package:flutter/material.dart';
import '../../pages/heropage/hero_main.dart';

class ActionSection extends StatelessWidget {
  final BoxConstraints constraints;

  const ActionSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 1024;

  double get maxWidth => constraints.maxWidth > 1200 ? 1100 : constraints.maxWidth * 0.88;
  double get contentPadding => isMobile ? 16.0 : 35.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 30.0 : 36.0,
          ),
          child: isMobile
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: contentPadding),
            child: Column(
              children: [
                _buildActionTitle(),
                const SizedBox(height: 20.0),
                _buildActionImage(),
                const SizedBox(height: 20.0),
                _buildActionCTAs(),
              ],
            ),
          )
              : Wrap(
            spacing: 24.0,
            runSpacing: 30.0,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Text dan CTA
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? maxWidth : maxWidth * 0.5,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: contentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildActionTitle(),
                      const SizedBox(height: 30.0),
                      _buildActionCTAs(),
                    ],
                  ),
                ),
              ),

              // Image responsif
              Padding(
                padding: EdgeInsets.only(right: contentPadding),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? maxWidth : 450,
                  ),
                  child: _buildActionImage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTitle() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'Satoshi-Regular',
          fontSize: 40.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: 'Apa yang ingin Anda\n'),
          TextSpan(
            text: 'Lakukan',
            style: TextStyle(
              color: Color(0xFF79AB43),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: ' hari ini?'),
        ],
      ),
    );
  }

  Widget _buildActionImage() {
    return Image.asset(
      'assets/images/home_2.png',
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }

  Widget _buildActionCTAs() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        HoverActionButton(
          onPressed: () {},
          text: 'Cari Asuransi',
          icon: Icons.search,
          isRounded: true,
          textStyle: const TextStyle(
            fontSize: 27.0,
            fontFamily: 'Satoshi-Regular',
            fontWeight: FontWeight.w500,
          ),
        ),
        HoverActionButton(
          onPressed: () {},
          text: 'Lapor Klaim',
          icon: Icons.report_problem,
          isOutlined: true,
          isRounded: true,
          textStyle: const TextStyle(
            fontSize: 27.0,
            fontFamily: 'Satoshi-Regular',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
