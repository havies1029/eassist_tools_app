import 'package:flutter/material.dart';
import 'claim_stepper.dart'; // pastikan sesuai path

const _primaryColor = Color(0xFF79AB43);
const _textColor = Colors.black87;
const _fontFamily = 'Satoshi-Regular';

class ActionSection extends StatelessWidget {
  final BoxConstraints constraints;
  const ActionSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 1024;

  double get maxWidth {
    final raw = constraints.maxWidth * 0.9;
    return raw > 1200 ? 1200 : raw;
  }

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(
    horizontal: isMobile ? 35.0 : (isTablet ? 48.0 : 80.0),
  );

  EdgeInsets get verticalPadding {
    if (isMobile) {
      return const EdgeInsets.only(top: 55.0, bottom: 10.0);
    } else if (isTablet) {
      return const EdgeInsets.symmetric(vertical: 72.0);
    } else {
      return const EdgeInsets.symmetric(vertical: 100.0);
    }
  }

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
      padding: verticalPadding.add(horizontalPadding),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER UTAMA
              Text.rich(
                TextSpan(
                  text: 'Petunjuk Pengajuan ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: _fontFamily,
                    color: _textColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Klaim',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.badge, color: _primaryColor, size: 30),
                  const SizedBox(width: 8),
                  Text(
                    'Pengguna non JPS',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: _fontFamily,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// ✅ Revisi Bagian STEP FORM
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: const ClaimStepper(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
