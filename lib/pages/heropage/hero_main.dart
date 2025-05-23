import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../widgets/section/action_section.dart';
import '../../widgets/section/carousel_section.dart';
import '../../widgets/section/client_section.dart';
import '../../widgets/section/feature_section.dart';
import '../../widgets/section/floating_buttons.dart';
import '../../widgets/section/footer_section.dart';
import '../../widgets/section/hero_section.dart';
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
        scaffoldBackgroundColor: const Color(0xFFD5F4B4), // Changed to light green
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
          return SingleChildScrollView(
            child: Container(
              color: const Color(0xFFD5F4B4), // Light green background
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
          );
        },
      ),
    );
  }

  // New carousel section method

  Widget _buildSideMenu() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF79AB43),
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
            _buildDrawerItem(Icons.assignment, 'Management Polis'),
            _buildDrawerItem(Icons.assessment, 'Management Asset'),
            _buildDrawerItem(Icons.attach_money, 'Tagihan Dan Pembayaran'),
            _buildDrawerItem(Icons.check_circle, 'Klaim'),
            _buildDrawerItem(Icons.people, 'Customers Services'),
            _buildDrawerItem(Icons.article, 'Artikel'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF79AB43),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Satoshi-Regular',
          fontSize: 16.0,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
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
            // Logo (tanpa shadow agar flat)
            Image.asset(
              'assets/images/jps_logo.png',
              height: 60.0,
            ),

            // Menu icon (tanpa background, shadow, atau borderRadius)
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

    // Calculate start and end angles for the arc
    // The gap will be at the bottom
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