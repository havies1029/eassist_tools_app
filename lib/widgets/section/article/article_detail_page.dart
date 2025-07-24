import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/gen_berita/berita2cari_bloc.dart';
import '../../../blocs/gen_berita/berita3cari_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../common/app_data.dart';
import '../../../models/gen_berita/berita2cari_model.dart';
import '../../../models/gen_berita/berita3cari_model.dart';
import '../../../pages/base/base_page.dart';

class ArticleDetailPage extends StatefulWidget {
  final BoxConstraints constraints;

  const ArticleDetailPage({
    super.key,
    required this.constraints,
  });

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};

  // Hover states untuk interactive elements
  int hoveredMenuIndex = -1;
  int hoveredSocialIndex = -1;
  int hoveredSidebarIndex = -1;
  bool hoveredBackButton = false;

  @override
  void initState() {
    super.initState();

    final berita1Id = AppData.berita1Id;
    debugPrint('🎯 Ambil dari AppData: $berita1Id');

    if (berita1Id != null) {
      context.read<Berita2CariBloc>().add(RefreshBerita2CariEvent(berita1Id: berita1Id));
      context.read<Berita3CariBloc>().add(RefreshBerita3CariEvent(berita1Id: berita1Id));

      // Langsung reset biar gak nyangkut
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppData.berita1Id = null;
        // AppData.gambarArtikel = null;
        debugPrint('🧹 AppData di-reset setelah frame');
      });
      debugPrint('🧹 AppData.berita1Id sudah di-reset ke null');
    } else {
      debugPrint("⚠️ berita1Id null di initState");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        child: BlocBuilder<Berita2CariBloc, Berita2CariState>(
          builder: (context, tocState) {
            return BlocBuilder<Berita3CariBloc, Berita3CariState>(
              builder: (context, contentState) {
                final tocItems = tocState.items;
                final sectionContents = contentState.items;

                // Initialize section keys
                for (final toc in tocItems) {
                  _sectionKeys[toc.berita2Id.toString()] = GlobalKey();
                }

                return isMobile
                    ? SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainArticle(tocItems, sectionContents, isMobile, isTablet),
                    ],
                  ),
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: _buildMainArticle(tocItems, sectionContents, isMobile, isTablet),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainArticle(
      List<Berita2CariModel> tocItems,
      List<Berita3CariModel> sectionContents,
      bool isMobile,
      bool isTablet,
      ) {
    // Responsive padding
    final double horizontalPadding = isMobile ? 16 : (isTablet ? 24 : 32);
    final double verticalPadding = isMobile ? 20 : (isTablet ? 24 : 32);

    return Container(
      margin: EdgeInsets.all(isMobile ? 8 : 16),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
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
          // Article Header
          _buildArticleHeader(isMobile, isTablet),
          SizedBox(height: isMobile ? 16 : 24),

          // Article Image (with proper scaling)
          _buildArticleImage(isMobile, isTablet),
          SizedBox(height: isMobile ? 16 : 24),

          // Table of Contents
          _buildTableOfContents(tocItems, isMobile, isTablet),
          SizedBox(height: isMobile ? 24 : 32),

          // Dynamic Content Sections
          ...sectionContents.map((section) {
            return Column(
              key: _sectionKeys[section.berita3Id.toString()],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildContentSection(
                  section.paragraf ?? 'Untitled Section',
                  [section.subjudul ?? 'No content available.'],
                  isMobile,
                  isTablet,
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),

          // Footer Social with Back Button
          SizedBox(height: isMobile ? 24 : 32),
          _buildFooterWithBackButton(isMobile, isTablet),
          SizedBox(height: isMobile ? 16 : 24),
          Container(height: 1, width: double.infinity, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildArticleHeader(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Article Title with responsive font size
        Text(
          AppData.JudulArtikel ?? 'Judul tidak tersedia',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: isMobile ? 22 : (isTablet ? 26 : 28),
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            height: 1.3,
          ),
        ),

        SizedBox(height: isMobile ? 12 : 16),

        // Author & Date + Social Actions - Responsive layout
        isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author Info
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.grey.shade600, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Admin · ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Social Actions
            Row(
              children: [
                _buildSocialIcon(Icons.bookmark_border, 0, isMobile, isTablet),
                const SizedBox(width: 8),
                _buildSocialIcon(Icons.share, 1, isMobile, isTablet),
                const SizedBox(width: 8),
                _buildSocialIcon(Icons.print, 2, isMobile, isTablet),
              ],
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Author Info
            Row(
              children: [
                CircleAvatar(
                  radius: isTablet ? 18 : 20,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.grey.shade600, size: isTablet ? 18 : 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Admin · ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isTablet ? 13 : 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            // Social Actions
            Row(
              children: [
                _buildSocialIcon(Icons.bookmark_border, 0, isMobile, isTablet),
                const SizedBox(width: 12),
                _buildSocialIcon(Icons.share, 1, isMobile, isTablet),
                const SizedBox(width: 12),
                _buildSocialIcon(Icons.print, 2, isMobile, isTablet),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArticleImage(bool isMobile, bool isTablet) {
    final imageUrl = AppData.gambarArtikel;
    final double imageHeight = isMobile ? 200 : (isTablet ? 260 : 300);
    final borderRadius = BorderRadius.circular(isMobile ? 8 : 12);

    return Row(
      children: [
        if (isMobile)
          Expanded(
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Container(
                height: imageHeight,
                color: Colors.white,
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : _buildImageFallback(isMobile, isTablet),
              ),
            ),
          )
        else
          Flexible(
            flex: isTablet ? 3 : 1, // Tablet 60%, Desktop 50%
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Container(
                height: imageHeight,
                color: Colors.white,
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(imageUrl, fit: BoxFit.contain)
                    : _buildImageFallback(isMobile, isTablet),
              ),
            ),
          ),
        if (!isMobile) Spacer(),
      ],
    );
  }


  Widget _buildImageFallback(bool isMobile, bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF79AB43).withOpacity(0.1),
            const Color(0xFF79AB43).withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)), // <— tambahkan ini
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.article,
            size: isMobile ? 48 : (isTablet ? 56 : 64),
            color: const Color(0xFF79AB43),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Article Image Placeholder',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: const Color(0xFF79AB43),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '🔗 ${AppData.gambarArtikel ?? "URL kosong"}',
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(String title, List<String> paragraphs, bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: isMobile ? 13 : (isTablet ? 15 : 16),
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildTableOfContents(List<Berita2CariModel> tocItems, bool isMobile, bool isTablet) {
    if (tocItems.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Isi',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 12 : (isTablet ? 14 : 16),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          ...tocItems.asMap().entries.map((entry) {
            int index = entry.key;
            final item = entry.value;
            return MouseRegion(
              onEnter: (_) => setState(() => hoveredMenuIndex = index),
              onExit: (_) => setState(() => hoveredMenuIndex = -1),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _scrollToSection(item.berita2Id.toString()),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 8 : 6,
                      horizontal: isMobile ? 8 : 12
                  ),
                  decoration: BoxDecoration(
                    color: hoveredMenuIndex == index
                        ? Colors.white.withOpacity(0.7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}.',
                        style: TextStyle(
                          fontFamily: 'Satoshi-Regular',
                          fontSize: isMobile ? 11 : 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.subjudul ?? 'Untitled',
                          style: TextStyle(
                            fontFamily: 'Satoshi-Regular',
                            fontSize: isMobile ? 11 : 12,
                            color: hoveredMenuIndex == index
                                ? const Color(0xFF79AB43)
                                : Colors.grey.shade700,
                            fontWeight: hoveredMenuIndex == index
                                ? FontWeight.w500
                                : FontWeight.w400,
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

  Widget _buildSocialIcon(IconData icon, int index, bool isMobile, bool isTablet) {
    final double iconSize = isMobile ? 16 : (isTablet ? 17 : 18);
    final double padding = isMobile ? 8 : 10;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSocialIndex = index),
      onExit: (_) => setState(() => hoveredSocialIndex = -1),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleSocialAction(icon),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: hoveredSocialIndex == index
                ? const Color(0xFF79AB43)
                : Colors.transparent,
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
            size: iconSize,
            color: hoveredSocialIndex == index
                ? Colors.white
                : const Color(0xFF79AB43),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(bool isMobile, bool isTablet) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredBackButton = true),
      onExit: (_) => setState(() => hoveredBackButton = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleBackAction(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 10
          ),
          decoration: BoxDecoration(
            color: hoveredBackButton
                ? const Color(0xFF79AB43)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF79AB43),
              width: 1,
            ),
            boxShadow: hoveredBackButton
                ? [
              BoxShadow(
                color: const Color(0xFF79AB43).withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                size: isMobile ? 16 : 18,
                color: hoveredBackButton
                    ? Colors.white
                    : const Color(0xFF79AB43),
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Flexible(
                child: Text(
                  isMobile ? 'Kembali' : 'Kembali ke Halaman Literasi',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: hoveredBackButton
                        ? Colors.white
                        : const Color(0xFF79AB43),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterWithBackButton(bool isMobile, bool isTablet) {
    final icons = [Icons.bookmark_border, Icons.share, Icons.print];

    return isMobile
        ? Column(
      children: [
        // Social Icons for mobile
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: icons.asMap().entries.map((entry) {
            int index = entry.key;
            IconData icon = entry.value;
            return Padding(
              padding: EdgeInsets.only(right: index < icons.length - 1 ? 16 : 0),
              child: _buildSocialIcon(icon, index + 100, isMobile, isTablet),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // Back Button for mobile
        Center(child: _buildBackButton(isMobile, isTablet)),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Social Icons
        Row(
          children: icons.asMap().entries.map((entry) {
            int index = entry.key;
            IconData icon = entry.value;
            return Padding(
              padding: EdgeInsets.only(right: index < icons.length - 1 ? 12 : 0),
              child: _buildSocialIcon(icon, index + 100, isMobile, isTablet),
            );
          }).toList(),
        ),

        // Back Button
        _buildBackButton(isMobile, isTablet),
      ],
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

  void _handleSocialAction(IconData icon) {
    // Implement social actions
    if (icon == Icons.bookmark_border) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Artikel disimpan')),
      );
    } else if (icon == Icons.share) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Artikel dibagikan')),
      );
    } else if (icon == Icons.print) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Artikel dicetak')),
      );
    }
  }

  void _handleBackAction() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // context.read<HomeBloc>().add(ArticlePageActiveEvent());
      context.read<HomeBloc>().add(PushPageEvent(PageType.article));
    });
  }

  void _handleSidebarArticleTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Membuka: $title')),
    );
  }
}