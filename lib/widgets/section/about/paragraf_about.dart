import 'package:flutter/material.dart';

class JPSInsuranceSection extends StatelessWidget {
  final BoxConstraints constraints;

  const JPSInsuranceSection({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1300 ? 1200 : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      color: Colors.white,
      child: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 24.0,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              // Header
              Text(
                'Kenapa Beli Asuransi di JPS?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Satoshi-Regular',
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/jps_logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Main Description
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    fontFamily: 'Satoshi-Regular',
                    color: Colors.black87,
                  ),
                  children: const [
                    TextSpan(
                      text: 'JPS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text:
                      ' adalah platform asuransi pintar yang memudahkan kamu menemukan pilihan asuransi terbaik sesuai kebutuhan. Kami bekerja sama dengan berbagai penyedia asuransi resmi yang terdaftar di ',
                    ),
                    TextSpan(
                      text: 'OJK',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      ', sehingga kamu bisa merasa aman dan percaya diri dalam setiap keputusan.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Benefits Description
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    fontFamily: 'Satoshi-Regular',
                    color: Colors.black87,
                  ),
                  children: const [
                    TextSpan(text: 'Dengan '),
                    TextSpan(
                      text: 'JPS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text:
                      ', kamu bisa membandingkan paket, mengakses konsultasi gratis, hingga mendapatkan diskon maksimal semua dalam satu platform yang cepat, praktis, dan ramah pengguna. Tidak perlu ribet, cukup beberapa klik untuk mendapatkan perlindungan yang tepat bagi kamu dan orang terdekat.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Testimonial Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Telah di Tinjau ✓',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Satoshi-Regular',
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Ryan Basudara',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Satoshi-Regular',
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Ahli Asuransi',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Satoshi-Regular',
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade200,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
