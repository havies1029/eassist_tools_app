import 'package:flutter/material.dart';

class ArtikelCard extends StatefulWidget {
  final BoxConstraints constraints;

  const ArtikelCard({super.key, required this.constraints});

  @override
  State<ArtikelCard> createState() => _ArtikelCardState();
}

class _ArtikelCardState extends State<ArtikelCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _scaleAnimation;

  bool _isButtonHovering = false;

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
    return Container(
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : 800,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 4,
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }


  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              width: 620,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(40.0),
              child: _buildContent(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Image.asset(
              'assets/images/about_5.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 410.0,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ARTIKEL',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
            color: const Color(0xFF79AB43),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Jangan Lewatkan Artikel Informatif Seputar Asuransi dari JPS!',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 32.0,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF79AB43),
            height: 1.3,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Temukan wawasan menarik, tips bermanfaat, dan panduan praktis tentang asuransi dalam artikel-artikel kami.',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF79AB43),
            height: 1.6,
          ),
        ),
        SizedBox(height: 24.0),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isButtonHovering = true),
          onExit: (_) => setState(() => _isButtonHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            transform: _isButtonHovering
                ? (Matrix4.identity()..scale(1.045))
                : Matrix4.identity(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: _isButtonHovering
                  ? const Color(0xFFE27430)
                  : const Color(0xFFFF8C42),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8C42).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Baca Sekarang',
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildImage() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(20.0),
          bottomRight: const Radius.circular(20.0),
          topLeft: isMobile ? const Radius.circular(20.0) : const Radius.circular(0),
          bottomLeft: isMobile ? const Radius.circular(20.0) : const Radius.circular(0),
        ),
        child: Image.asset(
            'assets/images/about_5.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: isMobile ? 200.0 : 410.0,
            ),
        );
    }
}