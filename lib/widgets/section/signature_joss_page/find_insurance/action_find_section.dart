import 'package:eassist_tools_app/widgets/section/signature_joss_page/decorations/AnimatedInsuranceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../decorations/AnimatedInsuranceCard.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;
  // Add these properties to control image dimensions
  final double? customImageWidth;
  final double? customImageHeight;
  final BoxFit? imageFit;

  const ActionSection({
    super.key,
    required this.constraints,
    this.customImageWidth,
    this.customImageHeight,
    this.imageFit = BoxFit.cover,
  });

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

  // Calculate dynamic image dimensions
  double get imageWidth => widget.customImageWidth ?? (isMobile ? 300 : 334);
  double get imageHeight => widget.customImageHeight ?? (isMobile ? 180 : 200);

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
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAF5), // Light green background like in image
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          padding: EdgeInsets.only(
            top: isMobile ? 40.0 : 80.0,
            bottom: isMobile ? 40.0 : 80.0,
          ),
          child: Center(
            child: Container(
              width: maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInsuranceGrid(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInsuranceGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildNewHeader(),
        SizedBox(height: 30),
        _buildInsuranceCards(),
      ],
    );
  }

  Widget _buildNewHeader() {
    return FadeTransition(
      opacity: _headerFadeAnimation,
      child: SlideTransition(
        position: _headerSlideAnimation,
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/find_insurance.svg', width: 45, height: 50),
            SizedBox(height: 12),
            // Title
            Text.rich(
              TextSpan(
                text: 'Yuk, temukan ',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: isMobile ? 20 : 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
                children: [
                  TextSpan(
                    text: 'asuransi',
                    style: const TextStyle(
                      color: Color(0xFF91DA2D),
                    ),
                  ),
                  const TextSpan(
                    text: ' yang pas buat kamu!',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            // Subtitle
            Container(
              child: Text(
                'Dari kendaraan sampai pendidikan, semua bisa kamu lindungi dengan mudah, cepat, dan harga yang bersahabat.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: isMobile ? 15 : 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFA6A6A6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceCards() {
    final categories = [
      {'image': 'assets/images/asuransi_mobil.png'},
      {'image': 'assets/images/asuransi_kesehatan.png'},
      {'image': 'assets/images/asuransi_jiwa.png'},
      {'image': 'assets/images/asuransi_perjalanan.png'},
      {'image': 'assets/images/asuransi_properti.png'},
      {'image': 'assets/images/asuransi_pendidikan.png'},
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isMobile ? 12 : 24,
      runSpacing: isMobile ? 16 : 24,
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 800 + (index * 200)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _buildInsuranceCard(
                  imagePath: category['image']!,
                  index: index,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildInsuranceCard({
    required String imagePath,
    required int index,
  }) {
    return AnimatedInsuranceCard(
      imagePath: imagePath,
      isMobile: isMobile,
      width: imageWidth,
      height: imageHeight,
      fit: widget.imageFit,
      borderRadius: 12,
      onTap: () {
        // Handle tap action here
        debugPrint('Tapped on insurance card: $imagePath');
      },
    );
  }
}