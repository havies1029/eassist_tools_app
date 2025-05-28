import 'package:flutter/material.dart';

class ProfileIndividuFormSection extends StatelessWidget {
  final Map<String, bool> editSection;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  ProfileIndividuFormSection({
    Key? key,
    required this.editSection,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);


  static const Map<String, List<Map<String, dynamic>>> sectionFields = {
    'Informasi Klien': [
      {'label': 'Nama Lengkap', 'key': 'nama'},
      {'label': 'Tipe', 'key': 'tipe'},
      {'label': 'No. Klien', 'key': 'klien'},
      {'label': 'Gender', 'key': 'gender'},
    ],
    'Kontak Klien': [
      {'label': 'Email', 'key': 'email'},
      {'label': 'No. HP', 'key': 'phone'},
      {'label': 'Alamat', 'key': 'alamat', 'maxLines': 2},
      {'label': 'Provinsi', 'key': 'provinsi'},
      {'label': 'Kota', 'key': 'kota'},
      {'label': 'Kode Pos', 'key': 'kodePos'},
    ],
    'Identitas dan Rekening': [
      {'label': 'KTP', 'key': 'ktp', 'isSpecial': true},
      {'label': 'Rekening Bank', 'key': 'rekeningBank', 'isSpecial': true},
      {'label': 'No. Rekening', 'key': 'noRekening'},
      {'label': 'NPWP', 'key': 'npwp'},
      {'label': 'Pekerjaan', 'key': 'pekerjaan'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final bool isMobile = maxWidth < 768;
    final bool isTablet = maxWidth >= 768 && maxWidth < 1024;

    if (isMobile) return _buildMobile();
    if (isTablet) return _buildTablet();
    return _buildDesktop();
  }

  Widget _buildMobile() {
    return Column(
      children: [
        ..._buildSections(['Informasi Klien', 'Kontak Klien', 'Identitas dan Rekening']),
      ],
    );
  }

  Widget _buildTablet() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSections(['Informasi Klien']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSections(['Kontak Klien']).first),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSections(['Identitas dan Rekening']).first),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSections(['Informasi Klien']).first,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSections(['Kontak Klien']).first,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSections(['Identitas dan Rekening']).first,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildSections(List<String> keys) {
    return keys.map((sectionKey) {
      final fields = sectionFields[sectionKey]!
          .map((field) => _buildField(
        field['label'],
        field['key'],
        sectionKey,
        maxLines: field['maxLines'] ?? 1,
        isSpecial: field['isSpecial'] ?? false,
      ))
          .toList();

      return Column(
        children: [
          _buildSectionWithTitle('$sectionKey :', sectionKey, fields),
          const SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget _buildSectionWithTitle(String title, String sectionKey, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              onTap: () => toggleEdit(sectionKey),
              child: Icon(
                editSection[sectionKey]! ? Icons.check : Icons.edit,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
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

  Widget _buildField(String label, String key, String sectionKey,
      {int maxLines = 1, bool isSpecial = false}) {
    final bool isEditing = editSection[sectionKey]!;

    if (isSpecial) {
      return _buildSpecialField(label, key, sectionKey);
    }

    final controller = controllers[key];
    if (controller == null) return const SizedBox.shrink();

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
              controller.text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialField(String label, String key, String sectionKey) {
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
          if (key == 'ktp') ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey.shade50,
              ),
              child: const Text(
                'KTP',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                'Upload KTP',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ] else if (key == 'rekeningBank') ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  // Plus icon
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Payment method icons
                  Container(
                    width: 32,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 32,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 32,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'AM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 32,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'V',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}