import 'package:flutter/material.dart';

class AboutJps extends StatelessWidget {
  final BoxConstraints constraints;

  const AboutJps({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 35.0 : (isTablet ? 40.0 : 80.0),
        vertical: isMobile ? 40.0 : 60.0,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Text(
                sectionTitle,
                style: titleStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16.0),

              // Paragraf pertama
              Text(
                paragraph1,
                style: paragraphStyle1,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12.0),

              // Paragraf kedua
              Text(
                paragraph2,
                style: paragraphStyle2,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== TextStyle Helpers =====
  TextStyle get titleStyle => TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: isMobile ? 25.0 : 40.0,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF79AB43),
    height: 1.3,
  );

  TextStyle get paragraphStyle1 => TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: isMobile ? 15.0 : 25.0,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF2D3748),
    height: 1.6,
  );

  TextStyle get paragraphStyle2 => paragraphStyle1.copyWith(
    fontSize: isMobile ? 14.0 : 25.0,
  );

  // ===== Layout & Responsive Helpers =====
  bool get isMobile => constraints.maxWidth < 768;

  bool get isTablet =>
      constraints.maxWidth >= 768 && constraints.maxWidth < 1024;

  double get maxWidth =>
      constraints.maxWidth > 1300 ? 1200 : constraints.maxWidth * 0.9;
}

// ============================
// === API or dynamic data section ===
// ============================

// Sementara hardcoded, nanti bisa diganti fetch dari API
const String sectionTitle = 'Kenali JPS Lebih Dekat';

const String paragraph1 =
    'JPS hadir sebagai solusi terpercaya untuk memudahkan Anda dalam memahami dan mengakses layanan asuransi. '
    'Kami menyediakan informasi yang jelas, proses klaim yang cepat dan praktis, serta perlindungan yang sesuai kebutuhan Anda.';

const String paragraph2 =
    'Dengan pendekatan yang ramah, responsif, dan efisien, JPS menjadikan asuransi lebih mudah diakses, lebih dekat dengan masyarakat, '
    'dan lebih relevan untuk semua kalangan. Bersama JPS, perlindungan Anda berada di tangan yang tepat.';