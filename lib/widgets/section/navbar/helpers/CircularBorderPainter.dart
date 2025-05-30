
// Custom painter for curved border
import 'dart:math';

import 'package:flutter/cupertino.dart';

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
    final double endAngle = 2 * pi - (pi * gapPercentage / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      endAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
