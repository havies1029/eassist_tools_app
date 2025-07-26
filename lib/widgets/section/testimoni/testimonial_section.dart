import 'package:eassist_tools_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/gen_review/reviewcari_bloc.dart';
import '../../../models/gen_review/reviewcari_model.dart';

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
    context.read<ReviewCariBloc>().add(RefreshReviewCariEvent());
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
      padding: EdgeInsets.symmetric(
        horizontal: widget.constraints.maxWidth > 1200 ? 105 : 20.0,
        vertical: 40,
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(isMobile),
              SizedBox(height: isMobile ? 10.0 : 15.0),
              _buildRatingSection(isMobile),
              SizedBox(height: isMobile ? 5.0 : 10.0),
              BlocBuilder<ReviewCariBloc, ReviewCariState>(
                builder: (context, state) {
                  if (state.status == ListStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == ListStatus.failure) {
                    return const Center(child: Text('Failed to load testimonials'));
                  } else if (state.items.isEmpty) {
                    return const Center(child: Text('No testimonials available'));
                  }
                  return _buildTestimonialCards(state.items, isMobile);
                },
              ),
              SizedBox(height: isMobile ? 10.0 : 15.0),
              _buildNavigationControls(isMobile),
            ],
          ),
        ),
      ),
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

  Widget _buildRatingSection(bool isMobile) {
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
                    gradient: RadialGradient(colors: [Color(0xFFE4FFBE), Color(0xFF91C050)], center: Alignment.center, radius: 0.8),
                  ),
                ),
                Container(
                  width: isMobile ? 66.03 : 80,
                  height: isMobile ? 66.03 : 80,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                ),
                Container(
                  width: isMobile ? 57 : 70,
                  height: isMobile ? 57 : 70,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE6F3D6)),
                  alignment: Alignment.center,
                  child: Text('5,0', style: TextStyle(fontFamily: 'Satoshi', fontSize: isMobile ? 25.4 : 30.13, fontWeight: FontWeight.bold, color: Color(0xFF91C050))),
                ),
              ],
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Terpercaya', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: isMobile ? 25 : 30.13, fontWeight: FontWeight.bold, color: Color(0xFF91C050))),
                Row(
                  children: List.generate(5, (index) => Icon(Icons.star, color: Color(0xFFFFC728), size: isMobile ? 17.94 : 21.28)),
                ),
                Text('50 dari 50 ulasan', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: isMobile ? 12 : 15.42, color: Colors.black54)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Ulasan Nasabah', style: TextStyle(fontSize: isMobile ? 15 : 18, color: Colors.black54)),
      ],
    );
  }

  Widget _buildTestimonialCards(List<ReviewCariModel> items, bool isMobile) {
    final itemsPerPage = isMobile ? 1 : 3;
    final totalPages = (items.length / itemsPerPage).ceil();

    return SizedBox(
      height: isMobile ? 204.37 : 210.37,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) => setState(() => _currentPage = page),
        itemCount: totalPages,
        itemBuilder: (context, pageIndex) {
          final startIndex = pageIndex * itemsPerPage;
          final endIndex = (startIndex + itemsPerPage > items.length) ? items.length : startIndex + itemsPerPage;

          return Row(
            children: [
              for (int i = startIndex; i < endIndex; i++) ...[
                Expanded(child: _buildTestimonialCard(items[i], isMobile)),
                if (i < endIndex - 1) const SizedBox(width: 16),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildTestimonialCard(ReviewCariModel item, bool isMobile) {
    return Container(
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
                decoration: BoxDecoration(color: const Color(0xFFFFC728).withOpacity(0.2), borderRadius: BorderRadius.circular(50)),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'Satoshi', fontSize: 10, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: item.nilai.toStringAsFixed(1), style: const TextStyle(color: Color(0xFFFFC728))),
                      TextSpan(text: '/${item.skala.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFFA6A6A6))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Row(
                children: List.generate(item.nilai.round(), (index) => const Icon(Icons.star, color: Color(0xFFFFD700), size: 20.37)),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Text(item.reviewer, style: const TextStyle(fontFamily: 'Satoshi-Regular', fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 1),
          Row(
            children: [
              Expanded(child: Text(item.instansi, style: const TextStyle(fontFamily: 'Satoshi-Regular', fontSize: 12.0, color: Colors.black54))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/thumbsup_solid.svg', width: 16.66, height: 16.66),
                    const SizedBox(width: 4.0),
                    const Text('Testimonial', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: Text('"${item.komentar}"', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: isMobile ? 15.0 : 16.0, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationControls(bool isMobile) {
    return BlocBuilder<ReviewCariBloc, ReviewCariState>(
      builder: (context, state) {
        if (state.items.isEmpty) return const SizedBox.shrink();
        final itemsPerPage = isMobile ? 1 : 3;
        final totalPages = (state.items.length / itemsPerPage).ceil();
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: _currentPage > 0
                  ? () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                  : null,
              icon: const Icon(Icons.chevron_left),
              iconSize: isMobile ? 20.0 : 24.0,
            ),
            IconButton(
              onPressed: _currentPage < totalPages - 1
                  ? () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
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
