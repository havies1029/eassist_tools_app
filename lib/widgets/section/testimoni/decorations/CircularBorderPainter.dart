
import 'dart:math';

import 'package:flutter/cupertino.dart';

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