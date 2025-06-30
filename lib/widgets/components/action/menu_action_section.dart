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
    horizontal: isMobile ? 0.0 : (isTablet ? 32.0 : 40.0),
  );

  EdgeInsets get verticalPadding => isMobile
      ? const EdgeInsets.only(top: 40.0, bottom: 00.0)
      : isTablet
      ? const EdgeInsets.only(top: 48.0, bottom: 0.0)
      : const EdgeInsets.only(top: 60.0, bottom: 0.0);

  double get itemWidth => isMobile ? 75 : 140;
  double get itemHeight => isMobile ? 103 : 180;
  double get iconSize => isMobile ? 64 : 100;
  double get fontSize => isMobile ? 12 : 16;
  double get spacing => isMobile ? 20 : 32;

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
                  _buildMenuItem(context, menuList[0]), // Cari Asuransi
                  _buildMenuItem(context, menuList[1]), // Lapor Klaim
                ],
              ),
              SizedBox(height: spacing),
              // Row 2: Sisanya (4 items)
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: isMobile ? 5 : 20,
                runSpacing: isMobile ? 10 : 24,
                children: [
                  _buildMenuItem(context, menuList[2]), // Management Aset
                  _buildMenuItem(context, menuList[3]), // Management Polis
                  _buildMenuItem(context, menuList[4]), // Management Klaim
                  _buildMenuItem(context, menuList[5]), // Tagihan dan Pembayaran
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.13),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                item['icon']!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
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
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String menuLabel) {
    switch (menuLabel) {
      case 'Cari\nAsuransi':
        context.go('/find_insurance');
        break;

      case 'Lapor Klaim':
      // Berdasarkan navbar code, ini menggunakan StatusPopupHelper
        StatusPopupHelper.show(context);
        break;

      case 'Management\nAset':
        context.go('/assets_management');
        break;

      case 'Management\nPolis':
      // Jika ada route untuk management polis, tambahkan disini
      // Untuk sementara, bisa diarahkan ke halaman lain atau tampilkan snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Management Polis - Fitur dalam pengembangan'),
            duration: Duration(seconds: 2),
          ),
        );
        break;

      case 'Management\nKlaim':
      // Jika ada route untuk management klaim, tambahkan disini
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Management Klaim - Fitur dalam pengembangan'),
            duration: Duration(seconds: 2),
          ),
        );
        break;

      case 'Tagihan dan\nPembayaran':
      // Jika ada route untuk tagihan dan pembayaran, tambahkan disini
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tagihan dan Pembayaran - Fitur dalam pengembangan'),
            duration: Duration(seconds: 2),
          ),
        );
        break;

      default:
      // Fallback untuk menu yang belum diimplementasi
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
  {'icon': 'assets/images/cari_asuransi.png', 'label': 'Cari\nAsuransi'},
  {'icon': 'assets/images/lapor_klaim.png', 'label': 'Lapor Klaim'},
  {'icon': 'assets/images/management_aset.png', 'label': 'Management\nAset'},
  {'icon': 'assets/images/management_polis.png', 'label': 'Management\nPolis'},
  {'icon': 'assets/images/management_klaim.png', 'label': 'Management\nKlaim'},
  {'icon': 'assets/images/tagihan_pembayaran.png', 'label': 'Tagihan dan\nPembayaran'},
];