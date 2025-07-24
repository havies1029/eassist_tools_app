import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FloatingButtons extends StatefulWidget {
  final BoxConstraints constraints;
  const FloatingButtons({super.key, required this.constraints});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons>
    with TickerProviderStateMixin {
  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isSmallMobile => widget.constraints.maxWidth < 400;
  bool get isTablet =>
      widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;
  double get maxWidth =>
      widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.95;

  final NumberFormat _numberFormat = NumberFormat.decimalPattern('id');

  late AnimationController _nasabahController;
  late AnimationController _klaimController;
  late AnimationController _mitraController;
  late AnimationController _danaController;

  late Animation<double> _nasabahAnimation;
  late Animation<double> _klaimAnimation;
  late Animation<double> _mitraAnimation;
  late Animation<double> _danaAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _nasabahController = _createController(2000);
    _klaimController = _createController(2200);
    _mitraController = _createController(2400);
    _danaController = _createController(2600);

    _nasabahAnimation = _createAnimation(_nasabahController, statistics['nasabah']!['value']);
    _klaimAnimation = _createAnimation(_klaimController, statistics['klaim']!['value']);
    _mitraAnimation = _createAnimation(_mitraController, statistics['mitra']!['value']);
    _danaAnimation = _createAnimation(_danaController, statistics['dana']!['value']);
  }

  AnimationController _createController(int durationMs) {
    return AnimationController(
      duration: Duration(milliseconds: durationMs),
      vsync: this,
    );
  }

  Animation<double> _createAnimation(AnimationController controller, int endValue) {
    return Tween<double>(begin: 0, end: endValue.toDouble()).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () => _nasabahController.forward());
    Future.delayed(const Duration(milliseconds: 500), () => _klaimController.forward());
    Future.delayed(const Duration(milliseconds: 700), () => _mitraController.forward());
    Future.delayed(const Duration(milliseconds: 900), () => _danaController.forward());
  }

  @override
  void dispose() {
    _nasabahController.dispose();
    _klaimController.dispose();
    _mitraController.dispose();
    _danaController.dispose();
    super.dispose();
  }

  String _formatNumber(double number) => '${_numberFormat.format(number.round())}+';
  String _formatCurrency(double amount) =>
      amount >= 1000000 ? 'Rp ${(amount / 1000000).round()} Miliar+' : 'Rp ${_numberFormat.format(amount.round())}+';

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, isMobile ? -30 : isTablet ? -45 : -60),

      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: isMobile
                ? (isSmallMobile ? 12.0 : 16.0)
                : isTablet
                ? 40.0
                : 95.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile ? 16.0 : 20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF79AB43).withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile
                  ? (isSmallMobile ? 8.0 : 12.0)
                  : isTablet
                  ? 14.0
                  : 16.0,
              horizontal: isMobile
                  ? (isSmallMobile ? 8.0 : 12.0)
                  : isTablet
                  ? 14.0
                  : 20.0,
            ),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStat(_nasabahAnimation, 'nasabah', format: _formatNumber),
        _buildStat(_klaimAnimation, 'klaim', format: _formatNumber),
        _buildStat(_mitraAnimation, 'mitra', format: _formatNumber),
        _buildStat(_danaAnimation, 'dana', format: _formatCurrency),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStat(_nasabahAnimation, 'nasabah', format: _formatNumber, mobile: true)),
            SizedBox(width: isSmallMobile ? 8 : 10),
            Expanded(child: _buildStat(_klaimAnimation, 'klaim', format: _formatNumber, mobile: true)),
          ],
        ),
        SizedBox(height: isSmallMobile ? 8 : 10),
        Row(
          children: [
            Expanded(child: _buildStat(_mitraAnimation, 'mitra', format: _formatNumber, mobile: true)),
            SizedBox(width: isSmallMobile ? 8 : 10),
            Expanded(child: _buildStat(_danaAnimation, 'dana', format: _formatCurrency, mobile: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(
      Animation<double> animation,
      String key, {
        required String Function(double) format,
        bool mobile = false,
      }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return StatCard(
          title: statistics[key]!['label'],
          value: format(animation.value),
          color: const Color(0xFF79AB43),
          isMobile: mobile,
          isSmallMobile: isSmallMobile,
          isTablet: !mobile, // ini logika tambahan
        );
      },
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final bool isMobile;
  final bool isSmallMobile;
  final bool isTablet;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    this.isMobile = false,
    this.isSmallMobile = false,
    this.isTablet = false,
  });

  TextStyle get titleStyle => TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: isMobile
        ? (isSmallMobile ? 10 : 11)
        : isTablet
        ? 14
        : 17,
    fontWeight: FontWeight.w600,
    color: Colors.grey[600],
    height: 1.2,
  );

  TextStyle get valueStyle => TextStyle(
    fontFamily: 'Satoshi-Bold',
    fontSize: isMobile
        ? (isSmallMobile ? 16 : 18)
        : isTablet
        ? 24
        : 32,
    fontWeight: FontWeight.w700,
    color: color,
    height: 1.1,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile
            ? (isSmallMobile ? 8 : 10)
            : isTablet
            ? 12
            : 14,
        horizontal: isMobile
            ? (isSmallMobile ? 4 : 6)
            : isTablet
            ? 6
            : 8,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
          SizedBox(height: isSmallMobile ? 2 : 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: valueStyle,
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================
// === API or dynamic data section ===
// ==============================

final Map<String, Map<String, dynamic>> statistics = {
  'nasabah': {
    'value': 3200,
    'label': 'Nasabah',
  },
  'klaim': {
    'value': 1500,
    'label': 'Klaim Sukses Diproses',
  },
  'mitra': {
    'value': 3200,
    'label': 'Mitra Kesehatan Aktif',
  },
  'dana': {
    'value': 12000000,
    'label': 'Total Pertanggungan Dana',
  },
};