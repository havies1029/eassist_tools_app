import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/article_page/article_detail.dart';
import 'article_content.dart';

class ArticleListPage extends StatefulWidget {
  final BoxConstraints constraints;

  const ArticleListPage({super.key, required this.constraints});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  int hoveredMainIndex = -1;
  int hoveredSideIndex = -1;
  int hoveredSidebarIndex = -1;

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'teknologi':
        return const Color(0xFF3B82F6);
      case 'lingkungan':
        return const Color(0xFF10B981);
      case 'bisnis':
        return const Color(0xFF8B5CF6);
      case 'pendidikan':
        return const Color(0xFFEF4444);
      case 'ekonomi':
        return const Color(0xFFF59E0B);
      case 'budaya':
        return const Color(0xFFEC4899);
      case 'infrastruktur':
        return const Color(0xFF6B7280);
      case 'kesehatan':
        return const Color(0xFF06B6D4);
      case 'olahraga':
        return const Color(0xFFEAB308);
      default:
        return const Color(0xFF79AB43);
    }
  }

  Widget buildMainArticleCard(Map<String, String> article, int index) {
    final bool isHovered = hoveredMainIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredMainIndex = index),
      onExit: (_) => setState(() => hoveredMainIndex = -1),
      child: GestureDetector(
        onTap: () {
          debugPrint('Klik artikel utama: ${article['title']}');
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ArticleDetailMain()),
            ); // 👈 arahkan hanya untuk artikel pertama
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.1),
                blurRadius: isHovered ? 20 : 10,
                offset: Offset(0, isHovered ? 10 : 5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                Image.asset(
                  article['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback gradient if image not found
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF79AB43).withOpacity(0.8),
                            const Color(0xFF79AB43),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Dark Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Content Overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          article['title']!,
                          style: const TextStyle(
                            fontFamily: 'Satoshi-Regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article['date']!,
                          style: TextStyle(
                            fontFamily: 'Satoshi-Regular',
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Hover Effect
                if (isHovered)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF79AB43).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSideArticleItem(Map<String, String> article, int index) {
    final bool isHovered = hoveredSideIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSideIndex = index),
      onExit: (_) => setState(() => hoveredSideIndex = -1),
      child: GestureDetector(
        onTap: () {
          debugPrint('Klik artikel sampingan: ${article['title']}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF79AB43).withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered
                  ? const Color(0xFF79AB43).withOpacity(0.2)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    article['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback gradient if image not found
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF79AB43).withOpacity(0.6),
                              const Color(0xFF79AB43),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.article,
                          color: Colors.white,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title']!,
                      style: const TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sumber: ${article['source']!}',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSidebarArticleItem(Map<String, String> article, int index) {
    final bool isHovered = hoveredSidebarIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSidebarIndex = index),
      onExit: (_) => setState(() => hoveredSidebarIndex = -1),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => debugPrint('Sidebar tapped: ${article['title']}'),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF79AB43).withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered
                  ? const Color(0xFF79AB43).withOpacity(0.2)
                  : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title']!,
                style: const TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF79AB43),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      article['category']!,
                      style: const TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.menu_book, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    article['readTime']!,
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double constraintWidth = widget.constraints.maxWidth;
    final bool isMobile = constraintWidth < 768;
    final bool isTablet = constraintWidth >= 768 && constraintWidth < 1024;
    final double maxWidth = constraintWidth > 1300 ? 1200.0 : constraintWidth * 0.9;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40.0 : 60.0,
            horizontal: isMobile ? 16.0 : 0,
          ),
          physics: const BouncingScrollPhysics(),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Cerita Besar - Mobile
              const Text(
                'Cerita Besar',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Mobile: Single column with landscape cards
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mainArticles.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) => Container(
                  height: 200, // Fixed height for mobile landscape cards
                  child: buildMainArticleCard(mainArticles[index], index),
                ),
              ),
              const SizedBox(height: 40),

              // Section Cerita Lainnya - Mobile (adaptif berdasarkan lebar)
              const Text(
                'Cerita Lainnya',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Cek apakah layar cukup lebar untuk 2 kolom
              constraintWidth < 500
                  ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sideArticles.length,
                itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
              )
                  : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.5, // Wide ratio for mobile side articles
                ),
                itemCount: sideArticles.length,
                itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
              ),
              const SizedBox(height: 40),

              // Section Artikel Lainnya - Mobile (sidebar articles)
              const Text(
                'Artikel Lainnya',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sidebarArticles.length,
                itemBuilder: (context, index) => buildSidebarArticleItem(sidebarArticles[index], index),
              ),
            ],
          )
              : isTablet
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Cerita Besar - Tablet
              const Text(
                'Cerita Besar',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Tablet: 2 columns with landscape cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.6, // Landscape ratio
                ),
                itemCount: mainArticles.length,
                itemBuilder: (context, index) => buildMainArticleCard(mainArticles[index], index),
              ),
              const SizedBox(height: 40),

              // Section Cerita Lainnya - Tablet (2 kolom untuk sideArticles)
              const Text(
                'Cerita Lainnya',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3.0, // Wide ratio for side articles
                ),
                itemCount: sideArticles.length,
                itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
              ),
              const SizedBox(height: 40),

              // Section Artikel Lainnya - Tablet (sidebar articles)
              const Text(
                'Artikel Lainnya',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.5, // Aspect ratio for tablet sidebar articles
                ),
                itemCount: sidebarArticles.length,
                itemBuilder: (context, index) => buildSidebarArticleItem(sidebarArticles[index], index),
              ),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom Kiri - Cerita Besar + Cerita Lainnya (Desktop)
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cerita Besar',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Desktop: 2 columns with landscape cards
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.4, // Landscape ratio for desktop
                      ),
                      itemCount: mainArticles.length,
                      itemBuilder: (context, index) => buildMainArticleCard(mainArticles[index], index),
                    ),
                    const SizedBox(height: 40),

                    // Section Cerita Lainnya - Desktop (2 kolom untuk sideArticles)
                    const Text(
                      'Cerita Lainnya',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3.5, // Wide ratio for desktop side articles
                      ),
                      itemCount: sideArticles.length,
                      itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 32),

              // Kolom Kanan - Artikel Lainnya (Desktop)
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Artikel Lainnya',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sidebarArticles.length,
                      itemBuilder: (context, index) => buildSidebarArticleItem(sidebarArticles[index], index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}