import 'package:flutter/material.dart';

class PropertiTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> propertiData;
  final Set<int> expandedRows;
  final bool isMobile;
  final Widget Function(Map<String, dynamic> properti, int index) buildRow;
  final Widget Function(Map<String, dynamic> properti, int index)? buildBreakdown;
  final Widget? tableHeader;

  const PropertiTableWidget({
    super.key,
    required this.propertiData,
    required this.expandedRows,
    required this.isMobile,
    required this.buildRow,
    this.buildBreakdown,
    this.tableHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            if (tableHeader != null) tableHeader!,
            ...propertiData.asMap().entries.map((entry) {
              final index = entry.key;
              final properti = entry.value;

              return Column(
                children: [
                  buildRow(properti, index),
                  if (expandedRows.contains(index) && buildBreakdown != null)
                    buildBreakdown!(properti, index),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
