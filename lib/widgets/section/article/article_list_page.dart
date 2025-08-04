import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/gen_berita/berita1cari_bloc.dart';
import '../../../blocs/gen_berita/berita2cari_bloc.dart';
import '../../../blocs/gen_berita/berita3cari_bloc.dart';
import '../../../blocs/gen_berita/beritakecilcari_bloc.dart';
import '../../../blocs/gen_berita/beritalaincari_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../common/app_data.dart';
import '../../../common/constants.dart';
import '../../../models/gen_berita/berita1cari_model.dart';
import '../../../pages/article_page/article_detail.dart';
import '../../../pages/base/base_page.dart';
import 'article_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<Berita1CariBloc>().add(const RefreshBerita1CariEvent(1));
    context.read<BeritaKecilCariBloc>().add(const RefreshBeritaKecilCariEvent(2));
    context.read<BeritaLainCariBloc>().add(const RefreshBeritaLainCariEvent(3));
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Berita1CariBloc, Berita1CariState>(
      builder: (context, state1) {
        return BlocBuilder<BeritaKecilCariBloc, BeritaKecilCariState>(
          builder: (context, state2) {
            return BlocBuilder<BeritaLainCariBloc, BeritaLainCariState>(
              builder: (context, state3) {
                final mainArticles = state1.items;
                final sideArticles = state2.items;
                final sidebarArticles = state3.items;

                final double constraintWidth = widget.constraints.maxWidth;
                final bool isMobile = constraintWidth < 768;
                final bool isTablet = constraintWidth >= 768 && constraintWidth < 1024;
                final double maxWidth = constraintWidth > 1300
                    ? 1200.0
                    : constraintWidth * 0.9;

                final isLoading = (state1.status == ListStatus.loading &&
                    state2.status == ListStatus.loading &&
                    state3.status == ListStatus.loading) &&
                    mainArticles.isEmpty &&
                    sideArticles.isEmpty &&
                    sidebarArticles.isEmpty;

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 60 : isTablet? 70 : 80,
                        horizontal: isMobile ? 10 : isTablet? 10 : 30,
                      ),
                      physics: const BouncingScrollPhysics(),
                      child: isMobile
                          ? buildMobileLayout(mainArticles, sideArticles, sidebarArticles, constraintWidth)
                          : isTablet
                          ? buildTabletLayout(mainArticles, sideArticles, sidebarArticles)
                          : buildDesktopLayout(mainArticles, sideArticles, sidebarArticles),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }



  Widget buildMainArticleCard(Berita1CariModel article, int index)  {
    final bool isHovered = hoveredMainIndex == index;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredMainIndex = index),
      onExit: (_) => setState(() => hoveredMainIndex = -1),
      child: GestureDetector(
        onTap: () {
          final berita1Id = article.berita1Id;
          final gambar = article.gambar;
          final judul = article.judul;

          AppData.berita1Id = berita1Id;
          AppData.gambarArtikel = gambar;
          AppData.JudulArtikel = judul;

          if (berita1Id != null) {
            context.read<Berita2CariBloc>().add(RefreshBerita2CariEvent(berita1Id: berita1Id));
            context.read<Berita3CariBloc>().add(RefreshBerita3CariEvent(berita1Id: berita1Id));

            context.read<HomeBloc>().add(PushPageEvent(PageType.article1));
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
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
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                Image.network(
                  article.gambar ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF91C050).withOpacity(0.8),
                            const Color(0xFF91C050),
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
                        bottom: Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          article.judul ?? '-',
                          style: TextStyle(
                            fontFamily: 'Satoshi-Regular',
                            fontSize: isMobile? 15.0 : 17.53,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          article.sumber,
                          style: TextStyle(
                            fontFamily: 'Satoshi-Regular',
                            fontSize: 12,
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
                      color: const Color(0xFF91C050).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSideArticleItem(Berita1CariModel article, int index) {
    final bool isHovered = hoveredSideIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSideIndex = index),
      onExit: (_) => setState(() => hoveredSideIndex = -1),
      child: GestureDetector(
        onTap: () {
          final berita1Id = article.berita1Id;
          final gambar = article.gambar;
          final judul = article.judul;

          AppData.berita1Id = berita1Id;
          AppData.gambarArtikel = gambar;
          AppData.JudulArtikel = judul;

          if (berita1Id != null) {
            context.read<Berita2CariBloc>().add(RefreshBerita2CariEvent(berita1Id: berita1Id));
            context.read<Berita3CariBloc>().add(RefreshBerita3CariEvent(berita1Id: berita1Id));

            context.read<HomeBloc>().add(PushPageEvent(PageType.article1));
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF91C050).withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered
                  ? const Color(0xFF91C050).withOpacity(0.2)
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
                  width: 100,
                  height: 100,
                  child:
                  Image.network(
                    article.gambar ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF91C050).withOpacity(0.6),
                              const Color(0xFF91C050),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.article,
                            color: Colors.white,
                            size: 24,
                          ),
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
                      article.judul ?? '-'!,
                      style: const TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sumber: ${article.sumber ?? ''}',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 12,
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

  Widget buildSidebarArticleItem(Berita1CariModel article, int index) {
    final bool isHovered = hoveredSidebarIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSidebarIndex = index),
      onExit: (_) => setState(() => hoveredSidebarIndex = -1),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          final berita1Id = article.berita1Id;
          final gambar = article.gambar;
          final judul = article.judul;

          AppData.berita1Id = berita1Id;
          AppData.gambarArtikel = gambar;
          AppData.JudulArtikel = judul;

          if (berita1Id != null) {
            context.read<Berita2CariBloc>().add(RefreshBerita2CariEvent(berita1Id: berita1Id));
            context.read<Berita3CariBloc>().add(RefreshBerita3CariEvent(berita1Id: berita1Id));

            context.read<HomeBloc>().add(PushPageEvent(PageType.article1));
          }
        },
        child: Container(
          // margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF91C050).withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(16.65),
            border: Border.all(
              color: isHovered
                  ? const Color(0xFF91C050).withOpacity(0.2)
                  : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.judul ?? '-'!,
                style: const TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 16,
                  color: Colors.black87,
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
                      color: const Color(0xFF91C050),
                      borderRadius: BorderRadius.circular(16.65),
                    ),
                    child: Text(
                      article.tema ?? '',
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
                    article.tglTerbit.toString(),
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

  Widget buildMobileLayout(List mainArticles, List sideArticles, List sidebarArticles, double constraintWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF91C050),
                width: 2,
              ),
            ),
          ),
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'Cerita Besar',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mainArticles.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) => SizedBox(height: 200, child: buildMainArticleCard(mainArticles[index], index)),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF91C050),
                width: 2,
              ),
            ),
          ),
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'Cerita lainnya',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
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
            childAspectRatio: 2.5,
          ),
          itemCount: sideArticles.length,
          itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
        ),
        const SizedBox(height: 40),
        const Text('Artikel Lainnya', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sidebarArticles.length,
          itemBuilder: (context, index) => buildSidebarArticleItem(sidebarArticles[index], index),
        ),
      ],
    );
  }

  Widget buildTabletLayout(List mainArticles, List sideArticles, List sidebarArticles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF91C050),
                width: 2.0,
              ),
            ),
          ),
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Cerita Besar',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.6,
          ),
          itemCount: mainArticles.length,
          itemBuilder: (context, index) => buildMainArticleCard(mainArticles[index], index),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF91C050),
                width: 2.0,
              ),
            ),
          ),
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Cerita Lainnya',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
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
            childAspectRatio: 3.0,
          ),
          itemCount: sideArticles.length,
          itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
        ),
        const SizedBox(height: 40),
        const Text('Artikel Lainnya', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: sidebarArticles.length,
          itemBuilder: (context, index) => buildSidebarArticleItem(sidebarArticles[index], index),
        ),
      ],
    );
  }

  Widget buildDesktopLayout(List mainArticles, List sideArticles, List sidebarArticles) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFF91C050),
                      width: 2.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Cerita Besar',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.4,
                ),
                itemCount: mainArticles.length,
                itemBuilder: (context, index) => buildMainArticleCard(mainArticles[index], index),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFF91C050),
                      width: 2.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Cerita Lainnya',
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3.5,
                ),
                itemCount: sideArticles.length,
                itemBuilder: (context, index) => buildSideArticleItem(sideArticles[index], index),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Artikel Lainnya', style: TextStyle(fontFamily: 'Satoshi-Regular', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
              const SizedBox(height: 10),
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
    );
  }
}