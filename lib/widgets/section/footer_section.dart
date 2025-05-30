import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  final BoxConstraints constraints;

  const FooterSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

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
            color: Colors.white, // 🔁 No shadow
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.zero,
                child: isMobile ? _buildMobileFooterContent() : _buildDesktopFooterContent(),
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
                    fontSize: isMobile ? 10.0 : 18.0, // ⬅️ Responsive font size
                    color: const Color(0xFF79AB43),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // RATA KIRI
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/images/jps_logo.png', height: 70.0),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'PT. Jaya Proteksindo Sakti',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 15.0, // lebih kecil
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 6.0),
        const Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: Text(
            'No. 7 - 9, Jl. Kramat Raya, Kramat, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10450',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 13.0, // lebih kecil
              color: Colors.black54,
              height: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildHoverButtonOutlined(
            icon: Icons.location_on_outlined,
            text: 'Google Maps',
            onPressed: () {},
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 28.0),
        const Text(
          'Media Sosial',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 15.0, // lebih kecil
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 12.0),
        // Social button rata kiri (Wrap alignment: start)
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.0,
          runSpacing: 10.0,
          children: [
            _buildSocialButton(Icons.facebook, 'Facebook', () {}, fontSize: 14.0),
            _buildSocialButton(Icons.camera_alt_outlined, 'Instagram', () {}, fontSize: 14.0),
            _buildSocialButton(Icons.business_center_outlined, 'LinkedIn', () {}, fontSize: 14.0),
          ],
        ),
      ],
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
                  // ✅ Logo dan Tulisan JPS horizontal
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
                          color: Color(0xFF79AB43),
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
    double fontSize = 18.0, // default tetap 18, mobile bisa override jadi 14
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color(0xFF79AB43)),
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Satoshi-Regular',
          fontSize: fontSize,
          color: const Color(0xFF79AB43),
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF79AB43)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String text, VoidCallback onPressed, {double fontSize = 18.0}) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16.0, color: const Color(0xFF79AB43)),
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Satoshi-Regular',
          fontSize: fontSize,
          color: Colors.black87,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}
