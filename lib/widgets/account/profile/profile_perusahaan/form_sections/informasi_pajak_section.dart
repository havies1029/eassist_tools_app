import 'package:flutter/material.dart';

/// FORM SECTION: “Informasi Pajak (Optional)”
class InformasiPajakSection extends StatelessWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const InformasiPajakSection({
    Key? key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);

  /// Daftar field untuk section “Informasi Pajak (Optional)”
  static const List<Map<String, dynamic>> _fields = [
    {'label': 'NPWP', 'key': 'npwp'},
    {'label': 'Alamat NPWP', 'key': 'alamatNpwp', 'maxLines': 2},
    {'label': 'Provinsi (NPWP)', 'key': 'provinsiNpwp'},
    {'label': 'Kota (NPWP)', 'key': 'kotaNpwp'},
    {'label': 'Kode Pos (NPWP)', 'key': 'kodePosNpwp'},
  ];

  @override
  Widget build(BuildContext context) {
    // Bangun daftar widget untuk setiap entry di _fields
    final List<Widget> fieldWidgets = _fields.map((f) {
      // Jika key termasuk dropdown‐like, gunakan _FieldDropdownItem
      if (f['key'] == 'provinsiNpwp' ||
          f['key'] == 'kotaNpwp' ||
          f['key'] == 'kodePosNpwp') {
        return _FieldDropdownItem(
          label: f['label'] as String,
          controller: controllers[f['key']]!,
          isEditing: isEditing,
          sectionKey: 'Informasi Pajak (Optional)',
        );
      } else {
        // Field teks biasa
        final int maxLines = f.containsKey('maxLines') ? f['maxLines'] as int : 1;
        return _FieldItem(
          label: f['label'] as String,
          controller: controllers[f['key']]!,
          isEditing: isEditing,
          sectionKey: 'Informasi Pajak (Optional)',
          maxLines: maxLines,
        );
      }
    }).toList();

    return _SectionContainer(
      title: 'Informasi Pajak (Optional) :',
      sectionKey: 'Informasi Pajak (Optional)',
      isEditing: isEditing,
      toggleEdit: () => toggleEdit('Informasi Pajak (Optional)'),
      children: fieldWidgets,
    );
  }
}

/// Kelas pembantu untuk satu field teks (label + TextField/Text)
class _FieldItem extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final String sectionKey;
  final int maxLines;

  const _FieldItem({
    Key? key,
    required this.label,
    required this.controller,
    required this.isEditing,
    required this.sectionKey,
    this.maxLines = 1,
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
              maxLines: maxLines,
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

/// Kelas pembantu untuk satu field dropdown‐like (readOnly + onTap)
class _FieldDropdownItem extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final String sectionKey;

  const _FieldDropdownItem({
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
          InkWell(
            onTap: isEditing
                ? () {
              // TODO: tampilkan modal bottom sheet atau dialog pilihan provinsi/kota/kodepos
            }
                : null,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Text(
                controller.text.isEmpty ? '— Pilih $label —' : controller.text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.text.isEmpty ? Colors.grey : Colors.black,
                ),
              ),
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
