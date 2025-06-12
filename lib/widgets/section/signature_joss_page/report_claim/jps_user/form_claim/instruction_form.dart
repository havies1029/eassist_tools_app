import 'package:flutter/material.dart';
import '../form_step_container.dart';

class InstructionForm extends StatelessWidget {
  const InstructionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 16.0),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for circle and connecting line
          SizedBox(
            width: 28,
            child: Column(
              children: [
                // Circle with number
                CircleAvatar(
                  radius: 14,
                  backgroundColor: color,
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                // Connecting lines (only if not last item)
                if (!isLast) ...[
                  const SizedBox(height: 8),
                  // First line
                  Container(
                    width: 2,
                    height: 14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          color, // langsung warna penuh
                          color,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Second line
                  Container(
                    width: 2,
                    height: 14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          color,
                          color,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Text content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}