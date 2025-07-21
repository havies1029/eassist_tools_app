import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    currentItemCount = 9; // Default to show 9 items (3x3 grid)
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _loadMore(int max) {
    setState(() {
      final step = 9; // Always add 9 more items (3 rows)
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
                  // New Header Design
                  _buildHeader(isMobile),
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
                        currentItemCount = 9; // Default to 9 items
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
                                child: _buildTestimonialGrid(displayedItems, isMobile),
                              );
                            },
                          ),
                          if (hasMore) ...[
                            const SizedBox(height: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF91C050),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                          ],
                          const SizedBox(height: 50),
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

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        SizedBox(
          width: isMobile ? 50.0 : 125,
          height: isMobile ? 50.0 : 125,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer border (gradient)
              Container(
                width: isMobile ? 50.0 : 125,
                height: isMobile ? 50.0 : 125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [Color(0xFFE4FFBE), Color(0xFF91C050)],
                    center: Alignment.center,
                    radius: 0.8,
                  ),
                ),
              ),
              // Inner white border
              Container(
                width: isMobile ? 40.0 : 108.33,
                height: isMobile ? 40.0 : 108.33,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              // Innermost circle (greenish background)
              Container(
                width: isMobile ? 35.0 : 96,
                height: isMobile ? 35.0 : 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE6F3D6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '5,0',
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: isMobile ? 25.0 : 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF91C050),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: isMobile ? 10.0 : 16.0),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Teks di kiri
            Text(
              'Terpercaya',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 15.0 : 30.13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF91C050),
              ),
            ),

            const SizedBox(width: 9),

            // Ikon di kanan
            SvgPicture.asset(
              'assets/icons/thumbsup_solid.svg',
              width: isMobile ? 10.0 : 25,
              height: isMobile ? 10.0 : 25,
            ),
          ],
        ),

        SizedBox(height: 0),

        // Star rating
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => Icon(
            Icons.star,
            color: Color(0xFFFFC728),
            size: isMobile ? 15.0 : 21.28,
          )),
        ),

        SizedBox(height: 0),

        // "50 dari 50 ulasan" text
        Text(
          '50 dari 50 ulasan',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: isMobile ? 12.0 : 15.42,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Ulasan Nasabah',
            style: TextStyle(
              fontSize: isMobile ? 15 : 18,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialGrid(List displayedItems, bool isMobile) {
    // Split items into rows of 3
    List<List> rows = [];
    for (int i = 0; i < displayedItems.length; i += 3) {
      rows.add(displayedItems.skip(i).take(3).toList());
    }

    return Column(
      children: rows.map((row) =>
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              children: [
                for (int i = 0; i < row.length; i++) ...[
                  Expanded(
                    child: _buildTestimonialCard(row[i], isMobile),
                  ),
                  if (i < row.length - 1) const SizedBox(width: 16),
                ],
                // Fill remaining space if less than 3 cards in row
                if (row.length < 3)
                  ...List.generate(
                      3 - row.length,
                          (index) => const Expanded(child: SizedBox())
                  ),
              ],
            ),
          )
      ).toList(),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial, bool isMobile) {
    return Container(
      height: isMobile ? 200.0 : 210.37,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE6E9F2),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating section at top right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 19,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC728).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: isMobile ? 8.0 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '5,0',
                            style: const TextStyle(color: Color(0xFFFFC728)),
                          ),
                          TextSpan(
                            text: '/5',
                            style: const TextStyle(color: Color(0xFFA6A6A6)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Row(
                children: List.generate(5, (index) => Icon(
                  Icons.star,
                  color: const Color(0xFFFFD700),
                  size: isMobile ? 15.0 : 20.37,
                )),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 10.0 : 15.0),

          // Name and subtitle
          Text(
            testimonial['name'] ?? 'Unknown',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 15.0 : 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 1),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Klien JPS',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isMobile ? 10.0 : 12.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/thumbsup_solid.svg',
                      width: isMobile ? 10.0 : 16.66,
                      height: isMobile ? 10.0 : 16.66,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Testimonial',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: isMobile ? 10.0 : 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 10.0 : 15.0),

          // Quote
          Expanded(
            child: Text(
              '"${testimonial['quote'] ?? 'No quote available'}"',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 15.0 : 16.0,
                color: Colors.black,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}