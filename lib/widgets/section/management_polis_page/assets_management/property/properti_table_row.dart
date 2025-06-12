import 'package:flutter/material.dart';

class PropertiTableRowWidget extends StatelessWidget {
  final Map<String, dynamic> properti;
  final int index;
  final bool isExpanded;
  final bool isMobile;
  final VoidCallback onToggleExpand;

  const PropertiTableRowWidget({
    super.key,
    required this.properti,
    required this.index,
    required this.isExpanded,
    required this.isMobile,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: MouseRegion(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isExpanded ? Colors.green.withOpacity(0.02) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onToggleExpand,
              splashColor: Colors.green.withOpacity(0.1),
              highlightColor: Colors.green.withOpacity(0.05),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8 : 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    _buildCell(
                      width: 40,
                      child: Row(
                        children: [
                          AnimatedRotation(
                            turns: isExpanded ? 0.25 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(Icons.arrow_right, size: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 4),
                          Text('${properti['no']}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                        ],
                      ),
                    ),
                    _buildCell(width: 120, text: properti['noSppa']),
                    _buildCell(width: 180, text: properti['riskLocation'], maxLines: 2),
                    _buildCell(width: 200, text: properti['occupancy'], fontWeight: FontWeight.w400, maxLines: 3),
                    _buildCell(width: 80, text: properti['interest'], center: true),
                    _buildCell(width: 140, text: properti['sumInsured']),
                    _buildCell(width: 160, text: properti['totalInterest']),
                    _buildCell(width: 80, text: properti['cover'], center: true),
                    _buildCell(width: 80, text: properti['rate'], center: true),
                    _buildCell(width: 120, text: properti['premium']),
                    _buildCell(
                      width: 120,
                      text: properti['totalPremium'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCell({
    required double width,
    String? text,
    Widget? child,
    TextStyle? style,
    FontWeight fontWeight = FontWeight.w500,
    int? maxLines,
    bool center = false,
  }) {
    return SizedBox(
      width: width,
      child: child ??
          Text(
            text ?? '',
            style: style ?? TextStyle(fontWeight: fontWeight, fontSize: 12),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: center ? TextAlign.center : TextAlign.start,
          ),
    );
  }
}
