import 'package:flutter/material.dart';

class FeatureSection extends StatelessWidget {
  final BoxConstraints constraints;
  const FeatureSection({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 70.0),
      child: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Text
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: 25.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Kami Membantu Anda '),
                        TextSpan(
                          text: 'Terlindungi',
                          style: TextStyle(
                            color: Color(0xFF79AB43),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' dengan Lebih Baik Setiap Hari.'),
                      ],
                    ),
                  ),
                ),
              ),
              // Main Content Row
              if (isMobile)
                Column(
                  children: [
                    _buildFeatureTitle(),
                    const SizedBox(height: 40.0),
                    _buildFeatureList(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kolom KIRI - Judul dan subjudul
                    Container(
                      width: 520, // ✅ Lebar tetap agar tidak terlalu lebar
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: _buildFeatureTitle(),
                      ),
                    ),

                    // Spacer kecil agar tidak terlalu rapat
                    const SizedBox(width: 20.0),

                    // Kolom KANAN - List fitur
                    Expanded( // ✅ Ambil sisa ruang agar lebih fleksibel dan lebar
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: _buildFeatureList(),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bagian Judul
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
            children: [
              TextSpan(text: 'Bagaimana '),
              TextSpan(
                text: 'JPS',
                style: TextStyle(color: Color(0xFF79AB43)),
              ),
              TextSpan(text: ' membantu'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Asuransi Anda Lebih Baik',
          style: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 20.0),

        // 🔧 Tambahkan batasan max width agar paragraf rata sejajar dengan judul
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600), // Ubah nilai sesuai lebar ideal heading
          child: const Text(
            'We turn your insurance ideas into engaging visuals that build trust,\ndrive clarity, and keep your audience informed and connected.',
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 20.0,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 30.0),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              const Icon(Icons.star, color: Color(0xFFFFD700), size: 20.0),
            const SizedBox(width: 8.0),
            const Text(
              '4.9 / 5 rating',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Approved by Client JPS',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic, // ⬅️ Tambahkan ini// ⬅️ Ubah jadi normal (hilangkan bold)
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          _buildFeatureItem(
            icon: Icons.check_circle_outline,
            title: 'Menginformasikan. Melindungi. Meyakinkan.',
            description:
            'Menyediakan informasi yang jelas, melindungi kepentingan Anda,\ndan memberikan rasa aman dalam setiap klaim asuransi.',
          ),
          const SizedBox(height: 32.0),
          _buildFeatureItem(
            icon: Icons.person_outline,
            title: 'Membangun Kepercayaan Klien',
            description:
            'Klaim yang cepat dan transparan membangun kepercayaan penuh untuk setiap langkah perlindungan Anda.',
          ),
          const SizedBox(height: 32.0),
          _buildFeatureItem(
            icon: Icons.description_outlined,
            title: 'Menyederhanakan Info Asuransi',
            description:
            'Proses klaim yang mudah dimengerti, mempermudah Anda dalam memahami hak dan perlindungan asuransi.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE9ECEF), width: 1.0),
          ),
          child: Center(
            child: Icon(icon, color: const Color(0xFF79AB43), size: 24.0),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
