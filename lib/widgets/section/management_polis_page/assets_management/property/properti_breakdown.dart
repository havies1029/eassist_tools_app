import 'dart:ui';
import 'package:flutter/material.dart';

class PropertiBreakdownWidget extends StatelessWidget {
  final Map<String, dynamic> breakdown;
  final bool isMobile;
  final ScrollController scrollController;

  const PropertiBreakdownWidget({
    super.key,
    required this.breakdown,
    required this.isMobile,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 16,
          vertical: 12,
        ),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            scrollbars: false,
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  const SizedBox(width: 120),
                  const SizedBox(width: 180),
                  const SizedBox(width: 200),
                  const SizedBox(width: 80),
                  const SizedBox(width: 140),
                  const SizedBox(width: 160),
                  const SizedBox(width: 80),
                  const SizedBox(width: 80),
                  SizedBox(
                    width: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBreakdownRow(
                          label: 'Discount',
                          percentage: breakdown['discount']['percentage'],
                          amount: breakdown['discount']['amount'],
                          color: Colors.red,
                        ),
                        const SizedBox(height: 4),
                        _buildBreakdownRow(
                          label: 'Policy Cost',
                          percentage: '',
                          amount: breakdown['policyCost'],
                          color: Colors.grey[700]!,
                        ),
                        const SizedBox(height: 4),
                        _buildBreakdownRow(
                          label: 'Premium',
                          percentage: '',
                          amount: breakdown['premiLainnya'],
                          color: Colors.grey[700]!,
                        ),
                        const SizedBox(height: 8),
                        Container(height: 1, color: Colors.grey[300]),
                        const SizedBox(height: 8),
                        _buildBreakdownRow(
                          label: 'TOTAL PREMIUM PAR',
                          percentage: '',
                          amount: breakdown['totalPremiumPar'],
                          color: Colors.green,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownRow({
    required String label,
    required String percentage,
    required String amount,
    required Color color,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              color: color,
            ),
          ),
        ),
        if (percentage.isNotEmpty) ...[
          Text(
            percentage,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          amount,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
