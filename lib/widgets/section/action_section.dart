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

  double get maxWidth =>
      widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;
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
          padding: EdgeInsets.only(
            top: isMobile ? 20.0 : 40.0,
            bottom: isMobile ? 0 : 40.0,
          ),
          child: Center(
            child: Container(
              width: maxWidth,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 0 : 36.0,
              ),
              child: isMobile
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedTitle(),
                    const SizedBox(height: 32.0),
                    _buildAnimatedBenefitPoints(),
                    const SizedBox(height: 32.0),
                    _buildAnimatedCTAs(),
                    const SizedBox(height: 32.0),
                    // Add image for mobile
                    _buildAnimatedImage(),
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
                          _buildAnimatedBenefitPoints(),
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
                        maxWidth: isTablet ? maxWidth * 0.4 : maxWidth * 0.4,
                        maxHeight: 300,
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
    return Center(
      child: AnimatedBuilder(
        animation: _imageController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_imageSlideAnimation.value, 0),
            child: FadeTransition(
              opacity: _imageController,
              child: MouseRegion(
                onEnter: (_) => _onImageHover(true),
                onExit: (_) => _onImageHover(false),
                child: Container(
                  width: isMobile ? double.infinity : null,
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? 350 : 400,
                    maxHeight: isMobile ? 350 : 400,
                  ),
                  child: _buildActionImage(),
                ),
              ),
            ),
          );
        },
      ),
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

  }

  Widget _buildActionTitle() {
    // Jika mobile, kita center-kan belah pihak agar padding kiri+kanan seimbang.
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center, // keseluruhan kolom rata tengah
        children: [
          // Baris pertama (judul + logo), dibungkus Center agar berada di tengah
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Asuransi melalui ',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                Image.asset(
                  'assets/images/jps_logo1.png',
                  height: 45.0,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          // Baris kedua, teks rata tengah
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0), // sudah center, jadi tak perlu horizontal padding tambahan
            child: Text(
              'Klaim mudah, perlindungan aman',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    // Jika bukan mobile, kembalikan seperti semula (left-aligned)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Asuransi melalui ',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: 36.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            Image.asset(
              'assets/images/jps_logo1.png',
              height: 50.0,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Klaim mudah, perlindungan aman',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            height: 1.3,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }


  Widget _buildBenefitPoints() {
    final benefits = [
      {'icon': Icons.flash_on, 'text': 'Klaim Cepat & Mudah'},
      {'icon': Icons.home_work, 'text': 'Bengkel Terpercaya'},
      {'icon': Icons.headset_mic, 'text': 'CS Responsif 24/7'},
      {'icon': Icons.verified_user, 'text': 'Perlindungan Terjamin'},
    ];

    if (isMobile) {
      return Column(
        children: [
          // Baris pertama, dengan padding vertikal di tiap fitur
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AnimatedBenefitPoint(
                    icon: benefits[0]['icon'] as IconData,
                    text: benefits[0]['text'] as String,
                    isMobile: true,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AnimatedBenefitPoint(
                    icon: benefits[1]['icon'] as IconData,
                    text: benefits[1]['text'] as String,
                    isMobile: true,
                  ),
                ),
              ),
            ],
          ),
          // Jarak antar baris (bisa disesuaikan jika perlu)
          const SizedBox(height: 20),
          // Baris kedua, dengan padding vertikal di tiap fitur
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AnimatedBenefitPoint(
                    icon: benefits[2]['icon'] as IconData,
                    text: benefits[2]['text'] as String,
                    isMobile: true,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AnimatedBenefitPoint(
                    icon: benefits[3]['icon'] as IconData,
                    text: benefits[3]['text'] as String,
                    isMobile: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }  else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0), // Tambahkan padding atas-bawah
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, right: 12.0),
                    child: AnimatedBenefitPointHorizontal(
                      icon: benefits[0]['icon'] as IconData,
                      text: benefits[0]['text'] as String,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, left: 12.0),
                    child: AnimatedBenefitPointHorizontal(
                      icon: benefits[1]['icon'] as IconData,
                      text: benefits[1]['text'] as String,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, right: 12.0),
                    child: AnimatedBenefitPointHorizontal(
                      icon: benefits[2]['icon'] as IconData,
                      text: benefits[2]['text'] as String,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, left: 12.0),
                    child: AnimatedBenefitPointHorizontal(
                      icon: benefits[3]['icon'] as IconData,
                      text: benefits[3]['text'] as String,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
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
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildActionCTAs() {
    if (isMobile) {
      // Mobile: Stack buttons vertically with full width
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            child: AnimatedHoverActionButton(
              onPressed: () {},
              text: 'Cari Asuransi',
              icon: Icons.search,
              isPrimary: true,
              delay: const Duration(milliseconds: 0),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: AnimatedHoverActionButton(
              onPressed: () {},
              text: 'Lapor Klaim',
              icon: Icons.report_problem,
              isPrimary: false,
              delay: const Duration(milliseconds: 200),
            ),
          ),
        ],
      );
    } else {
      // Desktop: keep original wrap layout
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
}

// Widget baru untuk desktop layout horizontal
class AnimatedBenefitPointHorizontal extends StatefulWidget {
  final IconData icon;
  final String text;
  final Duration delay;

  const AnimatedBenefitPointHorizontal({
    super.key,
    required this.icon,
    required this.text,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedBenefitPointHorizontal> createState() => _AnimatedBenefitPointHorizontalState();
}

class _AnimatedBenefitPointHorizontalState extends State<AnimatedBenefitPointHorizontal>
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
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // background putih
                    borderRadius: BorderRadius.circular(16.13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // shadow lembut
                        blurRadius: 8.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: const Color(0xFF79AB43), // warna ikon sesuai kebutuhan
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Satoshi-Regular',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
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

class AnimatedBenefitPoint extends StatefulWidget {
  final IconData icon;
  final String text;
  final Duration delay;
  final bool isMobile;

  const AnimatedBenefitPoint({
    super.key,
    required this.icon,
    required this.text,
    this.delay = Duration.zero,
    this.isMobile = false,
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
    // Tentukan sizeIcon lebih besar jika isMobile true
    final double sizeIcon = widget.isMobile ? 32.0 : 24.0;
    final EdgeInsets containerPadding = widget.isMobile
        ? const EdgeInsets.all(16.0)
        : const EdgeInsets.all(12.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // background putih
                    borderRadius: BorderRadius.circular(16.13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // shadow lembut
                        blurRadius: 8.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: const Color(0xFF79AB43), // warna ikon sesuai kebutuhan
                    size: sizeIcon,
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Satoshi-Regular',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
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

class ActionButtonsRow extends StatelessWidget {
  final List<Widget> children;
  const ActionButtonsRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children.map((child) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: child,
        );
      }).toList(),
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
                    borderRadius: BorderRadius.circular(16.13),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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