import 'package:flutter/material.dart';

class AboutJps extends StatelessWidget {
  final BoxConstraints constraints;
  // ==== Style Helper ====
  TextStyle get titleStyle => TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: isMobile ? 25 : 35,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  TextStyle get paragraphStyle => TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: isMobile ? 15 : 20,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF2D3748),
    height: 1.6,
  );

  // ==== Layout Helper ====
  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
  double get maxWidth => constraints.maxWidth > 1300 ? 1200 : constraints.maxWidth * 0.9;

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
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Kenali ',
                      style: titleStyle.copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'J',
                      style: titleStyle.copyWith(color: Color(0xFF79AB43)).copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'P',
                      style: titleStyle.copyWith(color: Color(0xFFFAA232)).copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'S',
                      style: titleStyle.copyWith(color: Color(0xFF79AB43)).copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' Lebih Dekat!',
                      style: titleStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Paragraf 1
              Text.rich(
                TextSpan(
                  style: paragraphStyle,
                  children: [
                    const TextSpan(text: ''),
                    const TextSpan(
                      text: 'JPS',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                        ' adalah broker asuransi berpengalaman yang mampu menciptakan keputusan strategis bagi para kliennya. Selain itu, '),
                    const TextSpan(
                      text: 'JPS',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                        ' juga berperan penting sebagai konsultan dan fasilitator dalam merancang kebutuhan asuransi secara khusus agar klien mendapatkan manfaat maksimal berupa perlindungan luas, harga terjangkau, dan kemudahan klaim.'),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),

              // Paragraf 2
              Text.rich(
                TextSpan(
                  style: paragraphStyle,
                  children: [
                    const TextSpan(
                      text: 'PT. Jaya Proteksindo Sakti',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                        ' didirikan pada 2 Januari 2001, berfokus pada penempatan asuransi umum seperti properti, manfaat karyawan, mesin, rekayasa (engineering), konstruksi, kendaraan bermotor, pengangkutan laut (marine cargo), penerbangan, kredit perdagangan, serta produk khusus lainnya.'),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),

              // Paragraf 3
              Text.rich(
                TextSpan(
                  style: paragraphStyle,
                  children: [
                    const TextSpan(text: 'Perusahaan telah memiliki izin usaha dari Otoritas Jasa Keuangan ('),
                    const TextSpan(
                      text: 'OJK',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                        ') berdasarkan keputusan '),
                    const TextSpan(
                      text: 'MenteriKeuangan No. 431/KM.17/2000.',
                      style: TextStyle(fontWeight: FontWeight.bold),
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