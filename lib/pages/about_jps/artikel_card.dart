import 'package:flutter/material.dart';

class ArtikelCard extends StatefulWidget {
  final BoxConstraints constraints;

  const ArtikelCard({super.key, required this.constraints});

  @override
  State<ArtikelCard> createState() => _ArtikelCardState();
}

class _ArtikelCardState extends State<ArtikelCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _hoverController;

  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _scaleAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxWidth => widget.constraints.maxWidth > 1300 ? 1200 : widget.constraints.maxWidth * 0.9;

  double get contentPadding => isMobile ? 16.0 : 32.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _hoverController.dispose();
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
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40.0 : 60.0,
            horizontal: contentPadding,
          ),
          child: Center(
            child: Container(
              width: maxWidth,
              child: SlideTransition(
                position: _slideInAnimation,
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildArtikelCard(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildArtikelCard() {
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_hoverController.value * 0.02),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 800,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08 + (_hoverController.value * 0.04)),
                    spreadRadius: 2 + (_hoverController.value * 3),
                    blurRadius: 20 + (_hoverController.value * 10),
                    offset: Offset(0, 8 + (_hoverController.value * 6)),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04 + (_hoverController.value * 0.02)),
                    spreadRadius: 4 + (_hoverController.value * 2),
                    blurRadius: 30 + (_hoverController.value * 15),
                    offset: Offset(0, 12 + (_hoverController.value * 8)),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        _buildContent(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildContent(),
        ),
        Expanded(
          flex: 1,
          child: _buildImage(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24.0 : 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge ARTIKEL
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Text(
              'ARTIKEL',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: isMobile ? 10.0 : 18.0,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF79AB43),
                letterSpacing: 0.5,
              ),
            ),
          ),

          SizedBox(height: isMobile ? 16.0 : 20.0),

          // Title
          Text(
            'Jangan Lewatkan Artikel Informatif Seputar Asuransi dari JPS!',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 32.0 : 40.0,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF79AB43),
              height: 1.3,
            ),
          ),

          SizedBox(height: isMobile ? 12.0 : 16.0),

          // Description
          Text(
            'Temukan wawasan menarik, tips bermanfaat, dan panduan praktis tentang asuransi dalam artikel-artikel kami.',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 18.0 : 20.0,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF79AB43),
              height: 1.6,
            ),
          ),

          SizedBox(height: isMobile ? 20.0 : 24.0),

          // Button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFF8C42),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF8C42).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Baca Sekarang',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: isMobile ? 14.0 : 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: isMobile ? 200.0 : 410.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: isMobile ? const Radius.circular(0) : const Radius.circular(0),
          topRight: const Radius.circular(20.0),
          bottomLeft: isMobile ? const Radius.circular(0) : const Radius.circular(0),
          bottomRight: const Radius.circular(20.0),
        ),
        child: Image.asset(
          'assets/images/about_5.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}