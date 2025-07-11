import 'package:flutter/material.dart';

class PolisSummarySection extends StatelessWidget {
  final BoxConstraints constraints;
  final int aktifQty;
  final int nonAktifQty;
  final int onProgressQty;
  final int berakhirQty;

  const PolisSummarySection({
    super.key,
    required this.constraints,
    required this.aktifQty,
    required this.nonAktifQty,
    required this.onProgressQty,
    required this.berakhirQty,
  });

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 14
      : constraints.maxWidth > 992
      ? 12
      : isTablet
      ? 10
      : 7;

  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : constraints.maxWidth > 768
      ? constraints.maxWidth * 0.95
      : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = isMobile ? 160 : 224;
    final double cardHeight = isMobile ? 60 : 168;

    final summaryData = [
      {
        'iconColor': const Color(0xFF79AB43),
        'icon': Icons.work_outline,
        'label': 'Polis Aktif',
        'value': aktifQty.toString(),
      },
      {
        'iconColor': const Color(0xFFFAA232),
        'icon': Icons.work_outline,
        'label': isMobile ? 'Polis non\nAktif' : 'Polis non Aktif',
        'value': nonAktifQty.toString(),
      },
      {
        'iconColor': const Color(0xFF62A5F6),
        'icon': Icons.sync,
        'label': isMobile ? 'Sedang di\nProses' : 'Sedang di Proses',
        'value': onProgressQty.toString(),
      },
      {
        'iconColor': const Color(0xFFF46262),
        'icon': Icons.work_outline,
        'label': isMobile ? 'Akan\nBerakhir' : 'Akan Berakhir',
        'value': berakhirQty.toString(),
      },
    ];

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: isMobile
              ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: summaryData.take(2).map((data) {
                  return _PolisSummaryCard(
                    iconColor: data['iconColor'] as Color,
                    iconData: data['icon'] as IconData,
                    label: data['label'] as String,
                    value: data['value'] as String,
                    width: cardWidth,
                    height: cardHeight,
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: summaryData.skip(2).map((data) {
                  return _PolisSummaryCard(
                    iconColor: data['iconColor'] as Color,
                    iconData: data['icon'] as IconData,
                    label: data['label'] as String,
                    value: data['value'] as String,
                    width: cardWidth,
                    height: cardHeight,
                  );
                }).toList(),
              ),
            ],
          )
              : Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: summaryData.map((data) {
              return _PolisSummaryCard(
                iconColor: data['iconColor'] as Color,
                iconData: data['icon'] as IconData,
                label: data['label'] as String,
                value: data['value'] as String,
                width: cardWidth,
                height: cardHeight,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


class _PolisSummaryCard extends StatelessWidget {
  final Color iconColor;
  final IconData iconData;
  final String label;
  final String value;
  final double width;
  final double height;

  const _PolisSummaryCard({
    required this.iconColor,
    required this.iconData,
    required this.label,
    required this.value,
    required this.width,
    required this.height,
  });

  bool _isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(isMobile ? 8 : 16),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: isMobile
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Satoshi',
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.visible,
              softWrap: true,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Satoshi',
              ),
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(iconData, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 14, fontFamily: 'Satoshi')),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Satoshi',
              )),
        ],
      ),
    );
  }
}
