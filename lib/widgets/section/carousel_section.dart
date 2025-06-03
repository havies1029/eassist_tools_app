import 'dart:async';
import 'dart:ui';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    viewportFraction: 0.7, // 🔥 Diperkecil agar gambar samping terlihat lebih blur
  );

  int _currentCarouselPage = 0;
  Timer? _carouselTimer;
  bool _isHovering = false;
  late AnimationController _hoverAnimationController;
  late Animation<double> _hoverAnimation;
  double _currentPageValue = 1000.0;

  /*
  final List<String> _carouselImages = [
    'assets/images/poster_1.png',
    'assets/images/poster_2.png',
    'assets/images/poster_3.png',
  ];
  */

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

    // 🔥 Listener untuk mendapatkan posisi page yang tepat
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

  // 🔥 Function untuk menghitung scale dan opacity berdasarkan posisi
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
      return 1.0 - (distance * 0.4); // Opacity dari 1.0 ke 0.6
    }
    return 0.6;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.constraints.maxWidth < 768;
    final isTablet = widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;
    final double maxWidth = widget.constraints.maxWidth > 1200
        ? 1200
        : widget.constraints.maxWidth * 0.9;
    final titleFontSize = isMobile ? 15.0 : (isTablet ? 22.0 : 24.0);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40.0 : 40.0,
        horizontal: isMobile ? 4.0 : 40.0,
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // RichText Title
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: titleFontSize,
                      color: Colors.black,
                    ),
                    children: const [
                      TextSpan(text: 'Apakah Anda siap bergabung dengan '),
                      TextSpan(
                        text: 'JPS',
                        style: TextStyle(
                          color: Color(0xFF79AB43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' dan mendapatkan '),
                      TextSpan(
                        text: 'Perlindungan Terbaik',
                        style: TextStyle(
                          color: Color(0xFF79AB43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: '?'),
                    ],
                  ),
                ),
              ),

              // Carousel dengan efek blur dan scale
              MouseRegion(
                onEnter: (_) => _onHoverEnter(),
                onExit: (_) => _onHoverExit(),
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
                          height: isMobile ? 200 : (isTablet ? 280 : 320), // 🔥 Fixed height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
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
                                        //_currentCarouselPage = index % _carouselImages.length;
                                        _currentCarouselPage = index %state.items.length;
                                      });
                                    },
                                    //itemCount: state.items.length,
                                    itemBuilder: (context, index) {
                                      final realIndex = index % state.items.length;
                                      final scale = _getScale(index);
                                      final opacity = _getOpacity(index);
                                      final isCenter = (_currentPageValue - index).abs() < 0.5;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Transform.scale(
                                          scale: scale,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16.0),
                                              boxShadow: isCenter ? [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.15),
                                                  spreadRadius: 3,
                                                  blurRadius: 15,
                                                  offset: const Offset(0, 6),
                                                ),
                                              ] : null,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16.0),
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  // Background image
                                                  Image.network(
                                                    state.items[realIndex].galleryUrl,
                                                    //_carouselImages[realIndex],
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
                                                  // 🔥 Blur effect untuk gambar yang tidak aktif
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

              const SizedBox(height: 20.0),

              // Page Indicator
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
                        //_carouselImages.length,
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