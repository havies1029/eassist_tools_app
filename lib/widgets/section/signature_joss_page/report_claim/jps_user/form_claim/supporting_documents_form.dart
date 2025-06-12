import 'package:flutter/material.dart';
import '../form_step_container.dart';

class SupportingDocumentsForm extends StatelessWidget {
  const SupportingDocumentsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormStepContainer(
      children: [
        const _SectionTitle(
          icon: Icons.attachment_outlined,
          title: 'Unggah Dokumen Pendukung',
        ),
        const SizedBox(height: 16),

        // Dokumen 1
        const _UploadField(label: 'KTP (Wajib)'),
        const SizedBox(height: 12),

        // Dokumen 2
        const _UploadField(label: 'Dokumen Polis (Opsional)'),
        const SizedBox(height: 12),

        // Dokumen 3
        const _UploadField(label: 'Bukti Kejadian atau Kerugian (Opsional)'),
        const SizedBox(height: 12),

        // Tambahan catatan
        const _InputField(
          label: 'Catatan Tambahan (Opsional)',
          maxLines: 3,
          isFullWidth: true,
        ),
      ],
    );
  }
}

class _UploadField extends StatelessWidget {
  final String label;
  const _UploadField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Implementasi upload nanti bisa ditambah
          },
          icon: const Icon(Icons.upload_file),
          label: const Text("Pilih File"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF79AB43),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final int maxLines;
  final bool isFullWidth;

  const _InputField({
    required this.label,
    this.maxLines = 1,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    final width = isFullWidth || !isWide ? double.infinity : (MediaQuery.of(context).size.width - 120) / 2;

    return SizedBox(
      width: width,
      child: TextField(
        maxLines: maxLines,
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
