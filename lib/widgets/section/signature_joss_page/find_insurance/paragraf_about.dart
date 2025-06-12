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
            horizontal: isMobile ? 16.0 : 0,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              // Header
              Text.rich(
                TextSpan(
                  text: 'Kenapa Beli Asuransi di ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Satoshi-Regular',
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: 'JPS',
                      style: TextStyle(
                        color: Color(0xFF79AB43), // Warna hijau brand
                        fontWeight: FontWeight.w700, // Bisa dibuat lebih tebal
                      ),
                    ),
                    TextSpan(text: '?'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Logo
              Container(
                width: 168,
                height: 168,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 14,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/jps-image.png',
                    width: 128,
                    height: 128,
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
                    fontSize: 24,
                    height: 1.6,
                    fontFamily: 'Satoshi-Regular',
                    color: Colors.black87,
                  ),
                  children: const [
                    TextSpan(
                      text: 'JPS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF79AB43),
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
                    fontSize: 24,
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
                        color: const Color(0xFF79AB43),
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
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0x80ABE86A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 1. Ikon Checklist
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF79AB43),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // 2. Teks Status
                        Text(
                          'Telah di Tinjau :',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Satoshi-Regular',
                            color: const Color(0xFF79AB43),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(width: 16),

                        // 3. Profil Peninjau
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Foto profil
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300,
                                image: const DecorationImage(
                                  image: NetworkImage('https://via.placeholder.com/40x40/CCCCCC/666666?text=RB'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Nama dan Jabatan
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Ryan Basudara',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Satoshi-Regular',
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF79AB43),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Ahli Asuransi',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Satoshi-Regular',
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFF79AB43),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
