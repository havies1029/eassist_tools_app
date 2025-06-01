import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SectionKontakKlien extends StatelessWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final VoidCallback toggleEdit;

  const SectionKontakKlien({
    super.key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSectionContainer(
      title: 'Kontak Klien',
      sectionKey: 'Kontak Klien',
      children: [
        _buildLabelText('Email'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'email',
          hintText: 'contoh@mail.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),

        _buildLabelText('No. HP'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'phone',
          hintText: '08xxxxxxxxxx',
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 12),

        _buildLabelText('Alamat'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'alamat',
          hintText: 'Masukkan alamat lengkap',
          keyboardType: TextInputType.multiline,
          maxLines: 2,
        ),
        const SizedBox(height: 12),

        _buildLabelText('Provinsi'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'provinsi',
          hintText: 'Pilih provinsi',
          readOnly: true,
          onTap: () {
            if (isEditing) {
              // TODO: panggil API provinsi
            }
          },
        ),
        const SizedBox(height: 12),

        _buildLabelText('Kota'),
        const SizedBox(height: 6),
        _buildTextField(
          keyName: 'kota',
          hintText: 'Pilih kota',
          readOnly: true,
          onTap: () {
            if (isEditing) {
              // TODO: panggil API kota berdasarkan provinsi
            }
          },
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
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controllers[keyName],
      readOnly: !isEditing || readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      onTap: onTap,
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
