import 'package:flutter/material.dart';

class PropertiTableHeaderWidget extends StatelessWidget {
  final bool isMobile;

  const PropertiTableHeaderWidget({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w600,
      fontSize: isMobile ? 10 : 12,
    );

    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 16,
        vertical: 12,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 40, child: Text('NO', style: headerStyle)),
            SizedBox(width: 120, child: Text('NO. SPPA', style: headerStyle)),
            SizedBox(width: 180, child: Text('RISK LOCATION', style: headerStyle)),
            SizedBox(width: 200, child: Text('OCCUPANCY', style: headerStyle)),
            SizedBox(width: 80, child: Text('INTEREST', style: headerStyle)),
            SizedBox(width: 140, child: Text('SUM INSURED', style: headerStyle)),
            SizedBox(width: 160, child: Text('TOTAL INTEREST\n(INCLUDE ADD-ONS)', style: headerStyle)),
            SizedBox(width: 80, child: Text('COVER', style: headerStyle)),
            SizedBox(width: 80, child: Text('RATE', style: headerStyle)),
            SizedBox(width: 120, child: Text('PREMIUM', style: headerStyle)),
            SizedBox(width: 120, child: Text('TOTAL\nPREMIUM', style: headerStyle)),
          ],
        ),
      ),
    );
  }
}
