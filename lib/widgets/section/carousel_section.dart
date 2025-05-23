import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    viewportFraction: 0.92, // 🔥 memberi jarak antar slide
  );

  int _currentCarouselPage = 0;
  Timer? _carouselTimer;
  bool _isHovering = false;
  late AnimationController _hoverAnimationController;
  late Animation<double> _hoverAnimation;

  final List<String> _carouselImages = [
    'assets/images/poster_1.png',
    'assets/images/poster_2.png',
    'assets/images/poster_3.png',
  ];

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
    _startCarouselTimer();
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

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.constraints.maxWidth < 768;
    final isTablet = widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;
    final double maxWidth = widget.constraints.maxWidth > 1200
        ? 1200
        : widget.constraints.maxWidth * 0.9;
    final titleFontSize = isMobile ? 20.0 : (isTablet ? 22.0 : 24.0);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 20.0 : 30.0,
        horizontal: isMobile ? 16.0 : 0.0,
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

              // Carousel with AspectRatio and padding
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context).copyWith(
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  },
                                ),
                                child: PageView.builder(
                                  controller: _carouselController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentCarouselPage = index % _carouselImages.length;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    final realIndex = index % _carouselImages.length;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6.0), // 💡 Spacing antar slide
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          _carouselImages[realIndex],
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _carouselImages.length,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
