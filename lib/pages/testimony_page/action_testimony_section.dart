import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;
  final int? maxItems; // Maksimum global (opsional)
  final int? maxItemsPerPage; // Maksimum per halaman/tampilan (opsional)

  const ActionSection({
    super.key,
    required this.constraints,
    this.maxItems,
    this.maxItemsPerPage,
  });

  @override
  State<ActionSection> createState() => ActionSectionState();
}

class ActionSectionState extends State<ActionSection> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int currentItemCount = 0;

  @override
  void initState() {
    super.initState();
    context.read<GallerytestimonyCariBloc>().add(RefreshGallerytestimonyCariEvent());

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    currentItemCount = 8;
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _loadMore(int max) {
    setState(() {
      final defaultPerPage = widget.constraints.maxWidth < 768 ? 4 : 6;
      final step = widget.maxItemsPerPage ?? defaultPerPage;
      currentItemCount = (currentItemCount + step).clamp(0, max);
      _fadeController.forward(from: 0); // ulangi animasi
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.constraints.maxWidth < 768;
    final double maxWidth = widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.constraints.maxWidth > 1200 ? 64.0 : 32.0,
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
                  BlocBuilder<GallerytestimonyCariBloc, GallerytestimonyCariState>(
                    builder: (context, state) {
                      if (state.status == ListStatus.initial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == ListStatus.failure) {
                        return const Center(child: Text('Failed to load images'));
                      } else if (state.items.isEmpty) {
                        return const Center(child: Text('No images available'));
                      }

                      final allItems = state.items.map((e) => e.toMap()).toList();
                      final maxDisplay = widget.maxItems != null
                          ? allItems.take(widget.maxItems!).toList()
                          : allItems;

                      if (currentItemCount == 0) {
                        final defaultPerPage = widget.constraints.maxWidth < 768 ? 4 : 6;
                        currentItemCount = widget.maxItemsPerPage ?? defaultPerPage;
                      }

                      final displayedItems = maxDisplay.take(currentItemCount).toList();
                      final hasMore = currentItemCount < maxDisplay.length;

                      _fadeController.forward(from: 0);

                      return Column(
                        children: [
                          AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimation.value,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: isMobile ? 16.0 : 32.0,
                                  runSpacing: 40.0,
                                  children: displayedItems
                                      .map((t) => _buildTestimonialItem(t, widget.constraints))
                                      .toList(),
                                ),
                              );
                            },
                          ),
                          if (hasMore) ...[
                            const SizedBox(height: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF79AB43),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              onPressed: () => _loadMore(maxDisplay.length),
                              child: const Text(
                                'Lihat Lebih Banyak',
                                style: TextStyle(
                                  fontFamily: 'Satoshi-Regular',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialItem(Map<String, String> testimonial, BoxConstraints constraints) {
    final double itemWidth = constraints.maxWidth < 768
        ? (constraints.maxWidth / 2) - 48
        : constraints.maxWidth > 1200
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
                  child: Image.network(
                    testimonial['image'] ?? '',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            testimonial['name'] ?? '',
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
            testimonial['quote'] ?? '',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
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
