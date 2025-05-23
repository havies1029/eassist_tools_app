import 'package:flutter/material.dart';

class FeatureSection extends StatefulWidget {
  final BoxConstraints constraints;
  const FeatureSection({super.key, required this.constraints});

  @override
  State<FeatureSection> createState() => _FeatureSectionState();
}

class _FeatureSectionState extends State<FeatureSection>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _titleController;
  late AnimationController _featuresController;

  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _titleScaleAnimation;
  late Animation<double> _featuresStaggerAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxWidth => widget.constraints.maxWidth > 1200
      ? 1200
      : widget.constraints.maxWidth * 0.9;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _featuresController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _headerFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _headerController,
          curve: Curves.easeOutCubic,
        ));

    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: _headerController,
          curve: Curves.easeOutBack,
        ));

    _titleFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _titleController,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
        ));

    _titleSlideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: _titleController,
          curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
        ));

    _titleScaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
          parent: _titleController,
          curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
        ));

    _featuresStaggerAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _featuresController,
          curve: Curves.easeOutCubic,
        ));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _headerController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _featuresController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _titleController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 70.0),
      child: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnimatedHeader(),
              isMobile
                  ? Column(
                children: [
                  _buildAnimatedTitle(),
                  const SizedBox(height: 40.0),
                  _buildAnimatedFeatureList(),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 520,
                    padding: const EdgeInsets.only(right: 40.0),
                    child: _buildAnimatedTitle(),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: _buildAnimatedFeatureList(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return AnimatedBuilder(
      animation: _headerController,
      builder: (context, child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FadeTransition(
              opacity: _headerFadeAnimation,
              child: SlideTransition(
                position: _headerSlideAnimation,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: isMobile ? 22.0 : 25.0,
                      color: Colors.black,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: 'Kami Membantu Anda '),
                      TextSpan(
                        text: 'Terlindungi',
                        style: TextStyle(
                          color: const Color(0xFF79AB43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' dengan Lebih Baik Setiap Hari.'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTitle() {
    return AnimatedBuilder(
      animation: _titleController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _titleFadeAnimation,
          child: SlideTransition(
            position: _titleSlideAnimation,
            child: ScaleTransition(
              scale: _titleScaleAnimation,
              child: _buildFeatureTitle(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedFeatureList() {
    return AnimatedBuilder(
      animation: _featuresController,
      builder: (context, child) {
        return _buildFeatureList();
      },
    );
  }

  Widget _buildFeatureTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 32.0 : 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
            children: [
              const TextSpan(text: 'Bagaimana '),
              TextSpan(
                text: 'JPS',
                style: TextStyle(color: const Color(0xFF79AB43)),
              ),
              const TextSpan(text: ' membantu'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Asuransi Anda Lebih Baik',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: isMobile ? 32.0 : 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20.0),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Kami membantu menyampaikan solusi asuransi Anda lewat visual yang jelas, terpercaya, dan mudah dipahami oleh semua audiens.',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 18.0 : 20.0,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        // ⭐ RATING
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 200 + (i * 100)),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: const Icon(
                      Icons.star,
                      color: Color(0xFFFFD700),
                      size: 20.0,
                    ),
                  );
                },
              ),
            const SizedBox(width: 8.0),
            const Text(
              '4.9 / 5 rating',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Approved by Client JPS',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          AnimatedFeatureItem(
            icon: Icons.check_circle_outline,
            title: 'Menginformasikan. Melindungi. Meyakinkan.',
            description:
            'Menyediakan informasi yang jelas, melindungi kepentingan Anda,\ndan memberikan rasa aman dalam setiap klaim asuransi.',
            delay: const Duration(milliseconds: 0),
            animation: _featuresStaggerAnimation,
          ),
          const SizedBox(height: 32.0),
          AnimatedFeatureItem(
            icon: Icons.person_outline,
            title: 'Membangun Kepercayaan Klien',
            description:
            'Klaim yang cepat dan transparan membangun kepercayaan penuh untuk setiap langkah perlindungan Anda.',
            delay: const Duration(milliseconds: 200),
            animation: _featuresStaggerAnimation,
          ),
          const SizedBox(height: 32.0),
          AnimatedFeatureItem(
            icon: Icons.description_outlined,
            title: 'Menyederhanakan Info Asuransi',
            description:
            'Proses klaim yang mudah dimengerti, mempermudah Anda dalam memahami hak dan perlindungan asuransi.',
            delay: const Duration(milliseconds: 400),
            animation: _featuresStaggerAnimation,
          ),
        ],
      ),
    );
  }
}


class AnimatedFeatureItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Duration delay;
  final Animation<double> animation;

  const AnimatedFeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
    required this.animation,
  });

  @override
  State<AnimatedFeatureItem> createState() => _AnimatedFeatureItemState();
}

class _AnimatedFeatureItemState extends State<AnimatedFeatureItem>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _entryController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _backgroundAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _entryAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _backgroundAnimation = ColorTween(
      begin: Colors.transparent,
      end: const Color(0xFF79AB43).withOpacity(0.02),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _iconScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.elasticOut,
    ));

    _entryAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutBack,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutCubic,
    ));

    // Start entry animation with delay
    Future.delayed(widget.delay, () {
      if (mounted) _entryController.forward();
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _entryController, widget.animation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _slideAnimation.value.dx * 50 * (1 - widget.animation.value),
            0,
          ),
          child: Opacity(
            opacity: _entryAnimation.value * widget.animation.value,
            child: MouseRegion(
              onEnter: (_) => _onHover(true),
              onExit: (_) => _onHover(false),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _backgroundAnimation.value,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: _iconScaleAnimation.value,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? const Color(0xFF79AB43).withOpacity(0.1)
                                : const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: _isHovered
                                  ? const Color(0xFF79AB43).withOpacity(0.3)
                                  : const Color(0xFFE9ECEF),
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              widget.icon,
                              color: const Color(0xFF79AB43),
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500, // tidak berubah
                                color: _isHovered ? const Color(0xFF79AB43) : Colors.black, // 🟢 efek hover hijau
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.description,
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.black54,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }
}