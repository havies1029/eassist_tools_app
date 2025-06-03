import 'package:flutter/material.dart';

/// FORM SECTION: “Informasi Pembayaran”
class InformasiPembayaranSection extends StatelessWidget {
  final bool isEditing;
  final TextEditingController controller;
  final void Function(String sectionKey) toggleEdit;

  const InformasiPembayaranSection({
    Key? key,
    required this.isEditing,
    required this.controller,
    required this.toggleEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> fieldWidgets = [
      _FieldItem(
        label: 'No. Rekening',
        controller: controller,
        isEditing: isEditing,
        sectionKey: 'Informasi Pembayaran',
      ),
    ];

    return _SectionContainer(
      title: 'Informasi Pembayaran :',
      sectionKey: 'Informasi Pembayaran',
      isEditing: isEditing,
      toggleEdit: () => toggleEdit('Informasi Pembayaran'),
      children: fieldWidgets,
    );
  }
}

/// Kelas pembantu untuk satu field (label + TextField/Text)
class _FieldItem extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final String sectionKey;

  const _FieldItem({
    Key? key,
    required this.label,
    required this.controller,
    required this.isEditing,
    required this.sectionKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: isEditing
                ? TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration.collapsed(hintText: ''),
              style: const TextStyle(fontSize: 16),
            )
                : Text(
              controller.text.isEmpty ? '-' : controller.text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kelas pembantu untuk container setiap section: judul + ikon edit + daftar children
class _SectionContainer extends StatelessWidget {
  final String title;
  final String sectionKey;
  final bool isEditing;
  final VoidCallback toggleEdit;
  final List<Widget> children;

  const _SectionContainer({
    Key? key,
    required this.title,
    required this.sectionKey,
    required this.isEditing,
    required this.toggleEdit,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: judul section + ikon edit/cek
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: toggleEdit,
              child: Icon(
                isEditing ? Icons.check : Icons.edit,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Kartu putih ber‐padding dan shadow
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}
