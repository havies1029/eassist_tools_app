import 'package:flutter/material.dart';

class AssetTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> assetData;
  final bool isMobile;
  final Widget Function(Map<String, dynamic> asset, int index) buildRow;

  const AssetTableWidget({
    super.key,
    required this.assetData,
    required this.isMobile,
    required this.buildRow,
  });

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w600,
      fontSize: isMobile ? 12 : 14,
    );

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
            // Header Table
            Container(
              color: Colors.grey[50],
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: 16,
              ),
              child: isMobile
                  ? Row(
                children: [
                  Expanded(flex: 1, child: Text('NO', style: headerStyle)),
                  Expanded(flex: 3, child: Text('ASET', style: headerStyle)),
                  Expanded(flex: 2, child: Text('JUMLAH ASET', style: headerStyle)),
                ],
              )
                  : Row(
                children: [
                  Expanded(flex: 1, child: Text('NO', style: headerStyle)),
                  Expanded(flex: 3, child: Text('ASET', style: headerStyle)),
                  Expanded(flex: 2, child: Text('JUMLAH ASET', style: headerStyle)),
                  Expanded(flex: 3, child: Text('HARGA PASAR', style: headerStyle)),
                  Expanded(flex: 3, child: Text('HARGA PERTANGGUNGAN', style: headerStyle)),
                ],
              ),
            ),
            // Rows
            ...assetData.asMap().entries.map((entry) {
              final index = entry.key;
              final asset = entry.value;
              return buildRow(asset, index);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
