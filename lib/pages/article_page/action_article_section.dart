import 'package:flutter/material.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ActionSection({super.key, required this.constraints});

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection> with TickerProviderStateMixin {
  int hoveredIndex = -1;
  int hoveredMenuIndex = -1;
  int hoveredSocialIndex = -1;
  int hoveredFooterSocialIndex = -1;

  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'apa-itu-jps': GlobalKey(),
    'jenis-perlindungan': GlobalKey(),
    'mengapa-penting': GlobalKey(),
    'siapa-peserta': GlobalKey(),
    'kesimpulan': GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    double maxWidth = widget.constraints.maxWidth > 1300
        ? 1200
        : widget.constraints.maxWidth * 0.9;
    bool isMobile = widget.constraints.maxWidth < 768;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40.0 : 60.0,
        horizontal: 20.0,
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          child: isMobile
              ? Column(
            children: [
              _buildMainArticle(),
              const SizedBox(height: 32),
              _buildSidebar(),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: _buildMainArticle()),
              const SizedBox(width: 32),
              Expanded(flex: 3, child: _buildSidebar()),
            ],
          ),
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
            'Apa Itu JPS? Mengenal Jenis Perlindungan Mikro yang Ramah Masyarakat',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person, color: Colors.grey.shade600, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Ryan Basudara · May 22, 2025',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              _buildSocialIcon(Icons.bookmark_border, 0),
              const SizedBox(width: 12),
              _buildSocialIcon(Icons.facebook, 1),
              const SizedBox(width: 12),
              _buildSocialIcon(Icons.camera_alt, 2),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/article_2.png',
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Table of Contents Menu - Half width
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _buildTableOfContents(),
              ),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
          const SizedBox(height: 32),
          // Main Content
          Container(
            key: _sectionKeys['apa-itu-jps'],
            child: _buildContentSection("Apa Itu JPS?", [
              "JPS (Jaminan Perlindungan Sosial) adalah program layanan asuransi mikro yang dirancang khusus untuk melindungi masyarakat dari berbagai risiko finansial. Program ini menawarkan solusi perlindungan yang mudah, murah, dan bermanfaat.",
              "JPS merupakan bagian dari program nasional yang bertujuan meningkatkan ketahanan sosial masyarakat, khususnya yang berpenghasilan rendah dan rentan terhadap risiko ekonomi konvensional."
            ]),
          ),
          const SizedBox(height: 20),
          Container(
            key: _sectionKeys['jenis-perlindungan'],
            child: _buildContentSection("Jenis Perlindungan Mikro yang Ditawarkan JPS", [
              "JPS menyediakan beragam jenis perlindungan yang dirancang untuk kebutuhan spesifik masyarakat. Berikut adalah jenis-jenis perlindungan utama:",
            ]),
          ),
          _buildProtectionTypesList(),
          const SizedBox(height: 20),
          Container(
            key: _sectionKeys['mengapa-penting'],
            child: _buildContentSection("Mengapa JPS Penting?", [
              "Dalam kondisi ekonomi yang tidak stabil dan harga yang sangat tinggi, agar tidak membebankan keuangan keluarga:",
            ]),
          ),
          _buildImportanceList(),
          const SizedBox(height: 20),
          Container(
            key: _sectionKeys['siapa-peserta'],
            child: _buildContentSection("Siapa yang Bisa Menjadi Peserta JPS?", [
              "Program JPS terbuka untuk berbagai kalangan masyarakat, khususnya:",
            ]),
          ),
          _buildParticipantsList(),
          const SizedBox(height: 20),
          Container(
            key: _sectionKeys['kesimpulan'],
            child: _buildContentSection("JPS bukan sekadar program asuransi mikro.", [
              "Ia adalah bentuk nyata dari upaya memperkuas perlindungan sosial di Indonesia— agar tidak ada lagi keluarga yang kehilangan arah karena musibah tak terduga. Melalui JPS, perlindungan menjadi sesuatu yang mudah, murah, dan menjangkau semua.",
              "Kini, siapa pun bisa melindungi diri dan orang tercinta, tanpa harus merogoh kocek dalam."
            ]),
          ),
          const SizedBox(height: 32),
          // Footer Social Icons
          _buildFooterSocial(),
          const SizedBox(height: 24),
          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildTableOfContents() {
    final List<Map<String, String>> menuItems = [
      {'title': 'Apa Itu JPS?', 'id': 'apa-itu-jps'},
      {'title': 'Jenis Perlindungan Mikro yang Ditawarkan JPS', 'id': 'jenis-perlindungan'},
      {'title': 'Mengapa JPS Penting?', 'id': 'mengapa-penting'},
      {'title': 'Siapa yang Bisa Menjadi Peserta JPS?', 'id': 'siapa-peserta'},
      {'title': 'JPS bukan sekadar program asuransi mikro.', 'id': 'kesimpulan'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Isi',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...menuItems.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> item = entry.value;

            return MouseRegion(
              onEnter: (_) => setState(() => hoveredMenuIndex = index),
              onExit: (_) => setState(() => hoveredMenuIndex = -1),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _scrollToSection(item['id']!);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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

  Widget _buildContentSection(String title, List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        ...paragraphs.map((paragraph) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            paragraph,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildProtectionTypesList() {
    final protectionTypes = [
      'Asuransi Mikro Jiwa: Memberikan santunan apabila keluarga atau peserta meninggal dunia, membantu meringankan beban ekonomi saat kehilangan pencari nafkah.',
      'Asuransi Mikro Kecelakaan: Melindungi peserta dari kerugian biaya akibat kecelakaan yang mengakibatkan luka yang memerlukan pengobatan, rawat inap, atau perawatan terkait.',
      'Bantuan Mikro Bencana: Memberikan bantuan bagi peserta untuk dapat mengirimkan diri atau keberatan, juga memberikan dukungan pembiayaan dalam situasi.',
      'Asuransi Mikro Pendidikan: Cocok untuk memberikan yang ingin mengatur kecelakannya bagi anak masalahnya bisa tetap demi bersama sehat hari.',
    ];

    return Column(
      children: protectionTypes.asMap().entries.map((entry) {
        return _bullet(entry.value);
      }).toList(),
    );
  }

  Widget _buildImportanceList() {
    final importancePoints = [
      'Premi Murah Terjangkau — Mengurangi masyarakat kebutuhan; pekerja informal hingga petani UMKM.',
      'Akses ke Layanan Nasional — Sejalan dengan visi inkusi keuangan dan meningkatkan kepentingan perseroannya.',
    ];

    return Column(
      children: importancePoints.map((point) => _bullet(point)).toList(),
    );
  }

  Widget _buildParticipantsList() {
    final participants = [
      'Pekerja informal (buruh harian, sopir, ojek, nelayan)',
      'Petani dan pekebun',
      'UMKM dan usaha kecil menengah',
      'Ibu rumah tangga',
      'Siswa dan pelajar',
      'Siapa pun yang ingin memiliki proteksi dasar untuk keluarga'
    ];

    return Column(
      children: participants.map((participant) => _bullet(participant)).toList(),
    );
  }

  Widget _buildSocialIcon(IconData icon, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSocialIndex = index),
      onExit: (_) => setState(() => hoveredSocialIndex = -1),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          print('Social icon tapped: $icon');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
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
            size: 18,
            color: hoveredSocialIndex == index
                ? Colors.white
                : const Color(0xFF79AB43),
          ),
        ),
      ),
    );
  }


  Widget _buildFooterSocial() {
    final footerIcons = [
      Icons.bookmark_border,
      Icons.facebook,
      Icons.camera_alt,
    ];

    return Row(
      children: footerIcons.asMap().entries.map((entry) {
        int index = entry.key;
        IconData icon = entry.value;

        return MouseRegion(
          onEnter: (_) => setState(() => hoveredSocialIndex = index + 100), // offset to avoid conflict
          onExit: (_) => setState(() => hoveredSocialIndex = -1),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              print('Footer social icon tapped: $icon');
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: index < footerIcons.length - 1 ? 12 : 0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: hoveredSocialIndex == index + 100
                    ? const Color(0xFF79AB43)
                    : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: hoveredSocialIndex == index + 100
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
                color: hoveredSocialIndex == index + 100
                    ? Colors.white
                    : const Color(0xFF79AB43),
              ),
            ),
          ),
        );
      }).toList(),
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
            decoration: BoxDecoration(
              color: const Color(0xFF79AB43),
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

  Widget _buildSidebar() {
    final List<Map<String, dynamic>> articles = [
      {
        'title': '5 Jenis Perlindungan JPS yang Wajib Diketahui Masyarakat',
        'category': 'Asuransi',
        'readTime': '5 Menit',
      },
      {
        'title': 'Bagaimana Cara Klaim Asuransi JPS dengan Mudah dan Cepat?',
        'category': 'Asuransi',
        'readTime': '5 Menit',
      },
      {
        'title': 'Kisah Nyata: JPS Membantu Saat Musibah Menimpa',
        'category': 'Asuransi',
        'readTime': '5 Menit',
      },
      {
        'title': 'Program Edukasi JPS: Literasi Asuransi untuk Semua Lapisan Masyarakat',
        'category': 'Asuransi',
        'readTime': '5 Menit',
      },
      {
        'title': 'Peran JPS dalam Meningkatkan Inklusi Keuangan di Indonesia',
        'category': 'Asuransi',
        'readTime': '5 Menit',
      },
      {
        'title': 'Perbandingan Asuransi Konvensional vs. Asuransi Mikro',
        'category': 'Asuransi',
        'readTime': '5 Menit',
      },
    ];

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
          Text(
            'Artikel Lainnya',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ...articles.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> article = entry.value;

            return MouseRegion(
              onEnter: (_) => setState(() => hoveredIndex = index),
              onExit: (_) => setState(() => hoveredIndex = -1),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  print('Article tapped: ${article['title']}');
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: hoveredIndex == index
                        ? const Color(0xFF79AB43).withOpacity(0.05)
                        : Colors.transparent,
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
                        article['title'],
                        style: TextStyle(
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              article['category'],
                              style: const TextStyle(
                                fontFamily: 'Satoshi-Regular',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.menu_book,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            article['readTime'],
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