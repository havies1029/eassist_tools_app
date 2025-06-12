import 'package:flutter/material.dart';

class SectionInformasiKlien extends StatelessWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final VoidCallback toggleEdit;

  const SectionInformasiKlien({
    super.key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSectionContainer(
      title: 'Informasi Klien',
      sectionKey: 'Informasi Klien',
      children: [
        _buildLabelText('Nama Lengkap'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'nama',
          hintText: 'Masukkan nama lengkap',
        ),
        const SizedBox(height: 12),

        _buildLabelText('Tipe'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'tipe',
          hintText: 'Masukkan tipe',
        ),
        const SizedBox(height: 12),

        _buildLabelText('No. Klien'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'klien',
          hintText: 'Masukkan nomor klien',
        ),
        const SizedBox(height: 12),

        _buildLabelText('Gender'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'gender',
          hintText: 'Masukkan gender',
        ),
      ],
    );
  }

  Widget _buildLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField({
    required String keyName,
    required String hintText,
  }) {
    return TextField(
      controller: controllers[keyName],
      readOnly: !isEditing,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required String sectionKey,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit),
                onPressed: toggleEdit,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
