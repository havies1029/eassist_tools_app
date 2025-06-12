import 'package:flutter/material.dart';
import 'decorations/AnimatedFeatureItem.dart';

const _primaryColor = Color(0xFF79AB43);
const _fontFamily = 'Satoshi-Regular';
const _textColor = Colors.black;
const _textColorSecondary = Colors.black54;
const _titleFontSizeMobile = 24.0;
const _titleFontSizeDesktop = 40.0;
const _descFontSizeMobile = 15.0;
const _descFontSizeDesktop = 20.0;
const _ratingFontSizeMobile = 16.0;
const _ratingFontSizeDesktop = 14.0;
const _italicFontSizeMobile = 16.0;
const _italicFontSizeDesktop = 17.0;
const _starColor = Color(0xFFFFD700);

class FeatureSection extends StatefulWidget {
  final BoxConstraints constraints;
  const FeatureSection({super.key, required this.constraints});

  @override
  State<FeatureSection> createState() => _FeatureSectionState();
}

class _FeatureSectionState extends State<FeatureSection> with TickerProviderStateMixin {
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

    _headerController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _titleController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _featuresController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    ));

    _headerSlideAnimation = Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutBack,
    ));

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _titleController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));

    _titleSlideAnimation = Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(CurvedAnimation(
      parent: _titleController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _titleScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _titleController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _featuresStaggerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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
      child: Center(
        child: Container(
          width: maxWidth,
          padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) _buildAnimatedHeader(),
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
                  const SizedBox(height: 20.0),
                  Expanded(child: Align(alignment: Alignment.topLeft, child: _buildAnimatedFeatureList())),
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
                  textAlign: isMobile ? TextAlign.left : TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: _fontFamily,
                      fontSize: isMobile ? 15.0 : 25.0,
                      color: _textColor,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: 'Kami Membantu Anda '),
                      TextSpan(
                        text: 'Terlindungi',
                        style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold),
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
      builder: (context, child) => _buildFeatureList(),
    );
  }

  Widget _buildFeatureTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: isMobile ? _titleFontSizeMobile : _titleFontSizeDesktop,
              fontWeight: FontWeight.bold,
              color: _textColor,
              height: 1.2,
            ),
            children: [
              const TextSpan(text: 'Bagaimana '),
              TextSpan(text: 'JPS', style: TextStyle(color: _primaryColor)),
              const TextSpan(text: ' Membantu Asuransi Anda Lebih Baik'),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 10.0 : 20.0),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Kami bantu menyampaikan solusi asuransi Anda lewat visual yang jelas, terpercaya, dan mudah dipahami oleh semua audiens.',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: isMobile ? _descFontSizeMobile : _descFontSizeDesktop,
              color: _textColorSecondary,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 10.0 : 20.0),
        Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < 5; i++)
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 200 + (i * 100)),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: const Icon(Icons.star, color: _starColor, size: 20.0),
                ),
              ),
            const SizedBox(width: 8.0),
            Text(
              '4.9 / 5 rating',
              style: TextStyle(
                fontSize: isMobile ? _ratingFontSizeMobile : _ratingFontSizeDesktop,
                fontWeight: FontWeight.w600,
                color: _textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Approved by Client JPS',
          style: TextStyle(
            fontSize: isMobile ? _italicFontSizeMobile : _italicFontSizeDesktop,
            color: _textColorSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: featureList
            .map((feature) => Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 8.0 : 18.0),
          child: AnimatedFeatureItem(
            icon: feature.icon,
            title: feature.title,
            description: feature.description,
            delay: feature.delay,
            animation: _featuresStaggerAnimation,
            isMobile: isMobile,
          ),
        ))
            .toList(),
      ),
    );
  }

  final List<_FeatureData> featureList = [
    _FeatureData(
      icon: Icons.info_outline,
      title: 'Menginformasikan. Melindungi. Meyakinkan.',
      description: 'Menyediakan informasi yang jelas, melindungi kepentingan Anda,\ndan memberikan rasa aman dalam setiap klaim asuransi.',
      delay: const Duration(milliseconds: 0),
    ),
    _FeatureData(
      icon: Icons.person_outline,
      title: 'Membangun Kepercayaan Klien',
      description: 'Klaim yang cepat dan transparan membangun kepercayaan penuh untuk setiap langkah perlindungan Anda.',
      delay: const Duration(milliseconds: 200),
    ),
    _FeatureData(
      icon: Icons.check_circle_outline,
      title: 'Menyederhanakan Info Asuransi',
      description: 'Proses klaim yang mudah dimengerti, mempermudah Anda dalam memahami hak dan perlindungan asuransi.',
      delay: const Duration(milliseconds: 400),
    ),
  ];
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final Duration delay;

  _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
  });
}
