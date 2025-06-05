import 'package:flutter/material.dart';

class ActionSectionCS extends StatelessWidget {
  final BoxConstraints constraints;

  const ActionSectionCS({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => isMobile ? 20.0 : 40.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: isMobile ? 48 : 50),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 50.0 : 80.0,
        horizontal: sidePadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderText(),
        const SizedBox(height: 24),
        _buildImage(),
        const SizedBox(height: 24),
        _buildSteps(),
        const SizedBox(height: 24),
        Center(child: _buildChatButton()),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildLeftColumn()),
        const SizedBox(width: 60),
        Expanded(flex: 6, child: _buildRightColumn()),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderText(),
        const SizedBox(height: 32),
        _buildImage(),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSteps(),
        const SizedBox(height: 40),
        _buildChatButton(),
      ],
    );
  }

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: _CSStyle.headerTitle(isMobile),
            children: const [
              TextSpan(text: 'Ngobrol Langsung Dengan Tim '),
              TextSpan(text: 'JPS', style: TextStyle(color: _CSStyle.green)),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 16 : 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              style: _CSStyle.description(isMobile),
              children: const [
                TextSpan(text: 'Kami menyediakan layanan chat cepat untuk membantu Anda '),
                TextSpan(text: 'menyelesaikan masalah', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: ', '),
                TextSpan(text: 'mendapatkan informasi', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: ', atau '),
                TextSpan(text: 'bertanya langsung kepada tim kami', style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: '. Chat ini tersedia setiap hari kerja.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: isMobile ? 200 : 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset('assets/images/cs_1.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSteps() {
    final steps = getStepItems(); // List of steps

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 16 : 24),
          child: Text('Langkah-Langkah Menggunakan Chat:', style: _CSStyle.sectionTitle(isMobile)),
        ),
        ...List.generate(steps.length, (index) {
          final step = steps[index];
          return Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 20 : 28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CSStyle.buildStepIcon(index + 1),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.title, style: _CSStyle.stepTitle(isMobile)),
                      const SizedBox(height: 8),
                      Text(step.description, style: _CSStyle.stepDesc(isMobile)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildChatButton() {
    final button = ElevatedButton.icon(
      onPressed: () {
        // TODO: implement chat action
      },
      icon: Image.asset('assets/images/whatsapp.png', width: 20, height: 20),
      label: Text('CHAT SEKARANG', style: _CSStyle.buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: _CSStyle.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 36.0 : 40.0, vertical: 18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 0,
      ),
    );

    return Container(
      width: isMobile ? double.infinity : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(color: _CSStyle.green.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: isMobile ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}

// ==========================
// STYLING & STYLE CONSTANTS
// ==========================

class _CSStyle {
  static const String font = 'Satoshi-Regular';
  static const Color green = Color(0xFF79AB43);
  static const Color dark = Color(0xFF1C1C1C);
  static const Color gray = Color(0xFF666666);

  static TextStyle headerTitle(bool isMobile) => TextStyle(
    fontFamily: font,
    fontSize: isMobile ? 20 : 36,
    fontWeight: FontWeight.w700,
    color: dark,
    height: 1.2,
  );

  static TextStyle description(bool isMobile) => TextStyle(
    fontFamily: font,
    fontSize: isMobile ? 15 : 16,
    color: gray,
    height: 1.6,
  );

  static TextStyle sectionTitle(bool isMobile) => TextStyle(
    fontFamily: font,
    fontSize: isMobile ? 15 : 24,
    fontWeight: FontWeight.w600,
    color: dark,
  );

  static TextStyle stepTitle(bool isMobile) => TextStyle(
    fontSize: isMobile ? 16 : 24,
    fontWeight: FontWeight.w600,
    fontFamily: font,
    color: dark,
    height: 1.3,
  );

  static TextStyle stepDesc(bool isMobile) => TextStyle(
    fontSize: isMobile ? 14 : 16,
    height: 1.6,
    fontFamily: font,
    color: gray,
  );

  static TextStyle buttonText = TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static Widget buildStepIcon(int index) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: green.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Center(
        child: Text('$index', style: const TextStyle(color: green, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: font)),
      ),
    );
  }
}

// ========================================
// DATA LANGKAH (Sementara Hardcode / API)
// ========================================

class StepItem {
  final String title;
  final String description;

  StepItem({required this.title, required this.description});
}

List<StepItem> getStepItems() {
  return [
    StepItem(
      title: 'Mulai Percakapan',
      description: 'Klik tombol Chat Sekarang, kirim pesan pertama Anda. Jelaskan pertanyaan atau kebutuhan secara singkat agar kami bisa bantu dengan cepat.',
    ),
    StepItem(
      title: 'Respons Instan',
      description: 'Tim customer care kami akan merespons dalam hitungan menit. Anda akan langsung terhubung dengan staf berpengalaman yang siap memberikan solusi terbaik.',
    ),
    StepItem(
      title: 'Riwayat Selalu Tersimpan',
      description: 'Semua percakapan akan tersimpan dengan aman untuk memudahkan Anda melakukan tindak lanjut di kemudian hari.',
    ),
  ];
}