import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.centerLeft,
      child: Container(
        width: maxWidth,
        margin: const EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 40.0,
          vertical: isMobile ? 20.0 : 50.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: _buildHeroText(
          isMobile ? TextAlign.center : TextAlign.left,
          paddingLeft: isMobile ? 0 : 130,
          paddingBottom: 40,
        ),
      ),
    );
  }

  Widget _buildHeroText(TextAlign align, {double paddingLeft = 0, double paddingBottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, bottom: paddingBottom),
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
}
