import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => constraints.maxWidth > 1200 ? 64.0 : 32.0;

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 40.0,
              vertical: isMobile ? 20.0 : 50.0,
            ),
            child: isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeroText(TextAlign.center),
                const SizedBox(height: 20.0),
                _buildHeroImage(),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Transform.translate(
                      offset: const Offset(0, -20), // ✅ Teks naik 20px
                      child: _buildHeroText(TextAlign.left),
                    ),
                  ),
                ),

                // Area gambar dengan Stack agar bisa membesar bebas
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 250,
                    ),
                    Positioned(
                      right: -40, // boleh diatur lebih jika mau keluar lebih jauh
                      bottom: 0,
                      child: SizedBox(
                        width: 360, // 🔥 gambar lebih besar dari box normal
                        child: _buildHeroImage(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText(TextAlign align) {
    return Column(
      crossAxisAlignment: align == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          'Klien Kami, Prioritas Kami:',
          textAlign: align,
          style: const TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Memberikan Solusi Terbaik untuk Anda!',
          textAlign: align,
          style: const TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 40,
            fontWeight: FontWeight.w200,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\n'
              'dan klaim asuransi hanya dalam hitungan menit cepat, aman, dan terdaftar OJK.',
          textAlign: align,
          style: const TextStyle(
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
    return Image.asset(
      'assets/images/human.png',
      fit: BoxFit.contain,
    );
  }
}
