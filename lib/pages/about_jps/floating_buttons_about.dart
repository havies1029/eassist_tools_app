import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FloatingButtons extends StatefulWidget {
  final BoxConstraints constraints;
  const FloatingButtons({super.key, required this.constraints});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
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

  String _formatNumber(int number) {
    return '${_numberFormat.format(number)}+';
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      return 'Rp ${amount ~/ 1000000} Miliar+';
    }
    return 'Rp ${_numberFormat.format(amount)}+';
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
    final stats = [
      _statistics['nasabah'],
      _statistics['klaim'],
      _statistics['mitra'],
      _statistics['dana'],
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(stats.length, (index) {
        return Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 8.0 : 4.0,
              right: index == stats.length - 1 ? 8.0 : 4.0,
            ),
            child: StatCard(
              title: stats[index]['label'],
              value: index == 3
                  ? _formatCurrency(stats[index]['value'])
                  : _formatNumber(stats[index]['value']),
              color: const Color(0xFF79AB43),
              rawValue: stats[index]['value'],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: _statistics['nasabah']['label'],
                value: _formatNumber(_statistics['nasabah']['value']),
                color: const Color(0xFF79AB43),
                rawValue: _statistics['nasabah']['value'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                title: _statistics['klaim']['label'],
                value: _formatNumber(_statistics['klaim']['value']),
                color: const Color(0xFF79AB43),
                rawValue: _statistics['klaim']['value'],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: _statistics['mitra']['label'],
                value: _formatNumber(_statistics['mitra']['value']),
                color: const Color(0xFF79AB43),
                rawValue: _statistics['mitra']['value'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                title: _statistics['dana']['label'],
                value: _formatCurrency(_statistics['dana']['value']),
                color: const Color(0xFF79AB43),
                rawValue: _statistics['dana']['value'],
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
  final int rawValue;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.rawValue,
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
