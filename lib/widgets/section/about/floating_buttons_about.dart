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
  double get maxWidth => widget.constraints.maxWidth > 1200
      ? 1200
      : widget.constraints.maxWidth * 0.95;

  final Map<String, dynamic> _statistics = {
    'nasabah': {'value': 3200, 'label': 'Nasabah'},
    'klaim': {'value': 1500, 'label': 'Klaim Sukses Diproses'},
    'mitra': {'value': 3200, 'label': 'Mitra Kesehatan Aktif'},
    'dana': {'value': 12000000, 'label': 'Total Pertanggungan Dana'},
  };

  final NumberFormat _numberFormat = NumberFormat.decimalPattern('id');

  // Animation controllers untuk setiap stat
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
    // Initialize controllers dengan durasi yang berbeda untuk efek staggered
    _nasabahController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _klaimController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );
    _mitraController = AnimationController(
      duration: const Duration(milliseconds: 2400),
      vsync: this,
    );
    _danaController = AnimationController(
      duration: const Duration(milliseconds: 2600),
      vsync: this,
    );

    // Create curved animations
    _nasabahAnimation = Tween<double>(
      begin: 0,
      end: _statistics['nasabah']['value'].toDouble(),
    ).animate(CurvedAnimation(
      parent: _nasabahController,
      curve: Curves.easeOutCubic,
    ));

    _klaimAnimation = Tween<double>(
      begin: 0,
      end: _statistics['klaim']['value'].toDouble(),
    ).animate(CurvedAnimation(
      parent: _klaimController,
      curve: Curves.easeOutCubic,
    ));

    _mitraAnimation = Tween<double>(
      begin: 0,
      end: _statistics['mitra']['value'].toDouble(),
    ).animate(CurvedAnimation(
      parent: _mitraController,
      curve: Curves.easeOutCubic,
    ));

    _danaAnimation = Tween<double>(
      begin: 0,
      end: _statistics['dana']['value'].toDouble(),
    ).animate(CurvedAnimation(
      parent: _danaController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startAnimations() {
    // Start animations dengan delay untuk efek staggered
    Future.delayed(const Duration(milliseconds: 300), () {
      _nasabahController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _klaimController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      _mitraController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _danaController.forward();
    });
  }

  @override
  void dispose() {
    _nasabahController.dispose();
    _klaimController.dispose();
    _mitraController.dispose();
    _danaController.dispose();
    super.dispose();
  }

  String _formatNumber(double number) {
    return '${_numberFormat.format(number.round())}+';
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).round()} Miliar+';
    }
    return 'Rp ${_numberFormat.format(amount.round())}+';
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -50),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
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
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            child: AnimatedBuilder(
              animation: _nasabahAnimation,
              builder: (context, child) {
                return StatCard(
                  title: _statistics['nasabah']['label'],
                  value: _formatNumber(_nasabahAnimation.value),
                  color: const Color(0xFF79AB43),
                );
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: AnimatedBuilder(
              animation: _klaimAnimation,
              builder: (context, child) {
                return StatCard(
                  title: _statistics['klaim']['label'],
                  value: _formatNumber(_klaimAnimation.value),
                  color: const Color(0xFF79AB43),
                );
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: AnimatedBuilder(
              animation: _mitraAnimation,
              builder: (context, child) {
                return StatCard(
                  title: _statistics['mitra']['label'],
                  value: _formatNumber(_mitraAnimation.value),
                  color: const Color(0xFF79AB43),
                );
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 8.0),
            child: AnimatedBuilder(
              animation: _danaAnimation,
              builder: (context, child) {
                return StatCard(
                  title: _statistics['dana']['label'],
                  value: _formatCurrency(_danaAnimation.value),
                  color: const Color(0xFF79AB43),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: _nasabahAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: _statistics['nasabah']['label'],
                    value: _formatNumber(_nasabahAnimation.value),
                    color: const Color(0xFF79AB43),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AnimatedBuilder(
                animation: _klaimAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: _statistics['klaim']['label'],
                    value: _formatNumber(_klaimAnimation.value),
                    color: const Color(0xFF79AB43),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: _mitraAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: _statistics['mitra']['label'],
                    value: _formatNumber(_mitraAnimation.value),
                    color: const Color(0xFF79AB43),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AnimatedBuilder(
                animation: _danaAnimation,
                builder: (context, child) {
                  return StatCard(
                    title: _statistics['dana']['label'],
                    value: _formatCurrency(_danaAnimation.value),
                    color: const Color(0xFF79AB43),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Satoshi-Bold',
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}