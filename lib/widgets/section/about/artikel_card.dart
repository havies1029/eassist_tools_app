import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArtikelCard extends StatefulWidget {
  final BoxConstraints constraints;

  const ArtikelCard({
    super.key,
    required this.constraints,
  });

  @override
  State<ArtikelCard> createState() => _ArtikelCardState();
}

class _ArtikelCardState extends State<ArtikelCard> with TickerProviderStateMixin {
  // CONSTANTS - Font Sizes, Colors, and Styles
  static const String _fontFamily = 'Satoshi-Regular';
  static const Color _primaryColor = Color(0xFF79AB43);
  static const Color _backgroundColor = Color(0xFFFFFFFF);
  static const Color _textPrimaryColor = Colors.black;

  // Font Sizes
  static const double _titleFontSizeMobile = 24.0;
  static const double _titleFontSizeDesktop = 27.0;
  static const double _subtitleFontSizeMobile = 14.0;
  static const double _subtitleFontSizeDesktop = 16.0;
  static const double _cardTitleFontSizeMobile = 15.0;
  static const double _cardTitleFontSizeDesktop = 18.0;
  static const double _cardDescFontSizeMobile = 13.0;
  static const double _cardDescFontSizeDesktop = 16.0;
  static const double _cardDateFontSizeMobile = 12.0;
  static const double _cardDateFontSizeDesktop = 16.0;
  static const double _readMoreFontSizeMobile = 13.0;
  static const double _readMoreFontSizeDesktop = 18.0;

  // Animation and Timer Controllers
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  bool _isHovering = false;
  double _currentPageValue = 1000.0;
  late AnimationController _hoverAnimationController;
  late Animation<double> _hoverAnimation;

  // Layout Properties
  double get maxWidth => widget.constraints.maxWidth > 1200
      ? 1200
      : widget.constraints.maxWidth * 0.95;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth < 1024;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializePageController();
    _setupPageListener();
    _startAutoScrollTimer();
  }

  void _initializeAnimations() {
    _hoverAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void _initializePageController() {
    double maxWidth = widget.constraints.maxWidth;
    double fraction;

    if (maxWidth < 600) {
      fraction = 360 / maxWidth;
    } else if (maxWidth < 900) {
      fraction = (360 * 2) / maxWidth;
    } else if (maxWidth < 1200) {
      fraction = (360 * 3) / maxWidth;
    } else {
      fraction = 0.25;
    }

    _pageController = PageController(
      initialPage: 1000,
      viewportFraction: fraction > 1 ? 1 : fraction,
    );
  }

  void _setupPageListener() {
    _pageController.addListener(() {
      if (_pageController.hasClients) {
        setState(() {
          _currentPageValue = _pageController.page ?? 1000.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
  }

  void _startAutoScrollTimer() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_isHovering && _pageController.hasClients && mounted) {
        final nextPage = _pageController.page!.toInt() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _pauseTimer() => _autoScrollTimer?.cancel();
  void _resumeTimer() => _startAutoScrollTimer();

  void _onHoverEnter() {
    setState(() => _isHovering = true);
    _hoverAnimationController.forward();
    _pauseTimer();
  }

  void _onHoverExit() {
    setState(() => _isHovering = false);
    _hoverAnimationController.reverse();
    _resumeTimer();
  }

  double _getScale(int index) {
    final distance = (_currentPageValue - index).abs();
    if (distance <= 1.0) {
      return 1.0 - (distance * 0.1);
    }
    return 0.9;
  }

  double _getOpacity(int index) {
    final distance = (_currentPageValue - index).abs();
    if (distance <= 1.0) {
      return 1.0 - (distance * 0.3);
    }
    return 0.7;
  }

  TextStyle _getTextStyle({
    required double mobileFontSize,
    required double desktopFontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: isMobile ? mobileFontSize : desktopFontSize,
      fontFamily: _fontFamily,
      fontWeight: fontWeight,
      color: color ?? _textPrimaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _backgroundColor,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40 : 80,
            horizontal: isMobile ? 35 : 40,
          ),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: isMobile ? 30 : 50),
              _buildCarouselWithInteractions(),
              SizedBox(height: isMobile ? 20 : 30),
              _buildPageIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: _getTextStyle(
              mobileFontSize: _titleFontSizeMobile,
              desktopFontSize: _titleFontSizeDesktop,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(text: 'Baca '),
              TextSpan(
                text: 'Artikel ',
                style: TextStyle(color: _primaryColor),
              ),
              TextSpan(text: 'Terbaru Kami'),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 8 : 20),
        Text(
          'Kami sajikan berita, panduan, dan edukasi asuransi yang relevan untuk Anda.',
          textAlign: TextAlign.center,
          style: _getTextStyle(
            mobileFontSize: _subtitleFontSizeMobile,
            desktopFontSize: _subtitleFontSizeDesktop,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselWithInteractions() {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            if (pointerSignal.scrollDelta.dx > 0) {
              final nextPage = _pageController.page!.toInt() + 1;
              _pageController.animateToPage(
                nextPage,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else if (pointerSignal.scrollDelta.dx < 0) {
              final prevPage = _pageController.page!.toInt() - 1;
              _pageController.animateToPage(
                prevPage,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: AnimatedBuilder(
          animation: _hoverAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _hoverAnimation.value,
              child: _buildArticlesCarousel(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildArticlesCarousel() {
    return SizedBox(
      height: isMobile ? 450 : (isTablet ? 480 : 550),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index % _getArticlesData().length;
            });
          },
          itemBuilder: (context, index) {
            final articles = _getArticlesData();
            final realIndex = index % articles.length;
            final scale = _getScale(index);
            final opacity = _getOpacity(index);
            final isCenter = (_currentPageValue - index).abs() < 0.5;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 5.0 : 0.0),
              child: Transform.scale(
                scale: scale,
                child: SizedBox(
                  width: 360,
                  child: _buildArticleCard(
                    articles[realIndex],
                    isCenter,
                    opacity,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildArticleCard(ArticleData article, bool isCenter, double opacity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isCenter ? [] : [],
      ),
      child: Opacity(
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArticleImage(article),
            _buildArticleContent(article),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleImage(ArticleData article) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
        height: isMobile ? 160 : 280,
        width: double.infinity,
        color: Colors.grey[200],
        child: Image.asset(
          article.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(
                Icons.image,
                size: 50,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildArticleContent(ArticleData article) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.constraints.maxWidth >= 1200 ? 15 : 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.date,
              style: _getTextStyle(
                mobileFontSize: _cardDateFontSizeMobile,
                desktopFontSize: _cardDateFontSizeDesktop,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            Text(
              article.title,
              style: _getTextStyle(
                mobileFontSize: _cardTitleFontSizeMobile,
                desktopFontSize: _cardTitleFontSizeDesktop,
                fontWeight: FontWeight.bold,
              ).copyWith(height: 1.3),
              maxLines: 2,
            ),
            SizedBox(height: isMobile ? 12 : 15),
            Expanded(
              child: Text(
                article.description,
                style: _getTextStyle(
                  mobileFontSize: _cardDescFontSizeMobile,
                  desktopFontSize: _cardDescFontSizeDesktop,
                  color: Colors.grey[600],
                ).copyWith(height: 1.4),
                maxLines: 3,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            _buildReadMoreButton(article),
          ],
        ),
      ),
    );
  }

  Widget _buildReadMoreButton(ArticleData article) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => _onReadMoreTapped(article),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Selengkapnya',
              style: _getTextStyle(
                mobileFontSize: _readMoreFontSizeMobile,
                desktopFontSize: _readMoreFontSizeDesktop,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.arrow_forward,
              size: 14,
              color: _textPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _getArticlesData().length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _currentPage == index ? 24.0 : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: _currentPage == index
                ? _primaryColor
                : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // API INTEGRATION SECTION
  // ============================================================================

  /// Method untuk handle read more button tap
  /// TODO: Implement navigation to article detail page
  void _onReadMoreTapped(ArticleData article) {
    print('Read more: ${article.title}');
    // TODO: Navigate to article detail page
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => ArticleDetailPage(articleId: article.id)
    // ));
  }

  /// Method untuk mendapatkan data artikel
  /// TODO: Replace with API call
  List<ArticleData> _getArticlesData() {
    // TODO: Implement API call to fetch articles
    // return await ArticleService.getArticles();

    // Hardcoded data for now
    return [
      ArticleData(
        id: "1",
        date: "12/12/2020",
        title: "Apa Itu JPS? Mengenal Jenis Perlindungan Mikro yang Ramah Masyarakat",
        description: "Pelajari solusi asuransi mikro dari JPS yang hadir untuk memberikan rasa aman tanpa ribet, cocok untuk individu maupun UMKM.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "2",
        date: "15/12/2020",
        title: "Panduan Lengkap Memilih Asuransi Kesehatan untuk Keluarga",
        description: "Tips memilih asuransi kesehatan yang tepat untuk melindungi keluarga dari risiko medis yang tidak terduga.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "3",
        date: "18/12/2020",
        title: "Mengapa UMKM Perlu Asuransi? Ini Alasannya",
        description: "Pentingnya proteksi bisnis untuk UMKM agar dapat bertahan dalam situasi ekonomi yang tidak menentu.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "4",
        date: "22/12/2020",
        title: "Tips Klaim Asuransi yang Mudah dan Cepat",
        description: "Panduan step-by-step untuk melakukan klaim asuransi dengan mudah dan mendapatkan pencairan yang cepat.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "5",
        date: "25/12/2020",
        title: "Investasi vs Asuransi: Mana yang Lebih Penting?",
        description: "Memahami perbedaan investasi dan asuransi serta bagaimana keduanya dapat melengkapi perencanaan keuangan Anda.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "6",
        date: "28/12/2020",
        title: "Asuransi Jiwa: Perlindungan Terbaik untuk Masa Depan",
        description: "Kenali berbagai jenis asuransi jiwa dan manfaatnya untuk memberikan rasa aman bagi keluarga tercinta.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "7",
        date: "30/12/2020",
        title: "Cara Menghitung Premi Asuransi yang Tepat",
        description: "Panduan praktis menghitung besaran premi asuransi yang sesuai dengan kemampuan finansial dan kebutuhan proteksi.",
        imageUrl: "assets/images/artikel1.png",
      ),
      ArticleData(
        id: "8",
        date: "02/01/2021",
        title: "Tren Asuransi Digital di Era Modern",
        description: "Bagaimana teknologi digital mengubah industri asuransi dan memberikan kemudahan akses bagi masyarakat.",
        imageUrl: "assets/images/artikel1.png",
      ),
    ];
  }
}

/// Data model untuk artikel
/// TODO: Add more fields as needed for API integration
class ArticleData {
  final String id; // Added for API integration
  final String date;
  final String title;
  final String description;
  final String imageUrl;

  ArticleData({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  /// Factory constructor untuk parsing dari JSON API response
  /// TODO: Implement JSON parsing
  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  /// Method untuk convert ke JSON untuk API request
  /// TODO: Implement if needed for POST/PUT operations
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description,
      'image_url': imageUrl,
    };
  }
}