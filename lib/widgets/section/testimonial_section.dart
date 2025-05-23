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
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Center(
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul
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
                      style: TextStyle(color: Color(0xFF79AB43)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),

              // Grid Testimoni
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

              // Tombol "Tampilkan semua" di kanan
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
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CustomPaint(
                  painter: CircularBorderPainter(
                    color: const Color(0xFF79AB43),
                    strokeWidth: 3.0,
                    gapPercentage: 0.25,
                  ),
                ),
              ),
              ClipOval(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    testimonial['image']!,
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
              fontSize: 16.0,
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
              fontSize: 14.0,
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
  final Color color;
  final double strokeWidth;
  final double gapPercentage;

  CircularBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gapPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double startAngle = -0.5 * pi + (pi * gapPercentage / 2);
    final double sweepAngle = 2 * pi - (pi * gapPercentage);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
