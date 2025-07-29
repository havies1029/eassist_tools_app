import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../pages/base/base_page.dart';
import '../../dialog/popup/status_popup.dart';

class FooterSection extends StatelessWidget {
  final BoxConstraints constraints;

  const FooterSection({super.key, required this.constraints});

  // ─── Colors ───────────────────────────────────────────────
  static const _primaryColor = Color(0xFF91C050);

  // ─── Button Styles ────────────────────────────────────
  static const _buttonBorderWidth = 1.5;
  static const _buttonBorderRadius = BorderRadius.all(Radius.circular(8.0));

  // ─── Font Properties ────────────────────────────────
  static const _fontFamily = 'Satoshi-Regular';
  static const _primaryTextColor = Colors.black87;
  static const _secondaryTextColor = Colors.black54;
  static const _linkColor = Colors.blue;

  // ─── Layout Properties ────────────────────────────────────
  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 95
      : isTablet
      ? 36 // padding tablet (sedikit lebih lebar dari mobile)
      : 24;


  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : isTablet
      ? constraints.maxWidth * 0.95
      : constraints.maxWidth * 0.9;

  // ─── Responsive Font Sizes ───────────────────────────────
  double get titleFontSize => 18.0;

  double get linkFontSize => 16.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            // ─── Main Footer Content ────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30.0),
              color: Colors.white,
              child: Center(
                child: Container(
                  width: maxWidth,
                  child: _buildFooterContent(context),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Container(
                  width: maxWidth,
                  child: _buildCopyrightContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchMaps() async {
    final url = 'https://www.google.com/maps/place/PT.+Jaya+Proteksindo+Sakti/@-6.1792182,106.8407798,17.29z/data=!4m6!3m5!1s0x2e69f4462436b6b3:0x969b983768aade03!8m2!3d-6.179265!4d106.842428!16s%2Fg%2F1thwm2z_?entry=ttu&g_ep=EgoyMDI1MDcwNi4wIKXMDSoASAFQAw%3D%3D';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('❌ Tidak bisa membuka Maps URL');
    }
  }

  Widget _buildFooterContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Section
        _buildLogoSection(),

        SizedBox(height: isMobile ? 20.0 : 30.0),

        // Main Content Section
        isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGoogleMapsButton(),
        const SizedBox(height: 16.0),
        _buildCompanyInfo(),
        const SizedBox(height: 16.0),
        _buildSocialMediaSection(),
        const SizedBox(height: 30.0),

        // Menu Sections Row dengan alignment yang tepat
        IntrinsicHeight( // Membuat kedua kolom memiliki tinggi yang sama
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unggulan Section
              Expanded(
                child: _buildSignatureSection(context),
              ),
              const SizedBox(width: 24.0),

              // Menu Section
              Expanded(
                child: _buildMenuSection(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column - Map & Company Info
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGoogleMapsButton(),
              const SizedBox(height: 24.0),
              _buildCompanyInfo(),
              const SizedBox(height: 16.0),
              _buildSocialMediaSection(),
            ],
          ),
        ),

        const SizedBox(width: 32.0),

        // Right Column - Menu Sections
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unggulan Section
              Expanded(
                child: _buildSignatureSection(context),
              ),
              const SizedBox(width: 24.0),

              // Menu Section
              Expanded(
                child: _buildMenuSection(),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildLogoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/JPS.png', height: 65.0),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PT. Jaya Proteksindo Sakti${isMobile ? ',' : ''}',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: linkFontSize,
            color: _secondaryTextColor,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'No. 7 - 9, Jl. Kramat Raya, Kramat, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10450',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: linkFontSize,
            color: _secondaryTextColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        _buildSocialMediaIcons(),
      ],
    );
  }

  Widget _buildSocialMediaIcons() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: isMobile ? 8.0 : 12.0,
        runSpacing: isMobile ? 8.0 : 12.0,
        children: [
          _buildSvgSocialIconButton('instagram.svg', () {
            _launchUrl('https://www.instagram.com/jayaproteksindosakti/');
          }),
          _buildSvgSocialIconButton('tiktok.svg', () {
            _launchUrl('https://www.instagram.com/jayaproteksindosakti/');
          }),
          _buildSvgSocialIconButton('linkedin.svg', () {
            _launchUrl('https://id.linkedin.com/company/jayaproteksindo');
          }),
          _buildSvgSocialIconButton('facebook.svg', () {}),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('❌ Tidak bisa membuka URL: $url');
    }
  }


  Widget _buildCopyrightContent() {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 0.5,
            height: 24.0,
            color: Colors.black12,
          ),
          Text(
            'Claim is Simple.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: linkFontSize,
              color: _secondaryTextColor,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            'Hak Cipta Dilindungi',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: linkFontSize,
              color: _secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8.0),
          _buildLegalLinks(),
        ],
      );
    } else {
      return SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Flexible(
              child: Text(
                'Claim is Simple.',
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: linkFontSize,
                  color: _secondaryTextColor,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Hak Cipta Dilindungi | ',
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: linkFontSize,
                    color: _secondaryTextColor,
                  ),
                ),
                _buildLegalLinks(),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildLegalLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHoverableLink('Syarat dan Ketentuan', () {}),
        Text(
          ' | ',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: linkFontSize,
            color: _secondaryTextColor,
          ),
        ),
        _buildHoverableLink('Kebijakan Privasi', () {}),
      ],
    );
  }

  Widget _buildHoverableLink(String text, VoidCallback onPressed) {
    return _AnimatedButton(
      onPressed: onPressed,
      isTextButton: true,
      child: Text.rich(
        TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: linkFontSize,
            color: _linkColor,
            decoration: TextDecoration.underline,
            decorationColor: _linkColor,     // ✅ garis bawah biru
            decorationThickness: 1.5,         // opsional, biar lebih tegas
          ),
        ),
      ),
    );
  }

  Widget _buildSignatureSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Menggunakan space minimum yang dibutuhkan
      children: [
        Text(
          'Unggulan',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        SizedBox(height: isMobile ? 8.0 : 16.0),
        _buildFooterLink('Cari Asuransi', () {
          context.read<HomeBloc>().add(PushPageEvent(PageType.findinsurance));
        }),
        _buildFooterLink('Lapor Klaim', () {
          StatusPopupHelper.show(context);
        }),
        // Tambahan spacing untuk menyeimbangkan dengan Menu section (opsional)
        if (!isMobile) ...[
          const SizedBox(height: 16.0),
          const SizedBox(height: 16.0),
          const SizedBox(height: 16.0),
        ],
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Menggunakan space minimum yang dibutuhkan
      children: [
        Text(
          'Menu',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        SizedBox(height: isMobile ? 8.0 : 16.0),
        _buildFooterLink('Aset', () {}),
        _buildFooterLink('Polis', () {}),
        _buildFooterLink('Klaim', () {}),
        _buildFooterLink('Tagihan dan Pembayaran', () {}),
        _buildFooterLink('Literasi', () {}),
      ],
    );
  }

  // Widget _buildSupportSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Support',
  //         style: TextStyle(
  //           fontFamily: _fontFamily,
  //           fontSize: titleFontSize,
  //           fontWeight: FontWeight.bold,
  //           color: _primaryColor,
  //         ),
  //       ),
  //       SizedBox(height: isMobile ? 8.0 : 16.0),
  //       _buildFooterLink('Customer Services', () {}),
  //     ],
  //   );
  // }

  Widget _buildFooterLink(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _AnimatedButton(
        onPressed: onPressed,
        isTextButton: true,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: linkFontSize,
            color: _secondaryTextColor,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleMapsButton() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: _launchMaps,
          child: Container(
            width: constraints.maxWidth, // Menggunakan lebar penuh dari parent
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Rasio aspek yang wajar untuk gambar maps
                child: Image.asset(
                  'assets/images/google_maps_location.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSvgSocialIconButton(String assetName, VoidCallback onPressed) {
    return _AnimatedButton(
      onPressed: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/$assetName',
            width: 30,
            height: 30,
            colorFilter: const ColorFilter.mode(_primaryColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildBalancedMenuSections(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Unggulan Section dengan fixed height
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 200), // Set minimum height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unggulan',
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
                SizedBox(height: isMobile ? 8.0 : 16.0),
                _buildFooterLink('Cari Asuransi', () {
                  context.read<HomeBloc>().add(PushPageEvent(PageType.findinsurance));
                }),
                _buildFooterLink('Lapor Klaim', () {
                  StatusPopupHelper.show(context);
                }),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24.0),

        // Menu Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menu',
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              SizedBox(height: isMobile ? 8.0 : 16.0),
              _buildFooterLink('Aset', () {}),
              _buildFooterLink('Polis', () {}),
              _buildFooterLink('Klaim', () {}),
              _buildFooterLink('Tagihan dan Pembayaran', () {}),
              _buildFooterLink('Literasi', () {}),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Animated Button Widget ────────────────────────────────
class _AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isTextButton;

  const _AnimatedButton({
    required this.child,
    required this.onPressed,
    this.isTextButton = false,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            Widget content = widget.child;

            // Jika ini adalah text button dan sedang hover, ubah warna teks
            if (widget.isTextButton && _isHovered) {
              content = DefaultTextStyle.merge(
                style: const TextStyle(color: Colors.blue),
                child: content,
              );
            }

            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: content,
              ),
            );
          },
        ),
      ),
    );
  }
}