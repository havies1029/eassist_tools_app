import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;

  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

  double get sidePadding {
    if (isMobile) return 0;
    return constraints.maxWidth > 1200 ? 64.0 : 32.0;
  }

  @override
  Widget build(BuildContext context) {
    // Branch untuk tampilan mobile
    if (isMobile) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 0),
        decoration: const BoxDecoration(
          color: Color(0xFF79AB43),
          borderRadius: BorderRadius.zero,
        ),
        // Hapus padding bawah dengan hanya menggunakan top dan horizontal
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          // Ubah agar semua isi kolom di kiri
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Panggil dengan TextAlign.left untuk meratakan teks ke kiri
            _buildHeroText(TextAlign.left),
            const SizedBox(height: 20.0),
            _buildHeroImage(),  // Sekarang otomatis 182x197 di mobile
          ],
        ),
      );
    }

    // Branch untuk tampilan non-mobile (tetap pakai padding vertikal penuh)
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Center(
        child: Container(
          width: maxWidth,
          margin: const EdgeInsets.only(top: 50),
          decoration: const BoxDecoration(
            color: Color(0xFF79AB43),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          // Non-mobile masih pakai padding atas & bawah 50
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Transform.translate(
                    offset: const Offset(0, -20),
                    child: _buildHeroText(TextAlign.left),
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(width: 300, height: 250),
                  Positioned(
                    right: -40,
                    bottom: 0,
                    child: SizedBox(
                      width: 360,
                      child: _buildHeroImage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText(TextAlign align) {
    // Tentukan ukuran font berdasarkan isMobile
    final double headingSize = isMobile ? 24 : 40;

    return Column(
      crossAxisAlignment: align == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          'Klien Kami, Prioritas Kami:',
          textAlign: align,
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: headingSize,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          isMobile
              ? 'Memberikan Solusi Terbaik!'
              : 'Memberikan Solusi Terbaik untuk Anda!',
          textAlign: align,
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: headingSize,
            fontWeight: FontWeight.w200,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isMobile
          // Versi mobile: ringkas jadi satu kalimat pendek
              ? 'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih'
              'dan klaim asuransi hanya dalam hitungan menit cepat, aman, dan terdaftar OJK.,'
          // Versi non-mobile: tetap pakai \n seperti semula
              : 'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\n'
              'dan klaim asuransi hanya dalam hitungan menit cepat, aman, dan terdaftar OJK.',
          textAlign: align,
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            height: 1.6,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    if (isMobile) {
      return Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          'assets/images/human.png',
          width: 242,
          height: 257,
          fit: BoxFit.contain,
        ),
      );
    }

    return Image.asset(
      'assets/images/human.png',
      fit: BoxFit.contain,
    );
  }

}
