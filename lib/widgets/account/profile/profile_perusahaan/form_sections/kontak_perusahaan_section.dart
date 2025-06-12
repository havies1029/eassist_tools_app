import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// FORM SECTION: “Kontak Perusahaan”
class KontakPerusahaanSection extends StatelessWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const KontakPerusahaanSection({
    Key? key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);

  /// Daftar field untuk section “Kontak Perusahaan”
  static const List<Map<String, dynamic>> _fields = [
    {'label': 'Email', 'key': 'email'},
    {'label': 'No. HP', 'key': 'phone'},
    {'label': 'Alamat', 'key': 'alamat', 'maxLines': 2},
    {'label': 'Provinsi', 'key': 'provinsi'},
    {'label': 'Kota', 'key': 'kota'},
    {'label': 'Kode Pos', 'key': 'kodePos'},
  ];

  @override
  Widget build(BuildContext context) {
    // Bangun daftar widget untuk setiap field di _fields
    final List<Widget> fieldWidgets = _fields.map((f) {
      // Jika field bersifat dropdown (Provinsi, Kota, Kode Pos), gunakan _FieldDropdownItem
      if (f['key'] == 'provinsi' || f['key'] == 'kota' || f['key'] == 'kodePos') {
        return _FieldDropdownItem(
          label: f['label'] as String,
          controller: controllers[f['key']]!,
          isEditing: isEditing,
          sectionKey: 'Kontak Perusahaan',
        );
      } else {
        // Field teks biasa
        final int maxLines = f.containsKey('maxLines') ? f['maxLines'] as int : 1;
        return _FieldItem(
          label: f['label'] as String,
          controller: controllers[f['key']]!,
          isEditing: isEditing,
          sectionKey: 'Kontak Perusahaan',
          maxLines: maxLines,
        );
      }
    }).toList();

    return _SectionContainer(
      title: 'Kontak Perusahaan :',
      sectionKey: 'Kontak Perusahaan',
      isEditing: isEditing,
      toggleEdit: () => toggleEdit('Kontak Perusahaan'),
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
              // TODO: tambahkan logika untuk menampilkan pilihan dropdown
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
