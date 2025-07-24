import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/base/base_page.dart';
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
    horizontal: isMobile ? 16.0 : (isTablet ? 32.0 : 40.0),
  );

  EdgeInsets get verticalPadding => isMobile
      ? const EdgeInsets.only(top: 40.0, bottom: 0.0)
      : isTablet
      ? const EdgeInsets.only(top: 48.0, bottom: 0.0)
      : const EdgeInsets.only(top: 60.0, bottom: 0.0);

  // Base dimensions untuk formasi 3-3 - diperbesar untuk mobile
  double get baseItemWidth => isMobile ? 100.0 : 120.0;
  double get baseItemHeight => isMobile ? 130.0 : 200.0;
  double get baseIconSize => isMobile ? 75.0 : 120.0;
  double get baseFontSize => isMobile ? 13.0 : 18.0;
  double get baseSpacing => isMobile ? 12.0 : 28.0;

  // Scale calculation untuk 3 items per row
  double get scaleFactor {
    final availableWidth = constraints.maxWidth - horizontalPadding.horizontal;

    // Hitung kebutuhan width untuk 3 items dalam satu row
    final threeItemsNeededWidth = (baseItemWidth * 3) + (baseSpacing * 2);
    final threeItemsScale = availableWidth / threeItemsNeededWidth;

    // Clamp untuk mencegah terlalu kecil atau terlalu besar
    return threeItemsScale.clamp(0.5, 1.0);
  }

  // Calculated dimensions dengan overflow protection - diperbesar minimum untuk mobile
  double get itemWidth => (baseItemWidth * scaleFactor).clamp(isMobile ? 85.0 : 40.0, 120.0);
  double get itemHeight => (baseItemHeight * scaleFactor).clamp(isMobile ? 110.0 : 65.0, 180.0);
  double get iconSize => (baseIconSize * scaleFactor).clamp(isMobile ? 60.0 : 30.0, 90.0);
  double get fontSize => (baseFontSize * scaleFactor).clamp(isMobile ? 12.0 : 7.0, 16.0);
  double get spacing => (baseSpacing * scaleFactor).clamp(8.0, 25.0);

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
              // Row 1: 3 items pertama
              _buildMenuRow(context, [0, 1, 2]),
              SizedBox(height: spacing),
              // Row 2: 3 items terakhir
              _buildMenuRow(context, [3, 4, 5]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuRow(BuildContext context, List<int> indices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < indices.length; i++) ...[
          Flexible(
            child: _buildMenuItem(context, menuList[indices[i]]),
          ),
          if (i < indices.length - 1) SizedBox(width: spacing),
        ],
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, String> item) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: itemWidth,
        maxHeight: itemHeight,
      ),
      child: MenuItemWidget(
        item: item,
        itemWidth: itemWidth,
        itemHeight: itemHeight,
        iconSize: iconSize,
        fontSize: fontSize,
        scaleFactor: scaleFactor,
        onTap: () => _handleMenuTap(context, item['label']!),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String menuLabel) {
    switch (menuLabel) {
      case 'Cari Asuransi':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // context.read<HomeBloc>().add(FindInsurancePageActiveEvent());
          context.read<HomeBloc>().add(PushPageEvent(PageType.findinsurance));
        });
        break;

      case 'Lapor Klaim':
        StatusPopupHelper.show(context);
        break;

      case 'Aset':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // context.read<HomeBloc>().add(AssetsManagementPageActiveEvent());
          context.read<HomeBloc>().add(PushPageEvent(PageType.assetsmanagement));
        });
        break;

      case 'Polis':
      case 'Klaim':
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

class MenuItemWidget extends StatefulWidget {
  final Map<String, String> item;
  final double itemWidth;
  final double itemHeight;
  final double iconSize;
  final double fontSize;
  final double scaleFactor;
  final VoidCallback onTap;

  const MenuItemWidget({
    super.key,
    required this.item,
    required this.itemWidth,
    required this.itemHeight,
    required this.iconSize,
    required this.fontSize,
    required this.scaleFactor,
    required this.onTap,
  });

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _tapController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _tapController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _tapController.forward();
  }

  void _onTapUp() {
    _tapController.reverse().then((_) {
      widget.onTap();
    });
  }

  void _onTapCancel() {
    _tapController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      onTapUp: (_) => _onTapUp(),
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _tapController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.itemWidth,
              height: widget.itemHeight,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16.13 * widget.scaleFactor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon container dengan size yang fleksibel
                  Container(
                    width: widget.iconSize,
                    height: widget.iconSize,
                    constraints: BoxConstraints(
                      maxWidth: widget.itemWidth * 0.8,
                      maxHeight: widget.itemHeight * 0.6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.13 * widget.scaleFactor),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      widget.item['icon']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: (6 * widget.scaleFactor).clamp(4.0, 10.0)),
                  // Text container dengan overflow protection
                  Container(
                    width: widget.itemWidth,
                    height: widget.itemHeight * 0.3,
                    padding: EdgeInsets.symmetric(
                        horizontal: (2 * widget.scaleFactor).clamp(1.0, 4.0)
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.item['label']!,
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2D3748),
                        height: 1.1,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<Map<String, String>> menuList = [
  {'icon': 'assets/images/cari_asuransi.png', 'label': 'Cari Asuransi'},
  {'icon': 'assets/images/lapor_klaim.png', 'label': 'Lapor Klaim'},
  {'icon': 'assets/images/management_aset.png', 'label': 'Aset'},
  {'icon': 'assets/images/management_polis.png', 'label': 'Polis'},
  {'icon': 'assets/images/management_klaim.png', 'label': 'Klaim'},
  {'icon': 'assets/images/tagihan_pembayaran.png', 'label': 'Tagihan dan Pembayaran'},
];