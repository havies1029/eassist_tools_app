import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  final BoxConstraints constraints;
  const FooterSection({super.key, required this.constraints});

  static const _primaryColor = Color(0xFF79AB43);
  static const _buttonBorderWidth = 1.5;
  static const _buttonBorderRadius = BorderRadius.all(Radius.circular(8.0));

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // ─── Konten Utama Footer ────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            color: Colors.white,
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.zero,
                child: isMobile
                    ? _buildMobileFooterContent()
                    : _buildDesktopFooterContent(),
              ),
            ),
          ),

          // ─── Copyright Bar ───────────────────────────────
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Container(
                width: maxWidth,
                child: Text(
                  'Protect your future with JPS. © ${DateTime.now().year} JPS Insurance Platform.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: isMobile ? 10.0 : 18.0,
                    color: _primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFooterContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo dan JPS text
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/jps_logo.png', height: 40.0),
              const SizedBox(width: 8.0),
              const Text(
                'JPS',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Nama perusahaan
          const Text(
            'PT. Jaya Proteksindo Sakti,',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4.0),

          // Alamat
          const Text(
            'No. 7 - 9, Jl. Kramat Raya, Kramat, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10450',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 12.0,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20.0),

          // Google Maps Button
          SizedBox(
            height: 36.0,
            child: _buildHoverButtonOutlined(
              icon: Icons.location_on_outlined,
              text: 'Google Maps',
              onPressed: () {},
              fontSize: 12.0,
            ),
          ),

          const SizedBox(height: 20.0),

          // Media Sosial
          const Text(
            'Media Sosial',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20.0),

          // Social Media Buttons
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              SizedBox(
                height: 36.0,
                child: _buildSocialButton(Icons.facebook, 'Facebook', () {}, fontSize: 12.0),
              ),
              SizedBox(
                height: 36.0,
                child: _buildSocialButton(Icons.camera_alt_outlined, 'Instagram', () {}, fontSize: 12.0),
              ),
              SizedBox(
                height: 36.0,
                child: _buildSocialButton(Icons.business_center_outlined, 'LinkedIn', () {}, fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooterContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/jps_logo.png', height: 60.0),
                      const SizedBox(width: 12.0),
                      const Text(
                        'JPS',
                        style: TextStyle(
                          fontFamily: 'Satoshi-Regular',
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'PT. Jaya Proteksindo Sakti',
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'No. 7 - 9, Jl. Kramat Raya, Kramat, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10450',
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 18.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildHoverButtonOutlined(
                    icon: Icons.location_on_outlined,
                    text: 'Google Maps',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Media Sosial',
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      _buildSocialButton(Icons.facebook, 'Facebook', () {}),
                      _buildSocialButton(Icons.camera_alt_outlined, 'Instagram', () {}),
                      _buildSocialButton(Icons.business_center_outlined, 'LinkedIn', () {}),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ],
    );
  }

  Widget _buildHoverButtonOutlined({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    double fontSize = 18.0,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: _primaryColor),
      label: Text(text,
        style: TextStyle(
          fontFamily: 'Satoshi-Regular',
          fontSize: fontSize,
          color: _primaryColor,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: _primaryColor,
          width: _buttonBorderWidth,  // 1.5
        ),
        shape: RoundedRectangleBorder(      // ← Menggunakan RoundedRectangleBorder
          borderRadius: _buttonBorderRadius, // ← Menggunakan radius yang sudah didefinisikan (16.13)
        ),
        padding: EdgeInsets.symmetric(
          horizontal: fontSize < 14.0 ? 16.0 : 24.0,
          vertical: fontSize < 14.0 ? 8.0 : 12.0,
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      IconData icon,
      String text,
      VoidCallback onPressed, {
        double fontSize = 18.0,
      }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16.0, color: _primaryColor),
      label: Text(text,
        style: TextStyle(
          fontFamily: 'Satoshi-Regular',
          fontSize: fontSize,
          color: _primaryColor,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: _primaryColor,
          width: _buttonBorderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: _buttonBorderRadius,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: fontSize < 14.0 ? 12.0 : 16.0,
          vertical: fontSize < 14.0 ? 8.0 : 12.0,
        ),
      ),
    );
  }
}