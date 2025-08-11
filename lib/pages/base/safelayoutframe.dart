import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SafeLayoutFrame extends StatelessWidget {
  final Widget child;

  const SafeLayoutFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Atas — navbar kosong (misalnya untuk logo, setting, dsb)
        Container(
          height: 72,
          width: double.infinity,
          color: Colors.red, // ganti dengan warna jika ingin lihat jelas
        ),

        // Tengah — isi halaman
        Expanded(child: child),

        // Bawah — bottom bar kosong
        Container(
          height: 64,
          width: double.infinity,
          color: Colors.red, // ganti warna jika perlu
        ),
      ],
    );
  }
}
