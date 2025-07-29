import 'package:flutter/material.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/article/action_article_section2.dart';
import '../../widgets/section/article/article_detail_page.dart';
import '../base/base_page.dart';

class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

// ✅ Terima berita1Id dan teruskan ke ArticlePage
class ArticleDetailMain extends StatelessWidget {

  const ArticleDetailMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF79AB43),
        scaffoldBackgroundColor: const Color(0xFFD5F4B4),
        fontFamily: 'Satoshi-Regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 16.0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ArticlePage(), // ⬅️ kirim ke ArticlePage
    );
  }
}

// ✅ Terima berita1Id dan teruskan ke ArticleDetailPage
class ArticlePage extends StatelessWidget {

  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = MediaQuery.of(context).size.width < 768;

          return Stack(
            children: [
              // Layer 1: Background
              Positioned.fill(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/article_home.png',
                      fit: isMobile ? BoxFit.fitHeight : BoxFit.cover,
                      alignment: isMobile ? Alignment.topCenter : const Alignment(0, 3),
                      cacheWidth: isMobile ? 720 : 1440,
                      cacheHeight: isMobile ? 960 : 800,
                    ),
                    if (!isMobile)
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black54,
                              Colors.black26,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 0.9],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Overlay semi gelap
              Container(
                color: Colors.black.withOpacity(0.4),
              ),

              // Layer 2: Konten scroll
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: isMobile ? 52 : 62),
                  child: Column(
                    children: [
                      // HeroSection(constraints: constraints, sectionType: SectionType.article),
                      // FloatingButtons(constraints: constraints),
                      ActionSection2(constraints: constraints),
                      // ArticleDetailPage( // ⬅️ KIRIM berita1Id ke sini
                      //   constraints: constraints,
                      //   berita1Id: berita1Id,
                      // ),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Navbar tetap di atas
              const _FixedNavbarOverlay(),
            ],
          );
        },
      ),
    );
  }
}

class _FixedNavbarOverlay extends StatelessWidget {
  const _FixedNavbarOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 20,
            child: NavbarWidget(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              pageType: PageType.article1,
            ),
          ),
        ],
      ),
    );
  }
}
