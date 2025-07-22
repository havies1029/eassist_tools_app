import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../pages/testimony_page/testimony_main.dart';
import 'testimonial_page.dart';

class TestimonialSection extends StatefulWidget {
  final BoxConstraints constraints;

  const TestimonialSection({super.key, required this.constraints});

  @override
  State<TestimonialSection> createState() => TestimonialSectionState();
}

class TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<GallerytestimonyCariBloc>().add(RefreshGallerytestimonyCariEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.constraints.maxWidth < 768;
    final double maxWidth = widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.constraints.maxWidth > 1200 ? 105 : 20.0,
          vertical: 20,
        ),
        child: Center(
          child: Container(
            width: maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header dengan ikon dan judul
                _buildHeader(isMobile),
                SizedBox(height: isMobile ? 10.0 : 15.0),

                // Rating section
                _buildRatingSection(isMobile),
                SizedBox(height: isMobile ? 5.0 : 10.0),

                // Testimonial cards
                BlocBuilder<GallerytestimonyCariBloc, GallerytestimonyCariState>(
                    builder: (context, state) {
                      if (state.status == ListStatus.initial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == ListStatus.failure) {
                        return const Center(
                          child: Text('Failed to load testimonials'),
                        );
                      } else if (state.items.isEmpty) {
                        return const Center(
                          child: Text('No testimonials available'),
                        );
                      }

                      return _buildTestimonialCards(state.items, isMobile);
                    }
                ),

                SizedBox(height: isMobile ? 10.0 : 15.0),

                // Navigation dots
                _buildNavigationControls(isMobile),
              ],
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Text(
            'Ulasan Nasabah',
            style: TextStyle(
              fontSize: isMobile ? 15 : 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCards(List items, bool isMobile) {
    // Show 3 items per page on desktop, 1 on mobile
    final itemsPerPage = isMobile ? 1 : 3;
    final totalPages = (items.length / itemsPerPage).ceil();

    return Container(
      height: isMobile ? 204.37 : 210.37,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: totalPages,
        itemBuilder: (context, pageIndex) {
          final startIndex = pageIndex * itemsPerPage;
          final endIndex = (startIndex + itemsPerPage > items.length)
              ? items.length
              : startIndex + itemsPerPage;

          return Row(
            children: [
              for (int i = startIndex; i < endIndex; i++) ...[
                Expanded(
                  child: _buildTestimonialCard(items[i].toMap(), isMobile),
                ),
                if (i < endIndex - 1) const SizedBox(width: 16), // ⬅️ spasi antar card
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:20, horizontal: 25),
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
                          fontSize: 10,
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
                  size: 20.37,
                )),
              ),
            ],
          ),

          SizedBox(height: 15.0),

          // Name and subtitle
          Text(
            testimonial['name'] ?? 'Unknown',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 16.0,
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
                    fontSize: 12.0,
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
                      width: 16.66,
                      height: 16.66,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Testimonial',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height:  15.0),

          // Quote
          Expanded(
            child: Text(
              '"${testimonial['quote'] ?? 'No quote available'}"',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 15.0 : 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationControls(bool isMobile) {
    return BlocBuilder<GallerytestimonyCariBloc, GallerytestimonyCariState>(
      builder: (context, state) {
        if (state.items.isEmpty) return const SizedBox.shrink();

        final itemsPerPage = isMobile ? 1 : 3;
        final totalPages = (state.items.length / itemsPerPage).ceil();

        return Row(
          mainAxisAlignment: MainAxisAlignment.end, // ➜ rata kanan
          children: [
            // Left arrow
            IconButton(
              onPressed: _currentPage > 0
                  ? () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
                  : null,
              icon: const Icon(Icons.chevron_left),
              iconSize: isMobile ? 20.0 : 24.0,
            ),

            // Right arrow
            IconButton(
              onPressed: _currentPage < totalPages - 1
                  ? () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
                  : null,
              icon: const Icon(Icons.chevron_right),
              iconSize: isMobile ? 20.0 : 24.0,
            ),
          ],
        );
      },
    );
  }
}