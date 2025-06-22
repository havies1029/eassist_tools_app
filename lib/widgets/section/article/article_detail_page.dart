
// article_detail_page.dart
// Isi ini identik dengan ActionSection dari referensi user,
// tinggal digunakan di dalam widget ActionSection di file berbeda jika mau.

import 'package:flutter/material.dart';
import 'article_content.dart';

class ArticleDetailPage extends StatefulWidget {
  final BoxConstraints constraints;

  const ArticleDetailPage({super.key, required this.constraints});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> with TickerProviderStateMixin {
  int hoveredIndex = -1;
  int hoveredMenuIndex = -1;
  int hoveredSocialIndex = -1;

  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    for (var item in tocItems) item['id']!: GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    final double constraintWidth = widget.constraints.maxWidth;
    final bool isMobile = constraintWidth < 768;
    final double maxWidth = constraintWidth > 1300 ? 1200.0 : constraintWidth * 0.9;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: isMobile
            ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainArticle(),
              const SizedBox(height: 32.0),
              _buildSidebar(),
            ],
          ),
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 7, child: _buildMainArticle()),
            const SizedBox(width: 32.0),
            Expanded(flex: 3, child: _buildSidebar()),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.4,
      );
    }
  }

  Widget _buildMainArticle() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            articleTitle,
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, color: Colors.grey.shade600, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$articleAuthor · $articleDate',
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSocialIcon(Icons.bookmark_border, 0),
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.facebook, 1),
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.camera_alt, 2),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              articleImagePath,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 280,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(Icons.image, size: 64, color: Colors.grey.shade400),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          _buildTableOfContents(isMobile: widget.constraints.maxWidth < 768),
          const SizedBox(height: 32),
          ...sectionContents.entries.map((entry) {
            final id = entry.key;
            final section = entry.value;
            return Column(
              key: _sectionKeys[id],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildContentSection(section['title'], List<String>.from(section['paragraphs'])),
                if (section.containsKey('bullets'))
                  Column(
                    children: List<String>.from(section['bullets']).map((b) => _bullet(b)).toList(),
                  ),
              ],
            );
          }).toList(),
          const SizedBox(height: 32),
          _buildFooterSocial(),
          const SizedBox(height: 24),
          Container(height: 1, width: double.infinity, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildContentSection(String title, List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        ...paragraphs.map((p) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            p,
            style: const TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        )),
      ],
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 12),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF79AB43),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableOfContents({required bool isMobile}) {
    return Container(
      width: isMobile ? double.infinity : null,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daftar Isi',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...tocItems.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;
            return MouseRegion(
              onEnter: (_) => setState(() => hoveredMenuIndex = index),
              onExit: (_) => setState(() => hoveredMenuIndex = -1),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _scrollToSection(item['id']!),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: hoveredMenuIndex == index ? Colors.white.withOpacity(0.7) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}.',
                        style: const TextStyle(
                          fontFamily: 'Satoshi-Regular',
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item['title']!,
                          style: TextStyle(
                            fontFamily: 'Satoshi-Regular',
                            fontSize: 12,
                            color: hoveredMenuIndex == index ? const Color(0xFF79AB43) : Colors.grey.shade700,
                            fontWeight: hoveredMenuIndex == index ? FontWeight.w500 : FontWeight.w400,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSocialIndex = index),
      onExit: (_) => setState(() => hoveredSocialIndex = -1),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => debugPrint('Icon tapped: $icon'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: hoveredSocialIndex == index ? const Color(0xFF79AB43) : Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: hoveredSocialIndex == index
                ? [
              BoxShadow(
                color: const Color(0xFF79AB43).withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
                : [],
          ),
          child: Icon(
            icon,
            size: 18,
            color: hoveredSocialIndex == index ? Colors.white : const Color(0xFF79AB43),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterSocial() {
    final icons = [Icons.bookmark_border, Icons.facebook, Icons.camera_alt];
    return Row(
      children: icons.asMap().entries.map((entry) {
        int index = entry.key;
        IconData icon = entry.value;
        return Padding(
          padding: EdgeInsets.only(right: index < icons.length - 1 ? 12 : 0),
          child: _buildSocialIcon(icon, index + 100),
        );
      }).toList(),
    );
  }

  Widget _buildSidebar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          )
        ],
      ),
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
          ...sidebarArticles.asMap().entries.map((entry) {
            int index = entry.key;
            var article = entry.value;
            return MouseRegion(
              onEnter: (_) => setState(() => hoveredIndex = index),
              onExit: (_) => setState(() => hoveredIndex = -1),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => debugPrint('Sidebar tapped: ${article['title']}'),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: hoveredIndex == index ? const Color(0xFF79AB43).withOpacity(0.05) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: hoveredIndex == index
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
          }).toList(),
        ],
      ),
    );
  }
}
