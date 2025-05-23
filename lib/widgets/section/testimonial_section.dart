import 'package:flutter/material.dart';
import 'dart:math' show pi;

class TestimonialSection extends StatelessWidget {
  final BoxConstraints constraints;

  const TestimonialSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;
    final double maxWidth = constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

    final List<Map<String, String>> testimonials = [
      {
        'name': 'Putri Ariana',
        'image': 'assets/images/t1.png',
        'quote': '"Proses klaim cepat dan tanpa ribet. Terima kasih JPS!"',
      },
      {
        'name': 'Brian Domani',
        'image': 'assets/images/t2.png',
        'quote': '"Sudah coba beberapa asuransi, tapi JPS paling responsif dan transparan."',
      },
      {
        'name': 'Monita Vonita',
        'image': 'assets/images/t3.png',
        'quote': '"JPS benar-benar peduli. Klaim saya diproses dengan cepat tanpa drama."',
      },
      {
        'name': 'Rian Pramaja',
        'image': 'assets/images/t4.png',
        'quote': '"Baru pertama kali klaim, prosesnya mudah dan agen sangat membantu banget!"',
      },
      {
        'name': 'Novia Wijaya',
        'image': 'assets/images/t5.png',
        'quote': '"Pelayanan ramah dan sangat membantu saat pengajuan klaim. JPS terbaik!"',
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth > 1200 ? 64.0 : 32.0,
        ),
        child: Center(
          child: Container(
            width: maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: 'Testimoni Nasabah '),
                      TextSpan(
                        text: 'JPS',
                        style: TextStyle(
                          color: Color(0xFF79AB43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 32.0,
                  runSpacing: 40.0,
                  children: testimonials
                      .take(5)
                      .map((t) => _buildTestimonialItem(t, constraints))
                      .toList(),
                ),
                const SizedBox(height: 40.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Tampilkan semua',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 16.0,
                        color: Color(0xFF79AB43),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialItem(Map<String, String> testimonial, BoxConstraints constraints) {
    final double itemWidth = constraints.maxWidth > 1200
        ? 200
        : constraints.maxWidth > 1024
        ? 170
        : 150;

    return SizedBox(
      width: itemWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CustomPaint(
                  painter: CircularBorderPainter(
                    strokeWidthBase: 1.5,
                    strokeWidthAccent: 6.0,
                    baseColor: const Color(0xFFB9E2A1),
                    accentColor: const Color(0xFF79AB43),
                    accentLengthAngle: pi * 0.8,
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                child: ClipOval(
                  child: Image.asset(
                    testimonial['image']!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            testimonial['name']!,
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            testimonial['quote']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 16.0,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularBorderPainter extends CustomPainter {
  final double strokeWidthBase;
  final double strokeWidthAccent;
  final Color baseColor;
  final Color accentColor;
  final double accentLengthAngle;

  CircularBorderPainter({
    required this.strokeWidthBase,
    required this.strokeWidthAccent,
    required this.baseColor,
    required this.accentColor,
    required this.accentLengthAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    // Lingkaran dasar (hijau muda)
    final Paint basePaint = Paint()
      ..color = baseColor
      ..strokeWidth = strokeWidthBase
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - strokeWidthBase / 2, basePaint);

    // Arc bawah (hijau tebal)
    final Paint accentPaint = Paint()
      ..color = accentColor
      ..strokeWidth = strokeWidthAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // ⬇️ START dari 90° - separuh panjang arc
    final double startAngle = pi / 2 - (accentLengthAngle / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidthAccent / 2),
      startAngle,
      accentLengthAngle,
      false,
      accentPaint,
    );
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
