import 'package:flutter/material.dart';
import '../../pages/heropage/hero_main.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ActionSection({super.key, required this.constraints});

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _imageController;
  late AnimationController _ctaController;

  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _imageSlideAnimation;
  late Animation<double> _ctaStaggerAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  double get maxWidth => widget.constraints.maxWidth > 1200 ? 1100 : widget.constraints.maxWidth * 0.88;
  double get contentPadding => isMobile ? 16.0 : 32.0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _ctaController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Setup animations
    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _imageSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutBack,
    ));

    _ctaStaggerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _ctaController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mainController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _imageController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _ctaController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _imageController.dispose();
    _ctaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Center(
            child: Container(
              width: maxWidth,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 30.0 : 36.0,
              ),
              child: isMobile
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                child: Column(
                  children: [
                    _buildAnimatedTitle(),
                    const SizedBox(height: 20.0),
                    _buildAnimatedBenefitPoints(),
                  ],
                ),
              )
                  : Wrap(
                spacing: 24.0,
                runSpacing: 30.0,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Text dan benefit points only
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? maxWidth : maxWidth * 0.5,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: contentPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAnimatedTitle(),
                          const SizedBox(height: 30.0),
                          _buildAnimatedBenefitPoints(),
                        ],
                      ),
                    ),
                  ),

                  // Image responsif
                  Padding(
                    padding: EdgeInsets.only(right: contentPadding),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? maxWidth : 450,
                      ),
                      child: _buildAnimatedImage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTitle() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _slideInAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _buildActionTitle(),
        ),
      ),
    );
  }

  Widget _buildAnimatedImage() {
    return AnimatedBuilder(
      animation: _imageController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_imageSlideAnimation.value, 0),
          child: FadeTransition(
            opacity: _imageController,
            child: MouseRegion(
              onEnter: (_) => _onImageHover(true),
              onExit: (_) => _onImageHover(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _buildActionImage(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedBenefitPoints() {
    return AnimatedBuilder(
      animation: _ctaController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _ctaStaggerAnimation,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _ctaStaggerAnimation.value)),
            child: _buildBenefitPoints(),
          ),
        );
      },
    );
  }

  void _onImageHover(bool isHovered) {
    // Image hover animation bisa ditambahkan di sini
  }

  Widget _buildActionTitle() {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Main title with logo
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Asuransi melalui ',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 28.0 : 36.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            Image.asset(
              'assets/images/jps_logo1.png',
              height: isMobile ? 40.0 : 50.0,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        // Subtitle
        Text(
          'Klaim mudah, perlindungan aman',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: isMobile ? 18.0 : 22.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            height: 1.3,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildBenefitPoints() {
    final leftColumn = [
      {'icon': Icons.flash_on, 'text': 'Klaim Cepat & Mudah'},
      {'icon': Icons.headset_mic, 'text': 'CS Responsif 24/7'},
    ];

    final rightColumn = [
      {'icon': Icons.home_work, 'text': 'Bengkel Terpercaya'},
      {'icon': Icons.verified_user, 'text': 'Perlindungan Terjamin'},
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: leftColumn
                .map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: AnimatedBenefitPoint(
                icon: b['icon'] as IconData,
                text: b['text'] as String,
              ),
            ))
                .toList(),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rightColumn
                .map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: AnimatedBenefitPoint(
                icon: b['icon'] as IconData,
                text: b['text'] as String,
              ),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionImage() {
    return Hero(
      tag: 'action_image',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.13),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.13),
          child: Image.asset(
            'assets/images/home_2.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class AnimatedBenefitPoint extends StatefulWidget {
  final IconData icon;
  final String text;
  final Duration delay;

  const AnimatedBenefitPoint({
    super.key,
    required this.icon,
    required this.text,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedBenefitPoint> createState() => _AnimatedBenefitPointState();
}

class _AnimatedBenefitPointState extends State<AnimatedBenefitPoint>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0), // Same as code 1
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16.13), // Same radius as code 1
                      boxShadow: [
                        // Multiple shadows for better depth
                        BoxShadow(
                          color: const Color(0xFF79AB43).withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: const Color(0xFF79AB43).withOpacity(0.08),
                          spreadRadius: 4,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: const Color(0xFF79AB43),
                      size: 18.0, // Same size as code 1
                    ),
                  ),
                  const SizedBox(width: 12.0), // Same spacing as code 1
                  Flexible(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 15.0, // Same font size as code 1
                        fontFamily: 'Satoshi-Regular',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          },
        );
    }
}