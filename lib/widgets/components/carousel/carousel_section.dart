import 'dart:async';
import 'dart:ui';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CarouselSection extends StatefulWidget {
  final BoxConstraints constraints;

  const CarouselSection({super.key, required this.constraints});

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection>
    with TickerProviderStateMixin {
  final PageController _carouselController = PageController(
    initialPage: 1000,
    viewportFraction: 0.7,
  );

  int _currentCarouselPage = 0;
  Timer? _carouselTimer;
  bool _isHovering = false;
  late AnimationController _hoverAnimationController;
  late Animation<double> _hoverAnimation;
  double _currentPageValue = 1000.0;

  static const double _imageAspectRatio = 400 / 286;

  // Parameter untuk mengatur ukuran image
  double _imageScaleFactor = 0.8; // Faktor skala untuk image (0.8 = 80% dari ukuran container)

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverAnimationController,
      curve: Curves.easeInOut,
    ));

    _carouselController.addListener(() {
      setState(() {
        _currentPageValue = _carouselController.page ?? 1000.0;
      });
    });

    _startCarouselTimer();

    context.read<GalleryeventCariBloc>().add(RefreshGalleryeventCariEvent());
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isHovering && _carouselController.hasClients && mounted) {
        final nextPage = _carouselController.page!.toInt() + 1;
        _carouselController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _pauseTimer() => _carouselTimer?.cancel();
  void _resumeTimer() => _startCarouselTimer();

  void _onHoverEnter() {
    setState(() => _isHovering = true);
    _hoverAnimationController.forward();
    _pauseTimer();
  }

  void _onHoverExit() {
    setState(() => _isHovering = false);
    _hoverAnimationController.reverse();
    _resumeTimer();
  }

  double _getScale(int index) {
    final distance = (_currentPageValue - index).abs();
    if (distance <= 1.0) {
      return 1.0 - (distance * 0.15); // Scale dari 1.0 ke 0.85
    }
    return 0.85;
  }

  double _getOpacity(int index) {
    final distance = (_currentPageValue - index).abs();
    if (distance <= 1.0) {
      return 1.0 - (distance * 0.4);
    }
    return 0.6;
  }

  double _getCarouselWidth() {
    final isMobile = widget.constraints.maxWidth < 768;
    final isTablet = widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

    if (isMobile) {
      return widget.constraints.maxWidth * 0.9 * 0.7;
    } else if (isTablet) {
      final maxContainerWidth = widget.constraints.maxWidth > 1200 ? 1000.0 : widget.constraints.maxWidth * 0.85;
      return maxContainerWidth * 0.7; // viewport fraction 0.85
    } else {
      final maxContainerWidth = widget.constraints.maxWidth > 1200 ? 1200.0 : widget.constraints.maxWidth * 0.85;
      return maxContainerWidth * 0.7; // viewport fraction 0.85
    }
  }

  // Method untuk mendapatkan ukuran image yang dapat disesuaikan
  double _getImageScaleFactor() {
    final isMobile = widget.constraints.maxWidth < 768;
    final isTablet = widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

    if (isMobile) {
      return 1.6; // Image lebih besar di mobile untuk visibilitas yang baik
    } else if (isTablet) {
      return 0.8;  // Ukuran sedang untuk tablet
    } else {
      return _imageScaleFactor; // Gunakan nilai yang dapat disesuaikan untuk desktop
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.constraints.maxWidth;
    final bool isMobile = width < 768;
    final bool isTablet = width >= 768 && width < 1024;

    final double maxWidth = width > 1200 ? 1200 : width * 0.9;
    final double horizontalPadding = width > 1200
        ? 95
        : width > 992
        ? 64
        : width > 768
        ? 48
        : 24;

    final double titleFontSize = isMobile ? 20 : isTablet ? 24 : 27;

    final carouselWidth = _getCarouselWidth();
    final carouselHeight = carouselWidth / _imageAspectRatio;
    final imageScaleFactor = _getImageScaleFactor();

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 40.0,
        horizontal: horizontalPadding,
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/percent.svg',
                width: isMobile ? 35 : 50.0,
                height: isMobile ? 35 : 50.0,
              ),

              SizedBox(height: 15),

              // Judul
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: titleFontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: const [
                    TextSpan(text: 'Promo '),
                    TextSpan(text: 'Spesial Asuransi '),
                    TextSpan(
                      text: 'JPS',
                      style: TextStyle(
                        color: Color(0xFF91C050),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              Text(
                'Daftar sekarang dan dapatkan penawaran eksklusif untuk '
                    'perlindungan aset pribadi maupun perusahaan Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: isMobile? 12 : 15.0,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 15),
              MouseRegion(
                // onEnter: (_) => _onHoverEnter(),
                // onExit: (_) => _onHoverExit(),
                child: Listener(
                  onPointerSignal: (pointerSignal) {
                    if (pointerSignal is PointerScrollEvent) {
                      if (pointerSignal.scrollDelta.dx > 0) {
                        final nextPage = _carouselController.page!.toInt() + 1;
                        _carouselController.animateToPage(
                          nextPage,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else if (pointerSignal.scrollDelta.dx < 0) {
                        final prevPage = _carouselController.page!.toInt() - 1;
                        _carouselController.animateToPage(
                          prevPage,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                  },
                  child: AnimatedBuilder(
                    animation: _hoverAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _hoverAnimation.value,
                        child: Container(
                          height: carouselHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.47),
                          ),
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: BlocBuilder<GalleryeventCariBloc, GalleryeventCariState>(
                                builder: (context, state) {
                                  if (state.status == ListStatus.initial) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state.status == ListStatus.failure) {
                                    return const Center(
                                      child: Text('Failed to load images'),
                                    );
                                  } else if (state.items.isEmpty) {
                                    return const Center(
                                      child: Text('No images available'),
                                    );
                                  }
                                  return PageView.builder(
                                    controller: _carouselController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentCarouselPage = index % state.items.length;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      final realIndex = index % state.items.length;
                                      final scale = _getScale(index);
                                      final opacity = _getOpacity(index);
                                      final isCenter = (_currentPageValue - index).abs() < 0.5;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Transform.scale(
                                          scale: scale,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14.47),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: carouselWidth * imageScaleFactor,
                                                height: (carouselWidth * imageScaleFactor) / _imageAspectRatio,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(14.47),
                                                  child: AspectRatio(
                                                    aspectRatio: _imageAspectRatio,
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        // Background image
                                                        Image.network(
                                                          state.items[realIndex].galleryUrl,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) {
                                                            return Container(
                                                              color: const Color(0xFF79AB43).withOpacity(0.1),
                                                              child: const Center(
                                                                child: Icon(Icons.image_not_supported, size: 48),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        if (!isCenter)
                                                          BackdropFilter(
                                                            filter: ImageFilter.blur(
                                                              sigmaX: 3.0,
                                                              sigmaY: 3.0,
                                                            ),
                                                            child: Container(
                                                              color: Colors.black.withOpacity(0.1),
                                                            ),
                                                          ),
                                                        // 🔥 Opacity overlay
                                                        Container(
                                                          color: Colors.black.withOpacity(1.0 - opacity),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<GalleryeventCariBloc, GalleryeventCariState>(
                  builder: (context, state) {
                    if (state.status == ListStatus.initial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == ListStatus.failure) {
                      return const Center(
                        child: Text('Failed to load images'),
                      );
                    } else if (state.items.isEmpty) {
                      return const Center(
                        child: Text('No images available'),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        state.items.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: _currentCarouselPage == index ? 24.0 : 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: _currentCarouselPage == index
                                ? const Color(0xFF79AB43)
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}