import 'package:flutter/material.dart';

class PropertiBreakdownWidget extends StatefulWidget {
  final Map<String, dynamic> breakdown;
  final bool isMobile;

  const PropertiBreakdownWidget({
    super.key,
    required this.breakdown,
    required this.isMobile,
  });

  @override
  State<PropertiBreakdownWidget> createState() =>
      _PropertiBreakdownWidgetState();
}

class _PropertiBreakdownWidgetState extends State<PropertiBreakdownWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          horizontal: widget.isMobile ? 8 : 16,
          vertical: 12,
        ),
        child: SizedBox(
          // Tinggi bisa disesuaikan jika perlu
          // height: 100,
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,    // selalu tampilkan thumb saat scrollable
            trackVisibility: true,    // tampilkan track (garis) di bawah thumb (Flutter 3.7+)
            thickness: 6,             // ketebalan scrollbar
            radius: const Radius.circular(3),
            // interactive: true,     // default true, agar thumb bisa drag
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildColumnBlock(
                    'Discount',
                    widget.breakdown['discount']['percentage'],
                    widget.breakdown['discount']['amount'],
                    Colors.red,
                  ),
                  _buildColumnBlock(
                    'Policy Cost',
                    '',
                    widget.breakdown['policyCost'],
                    Colors.grey[700]!,
                  ),
                  _buildColumnBlock(
                    'Premium',
                    '',
                    widget.breakdown['premiLainnya'],
                    Colors.grey[700]!,
                  ),
                  _buildColumnBlock(
                    'TOTAL PREMIUM PAR',
                    '',
                    widget.breakdown['totalPremiumPar'],
                    Colors.green,
                    isBold: true,
                  ),
                  // Tambah kolom lain bila diperlukan agar overflow dan scroll aktif
                  // Contoh tambahan:
                  //_buildColumnBlock('Lainnya 1', '', '...', Colors.blue),
                  //_buildColumnBlock('Lainnya 2', '', '...', Colors.blue),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnBlock(
      String label,
      String percentage,
      String amount,
      Color color, {
        bool isBold = false,
      }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreakdownRow(
            label: label,
            percentage: percentage,
            amount: amount,
            color: color,
            isBold: isBold,
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: Colors.grey[300]),
        ],
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
