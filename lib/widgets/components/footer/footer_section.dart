import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterSection extends StatelessWidget {
  final BoxConstraints constraints;

  const FooterSection({super.key, required this.constraints});

  // ─── Colors ───────────────────────────────────────────────
  static const _primaryColor = Color(0xFF79AB43);

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

  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : constraints.maxWidth * 0.9;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 95
      : constraints.maxWidth > 992
      ? 64
      : constraints.maxWidth > 768
      ? 48
      : 24;

  // ─── Responsive Font Sizes ───────────────────────────────
  double get logoFontSize => isMobile ? 24.0 : 30.0;
  double get titleFontSize => isMobile ? 15.0 : 18.0;
  double get linkFontSize => isMobile ? 15.0 : 16.0;
  double get smallTextFontSize => 15.0;

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
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              color: Colors.white,
              child: Center(
                child: Container(
                  width: maxWidth,
                  child: _buildFooterContent(),
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

  Widget _buildFooterContent() {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogoSection(),
          const SizedBox(height: 20.0),
          _buildGoogleMapsButton(),
          const SizedBox(height: 16.0),
          _buildCompanyInfo(),
          const SizedBox(height: 10.0),
          _buildSocialMediaSection(),
          const SizedBox(height: 30.0),

          _buildSignatureSection(),
          const SizedBox(height: 20.0),
          _buildMenuSection(),
          const SizedBox(height: 20.0),
          _buildSupportSection(),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogoSection(),
                const SizedBox(height: 20.0),
                _buildGoogleMapsButton(),
                const SizedBox(height: 24.0),
                _buildCompanyInfo(),
                const SizedBox(height: 16.0),
                _buildSocialMediaSection(),
              ],
            ),
          ),
          const SizedBox(width: 40.0),
          Expanded(flex: 2, child: _buildSignatureSection()),
          const SizedBox(width: 40.0),
          Expanded(flex: 2, child: _buildMenuSection()),
          const SizedBox(width: 40.0),
          Expanded(flex: 2, child: _buildSupportSection()),
        ],
      );
    }
  }

  Widget _buildLogoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/JPS.png', height: isMobile ? 40.0 : 40.0),
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
            fontSize: isMobile ? titleFontSize : titleFontSize,
            fontWeight: FontWeight.bold,
            color: _primaryTextColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'No. 7 - 9, Jl. Kramat Raya, Kramat, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10450',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: titleFontSize,
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
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: isMobile ? 8.0 : 12.0,
      runSpacing: isMobile ? 8.0 : 12.0,
      children: [
        _buildSvgSocialIconButton('instagram.svg', () {}),
        _buildSvgSocialIconButton('linkedin.svg', () {}),
        _buildSvgSocialIconButton('facebook.svg', () {}),
      ],
    );
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
            'Protect your future with JPS.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: titleFontSize,
              color: _secondaryTextColor,
            ),
          ),
          Text(
            '© ${DateTime.now().year} JPS Insurance Platform.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: titleFontSize,
              color: _secondaryTextColor,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            'All Rights Reserved',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: smallTextFontSize,
              color: _secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8.0),
          _buildLegalLinks(), // Berisi Terms and Privacy
        ],
      );
    } else {
      return SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Protect your future with JPS. © ${DateTime.now().year} JPS Insurance Platform.',
              style: TextStyle(
                fontFamily: _fontFamily,
                fontSize: titleFontSize,
                color: _secondaryTextColor,
              ),
            ),
            Row(
              children: [
                Text(
                  'All Rights Reserved |',
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: smallTextFontSize,
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
        GestureDetector(
          onTap: () {},
          child: Text(
            'Terms and Conditions',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: smallTextFontSize,
              color: _linkColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          ' | ',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: smallTextFontSize,
            color: _secondaryTextColor,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Privacy Policy',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: smallTextFontSize,
              color: _linkColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Signature',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        SizedBox(height: isMobile ? 8.0 : 16.0),
        _buildFooterLink('Cari Asuransi', () {}),
        _buildFooterLink('Lapor Klaim', () {}),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
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
        _buildFooterLink('Management Aset', () {}),
        _buildFooterLink('Management Polis', () {}),
        _buildFooterLink('Management Klaim', () {}),
        _buildFooterLink('Tagihan dan Pembayaran', () {}),
        _buildFooterLink('Literasi', () {}),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support',
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        SizedBox(height: isMobile ? 8.0 : 16.0),
        _buildFooterLink('Customer Services', () {}),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 4.0 : 8.0),
      child: GestureDetector(
        onTap: onPressed,
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
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.location_on_outlined, color: _primaryColor),
      label: Text(
        'Google Maps',
        style: TextStyle(
          fontFamily: _fontFamily,
          fontSize: titleFontSize,
          color: _primaryColor,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: _primaryColor,
          width: _buttonBorderWidth,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: _buttonBorderRadius,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: titleFontSize < 14.0 ? 16.0 : 24.0,
          vertical: titleFontSize < 14.0 ? 8.0 : 12.0,
        ),
      ),
    );
  }

  Widget _buildSvgSocialIconButton(String assetName, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/icons/$assetName',
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(_primaryColor, BlendMode.srcIn),
      ),
      splashRadius: 20,
    );
  }
}