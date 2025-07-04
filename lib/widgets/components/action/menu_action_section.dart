import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return AnimatedMenuItemWidget(
      item: item,
      itemWidth: itemWidth,
      itemHeight: itemHeight,
      iconSize: iconSize,
      fontSize: fontSize,
      scaleFactor: scaleFactor,
      onTap: () => _handleMenuTap(context, item['label']!),
    );
  }

  void _handleMenuTap(BuildContext context, String menuLabel) {
    switch (menuLabel) {
      case 'Cari Asuransi':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(FindInsurancePageActiveEvent());
        });
        break;

      case 'Lapor Klaim':
        StatusPopupHelper.show(context);
        break;

      case 'Management Aset':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(AssetsManagementPageActiveEvent());
        });
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

class AnimatedMenuItemWidget extends StatefulWidget {
  final Map<String, String> item;
  final double itemWidth;
  final double itemHeight;
  final double iconSize;
  final double fontSize;
  final double scaleFactor;
  final VoidCallback onTap;

  const AnimatedMenuItemWidget({
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
  State<AnimatedMenuItemWidget> createState() => _AnimatedMenuItemWidgetState();
}

class _AnimatedMenuItemWidgetState extends State<AnimatedMenuItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _tapController;

  late Animation<Color?> _backgroundColorAnimation;
  late Animation<double> _opacityAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Hover animation controller
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Tap animation controller
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // Background color animation
    _backgroundColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.grey.withOpacity(0.05),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));

    // Opacity animation for tap feedback
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: _tapController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  void _onTapDown() {
    _tapController.forward();
  }

  void _onTapUp() {
    _tapController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _tapController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapUp(),
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _tapController]),
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.itemWidth,
              height: widget.itemHeight,
              decoration: BoxDecoration(
                color: _backgroundColorAnimation.value,
                borderRadius: BorderRadius.circular(16.13 * widget.scaleFactor),
              ),
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon container
                    Container(
                      width: widget.iconSize,
                      height: widget.iconSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.13 * widget.scaleFactor),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.13 * widget.scaleFactor),
                        ),
                        child: Image.asset(
                          widget.item['icon']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8 * widget.scaleFactor),
                    // Text
                    Flexible(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontFamily: 'Satoshi-Regular',
                          fontSize: widget.fontSize,
                          fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                          color: _isHovered
                              ? const Color(0xFF1E40AF)
                              : const Color(0xFF2D3748),
                          height: 1.2,
                        ),
                        child: Text(
                          widget.item['label']!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
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