import 'package:flutter/material.dart';

import '../section/action_section.dart';

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

  // New animations for header
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  double get maxWidth =>
      widget.constraints.maxWidth > 1300 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get contentPadding => isMobile ? 16.0 : 0;

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

    // New header animations
    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.1, 0.6, curve: Curves.easeOutCubic),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInsuranceGrid(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInsuranceGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // New Header
        _buildNewHeader(),
        // Grid kartu asuransi
        _buildInsuranceCards(),
      ],
    );
  }

  Widget _buildNewHeader() {
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
                  const TextSpan(text: 'Yuk, temukan '),
                  TextSpan(
                    text: 'asuransi',
                    style: TextStyle(
                      color: const Color(0xFF79AB43),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' yang pas buat '),
                  TextSpan(
                    text: 'kamu',
                    style: TextStyle(
                      color: const Color(0xFF79AB43),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: '!'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInsuranceCards() {
    final categories = [
      {
        'title': 'Asuransi Mobil',
        'subtitle': 'Lindungi kendaraan Anda dengan perlindungan menyeluruh',
        'image': 'assets/images/find_1.png',
        'color': const Color(0xFF1E3A8A),
      },
      {
        'title': 'Asuransi Kesehatan',
        'subtitle': 'Jaminan kesehatan terbaik untuk keluarga tercinta',
        'image': 'assets/images/find_2.png',
        'color': const Color(0xFF059669),
      },
      {
        'title': 'Asuransi Jiwa',
        'subtitle': 'Perlindungan masa depan yang terjamin',
        'image': 'assets/images/find_3.png',
        'color': const Color(0xFF7C3AED),
      },
      {
        'title': 'Asuransi Perjalanan',
        'subtitle': 'Traveling dengan tenang dan nyaman',
        'image': 'assets/images/find_4.png',
        'color': const Color(0xFFDC2626),
      },
      {
        'title': 'Asuransi Rumah & Properti',
        'subtitle': 'Lindungi rumah dan harta berhargamu dari bencana dan risiko tak terduga',
        'image': 'assets/images/find_5.png',
        'color': const Color(0xFFDC2626),
      },
      {
        'title': 'Asuransi Pendidikan',
        'subtitle': 'Persiapkan masa depan dengan dana pendidikan yang aman',
        'image': 'assets/images/find_6.png',
        'color': const Color(0xFFDC2626),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: isMobile ? 16 : 36,
        mainAxisSpacing: isMobile ? 16 : 36,
        childAspectRatio: isMobile ? 1.4 : 1.6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 800 + (index * 200)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _buildInsuranceCard(
                  title: category['title'] as String,
                  subtitle: category['subtitle'] as String,
                  imagePath: category['image'] as String,
                  color: category['color'] as Color,
                  index: index,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInsuranceCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required Color color,
    required int index,
  }) {
    return AnimatedInsuranceCard(
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      color: color,
      isMobile: isMobile,
      onTap: () {
        print('Selected: $title');
        // Handle navigation or action here
      },
    );
  }
}

class AnimatedInsuranceCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
  final bool isMobile;
  final VoidCallback onTap;

  const AnimatedInsuranceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<AnimatedInsuranceCard> createState() => _AnimatedInsuranceCardState();
}

class _AnimatedInsuranceCardState extends State<AnimatedInsuranceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _overlayAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _overlayAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: _elevationAnimation.value,
                  offset: Offset(0, _elevationAnimation.value * 0.3),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Subtle gradient overlay for text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),

                          // Title with better contrast
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.isMobile ? 16 : 20,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Satoshi-Regular',
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              child: Text(widget.title),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle with background for readability
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: widget.isMobile ? 11 : 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Satoshi-Regular',
                                height: 1.4,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              child: Text(
                                widget.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Spacer(),

                          // Arrow icon with enhanced visibility
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: _isHovered ? 0.125 : 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: widget.color.withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: widget.color,
                                size: widget.isMobile ? 16 : 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Invisible tap area
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: widget.onTap,
                          onHover: _onHover,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(),
                        ),
                      ),
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
}