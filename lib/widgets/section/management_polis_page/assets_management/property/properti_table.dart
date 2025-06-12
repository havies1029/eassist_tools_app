import 'package:flutter/material.dart';

class PropertiTableWidget extends StatefulWidget {
  final List<Map<String, dynamic>> propertiData;
  final Set<int> expandedRows;
  final bool isMobile;
  final Widget Function(Map<String, dynamic> properti, int index) buildRow;
  final Widget Function(Map<String, dynamic> properti, int index)? buildBreakdown;
  final Widget Function(ScrollController controller)? buildHeader;

  const PropertiTableWidget({
    super.key,
    required this.propertiData,
    required this.expandedRows,
    required this.isMobile,
    required this.buildRow,
    this.buildBreakdown,
    this.buildHeader,
  });

  @override
  State<PropertiTableWidget> createState() => _PropertiTableWidgetState();
}

class _PropertiTableWidgetState extends State<PropertiTableWidget> {
  final ScrollController _horizontalController = ScrollController();

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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _horizontalController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.buildHeader != null)
                widget.buildHeader!(_horizontalController),
              ...widget.propertiData.asMap().entries.map((entry) {
                final index = entry.key;
                final properti = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.buildRow(properti, index),
                    if (widget.expandedRows.contains(index) && widget.buildBreakdown != null)
                      widget.buildBreakdown!(properti, index),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
