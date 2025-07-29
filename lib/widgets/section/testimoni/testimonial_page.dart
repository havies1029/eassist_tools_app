import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/models/gen_review/reviewcari_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/gen_review/reviewcari_bloc.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;
  final int? maxItems;
  final int? maxItemsPerPage;

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
    context.read<ReviewCariBloc>().add(RefreshReviewCariEvent());

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    currentItemCount = 9;
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _loadMore(int max) {
    setState(() {
      final step = 9;
      currentItemCount = (currentItemCount + step).clamp(0, max);
      _fadeController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.constraints.maxWidth < 768;
    final bool isTablet = widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;
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
              child: BlocBuilder<ReviewCariBloc, ReviewCariState>(
                builder: (context, state) {
                  if (state.status == ListStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == ListStatus.failure) {
                    return const Center(child: Text('Failed to load reviews'));
                  } else if (state.items.isEmpty) {
                    return const Center(child: Text('No reviews available'));
                  }

                  final allItems = state.items;
                  final maxDisplay = widget.maxItems != null
                      ? allItems.take(widget.maxItems!).toList()
                      : allItems;

                  if (currentItemCount == 0) {
                    currentItemCount = 9;
                  }

                  final displayedItems = maxDisplay.take(currentItemCount).toList();
                  final hasMore = currentItemCount < maxDisplay.length;

                  _fadeController.forward(from: 0);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      _buildHeader(isMobile),
                      SizedBox(height: isMobile ? 10.0 : 15.0),
                      _buildRatingSection(isMobile, allItems),
                      SizedBox(height: isMobile ? 5.0 : 10.0),
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: _buildTestimonialGrid(displayedItems, isMobile, isTablet),
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
                              side: const BorderSide(color: Color(0xFF91C050)),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating(double rating, {double size = 20.0}) {
    int fullStars = rating.floor();

    // Cek sisa desimal
    final decimal = rating - fullStars;

    bool hasHalfStar = decimal >= 0.25 && decimal < 0.75;
    bool roundUp = decimal >= 0.75;

    if (roundUp) fullStars += 1;

    int totalStars = fullStars + (hasHalfStar ? 1 : 0);
    int emptyStars = 5 - totalStars;

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          Icon(Icons.star, color: Color(0xFFFFC728), size: size),

        if (hasHalfStar)
          Icon(Icons.star_half, color: Color(0xFFFFC728), size: size),

        for (int i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: Color(0xFFFFC728), size: size),
      ],
    );
  }


  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        SvgPicture.asset('assets/icons/thumbsup.svg', width: isMobile ? 40 : 50, height: isMobile ? 40 : 50),
        const SizedBox(height: 15),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: isMobile ? 20.0 : 25.0, fontWeight: FontWeight.bold, color: Colors.black),
            children: const [
              TextSpan(text: 'Kata Mereka Tentang '),
              TextSpan(text: 'Kami', style: TextStyle(color: Color(0xFF91C050))),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
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
              Text('Dari layanan ', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: isMobile ? 12 : 15, color: Colors.black)),
              Image.asset('assets/images/JPS(2).png', width: isMobile ? 54.67 : 65, height: isMobile ? 27.02 : 32, fit: BoxFit.contain),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(bool isMobile, List<ReviewCariModel> items) {
    final totalUlasan = items.length;
    final rataRata = totalUlasan == 0
        ? 0.0
        : items.map((e) => e.nilai).reduce((a, b) => a + b) / totalUlasan;

    final nilaiTeks = rataRata.toStringAsFixed(1).replaceAll('.', ',');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: isMobile ? 76.19 : 90.39,
                  height: isMobile ? 76.19 : 90.39,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0xFFE4FFBE), Color(0xFF91C050)],
                      center: Alignment.center,
                      radius: 0.8,
                    ),
                  ),
                ),
                Container(
                  width: isMobile ? 66.03 : 80,
                  height: isMobile ? 66.03 : 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: isMobile ? 57 : 70,
                  height: isMobile ? 57 : 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE6F3D6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    nilaiTeks,
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
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terpercaya',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isMobile ? 25 : 30.13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF91C050),
                  ),
                ),
                _buildStarRating(rataRata, size: isMobile ? 17.94 : 21.28),
                Text(
                  '$totalUlasan dari $totalUlasan ulasan',
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
    );
  }

  Widget _buildTestimonialGrid(List<ReviewCariModel> items, bool isMobile, bool isTablet) {
    if (isMobile) {
      return Column(
        children: items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildTestimonialCard(item, true),
        )).toList(),
      );
    }

    final chunkSize = isTablet ? 2 : 3;
    List<List> rows = [];
    for (int i = 0; i < items.length; i += chunkSize) {
      rows.add(items.skip(i).take(chunkSize).toList());
    }

    return Column(
      children: rows.map((row) =>
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              children: [
                for (int i = 0; i < row.length; i++) ...[
                  Expanded(child: _buildTestimonialCard(row[i], false)),
                  if (i < row.length - 1) const SizedBox(width: 16),
                ],
                if (row.length < chunkSize)
                  ...List.generate(chunkSize - row.length, (_) => const Expanded(child: SizedBox())),
              ],
            ),
          )
      ).toList(),
    );
  }

  Widget _buildTestimonialCard(ReviewCariModel review, bool isMobile) {
    final isSmall = isMobile;
    final ratingStr = "${review.nilai.toStringAsFixed(1)}/${review.skala.toInt()}";

    return Container(
      height: isSmall ? 200.0 : 210.37,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6E9F2), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: isSmall ? 8.0 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: review.nilai.toStringAsFixed(1), style: const TextStyle(color: Color(0xFFFFC728))),
                        TextSpan(text: '/${review.skala.toInt()}', style: const TextStyle(color: Color(0xFFA6A6A6))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              _buildStarRating(review.nilai),
            ],
          ),

          SizedBox(height: isSmall ? 10.0 : 15.0),
          Text(
            review.reviewer,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isSmall ? 15.0 : 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 1),
          Row(
            children: [
              Expanded(
                child: Text(
                  review.instansi,
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isSmall ? 10.0 : 12.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/thumbsup_solid.svg', width: 14, height: 14),
                  const SizedBox(width: 4),
                  const Text("Testimonial", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ],
          ),
          SizedBox(height: isSmall ? 10.0 : 15.0),
          Expanded(
            child: Text(
              '"${review.komentar}"',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isSmall ? 15.0 : 16.0,
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
