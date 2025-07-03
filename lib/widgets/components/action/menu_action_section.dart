import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../dialog/popup/status_popup.dart';

class MenuActionSection extends StatelessWidget {
  final BoxConstraints constraints;

  const MenuActionSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 800;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 1024;

  double get maxWidth {
    final raw = constraints.maxWidth * 0.75;
    return raw > 900 ? 1200 : raw;
  }

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(
    horizontal: isMobile ? 8.0 : (isTablet ? 32.0 : 40.0),
  );

  EdgeInsets get verticalPadding => isMobile
      ? const EdgeInsets.only(top: 40.0, bottom: 0.0)
      : isTablet
      ? const EdgeInsets.only(top: 48.0, bottom: 0.0)
      : const EdgeInsets.only(top: 60.0, bottom: 0.0);

  // Responsive sizing with auto-scaling
  double get baseItemWidth => isMobile ? 63.98 : 99.04;
  double get baseItemHeight => isMobile ? 104.18 : 182.95;
  double get baseIconSize => isMobile ? 63.98 : 99.04;
  double get baseFontSize => isMobile ? 10 : 16;
  double get baseSpacing => isMobile ? 8 : 25;

// Calculate scale factor based on available width
  double get scaleFactor {
    if (!isMobile) return 1.0;

    final availableWidth = constraints.maxWidth - horizontalPadding.horizontal;
    final secondRowNeededWidth = (baseItemWidth * 4) + (baseSpacing * 3);
    final scale = availableWidth / secondRowNeededWidth;
    return scale.clamp(0.4, 1.0); // ← Lebih kecil
  }

  double get itemWidth => baseItemWidth * scaleFactor;
  double get itemHeight => baseItemHeight * scaleFactor;
  double get iconSize => baseIconSize * scaleFactor;
  double get fontSize => (baseFontSize * scaleFactor).clamp(10.0, 16.0);
  double get spacing => baseSpacing * scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: verticalPadding.add(horizontalPadding),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              // Row 1: Cari Asuransi dan Lapor Klaim
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMenuItem(context, menuList[0]),
                  SizedBox(width: spacing), // Tambah spacing antar item
                  _buildMenuItem(context, menuList[1]),
                ],
              ),
              SizedBox(height: spacing),
              // Row 2: Sisanya (4 items)
              Wrap(
                alignment: WrapAlignment.center,
                spacing: spacing,
                runSpacing: spacing * 0.5,
                children: [
                  _buildMenuItem(context, menuList[2]),
                  _buildMenuItem(context, menuList[3]),
                  _buildMenuItem(context, menuList[4]),
                  _buildMenuItem(context, menuList[5]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () => _handleMenuTap(context, item['label']!),
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.13 * scaleFactor),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                item['icon']!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8 * scaleFactor),
            Flexible(
              child: Text(
                item['label']!,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2D3748),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String menuLabel) {
    switch (menuLabel) {
      case 'Cari Asuransi':
        context.go('/find_insurance');
        break;

      case 'Lapor Klaim':
        StatusPopupHelper.show(context);
        break;

      case 'Management Aset':
        context.go('/assets_management');
        break;

      case 'Management Polis':
      case 'Management Klaim':
      case 'Tagihan dan Pembayaran':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$menuLabel - Fitur dalam pengembangan'),
            duration: const Duration(seconds: 2),
          ),
        );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Menu "$menuLabel" belum tersedia'),
            duration: const Duration(seconds: 2),
          ),
        );
        break;
    }
  }
}

final List<Map<String, String>> menuList = [
  {'icon': 'assets/images/cari_asuransi.png', 'label': 'Cari Asuransi'},
  {'icon': 'assets/images/lapor_klaim.png', 'label': 'Lapor Klaim'},
  {'icon': 'assets/images/management_aset.png', 'label': 'Management Aset'},
  {'icon': 'assets/images/management_polis.png', 'label': 'Management Polis'},
  {'icon': 'assets/images/management_klaim.png', 'label': 'Management Klaim'},
  {'icon': 'assets/images/tagihan_pembayaran.png', 'label': 'Tagihan dan Pembayaran'},
];