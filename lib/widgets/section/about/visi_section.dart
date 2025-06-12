import 'package:flutter/material.dart';

class VisiSection extends StatelessWidget {
  const VisiSection({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  static const String _fontFamily = 'Satoshi';

  static const Color _textColor = Colors.black;
  static const Color _textColorMuted = Colors.black87;
  static const Color _primaryGreen = Color(0xFF79AB43);
  static const Color _primaryOrange = Color(0xFFFAA232);
  static const Color _shadowColor = Colors.grey;

  static double cardWidth(bool isMobile) => isMobile ? 376 : 643;
  static double cardHeight(bool isMobile) => isMobile ? 271 : 350;
  static double circleSize(bool isMobile) => isMobile ? 40 : 58;
  static double iconBoxSize(bool isMobile) => isMobile ? 70 : 90;
  static double progressChartWidth(bool isMobile) => isMobile ? 360 : 480;
  static double progressChartHeight(bool isMobile) => isMobile ? 290 : 385;
  static double bankSectionWidth(bool isMobile) => isMobile ? 370 : 656;
  static double bankSectionHeight(bool isMobile) => isMobile ? 320 : 530;
  static double centerLogoWidth(bool isMobile) => isMobile ? 120 : 148;
  static double centerLogoHeight(bool isMobile) => isMobile ? 40 : 67;
  static double bankLogoWidth(bool isMobile) => isMobile ? 170 : 160;
  static double bankLogoHeight(bool isMobile) => isMobile ? 100 : 60;


  static TextStyle _headerTitleStyle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 20 : 27,
    fontWeight: FontWeight.bold,
    color: _textColor,
    fontFamily: _fontFamily,
  );

  static TextStyle _headerSubtitleStyle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 15 : 18,
    color: _textColorMuted,
    height: isMobile ? 1 : 1.3,
    fontFamily: _fontFamily,
  );

  static TextStyle _cardTitleStyle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 20 : 30,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );

  static TextStyle _cardBodyStyle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 15 : 20,
    height: 1.4,
    fontFamily: _fontFamily,
  );

  static TextStyle _pointTextStyle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 15 : 20,
    fontWeight: FontWeight.w500,
    color: _textColorMuted,
    fontFamily: _fontFamily,
  );

  static TextStyle _progressTitleStyle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 14 : 19,
    fontWeight: FontWeight.w600,
    color: _textColorMuted,
    fontFamily: _fontFamily,
  );

  bool get _isMobile => constraints.maxWidth < 768;
  bool get _isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 1024;

  EdgeInsets get _sectionPadding => EdgeInsets.symmetric(
    horizontal: _isMobile ? 20 : (_isTablet ? 40 : 80),
    vertical: _isMobile ? 40 : 80,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: _isMobile ? 20 : 40),
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                SizedBox(height: _isMobile ? 20 : 60),
                _buildContentLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // HEADER SECTION
  // ============================================================================

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeaderTitle(),
        const SizedBox(height: 10),
        _buildHeaderSubtitle(),
      ],
    );
  }

  Widget _buildHeaderTitle() {
    return RichText(
      text: TextSpan(
        style: _headerTitleStyle(_isMobile),
        children: [
          const TextSpan(text: 'VISI '),
          TextSpan(
            text: 'J',
            style: _headerTitleStyle(_isMobile).copyWith(
              color: _primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'P',
            style: _headerTitleStyle(_isMobile).copyWith(
              color: _primaryOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'S',
            style: _headerTitleStyle(_isMobile).copyWith(
              color: _primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSubtitle() {
    return Text(
      'Memberikan perlindungan asuransi yang mudah, inovatif, dan terpercaya.',
      textAlign: TextAlign.center,
      style: _headerSubtitleStyle(_isMobile),
    );
  }

  // ============================================================================
  // LAYOUT BUILDERS
  // ============================================================================

  Widget _buildContentLayout() {
    return Column(
      children: [
        _buildFirstRow(),
        SizedBox(height: _isMobile ? 30 : 40),
        _buildSecondRow(),
        SizedBox(height: _isMobile ? 30 : 60),
        _buildThirdRow(),
      ],
    );
  }

  Widget _buildFirstRow() {
    if (_isMobile) {
      return Column(
        children: [
          _buildTimelineCard(
            'Saat Ini',
            _primaryGreen,
            VisiData.saatIniTexts,
          ),
          SizedBox(height: 30),
          _buildInsurancePoints(),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: _buildTimelineCard(
              'Saat Ini',
              _primaryGreen,
              VisiData.saatIniTexts,
            ),
          ),
          const SizedBox(width: 40),
          Expanded(child: _buildInsurancePoints()),
        ],
      );
    }
  }

  Widget _buildSecondRow() {
    if (_isMobile) {
      return Column(
        children: [
          _buildTimelineCard(
            'Jangka Pendek',
            _primaryOrange,
            VisiData.jangkaPendekTexts,
          ),
          SizedBox(height: 30),
          _buildBankPartnersSection(),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(child: _buildBankPartnersSection()),
          const SizedBox(width: 40),
          Expanded(
            child: _buildTimelineCard(
              'Jangka Pendek',
              _primaryOrange,
              VisiData.jangkaPendekTexts,
            ),
          ),
        ],
      );
    }
  }
  Widget _buildBankPartnersSection() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: _isMobile ? 300 : bankSectionWidth(_isMobile),
        maxHeight: _isMobile ? 300 : bankSectionHeight(_isMobile),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: CirclesPainter())),
          _buildCenterLogo(),
          ...VisiData.bankLogos.asMap().entries.map((entry) {
            final index = entry.key;
            final bank = entry.value;
            return _buildPositionedBankLogo(index, bank);
          }),
          if (!_isMobile) Positioned.fill(child: CustomPaint(painter: DottedLinesPainter())),
        ],
      ),
    );
  }

  Widget _buildThirdRow() {
    if (_isMobile) {
      return Column(
        children: [
          _buildTimelineCard(
            'Jangka Panjang',
            _primaryGreen,
            VisiData.jangkaPanjangTexts,
          ),
          SizedBox(height: 30),
          _buildProgressChart(),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: _buildTimelineCard(
              'Jangka Panjang',
              _primaryGreen,
              VisiData.jangkaPanjangTexts,
            ),
          ),
          const SizedBox(width: 40),
          Expanded(child: _buildProgressChart()),
        ],
      );
    }
  }

  // ============================================================================
  // TIMELINE CARD
  // ============================================================================

  Widget _buildTimelineCard(String title, Color color, List<String> texts) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: cardWidth(_isMobile),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: _isMobile ? 8 : 24,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineIcon(color),
            SizedBox(width: _isMobile ? 20 : 50),
            Flexible(child: _buildTimelineContent(title, color, texts)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineIcon(Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(8),
      width: circleSize(_isMobile),
      height: circleSize(_isMobile),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: _isMobile ? 20 : 30,
      ),
    );
  }

  Widget _buildTimelineContent(String title, Color color, List<String> texts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _cardTitleStyle(_isMobile).copyWith(color: color),
        ),
        SizedBox(height: _isMobile ? 5 : 20),
        ...texts.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          return Column(
            children: [
              if (index > 0) SizedBox(height: _isMobile ? 8 : 30),
              Text(
                text,
                style: _cardBodyStyle(_isMobile),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ],
          );
        }),
      ],
    );
  }

  // ============================================================================
  // INSURANCE POINTS
  // ============================================================================

  Widget _buildInsurancePoints() {
    return Container(
      padding: EdgeInsets.only(
        top: _isMobile ? 0 : 24,
        left: _isMobile ? 16 : 24,
        right: _isMobile ? 16 : 24,
        bottom: _isMobile ? 16 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: VisiData.insurancePoints.asMap().entries.map((entry) {
          final index = entry.key;
          final point = entry.value;
          return Column(
            children: [
              if (index > 0) const SizedBox(height: 16),
              _buildInsurancePoint(point.icon, point.text),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInsurancePoint(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildInsurancePointIcon(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: _pointTextStyle(_isMobile)),
        ),
      ],
    );
  }

  Widget _buildInsurancePointIcon(IconData icon) {
    return Container(
      width: iconBoxSize(_isMobile),
      height: iconBoxSize(_isMobile),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: _shadowColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: _primaryGreen, size: 40),
    );
  }

  // ============================================================================
  // PROGRESS CHART
  // ============================================================================

  Widget _buildProgressChart() {
    if (_isMobile) {
      // 🔹 RESPONSIF UNTUK MOBILE (360x290, padding kecil, FittedBox, dll)
      return Container(
        width: 360,
        height: 290,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress', style: _progressTitleStyle(true)),
            const SizedBox(height: 12),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 360,
                    height: 290,
                    child: CustomPaint(
                      painter: ProgressChartPainter(isMobile: true),
                      size: const Size(360, 290),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // 🔹 NORMAL UNTUK DESKTOP (seperti sebelumnya, tidak pakai FittedBox)
      return Container(
        width: progressChartWidth(false),
        height: progressChartHeight(false),
        padding: const EdgeInsets.all(24),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress', style: _progressTitleStyle(false)),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    painter: ProgressChartPainter(isMobile: false),
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  // ============================================================================
  // BANK PARTNERS SECTION
  // ============================================================================

  Widget _buildCenterLogo() {
    return Positioned.fill(
      child: Center(
        child: Container(
          width: centerLogoWidth(_isMobile),
          height: centerLogoHeight(_isMobile),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: _shadowColor.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/JPS(2).png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildPositionedBankLogo(int index, BankLogo bank) {
    final position = _getBankLogoPositions()[index];

    return Positioned(
      left: position['left'],
      right: position['right'],
      top: position['top'],
      bottom: position['bottom'],
      child: _buildBankLogoContainer(bank),
    );
  }

  Widget _buildBankLogoContainer(BankLogo bank) {
    return Container(
      width: _isMobile ? 100 : bankLogoWidth(_isMobile),
      height: _isMobile ? 45 : bankLogoHeight(_isMobile),
      alignment: Alignment.center,
      child: Image.asset(
        bank.path,
        height: bank.height,
        width: bank.width,
        fit: bank.fit,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Text(
            bank.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _shadowColor.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  List<Map<String, double?>> _getBankLogoPositions() {
    if (_isMobile) {
      return [
        {'left': 120.0, 'top': 0.0},    // BSI - atas tengah
        {'right': 0.0, 'top': 80.0},    // BRI - kanan atas
        {'right': 0.0, 'bottom': 80.0}, // UOB - kanan bawah
        {'left': 120.0, 'bottom': 0.0}, // Hana Bank - bawah tengah
        {'left': 0.0, 'bottom': 80.0},  // BNI - kiri bawah
        {'left': 0.0, 'top': 80.0},     // Mandiri - kiri atas
      ];
    }

    return [
      {'left': 80.0, 'top': 60.0},      // BSI
      {'right': 80.0, 'top': 60.0},     // BRI
      {'left': 20.0, 'top': 220.0},     // Mandiri
      {'right': 20.0, 'top': 220.0},    // UOB
      {'left': 80.0, 'bottom': 60.0},   // BNI
      {'right': 80.0, 'bottom': 60.0},  // Hana Bank
    ];
  }
}

// ============================================================================
// DATA MODELS
// ============================================================================

class InsurancePoint {
  const InsurancePoint({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
}

class BankLogo {
  const BankLogo({
    required this.name,
    required this.path,
    required this.height,
    required this.width,
    required this.fit,
  });

  final String name;
  final String path;
  final double height;
  final double width;
  final BoxFit fit;
}

// ============================================================================
// DATA PROVIDER - API INTEGRATION READY
// ============================================================================

class VisiData {
  // TODO: Replace with API calls
  static const List<String> saatIniTexts = [
    'Menawarkan produk asuransi yang berbeda dibandingkan pesaing.',
    'Menerapkan ISO 270001:2022 untuk menjaga kerahasiaan data pelanggan.',
    'Berada di peringkat 8 besar broker asuransi di Indonesia.',
  ];

  static const List<String> jangkaPendekTexts = [
    'Menjalin kemitraan strategis dengan seluruh bank nasional.',
    'Konsisten menghadirkan komitmen utama kami: "Klaim yang mudah, cepat, dan transparan.',
  ];

  static const List<String> jangkaPanjangTexts = [
    'Mengembangkan produk asuransi unggulan yang unik dan menjadi pilihan utama di pasar nasional.',
  ];

  static const List<InsurancePoint> insurancePoints = [
    InsurancePoint(
      icon: Icons.lightbulb_outline,
      text: 'Produk asuransi unggulan & berbeda.',
    ),
    InsurancePoint(
      icon: Icons.shield_outlined,
      text: 'ISO 27001:2022 privasi data terjamin.',
    ),
    InsurancePoint(
      icon: Icons.emoji_events_outlined,
      text: 'Top 8 broker asuransi nasional.',
    ),
  ];

  static const List<BankLogo> bankLogos = [
    BankLogo(
      name: 'BSI',
      path: 'assets/images/BSI.png',
      height: 61.0,
      width: 160.0,
      fit: BoxFit.contain,
    ),
    BankLogo(
      name: 'BRI',
      path: 'assets/images/BRI.png',
      height: 60.0,
      width: 160.0,
      fit: BoxFit.contain,
    ),
    BankLogo(
      name: 'Mandiri',
      path: 'assets/images/MANDIRI.png',
      height: 60.0,
      width: 160.0,
      fit: BoxFit.contain,
    ),
    BankLogo(
      name: 'UOB',
      path: 'assets/images/UOB.png',
      height: 60.0,
      width: 160.0,
      fit: BoxFit.contain,
    ),
    BankLogo(
      name: 'BNI',
      path: 'assets/images/BNI.png',
      height: 60.0,
      width: 160.0,
      fit: BoxFit.contain,
    ),
    BankLogo(
      name: 'Hana Bank',
      path: 'assets/images/HANABANK.png',
      height: 60.0,
      width: 160.0,
      fit: BoxFit.cover,
    ),
  ];

  static const List<double> progressDataPoints = [5.9, 6.6, 6.3, 7.0, 7.25, 6.95, 7.6];
  static const List<String> progressYears = ['2021', '2022', '2023', '2024', '2025', '2026'];
}

// ============================================================================
// CUSTOM PAINTERS
// ============================================================================
class VerticalDottedLinePainter extends CustomPainter {
  final double height;
  final Color color;

  VerticalDottedLinePainter({required this.height, this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    const double dashHeight = 4, dashSpace = 4;
    double startY = 0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    while (startY < height) {
      canvas.drawLine(Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw concentric circles
    canvas.drawCircle(center, size.width * 0.38, paint);
    canvas.drawCircle(center, size.width * 0.28, paint);
    canvas.drawCircle(center, size.width * 0.18, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DottedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB).withOpacity(0.4)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw dotted lines to each bank logo position
    final endpoints = [
      Offset(160, 90),   // BSI
      Offset(520, 90),   // BRI
      Offset(100, 250),  // Mandiri
      Offset(580, 250),  // UOB
      Offset(160, 410),  // BNI
      Offset(520, 410),  // Hana Bank
    ];

    for (final endpoint in endpoints) {
      _drawDottedLine(canvas, center, endpoint, paint);
    }
  }

  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 3;
    const double dashSpace = 3;

    final double distance = (end - start).distance;
    final int dashCount = (distance / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final double startDistance = i * (dashWidth + dashSpace);
      final double endDistance = startDistance + dashWidth;

      final Offset dashStart = start + (end - start) * (startDistance / distance);
      final Offset dashEnd = start + (end - start) * (endDistance / distance);

      canvas.drawLine(dashStart, dashEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProgressChartPainter extends CustomPainter {
  final bool isMobile;

  ProgressChartPainter({this.isMobile = false});

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawLabels(canvas, size);
    _drawChart(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    final margins = _getMargins();
    const minY = 5.5;
    const maxY = 8.0;

    final chartHeight = size.height - margins.bottom - margins.top;
    final chartWidth = size.width - margins.left - margins.right;

    final yLabels = [6.0, 6.5, 7.0, 7.5, 8.0];

    for (final yValue in yLabels) {
      final y = margins.top + chartHeight - ((yValue - minY) / (maxY - minY)) * chartHeight;
      canvas.drawLine(
        Offset(margins.left, y),
        Offset(margins.left + chartWidth + (isMobile ? 8 : 0), y),
        paintGrid,
      );
    }
  }

  void _drawLabels(Canvas canvas, Size size) {
    final margins = _getMargins();
    const minY = 5.5;
    const maxY = 8.0;
    final chartWidth = size.width - margins.left;
    final chartHeight = size.height - margins.bottom - margins.top;
    final stepX = chartWidth / (VisiData.progressYears.length - 1);

    // Y-axis labels
    final yLabels = [6.0, 6.5, 7.0, 7.5, 8.0];
    for (final yValue in yLabels) {
      final y = margins.top + chartHeight - ((yValue - minY) / (maxY - minY)) * chartHeight;
      _drawText(
        canvas,
        yValue.toString(),
        Offset(margins.left - (isMobile ? 20 : 30), y - (isMobile ? 6 : 8)),
        fontSize: isMobile ? 10 : 12,
      );
    }

    // X-axis labels
    for (var i = 0; i < VisiData.progressYears.length; i++) {
      final x = margins.left + stepX * i;
      final textWidth = isMobile ? 12 : 15;
      _drawText(
        canvas,
        VisiData.progressYears[i],
        Offset(x - textWidth, size.height - (isMobile ? 15 : 20)),
        fontSize: isMobile ? 10 : 12,
      );
    }
  }

  void _drawChart(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFF6B9B37)
      ..strokeWidth = isMobile ? 2 : 3
      ..style = PaintingStyle.stroke;

    final paintPoint = Paint()
      ..color = const Color(0xFF6B9B37)
      ..style = PaintingStyle.fill;

    final margins = _getMargins();
    const minY = 5.5;
    const maxY = 8.0;
    final chartWidth = size.width - margins.left - margins.right;
    final chartHeight = size.height - margins.bottom - margins.top;
    final stepX = chartWidth / (VisiData.progressYears.length - 1);
    final path = Path();
    for (var i = 0; i < VisiData.progressDataPoints.length; i++) {
      final x = (margins.left + stepX * i).clamp(margins.left, margins.left + chartWidth);
      final y = margins.top + chartHeight -
          ((VisiData.progressDataPoints[i] - minY) / (maxY - minY)) * chartHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(
        Offset(x, y),
        isMobile ? 4 : 6,
        paintPoint,
      );
    }

    canvas.drawPath(path, paintLine);
  }

  Margins _getMargins() {
    if (isMobile) {
      return Margins(
        left: 24.0,
        right: 8.0,
        top: 12.0,
        bottom: 20.0,
      );
    } else {
      return Margins(
        left: 40.0,
        right: 20.0,
        top: 20.0,
        bottom: 30.0,
      );
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, {double fontSize = 12}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: fontSize,
          fontWeight: isMobile ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Margins {
  final double left;
  final double right;
  final double top;
  final double bottom;

  Margins({
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
  });
}