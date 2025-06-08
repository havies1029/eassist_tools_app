import 'package:eassist_tools_app/widgets/section/assets/decorations/AssetData.dart';
import 'package:eassist_tools_app/widgets/section/assets/decorations/StatData.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AssetDashboardSection extends StatefulWidget {
  final BoxConstraints constraints;

  const AssetDashboardSection({super.key, required this.constraints});

  @override
  State<AssetDashboardSection> createState() => _AssetDashboardSectionState();
}

class _AssetDashboardSectionState extends State<AssetDashboardSection>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _chartController;
  late AnimationController _statsController;

  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _chartAnimation;
  late Animation<double> _statsAnimation;

  int? _hoveredLegendIndex;
  int? _hoveredStatIndex;

  final List<AssetData> _assetData = [
    AssetData(label: 'Properti', percentage: 30, color: const Color(0xFF3B82F6)),
    AssetData(label: 'Kapal Laut', percentage: 25, color: const Color(0xFFEF4444)),
    AssetData(label: 'Lainnya', percentage: 20, color: const Color(0xFFEAB308)),
    AssetData(label: 'Kendaraan', percentage: 15, color: const Color(0xFF22C55E)),
    AssetData(label: 'Aset Belum Diklasifikasi', percentage: 10, color: const Color(0xFFA855F7)),
  ];

  final List<StatData> _statsData = [
    StatData(
      icon: Icons.bar_chart,
      label: 'Total Aset',
      value: '3.200+',
      color: const Color(0xFFF59E0B),
    ),
    StatData(
      icon: Icons.trending_up,
      label: 'Total Nilai Pertanggungan',
      value: '12 Milliar+',
      color: const Color(0xFF22C55E),
    ),
    StatData(
      icon: Icons.bar_chart,
      label: 'Total Polis Aktif',
      value: '1.500+',
      color: const Color(0xFF3B82F6),
    ),
    StatData(
      icon: Icons.trending_up,
      label: 'Jumlah Aset per Kategori',
      value: '1.250',
      color: const Color(0xFF22C55E),
    ),
  ];

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  double get maxWidth =>
      widget.constraints.maxWidth > 1300 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get contentPadding => isMobile ? 16.0 : 32.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _chartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _statsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _chartAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _chartController,
      curve: Curves.easeOutCubic,
    ));

    _statsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _statsController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mainController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _chartController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    _statsController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _chartController.dispose();
    _statsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white, // ← Background dasar diubah menjadi putih
      padding: EdgeInsets.only(
        top: isMobile ? 40.0 : 60.0,
        bottom: isMobile ? 40.0 : 80.0,
        left: contentPadding,
        right: contentPadding,
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          child: isMobile
              ? Column(
            children: [
              _buildChartSection(),
              SizedBox(height: isMobile ? 32 : 48),
              _buildStatsSection(),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _buildChartSection()),
              SizedBox(width: isMobile ? 32 : 48),
              Expanded(flex: 5, child: _buildStatsSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeInAnimation,
          child: SlideTransition(
            position: _slideInAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(isMobile ? 24.0 : 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChartHeader(),
                  SizedBox(height: isMobile ? 24 : 32),
                  _buildDonutChart(),
                  SizedBox(height: isMobile ? 24 : 32),
                  _buildLegend(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChartHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Nilai Aset',
          style: TextStyle(
            fontSize: isMobile ? 22.0 : 28.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
            fontFamily: 'Satoshi-Regular',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Diperbarui: 2 Juni 2025',
          style: TextStyle(
            fontSize: isMobile ? 12.0 : 14.0,
            color: const Color(0xFF6B7280),
            fontFamily: 'Satoshi-Regular',
          ),
        ),
      ],
    );
  }

  Widget _buildDonutChart() {
    return Center(
      child: SizedBox(
        width: isMobile ? 180 : 240,
        height: isMobile ? 180 : 240,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _chartAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(isMobile ? 180 : 240, isMobile ? 180 : 240),
                  painter: DonutChartPainter(
                    assetData: _assetData,
                    animationValue: _chartAnimation.value,
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _chartAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _chartAnimation.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: const Color(0xFF6B7280),
                            size: isMobile ? 18 : 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '12 M',
                            style: TextStyle(
                              fontSize: isMobile ? 22.0 : 28.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F2937),
                              fontFamily: 'Satoshi-Regular',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total Nilai Aset\nAktif',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 10.0 : 12.0,
                          color: const Color(0xFF6B7280),
                          height: 1.2,
                          fontFamily: 'Satoshi-Regular',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: _assetData.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 800 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(20 * (1 - value), 0),
              child: Opacity(
                opacity: value,
                child: _buildLegendItem(item, index),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildLegendItem(AssetData item, int index) {
    final isHovered = _hoveredLegendIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredLegendIndex = index),
      onExit: (_) => setState(() => _hoveredLegendIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12,
          vertical: isMobile ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFFF9FAFB) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isHovered
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isMobile ? 14 : 16,
              height: isMobile ? 14 : 16,
              decoration: BoxDecoration(
                color: item.color,
                shape: BoxShape.circle,
              ),
              transform: Matrix4.identity()..scale(isHovered ? 1.2 : 1.0),
            ),
            SizedBox(width: isMobile ? 10 : 12),
            Text(
              '${item.label} - ${item.percentage}%',
              style: TextStyle(
                fontSize: isMobile ? 12.0 : 14.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
                fontFamily: 'Satoshi-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsHeader(),
        SizedBox(height: isMobile ? 24 : 32),
        _buildStatsGrid(),
      ],
    );
  }

  Widget _buildStatsHeader() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeInAnimation,
          child: SlideTransition(
            position: _slideInAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '18 Tahun Menjaga Aset Anda Tetap Aman.',
                  style: TextStyle(
                    fontSize: isMobile ? 26.0 : 40.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                    height: 1.2,
                    fontFamily: 'Satoshi-Regular',
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),
                Text(
                  'Ribuan pengguna mempercayakan perlindungan aset mereka kepada kami.',
                  style: TextStyle(
                    fontSize: isMobile ? 14.0 : 18.0,
                    color: const Color(0xFF6B7280),
                    height: 1.5,
                    fontFamily: 'Satoshi-Regular',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: isMobile ? 12 : 16,
        mainAxisSpacing: isMobile ? 12 : 16,
        childAspectRatio: isMobile ? 4.0 : 2.8,
      ),
      itemCount: _statsData.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 600 + (index * 150)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _buildStatCard(_statsData[index], index),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard(StatData stat, int index) {
    final isHovered = _hoveredStatIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStatIndex = index),
      onExit: (_) => setState(() => _hoveredStatIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.15 : 0.08),
              blurRadius: isHovered ? 24 : 16,
              offset: Offset(0, isHovered ? 8 : 4),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: isHovered
                ? Colors.grey.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        transform: Matrix4.identity()
          ..scale(isHovered ? 1.03 : 1.0)
          ..translate(0.0, isHovered ? -4.0 : 0.0),
        padding: EdgeInsets.all(isMobile ? 14.0 : 20.0),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.all(isMobile ? 10 : 12),
              decoration: BoxDecoration(
                color: stat.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: isHovered
                    ? [
                  BoxShadow(
                    color: stat.color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              transform: Matrix4.identity()..rotateZ(isHovered ? 0.1 : 0.0),
              child: Icon(
                stat.icon,
                color: stat.color,
                size: isMobile ? 18 : 24,
              ),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat.label,
                    style: TextStyle(
                      fontSize: isMobile ? 11.0 : 13.0,
                      color: const Color(0xFF6B7280),
                      fontFamily: 'Satoshi-Regular',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: isMobile ? 18.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: stat.color,
                      fontFamily: 'Satoshi-Regular',
                    ),
                    child: Text(stat.value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<AssetData> assetData;
  final double animationValue;

  DonutChartPainter({
    required this.assetData,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.7;
    final strokeWidth = size.width * 0.12;

    double startAngle = -math.pi / 2;

    for (int i = 0; i < assetData.length; i++) {
      final item = assetData[i];
      final sweepAngle = (item.percentage / 100) * 2 * math.pi * animationValue;

      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
