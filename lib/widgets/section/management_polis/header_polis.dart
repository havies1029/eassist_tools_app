import 'package:flutter/material.dart';

class HeaderPolis extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isAsset;

  const HeaderPolis({
    super.key,
    required this.constraints,
    this.isAsset = false, // default = false untuk halaman polis
  });

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 95
      : constraints.maxWidth > 992
      ? 64
      : isTablet
      ? 40
      : 24;

  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : isTablet
      ? constraints.maxWidth * 0.95
      : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    final title = isAsset ? 'MANAGEMENT ASET' : 'MANAGEMENT POLIS';
    final subtitle = isAsset
        ? (isMobile
        ? 'Kelola dan Perpanjang Aset Asuransi\n Anda Dengan Mudah'
        : 'Kelola dan Perpanjang Aset Asuransi Anda Dengan Mudah')
        : (isMobile
        ? 'Kelola dan Perpanjang Polis Asuransi\n Anda Dengan Mudah'
        : 'Kelola dan Perpanjang Polis Asuransi Anda Dengan Mudah');

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: isMobile ? 30 : 50,
        bottom: 10,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: isMobile ? 25 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: isMobile ? 15 : 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.3),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}