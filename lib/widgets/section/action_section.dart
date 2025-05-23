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
  double get contentPadding => isMobile ? 16.0 : 35.0;

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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
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
                    _buildAnimatedImage(),
                    const SizedBox(height: 20.0),
                    _buildAnimatedCTAs(),
                  ],
                ),
              )
                  : Wrap(
                spacing: 24.0,
                runSpacing: 30.0,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Text dan CTA
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
                          _buildAnimatedCTAs(),
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

  Widget _buildAnimatedCTAs() {
    return AnimatedBuilder(
      animation: _ctaController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _ctaStaggerAnimation,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _ctaStaggerAnimation.value)),
            child: _buildActionCTAs(),
          ),
        );
      },
    );
  }

  void _onImageHover(bool isHovered) {
    // Image hover animation bisa ditambahkan di sini
  }

  Widget _buildActionTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF79AB43), Color(0xFF5D8B32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: isMobile ? 32.0 : 40.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.2,
          ),
          children: [
            const TextSpan(text: 'Apa yang ingin Anda\n'),
            TextSpan(
              text: 'Lakukan',
              style: TextStyle(
                color: const Color(0xFF79AB43),
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: ' hari ini?'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionImage() {
    return Hero(
      tag: 'action_image',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/home_2.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildActionCTAs() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        AnimatedHoverActionButton(
          onPressed: () {},
          text: 'Cari Asuransi',
          icon: Icons.search,
          isPrimary: true,
          delay: const Duration(milliseconds: 0),
        ),
        AnimatedHoverActionButton(
          onPressed: () {},
          text: 'Lapor Klaim',
          icon: Icons.report_problem,
          isPrimary: false,
          delay: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

class AnimatedHoverActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isPrimary;
  final Duration delay;

  const AnimatedHoverActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.isPrimary = true,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedHoverActionButton> createState() => _AnimatedHoverActionButtonState();
}

class _AnimatedHoverActionButtonState extends State<AnimatedHoverActionButton>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pressController;
  late AnimationController _entryController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _entryAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 4.0,
      end: 12.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: widget.isPrimary ? const Color(0xFF79AB43) : Colors.white,
      end: widget.isPrimary ? const Color(0xFF5D8B32) : const Color(0xFF79AB43),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _iconRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _entryAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.elasticOut,
    ));

    // Start entry animation with delay
    Future.delayed(widget.delay, () {
      if (mounted) _entryController.forward();
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pressController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _pressController, _entryController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _entryAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTapDown: (_) => _pressController.forward(),
              onTapUp: (_) => _pressController.reverse(),
              onTapCancel: () => _pressController.reverse(),
              onTap: widget.onPressed,
              child: Transform.scale(
                scale: _scaleAnimation.value * (1.0 - _pressController.value * 0.05),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    borderRadius: BorderRadius.circular(30),
                    border: widget.isPrimary
                        ? null
                        : Border.all(
                      color: _isHovered
                          ? const Color(0xFF79AB43)
                          : const Color(0xFF79AB43).withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF79AB43).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: _elevationAnimation.value,
                        offset: Offset(0, _elevationAnimation.value / 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: Icon(
                          widget.icon,
                          color: widget.isPrimary
                              ? Colors.white
                              : (_isHovered ? Colors.white : const Color(0xFF79AB43)),
                          size: 20.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Satoshi-Regular',
                          fontWeight: FontWeight.w600,
                          color: widget.isPrimary
                              ? Colors.white
                              : (_isHovered ? Colors.white : const Color(0xFF79AB43)),
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