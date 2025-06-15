import 'package:flutter/material.dart';
import '../form_step_container.dart';

class InstructionForm extends StatelessWidget {
  const InstructionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width < 768;

        return Padding(
          padding: EdgeInsets.only(
            left: 0,
            top: isMobile ? 8.0 : 16.0,
            right: isMobile ? 8.0 : 0,
          ),
          child: FormStepContainer(
            children: const [
              InstructionStep(
                number: 1,
                text: 'Lengkapi semua informasi yang diminta pada formulir ini.',
                isLast: false,
              ),
              InstructionStep(
                number: 2,
                text: 'Lampirkan dokumen pendukung yang diperlukan sesuai jenis klaim.',
                color: Colors.orange,
                isLast: false,
              ),
              InstructionStep(
                number: 3,
                text: 'Periksa kembali semua informasi sebelum mengirimkan formulir.',
                isLast: false,
              ),
              InstructionStep(
                number: 4,
                text: 'Proses verifikasi klaim membutuhkan waktu 3–5 hari kerja.',
                color: Colors.orange,
                isLast: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class InstructionStep extends StatelessWidget {
  final int number;
  final String text;
  final Color color;
  final bool isLast;

  const InstructionStep({
    super.key,
    required this.number,
    required this.text,
    this.color = const Color(0xFF79AB43),
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width < 768;
        final screenWidth = MediaQuery.of(context).size.width;

        // Responsif padding dan spacing
        final bottomPadding = isMobile ? 12.0 : 4.0;
        final circleRadius = isMobile ? 16.0 : 14.0;
        final fontSize = isMobile ? 15.0 : 16.0;
        final horizontalSpacing = isMobile ? 16.0 : 12.0;
        final lineHeight = isMobile ? 1.4 : 1.5;

        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column for circle and connecting line
                SizedBox(
                  width: isMobile ? 40 : 28,
                  child: Column(
                    children: [
                      // Circle with number
                      CircleAvatar(
                        radius: circleRadius,
                        backgroundColor: color,
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 16 : 14,
                          ),
                        ),
                      ),
                      // Connecting lines (only if not last item)
                      if (!isLast) ...[
                        SizedBox(height: isMobile ? 12 : 8),
                        // Flexible connecting line yang menyesuaikan tinggi text
                        Expanded(
                          child: Container(
                            width: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  color.withOpacity(0.8),
                                  color.withOpacity(0.3),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 12 : 8),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: horizontalSpacing),
                // Text content dengan flex untuk menghindari overflow
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isMobile ? 4.0 : 2.0,
                      right: isMobile ? 8.0 : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: fontSize,
                            height: lineHeight,
                            color: const Color(0xFF2D3748),
                            fontWeight: isMobile ? FontWeight.w500 : FontWeight.normal,
                          ),
                          // Pastikan text tidak overflow dengan soft wrap
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        // Tambahan spacing di mobile untuk readability yang lebih baik
                        if (isMobile && !isLast)
                          const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}