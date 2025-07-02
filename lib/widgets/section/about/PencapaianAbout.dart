import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PencapaianSection extends StatelessWidget {
  final BoxConstraints constraints;

  // Color Constants
  static const Color _primaryGreen = Color(0xFF79AB43);
  static const Color _primaryOrange = Color(0xFFFAA232);
  static const Color _timelineGreen = Color(0xFF81C539);
  static const Color _timelineBorder = Color(0xFFADD97E);
  static const Color _timelineOuter = Color(0xFFD9EEC4);

  // Font Constants
  static const String _fontFamily = 'Satoshi-Regular';
  double _headerFontSize(bool isMobile) => isMobile ? 20 : 27;
  double _subHeaderFontSize(bool isMobile) => isMobile ? 18 : 18;
  double _yearFontSize(bool isMobile) => isMobile ? 19.5 : 30;
  double _itemFontSize(bool isMobile) => isMobile ? 13.5 : 20;
  double _jpsFontSize(bool isMobile) => isMobile ? 13.5 : 20;

  // Spacing Constants
  double _horizontalPadding(bool isMobile) => isMobile ? 16 : 40;
  double _verticalPadding(bool isMobile) => isMobile ? 32 : 80;
  double _cardPadding(bool isMobile) => isMobile ? 16 : 20;
  static const double _sectionSpacing = 48;
  static const double _itemSpacing = 10;

  const PencapaianSection({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(isMobile),
              vertical: _verticalPadding(isMobile),
            ),
            child: Column(
              children: [
                _buildHeader(isMobile),
                const SizedBox(height: _sectionSpacing),
                _buildVerticalTimeline(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: _headerFontSize(isMobile),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: 'Pencapaian '),
              TextSpan(text: 'J', style: TextStyle(color: _primaryGreen, fontWeight: FontWeight.bold)),
              TextSpan(text: 'P', style: TextStyle(color: _primaryOrange, fontWeight: FontWeight.bold)),
              TextSpan(text: 'S', style: TextStyle(color: _primaryGreen, fontWeight: FontWeight.bold)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Container(
          constraints: const BoxConstraints(maxWidth: 1228),
          child: Text(
            'Terpercaya sebagai broker asuransi unggulan dengan pertumbuhan dan kemitraan nasional yang konsisten.',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: _subHeaderFontSize(isMobile),
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalTimeline(bool isMobile) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: isMobile ? constraints.maxWidth - 32 : 800),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTimelineDots(),
                SizedBox(width: isMobile ? 12 : 24),
                _buildTimelineContent(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineDots() {
    final bool isMobile = constraints.maxWidth < 768;

    return Column(
      children: timelineData.asMap().entries.expand((entry) {
        final index = entry.key;
        final isLast = index == timelineData.length - 1;
        List<Widget> widgets = [];

        // Add timeline dot
        widgets.add(_buildTimelineDot());

        // Add connecting line if not last item
        if (!isLast) {
          int itemCount = timelineData[index].items.length;
          double estimatedHeight = 60 + (itemCount * (isMobile ? 40 : 55)) + _sectionSpacing;
          widgets.add(_buildTimelineLine(estimatedHeight));
        }
        return widgets;
      }).toList(),
    );
  }

  Widget _buildTimelineDot() {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _timelineOuter, width: 5),
      ),
      child: Center(
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _timelineGreen,
            border: Border.all(color: _timelineBorder, width: 5),
            boxShadow: [
              BoxShadow(
                color: _timelineOuter,
                blurRadius: 8,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineLine(double height) {
    return Container(
      width: 3,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: _primaryGreen.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTimelineContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: timelineData.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        return Padding(
          padding: EdgeInsets.only(
              bottom: index < timelineData.length - 1 ? _sectionSpacing : 0
          ),
          child: _buildContentCard(data, isMobile),
        );
      }).toList(),
    );
  }

  Widget _buildContentCard(TimelineData data, bool isMobile) {
    return IntrinsicWidth(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: isMobile ? constraints.maxWidth - 100 : double.infinity,
        ),
        padding: EdgeInsets.all(isMobile ? _cardPadding(isMobile) - 4 : _cardPadding(isMobile)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildYear(data.year, isMobile),
            SizedBox(height: isMobile ? 24 : 32),
            _buildTimelineItems(data.items, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildYear(String year, bool isMobile) {
    return Stack(
      children: [
        Positioned(
          bottom: 7,
          left: 0,
          right: 0,
          child: Container(height: 8, color: _primaryOrange.withOpacity(0.6)),
        ),
        Text(
          year,
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: _yearFontSize(isMobile),
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItems(List<TimelineItem> items, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _buildTimelineItem(item, isMobile)).toList(),
    );
  }

  Widget _buildTimelineItem(TimelineItem item, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? _itemSpacing - 2 : _itemSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: SvgPicture.asset(
              'assets/icons/check.svg',
              width: isMobile ? 17 : 32,
              height: isMobile ? 17 : 32,
              color: _primaryGreen,
            ),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(
            child: _buildRichItemText(item, isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildRichItemText(TimelineItem item, bool isMobile) {
    List<InlineSpan> spans = [];
    String remaining = item.text;

    // Process "JPS" with special styling first
    while (remaining.contains('JPS')) {
      int jpsIndex = remaining.indexOf('JPS');

      if (jpsIndex > 0) {
        String beforeJPS = remaining.substring(0, jpsIndex);
        spans.addAll(_processRegularHighlights(beforeJPS, item.highlights, isMobile));
      }

      spans.add(TextSpan(
        children: [
          TextSpan(
            text: 'J',
            style: TextStyle(
              color: _primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: _jpsFontSize(isMobile),
              fontFamily: _fontFamily,
            ),
          ),
          TextSpan(
            text: 'P',
            style: TextStyle(
              color: _primaryOrange,
              fontWeight: FontWeight.bold,
              fontSize: _jpsFontSize(isMobile),
              fontFamily: _fontFamily,
            ),
          ),
          TextSpan(
            text: 'S',
            style: TextStyle(
              color: _primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: _jpsFontSize(isMobile),
              fontFamily: _fontFamily,
            ),
          ),
        ],
      ));

      remaining = remaining.substring(jpsIndex + 3);
    }

    if (remaining.isNotEmpty) {
      spans.addAll(_processRegularHighlights(remaining, item.highlights, isMobile));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _itemFontSize(isMobile),
          color: Colors.black87,
        ),
        children: spans,
      ),
    );
  }

  List<InlineSpan> _processRegularHighlights(String text, List<String> highlights, bool isMobile) {
    List<InlineSpan> spans = [];
    String remaining = text;

    List<String> nonJPSHighlights = highlights.where((h) => h != 'JPS').toList();

    for (var keyword in nonJPSHighlights) {
      int index = remaining.indexOf(keyword);
      if (index >= 0) {
        if (index > 0) {
          spans.add(TextSpan(
            text: remaining.substring(0, index),
            style: TextStyle(fontFamily: _fontFamily),
          ));
        }
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _primaryOrange,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              keyword,
              style: TextStyle(
                fontFamily: _fontFamily,
                color: Colors.white,
                fontSize: _itemFontSize(isMobile),
                height: 1.2,
              ),
            ),
          ),
        ));
        remaining = remaining.substring(index + keyword.length);
      }
    }

    if (remaining.isNotEmpty) {
      spans.add(TextSpan(
        text: remaining,
        style: TextStyle(fontFamily: _fontFamily),
      ));
    }

    return spans;
  }
}

// ====================================================================
// DATA SECTION - TO BE CONNECTED WITH API
// ====================================================================

class TimelineData {
  final String year;
  final Color dotColor;
  final List<TimelineItem> items;

  TimelineData(this.year, this.dotColor, this.items);
}

class TimelineItem {
  final String text;
  final List<String> highlights;

  TimelineItem(this.text, this.highlights);
}

// Timeline data that will be replaced with API data
final List<TimelineData> timelineData = [
  TimelineData('2001', PencapaianSection._primaryGreen, [
    TimelineItem('JPS didirikan pada tahun 2021', ['JPS', '2021']),
    TimelineItem('Memulai operasional dengan fokus utama karyawan', ['karyawan']),
    TimelineItem('Berhasil menyelesaikan klaim awalnya 2 miliar', ['2 miliar']),
    TimelineItem('Mulai membangun kepercayaan dari klien', []),
  ]),
  TimelineData('2007', PencapaianSection._primaryGreen, [
    TimelineItem('JPS mencatat pendapatan premi asuransi yang signifikan \nselama periode ini', ['signifikan']),
  ]),
  TimelineData('2010', PencapaianSection._primaryGreen, [
    TimelineItem('Mengalami permasalahan internal selama periode 2008–2011', ['2008–2011']),
  ]),
  TimelineData('2019', PencapaianSection._primaryGreen, [
    TimelineItem('Mengalami pertumbuhan yang pesat', ['pesat']),
    TimelineItem('Berhasil menyelesaikan klaim hingga 500 miliar', ['500 miliar']),
    TimelineItem('Memulai proses digitalisasi sistem', []),
  ]),
  TimelineData('2022', PencapaianSection._primaryGreen, [
    TimelineItem('Penurunan bisnis akibat pandemi COVID-19', ['COVID-19']),
    TimelineItem('Memulai digitalisasi proses kerja secara menyeluruh', []),
  ]),
  TimelineData('2023', PencapaianSection._primaryGreen, [
    TimelineItem('Mendapatkan proyek dari berbagai BUMN dan BUMD', ['BUMN dan BUMD']),
    TimelineItem('Bisnis dan basis klien mulai tumbuh kembali 500 miliar', ['500 miliar']),
    TimelineItem('Menerima sertifikasi ISO 27001:2022', ['ISO 27001:2022']),
  ]),
  TimelineData('2024', PencapaianSection._primaryGreen, [
    TimelineItem('Bekerja sama dengan bank-bank besar seperti \nDBS, CIMB, Mandiri, dan Bank of China', ['DBS, CIMB, Mandiri, dan Bank of China']),
    TimelineItem('Digital transformation menguat dalam sistem \nbank dan perusahaan asuransi', ['bank dan perusahaan asuransi']),
  ]),
];