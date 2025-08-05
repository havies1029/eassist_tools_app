import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
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
  double get desktopGapOuter =>
      constraints.maxWidth >= 1200 ? 50.0 : 24.0; // Map ↔︎ Menu
  double get desktopGapInner =>
      constraints.maxWidth >= 1200 ? 46.0 : 20.0; // Signature ↔︎ Menu

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
        // Company Info
        _buildCompanyInfo(),
        const SizedBox(height: 16.0),

        // Social Media
        _buildSocialMediaSection(),
        const SizedBox(height: 20.0),

        // Map (full width)
        _buildGoogleMapsButton(),
        const SizedBox(height: 16.0),

        // Unggulan (full width)
        _buildSignatureSection(context),
        const SizedBox(height: 12.0),

        // Menu (full width)
        _buildMenuSection(context),
      ],
    );
  }


  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Info and Social Media in a row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Company Info & Social Media
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompanyInfo(),
                  const SizedBox(height: 16.0),
                  _buildSocialMediaSection(),
                ],
              ),
            ),
            const SizedBox(width: 32.0),
            // Right side spacer
            Expanded(flex: 2, child: Container()),
          ],
        ),

        const SizedBox(height: 24.0),

        // Map and Menu sections
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MAP
            Expanded(
              flex: 2,
              child: _buildGoogleMapsButton(),
            ),

            // GAP: Map → (Signature+Menu)
            SizedBox(width: desktopGapOuter),

            // (Signature + Menu)
            Expanded(
              flex: 3,
              child: Wrap(
                spacing: desktopGapInner,   // GAP: Signature ↔︎ Menu
                runSpacing: 12,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: _buildSignatureSection(context),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: _buildMenuSection(context),
                  ),
                ],
              ),
            ),
          ],
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
            decorationColor: _linkColor,
            decorationThickness: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSignatureSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    // true jika login_client, atau login_token dengan custType 'C'
    final showClientMenus = context.select<AuthenticationBloc, bool>((bloc) {
      final s = bloc.state;
      if (s is AuthenticationAuthenticated) {
        final from = s.authenticatedFrom ?? '';
        final cust = s.user.custType ?? '';
        return from == 'login_client' || (from == 'login_token' && cust == 'C');
      }
      return false;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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

        // HANYA tampil saat client-context
        if (showClientMenus) _buildFooterLink('Aset', () {}),
        if (showClientMenus) _buildFooterLink('Polis', () {}),
        if (showClientMenus) _buildFooterLink('Klaim', () {}),
        if (showClientMenus) _buildFooterLink('Tagihan dan Pembayaran', () {}),

        // Selalu tersedia
        _buildFooterLink('Literasi', () {
          context.read<HomeBloc>().add(PushPageEvent(PageType.about));
        }),
      ],
    );
  }


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
            width: constraints.maxWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
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