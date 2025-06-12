import 'package:flutter/material.dart';
import '../form_step_container.dart';

class ClaimPaymentForm extends StatelessWidget {
  const ClaimPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormStepContainer(
      children: [
        const _SectionTitle(
          icon: Icons.account_balance,
          title: 'Informasi Bank untuk Pembayaran Klaim',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          children: const [
            _InputField(label: 'Nama Bank'),
            _InputField(label: 'Nomor Rekening'),
            _InputField(label: 'Nama Pemilik Rekening', isFullWidth: true),
          ],
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final bool isFullWidth;

  const _InputField({
    required this.label,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    final width = isFullWidth || !isWide ? double.infinity : (MediaQuery.of(context).size.width - 120) / 2;

    return SizedBox(
      width: width,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }
}
