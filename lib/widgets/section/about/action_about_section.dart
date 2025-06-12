import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF79AB43);
const _textColor = Colors.black87;
const _benefitTextColor = Color(0xFF2D3748);
const _fontFamily = 'Satoshi-Regular';

const _benefitTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w500,
  color: _benefitTextColor,
);

TextStyle titleTextStyle(bool isMobile) => TextStyle(
  fontFamily: _fontFamily,
  fontSize: isMobile ? 30.0 : 45.0,
  fontWeight: isMobile ? FontWeight.w600 : FontWeight.w400,
  fontStyle: isMobile ? FontStyle.italic : FontStyle.normal,
  color: _textColor,
  height: 1.2,
);

TextStyle subtitleTextStyle(bool isMobile) => TextStyle(
  fontFamily: _fontFamily,
  fontSize: isMobile ? 20.0 : 30.0,
  fontWeight: isMobile ? FontWeight.w500 : FontWeight.w400,
  fontStyle: isMobile ? FontStyle.italic : FontStyle.normal,
  color: _textColor,
  height: 1.3,
);

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;
  const ActionSection({super.key, required this.constraints});

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _imageController;

  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _imageSlideAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  double get maxWidth {
    final raw = widget.constraints.maxWidth * 0.9;
    return raw > 1200 ? 1200 : raw;
  }

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(
    horizontal: isMobile ? 35.0 : (isTablet ? 48.0 : 80.0),
  );

  EdgeInsets get verticalPadding {
    if (isMobile) {
      return const EdgeInsets.only(top: 55.0, bottom: 10.0);
    } else if (isTablet) {
      return const EdgeInsets.symmetric(vertical: 72.0);
    } else {
      return const EdgeInsets.symmetric(vertical: 100.0);
    }
  }

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _imageController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic)),
    );
    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic)),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _imageSlideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOutBack),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mainController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _imageController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Stack(
            children: [
              if (isMobile) _buildMobileBackgroundImage(),
              Container(
                padding: verticalPadding.add(horizontalPadding),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: isMobile ? _buildMobileContent() : _buildDesktopContent(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileBackgroundImage() {
    return Positioned(
      top: 80,
      right: -80,
      child: AnimatedBuilder(
        animation: _imageController,
        builder: (context, child) {
          return Opacity(
            opacity: 0.15 * _imageController.value,
            child: Transform.scale(
              scale: 1.5,
              child: Container(
                width: 250,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.13),
                  child: Image.asset('assets/images/home_2.png', fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedTitle(),
        const SizedBox(height: 32.0),
        _buildBenefitPoints(),
        const SizedBox(height: 32.0),
        _buildAnimatedImage(),
      ],
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isTablet ? maxWidth : maxWidth * 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnimatedTitle(),
              const SizedBox(height: 30.0),
              _buildBenefitPoints(),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
        const SizedBox(width: 24.0),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth * 0.4, maxHeight: 300),
          child: _buildAnimatedImage(),
        ),
      ],
    );
  }

  Widget _buildAnimatedTitle() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _slideInAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Asuransi melalui ', style: titleTextStyle(isMobile)),
                  Flexible(
                    flex: 0,
                    child: Image.asset(
                      'assets/images/JPS(2).png',
                      height: isMobile ? 36.0 : 70.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text('Klaim mudah, perlindungan aman', style: subtitleTextStyle(isMobile)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedImage() {
    if (isMobile) return const SizedBox.shrink();
    return Center(
      child: AnimatedBuilder(
        animation: _imageController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_imageSlideAnimation.value, 0),
            child: FadeTransition(
              opacity: _imageController,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildBenefitPoints() {
    return isMobile ? _buildMobileGrid() : _buildDesktopGrid();
  }

  Widget _buildMobileGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _benefitItem(benefitList[0])),
            const SizedBox(width: 15),
            Expanded(child: _benefitItem(benefitList[1])),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _benefitItem(benefitList[2])),
            const SizedBox(width: 15),
            Expanded(child: _benefitItem(benefitList[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _benefitItem(benefitList[0], horizontal: true)),
            const SizedBox(width: 24),
            Expanded(child: _benefitItem(benefitList[1], horizontal: true)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _benefitItem(benefitList[2], horizontal: true)),
            const SizedBox(width: 24),
            Expanded(child: _benefitItem(benefitList[3], horizontal: true)),
          ],
        ),
      ],
    );
  }

  Widget _benefitItem(Map<String, dynamic> item, {bool horizontal = false}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F9F0),
            borderRadius: BorderRadius.circular(16.13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(item['icon'], color: _primaryColor, size: 25.0),
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            item['text'],
            style: _benefitTextStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}

final List<Map<String, dynamic>> benefitList = [
  {'icon': Icons.flash_on, 'text': 'Klaim Cepat & Mudah'},
  {'icon': Icons.home_work, 'text': 'Bengkel Terpercaya'},
  {'icon': Icons.headset_mic, 'text': 'CS Responsif 24/7'},
  {'icon': Icons.verified_user, 'text': 'Perlindungan Terjamin'},
];