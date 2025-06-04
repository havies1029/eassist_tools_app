import 'package:flutter/material.dart';

class AboutJps extends StatefulWidget {
  final BoxConstraints constraints;

  const AboutJps({super.key, required this.constraints});

  @override
  State<AboutJps> createState() => _AboutJpsState();
}

class _AboutJpsState extends State<AboutJps> with TickerProviderStateMixin {
  late AnimationController _controller;

  // Individual hover controllers for each image
  late AnimationController _hoverController1;
  late AnimationController _hoverController2;
  late AnimationController _hoverController3;
  late AnimationController _hoverController4;

  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _imageSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _staggeredAnimation1;
  late Animation<double> _staggeredAnimation2;
  late Animation<double> _staggeredAnimation3;
  late Animation<double> _staggeredAnimation4;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;
  double get maxWidth => widget.constraints.maxWidth > 1300 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get contentPadding => isMobile ? 16.0 : 10.0;

  final GlobalKey _descriptionKey = GlobalKey();
  double _textHeight = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Initialize individual hover controllers
    _hoverController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hoverController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hoverController3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hoverController4 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOutCubic),
    ));

    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.4, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    ));

    _imageSlideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
    ));

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
    ));

    _staggeredAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.5, curve: Curves.easeOutBack),
    ));

    _staggeredAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.6, curve: Curves.easeOutBack),
    ));

    _staggeredAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.7, curve: Curves.easeOutBack),
    ));

    _staggeredAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 0.8, curve: Curves.easeOutBack),
    ));

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _descriptionKey.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        setState(() {
          _textHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hoverController1.dispose();
    _hoverController2.dispose();
    _hoverController3.dispose();
    _hoverController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Center(
            child: Container(
              width: maxWidth,
              padding: EdgeInsets.only(
                bottom: isMobile ? 40.0 : 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAnimatedHeader(),
                  SizedBox(height: isMobile ? 40.0 : 60.0),
                  _buildContentSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedHeader() => const SizedBox.shrink();

  Widget _buildContentSection() {
    if (isMobile) {
      return Column(
        children: [
          _buildImageGrid(),
          const SizedBox(height: 40.0),
          _buildAnimatedDescription(),
        ],
      );
    } else {
      // Desktop layout
      return Column(
        children: [
          // Row 1: Gambar 1 & 2, dan teks
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kiri: 2 gambar atas
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start, // <-- rata bawah
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 420,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end, // Sebenarnya dengan Expanded, ini tidak ngaruh, tapi boleh dipakai
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.asset(
                                    'assets/images/about_2.png',
                                    fit: BoxFit.fitHeight,
                                    width: double.infinity,
                                    height: 200,
                                    alignment: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.asset(
                                    'assets/images/about_3.png',
                                    fit: BoxFit.fitHeight,
                                    width: double.infinity,
                                    height: 250,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Kanan: Text
              Expanded(
                child: _buildAnimatedDescription(),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Row 2: Gambar 3 & 4, fill full width, height lebih pendek
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    'assets/images/about_1.png',
                    fit: BoxFit.fitHeight, // atau coba BoxFit.contain
                    width: double.infinity,
                    height: 250,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    'assets/images/about_4.png',
                    fit: BoxFit.fitHeight, // Untuk fill, atau coba BoxFit.contain
                    width: double.infinity,
                    height: 250,
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }


  Widget _buildImageGrid() {
    return Transform.translate(
      offset: Offset(_imageSlideAnimation.value, 0),
      child: FadeTransition(
        opacity: _controller,
        child: _buildFigmaStyleGrid(),
      ),
    );
  }

  Widget _buildFigmaStyleGrid() {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gambar atas (about_1 & about_2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAnimatedImageContainer(
                  'assets/images/about_1.png',
                  height: 120,
                  animation: _staggeredAnimation1,
                  hoverController: _hoverController1,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAnimatedImageContainer(
                  'assets/images/about_2.png',
                  height: 120,
                  animation: _staggeredAnimation2,
                  hoverController: _hoverController2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildAnimatedDescription(),
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _buildAnimatedImageContainer(
                  'assets/images/about_3.png',
                  height: 120,
                  animation: _staggeredAnimation3,
                  hoverController: _hoverController3,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAnimatedImageContainer(
                  'assets/images/about_4.png',
                  height: 120,
                  animation: _staggeredAnimation4,
                  hoverController: _hoverController4,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // ... (Dekstop tetap seperti sebelumnya)
      return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildAnimatedImageContainer('assets/images/about_1.png', height: 180.0, animation: _staggeredAnimation1, hoverController: _hoverController1)),
                const SizedBox(width: 16.0),
                Expanded(child: _buildAnimatedImageContainer('assets/images/about_2.png', height: 180.0, animation: _staggeredAnimation2, hoverController: _hoverController2)),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(child: _buildAnimatedImageContainer('assets/images/about_3.png', height: 180.0, animation: _staggeredAnimation3, hoverController: _hoverController3)),
                const SizedBox(width: 16.0),
                Expanded(child: _buildAnimatedImageContainer('assets/images/about_4.png', height: 180.0, animation: _staggeredAnimation4, hoverController: _hoverController4)),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildAnimatedImageContainer(String path, {
    required double height,
    required Animation<double> animation,
    required AnimationController hoverController
  }) {
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - animation.value)),
          child: _buildHoverImageContainer(path, height: height, hoverController: hoverController),
        ),
      ),
    );
  }

  Widget _buildHoverImageContainer(String path, {
    required double height,
    required AnimationController hoverController
  }) {
    return MouseRegion(
      onEnter: (_) => hoverController.forward(),
      onExit: (_) => hoverController.reverse(),
      child: AnimatedBuilder(
        animation: hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (hoverController.value * 0.05),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF79AB43).withOpacity(0.15 + (hoverController.value * 0.1)),
                    spreadRadius: 2 + (hoverController.value * 2),
                    blurRadius: 12 + (hoverController.value * 8),
                    offset: Offset(0, 4 + (hoverController.value * 4)),
                  ),
                  BoxShadow(
                    color: const Color(0xFF79AB43).withOpacity(0.08 + (hoverController.value * 0.05)),
                    spreadRadius: 4 + (hoverController.value * 2),
                    blurRadius: 20 + (hoverController.value * 10),
                    offset: Offset(0, 8 + (hoverController.value * 4)),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19.15),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedDescription() {
    return FadeTransition(
      opacity: _textFadeAnimation,
      child: Transform.translate(
        offset: Offset(0, 30 * (1 - _textFadeAnimation.value)),
        child: Column(
          key: _descriptionKey,
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mengenal JPS: Jelas, Praktis, dan Solutif!',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 14.0 : 16.0,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF79AB43),
                height: 1.3,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 12.0),
            Text(
              'Tentang JPS',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 28.0 : 36.0,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D3748),
                height: 1.2,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 20.0),
            Text(
              'JPS hadir untuk memudahkan Anda memahami dunia asuransi tanpa ribet. Kami menyediakan informasi yang jelas, proses klaim yang praktis, dan solusi tepat guna yang membantu Anda mendapatkan perlindungan terbaik. Bersama JPS, asuransi tak lagi rumit, tapi jadi lebih dekat dan lebih mudah dimengerti oleh semua kalangan.',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 16.0 : 16.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF718096),
                height: 1.6,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}