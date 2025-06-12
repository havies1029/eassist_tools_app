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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Row(
                          children: [
                            AnimatedRotation(
                              turns: isExpanded ? 0.25 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.arrow_right,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${properti['no']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          properti['noSppa'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          properti['riskLocation'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          properti['occupancy'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          properti['interest'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          properti['sumInsured'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(
                          properti['totalInterest'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          properti['cover'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          properti['rate'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          properti['premium'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          properti['totalPremium'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
