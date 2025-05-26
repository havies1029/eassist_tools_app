import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../widgets/section/action_section.dart';
import '../../widgets/section/carousel_section.dart';
import '../../widgets/section/client_section.dart';
import '../../widgets/section/feature_section.dart';
import '../../widgets/section/floating_buttons.dart';
import '../../widgets/section/footer_section.dart';
import 'hero_section_heropage.dart';
import '../../widgets/section/testimonial_section.dart';

class HeroMain extends StatelessWidget {
  const HeroMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF79AB43),
        scaffoldBackgroundColor: const Color(0xFFD5F4B4),
        fontFamily: 'Satoshi-Regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 16.0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const HeroPage(),
    );
  }
}

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildSideMenu(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // 🔽 Background Image (full fill)
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg-home.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),

              // 🔽 Konten Utama di atas background
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNavBar(constraints),
                    HeroSection(constraints: constraints),
                    FloatingButtons(constraints: constraints),
                    ActionSection(constraints: constraints),
                    FeatureSection(constraints: constraints),
                    CarouselSection(constraints: constraints),
                    TestimonialSection(constraints: constraints),
                    ClientSection(constraints: constraints),
                    FooterSection(constraints: constraints),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _buildSideMenu() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF79AB43),
                    Color(0xFF8BBD54),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/jps_logo.png',
                    height: 40.0,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Menu JPS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Satoshi-Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ExpandableDrawerItem(
              icon: Icons.assignment,
              title: 'Management Polis',
              subItems: [
                SubMenuItem(
                  icon: Icons.add_circle_outline,
                  title: 'Buat Polis Baru',
                  onTap: () => _handleMenuTap('Buat Polis Baru'),
                ),
                SubMenuItem(
                  icon: Icons.list_alt,
                  title: 'Daftar Polis Aktif',
                  onTap: () => _handleMenuTap('Daftar Polis Aktif'),
                ),
                SubMenuItem(
                  icon: Icons.edit,
                  title: 'Edit Polis',
                  onTap: () => _handleMenuTap('Edit Polis'),
                ),
                SubMenuItem(
                  icon: Icons.history,
                  title: 'Riwayat Polis',
                  onTap: () => _handleMenuTap('Riwayat Polis'),
                ),
              ],
            ),
            ExpandableDrawerItem(
              icon: Icons.assessment,
              title: 'Management Asset',
              subItems: [
                SubMenuItem(
                  icon: Icons.home,
                  title: 'Properti',
                  onTap: () => _handleMenuTap('Properti'),
                ),
                SubMenuItem(
                  icon: Icons.directions_car,
                  title: 'Kendaraan',
                  onTap: () => _handleMenuTap('Kendaraan'),
                ),
                SubMenuItem(
                  icon: Icons.favorite,
                  title: 'Kesehatan',
                  onTap: () => _handleMenuTap('Kesehatan'),
                ),
                SubMenuItem(
                  icon: Icons.business,
                  title: 'Bisnis',
                  onTap: () => _handleMenuTap('Bisnis'),
                ),
              ],
            ),
            ExpandableDrawerItem(
              icon: Icons.attach_money,
              title: 'Tagihan Dan Pembayaran',
              subItems: [
                SubMenuItem(
                  icon: Icons.receipt_long,
                  title: 'Lihat Tagihan',
                  onTap: () => _handleMenuTap('Lihat Tagihan'),
                ),
                SubMenuItem(
                  icon: Icons.payment,
                  title: 'Bayar Premi',
                  onTap: () => _handleMenuTap('Bayar Premi'),
                ),
                SubMenuItem(
                  icon: Icons.account_balance_wallet,
                  title: 'Metode Pembayaran',
                  onTap: () => _handleMenuTap('Metode Pembayaran'),
                ),
                SubMenuItem(
                  icon: Icons.notifications,
                  title: 'Pengingat Tagihan',
                  onTap: () => _handleMenuTap('Pengingat Tagihan'),
                ),
              ],
            ),
            ExpandableDrawerItem(
              icon: Icons.check_circle,
              title: 'Klaim',
              subItems: [
                SubMenuItem(
                  icon: Icons.add_box,
                  title: 'Ajukan Klaim',
                  onTap: () => _handleMenuTap('Ajukan Klaim'),
                ),
                SubMenuItem(
                  icon: Icons.track_changes,
                  title: 'Status Klaim',
                  onTap: () => _handleMenuTap('Status Klaim'),
                ),
                SubMenuItem(
                  icon: Icons.upload_file,
                  title: 'Upload Dokumen',
                  onTap: () => _handleMenuTap('Upload Dokumen'),
                ),
                SubMenuItem(
                  icon: Icons.help_outline,
                  title: 'Panduan Klaim',
                  onTap: () => _handleMenuTap('Panduan Klaim'),
                ),
              ],
            ),
            ExpandableDrawerItem(
              icon: Icons.people,
              title: 'Customer Services',
              subItems: [
                SubMenuItem(
                  icon: Icons.chat,
                  title: 'Live Chat',
                  onTap: () => _handleMenuTap('Live Chat'),
                ),
                SubMenuItem(
                  icon: Icons.phone,
                  title: 'Hubungi Kami',
                  onTap: () => _handleMenuTap('Hubungi Kami'),
                ),
                SubMenuItem(
                  icon: Icons.email,
                  title: 'Kirim Email',
                  onTap: () => _handleMenuTap('Kirim Email'),
                ),
                SubMenuItem(
                  icon: Icons.location_on,
                  title: 'Lokasi Kantor',
                  onTap: () => _handleMenuTap('Lokasi Kantor'),
                ),
              ],
            ),
            ExpandableDrawerItem(
              icon: Icons.article,
              title: 'Artikel',
              subItems: [
                SubMenuItem(
                  icon: Icons.trending_up,
                  title: 'Tips Investasi',
                  onTap: () => _handleMenuTap('Tips Investasi'),
                ),
                SubMenuItem(
                  icon: Icons.security,
                  title: 'Panduan Asuransi',
                  onTap: () => _handleMenuTap('Panduan Asuransi'),
                ),
                SubMenuItem(
                  icon: Icons.health_and_safety,
                  title: 'Kesehatan & Gaya Hidup',
                  onTap: () => _handleMenuTap('Kesehatan & Gaya Hidup'),
                ),
                SubMenuItem(
                  icon: Icons.new_releases,
                  title: 'Berita Terkini',
                  onTap: () => _handleMenuTap('Berita Terkini'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(String menuName) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigasi ke: $menuName'),
        backgroundColor: const Color(0xFF79AB43),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildNavBar(BoxConstraints constraints) {
    double maxWidth = constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: SizedBox(
        width: maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/jps_logo.png',
              height: 60.0,
            ),
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF79AB43),
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              tooltip: 'Open navigation menu',
              splashRadius: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoverButtonOutlined({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return HoverButton(
      onPressed: onPressed,
      color: Colors.transparent,
      textColor: const Color(0xFF79AB43),
      isRounded: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF79AB43), width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: const Color(0xFF79AB43),
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Satoshi-Regular',
                color: Color(0xFF79AB43),
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return HoverButton(
      onPressed: onPressed,
      color: Colors.transparent,
      textColor: const Color(0xFF79AB43),
      isRounded: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: const Color(0xFF79AB43),
              size: 16.0,
            ),
            const SizedBox(width: 6.0),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Satoshi-Regular',
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model untuk submenu items
class SubMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SubMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

// Widget untuk expandable drawer item dengan submenu
class ExpandableDrawerItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<SubMenuItem> subItems;

  const ExpandableDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subItems,
  });

  @override
  State<ExpandableDrawerItem> createState() => _ExpandableDrawerItemState();
}

class _ExpandableDrawerItemState extends State<ExpandableDrawerItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _isHovered
                  ? const Color(0xFF79AB43).withOpacity(0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: ListTile(
              leading: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.icon,
                  color: _isHovered
                      ? const Color(0xFF79AB43)
                      : const Color(0xFF79AB43).withOpacity(0.8),
                  size: _isHovered ? 22.0 : 22.0,
                ),
              ),
              title: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 16.0,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  color: _isHovered ? const Color(0xFF2D5016) : Colors.black87,
                ),
                child: Text(widget.title),
              ),
              trailing: AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value * 2 * pi,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: _isHovered
                          ? const Color(0xFF79AB43)
                          : Colors.grey.shade600,
                    ),
                  );
                },
              ),
              onTap: _toggleExpanded,
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: widget.subItems.map((subItem) {
                return SubMenuTile(subItem: subItem);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget untuk sub menu tile dengan animasi hover
class SubMenuTile extends StatefulWidget {
  final SubMenuItem subItem;

  const SubMenuTile({
    super.key,
    required this.subItem,
  });

  @override
  State<SubMenuTile> createState() => _SubMenuTileState();
}

class _SubMenuTileState extends State<SubMenuTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF8BBD54).withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
          border: _isHovered
              ? Border.all(
            color: const Color(0xFF8BBD54).withOpacity(0.3),
            width: 1.0,
          )
              : null,
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            child: Icon(
              widget.subItem.icon,
              size: _isHovered ? 20.0 : 18.0,
              color: _isHovered
                  ? const Color(0xFF8BBD54)
                  : const Color(0xFF79AB43).withOpacity(0.7),
            ),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: _isHovered ? 14.5 : 14.0,
              fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
              color: _isHovered
                  ? const Color(0xFF2D5016)
                  : Colors.black.withOpacity(0.8),
            ),
            child: Text(widget.subItem.title),
          ),
          onTap: widget.subItem.onTap,
        ),
      ),
    );
  }
}

// Custom painter for curved border
class CircularBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapPercentage;

  CircularBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gapPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double startAngle = -0.5 * pi + (pi * gapPercentage / 2);
    final double endAngle = 2 * pi - (pi * gapPercentage / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      endAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom Widgets for Animation and Interactivity
class HoverAnimatedContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const HoverAnimatedContainer({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  State<HoverAnimatedContainer> createState() => _HoverAnimatedContainerState();
}

class _HoverAnimatedContainerState extends State<HoverAnimatedContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFEEF7DD) : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.child,
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final bool isRounded;

  const HoverButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = Colors.transparent,
    this.textColor = const Color(0xFF79AB43),
    this.isRounded = false,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.isRounded ? 30.0 : 4.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.95)
                : widget.color,
            borderRadius: radius,
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: radius,
            child: DefaultTextStyle(
              style: TextStyle(
                color: widget.textColor,
                fontFamily: 'Satoshi-Regular',
                fontWeight: FontWeight.w500,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class HoverActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isOutlined;
  final bool isRounded;
  final TextStyle? textStyle;

  const HoverActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.textStyle,
    this.isOutlined = false,
    this.isRounded = false,
  });

  @override
  State<HoverActionButton> createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: widget.isOutlined
              ? Colors.transparent
              : _isHovered
              ? const Color(0xFF8BBD54)
              : const Color(0xFF79AB43),
          border: widget.isOutlined
              ? Border.all(
            color: _isHovered
                ? const Color(0xFF8BBD54)
                : const Color(0xFF79AB43),
            width: 2.0,
          )
              : null,
          borderRadius: BorderRadius.circular(widget.isRounded ? 16.56 : 4.0),
          boxShadow: widget.isOutlined ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(widget.isRounded ? 16.56 : 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.isOutlined
                    ? const Color(0xFF79AB43)
                    : Colors.white,
                size: 27.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  color: widget.isOutlined
                      ? const Color(0xFF79AB43)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 27.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}