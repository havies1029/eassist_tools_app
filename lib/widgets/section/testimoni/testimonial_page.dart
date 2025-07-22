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
                  const SizedBox(height: 30),
                  _buildHeader(isMobile),
                  const SizedBox(height: 15),
                  _buildRatingSection(isMobile),
                  const SizedBox(height: 30),
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
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF91C050),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Color(0xFF91C050),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              onPressed: () => _loadMore(maxDisplay.length),
                              child: const Text(
                                'Lihat Lebih Banyak',
                                style: TextStyle(
                                  fontFamily: 'Satoshi-Regular',
                                  fontSize: 15,
                                  color: Color(0xFF91C050),
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
        // Icon
        Container(
          child: SvgPicture.asset(
            'assets/icons/thumbsup.svg',
            width: isMobile ? 40 : 50,
            height: isMobile ? 40 : 50,
          ),
        ),

        SizedBox(height: 15),

        // Title
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 20.0 : 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: 'Kata Mereka Tentang '),
              const TextSpan(
                text: 'Kami',
                style: TextStyle(
                  color: Color(0xFF91C050),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),

        // Subtitle
        Container(
          width: 180,
          height: 43.74,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(42.06),
            border: Border.all(color: const Color(0xFF91C050)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dari layanan ',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: isMobile ? 12 : 15,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                'assets/images/JPS(2).png',
                width: isMobile? 54.67 : 65,
                height: isMobile ? 27.02 : 32,
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(bool isMobile) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bulat hijau dengan nilai 5,0
            SizedBox(
              width: isMobile ? 76.19 : 90.39,
              height: isMobile ? 76.19 : 90.39,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ✅ Outer border (gradient)
                  Container(
                    width: isMobile ? 76.19 : 90.39,
                    height: isMobile ? 76.19 : 90.39,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0xFFE4FFBE), Color(0xFF91C050)],
                        center: Alignment.center,
                        radius: 0.8,
                      ),
                    ),
                  ),

                  // ✅ Inner white border
                  Container(
                    width: isMobile ? 66.03 : 80,
                    height: isMobile ? 66.03 : 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),

                  // ✅ Innermost circle (greenish background)
                  Container(
                    width: isMobile ? 57 : 70,
                    height: isMobile ? 57 : 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE6F3D6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '5,0',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: isMobile ? 25.4 : 30.13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF91C050),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            // Bagian teks
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terpercaya',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isMobile ? 25 : 30.13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF91C050),
                  ),
                ),

                const SizedBox(height: 0),

                Row(
                  children: List.generate(5, (index) => Icon(
                    Icons.star,
                    color: Color(0xFFFFC728),
                    size: isMobile ? 17.94 : 21.28,
                  )),
                ),

                const SizedBox(height: 0),

                Text(
                  '50 dari 50 ulasan',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isMobile ? 12 : 15.42,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Ulasan Nasabah',
            style: TextStyle(
              fontSize: isMobile ? 15 : 18,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialGrid(List displayedItems, bool isMobile) {
    if (isMobile) {
      return Column(
        children: displayedItems.map<Widget>((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildTestimonialCard(item, true),
          );
        }).toList(),
      );
    }

    // Desktop: 3 kolom per baris
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
                    child: _buildTestimonialCard(row[i], false),
                  ),
                  if (i < row.length - 1) const SizedBox(width: 16),
                ],
                // Fill empty slots
                if (row.length < 3)
                  ...List.generate(3 - row.length, (_) => const Expanded(child: SizedBox())),
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