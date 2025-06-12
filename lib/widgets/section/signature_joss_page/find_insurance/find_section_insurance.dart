import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => constraints.maxWidth > 1200 ? 134.0 : 32.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Align(
        alignment: Alignment.topLeft, // GANTI dari Center ke Align
        child: Container(
          width: maxWidth,
          margin: const EdgeInsets.only(top: 100),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 40.0,
              vertical: isMobile ? 20.0 : 30.0,
            ),
            child: isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeroText(TextAlign.center),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Transform.translate(
                    offset: const Offset(0, -20),
                    child: _buildHeroText(TextAlign.left),
                  ),
                ),
                // GAMBAR DIHAPUS TOTAL
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
        // 🔽 Baris utama dengan gaya campuran
        RichText(
          textAlign: align,
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 45,
              color: Colors.white,
            ),
            children: const [
              TextSpan(
                text: 'Jenis asuransi ',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: 'apa yang\nkamu butuhkan?',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 🔽 Baris deskripsi bawah
        RichText(
          textAlign: align,
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 15,
              height: 1.6,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            children: const [
              TextSpan(
                text: 'Pilih kategori asuransi',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: ' yang sesuai dengan kebutuhan Anda.',
              ),
            ],
          ),
        ),

        // ✅ Tambahkan jarak ke bawah
        const SizedBox(height: 20),
      ],
    );
  }
}
