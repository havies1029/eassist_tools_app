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
              horizontal: isMobile ? 20.0 : 40.0,
              vertical: isMobile ? 30.0 : 50.0,
            ),
            child: isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- JUDUL (persis sama dgn contoh pertama)
                const Text(
                  'Klien Kami, Prioritas Kami:',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Memberikan Solusi Terbaik untuk Anda!',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'JPS',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: ' adalah platform asuransi pintar yang memudahkan kamu mencari, memilih, dan klaim asuransi hanya dalam hitungan menit ',
                      ),
                      TextSpan(
                        text: 'cepat',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: ', '),
                      TextSpan(
                        text: 'aman',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: ', dan '),
                      TextSpan(
                        text: 'terdaftar OJK',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                // --- GAMBAR
                _buildHeroImage(),
                const SizedBox(height: 30.0),
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
                      offset: const Offset(0, -20),
                      child: _buildHeroText(TextAlign.left),
                    ),
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const SizedBox(
                      width: 300,
                      height: 250,
                    ),
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
      ),
    );
  }

  // --- DESKTOP MODE SAJA
  Widget _buildHeroText(TextAlign align) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Column(
        crossAxisAlignment: align == TextAlign.left
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(
            'Selamat Datang, [Nama User]',
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
            'Berikut ringkasan polis Anda Hari ini:',
            textAlign: align,
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 40,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: align,
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: 'JPS',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text:
                  ' adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\ndan klaim asuransi hanya dalam hitungan menit ',
                ),
                TextSpan(
                  text: 'cepat',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ', '),
                TextSpan(
                  text: 'aman',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ', dan '),
                TextSpan(
                  text: 'terdaftar OJK',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Image.asset(
      'assets/images/human.png',
      fit: BoxFit.contain,
    );
  }
}
