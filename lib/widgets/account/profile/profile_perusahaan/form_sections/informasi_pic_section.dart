import 'package:flutter/material.dart';

/// FORM SECTION: “Informasi PIC”
class InformasiPICSection extends StatelessWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const InformasiPICSection({
    Key? key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);

  /// Daftar field untuk section “Informasi PIC”
  static const List<Map<String, dynamic>> _fields = [
    {'label': 'Nama PIC', 'key': 'namaPic'},
    {'label': 'No. HP PIC', 'key': 'phonePic'},
    {'label': 'Jabatan PIC', 'key': 'jabatanPic'},
  ];

  @override
  Widget build(BuildContext context) {
    // Bangun daftar widget _FieldItem untuk setiap entry di _fields
    final List<Widget> fieldWidgets = _fields.map((f) {
      return _FieldItem(
        label: f['label'] as String,
        controller: controllers[f['key']]!,
        isEditing: isEditing,
        sectionKey: 'Informasi PIC',
      );
    }).toList();

    return _SectionContainer(
      title: 'Informasi PIC :',
      sectionKey: 'Informasi PIC',
      isEditing: isEditing,
      toggleEdit: () => toggleEdit('Informasi PIC'),
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
