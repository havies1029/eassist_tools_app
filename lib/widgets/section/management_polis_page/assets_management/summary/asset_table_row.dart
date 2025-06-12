import 'package:flutter/material.dart';

class AssetTableRowWidget extends StatelessWidget {
  final Map<String, dynamic> asset;
  final int index;
  final bool isMobile;
  final Widget Function(Map<String, dynamic> asset)? mobileRowBuilder;
  final Widget Function(Map<String, dynamic> asset)? desktopRowBuilder;

  const AssetTableRowWidget({
    super.key,
    required this.asset,
    required this.index,
    required this.isMobile,
    required this.mobileRowBuilder,
    required this.desktopRowBuilder,
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
        onEnter: (_) {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
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
              onTap: () {},
              splashColor: Colors.green.withOpacity(0.1),
              highlightColor: Colors.green.withOpacity(0.05),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 20,
                  vertical: 16,
                ),
                child: isMobile
                    ? mobileRowBuilder!(asset)
                    : desktopRowBuilder!(asset),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
