import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SectionIdentitasRekening extends StatelessWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final VoidCallback toggleEdit;

  const SectionIdentitasRekening({
    super.key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSectionContainer(
      title: 'Identitas dan Rekening',
      sectionKey: 'Identitas dan Rekening',
      children: [
        _buildLabelText('KTP'),
        const SizedBox(height: 6),
        _buildSpecialField(
          keyName: 'ktp',
          placeholderText: controllers['ktp']?.text.isNotEmpty == true
              ? controllers['ktp']!.text
              : 'Belum ada file',
          onTap: () {
            if (isEditing) {
              // TODO: implementasi file picker untuk upload KTP
            }
          },
        ),
        const SizedBox(height: 12),

        _buildLabelText('Rekening Bank'),
        const SizedBox(height: 6),
        _buildSpecialField(
          keyName: 'rekeningBank',
          placeholderText: 'Pilih bank',
          onTap: () {
            if (isEditing) {
              // TODO: implementasi modal pilih bank
            }
          },
        ),
        const SizedBox(height: 12),

        _buildLabelText('No. Rekening'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'noRekening',
          hintText: 'Masukkan nomor rekening',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 12),

        _buildLabelText('NPWP'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'npwp',
          hintText: 'Masukkan NPWP',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controllers[keyName],
      readOnly: !isEditing,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  Widget _buildSpecialField({
    required String keyName,
    required String placeholderText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
          color: isEditing ? Colors.grey.shade100 : Colors.grey.shade200,
        ),
        child: Text(
          placeholderText,
          style: TextStyle(
            color: controllers[keyName]?.text.isEmpty ?? true
                ? Colors.grey
                : Colors.black,
          ),
        ),
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
