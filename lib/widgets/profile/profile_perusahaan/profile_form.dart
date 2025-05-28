import 'package:flutter/material.dart';

class ProfileFormSection extends StatelessWidget {
  final Map<String, bool> editSection;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const ProfileFormSection({
    super.key,
    required this.editSection,
    required this.controllers,
    required this.toggleEdit,
  });

  static const Map<String, List<Map<String, dynamic>>> sectionFields = {
    'Informasi Perusahaan': [
      {'label': 'Nama Badan Usaha', 'key': 'nama'},
      {'label': 'Tipe', 'key': 'tipe'},
      {'label': 'Bentuk Badan', 'key': 'bentuk'},
      {'label': 'No. Klien', 'key': 'klien'},
      {'label': 'Bidang Usaha', 'key': 'bidangUsaha'},
    ],
    'Kontak Perusahaan': [
      {'label': 'Email', 'key': 'email'},
      {'label': 'No. HP', 'key': 'phone'},
      {'label': 'Alamat', 'key': 'alamat', 'maxLines': 2},
      {'label': 'Provinsi', 'key': 'provinsi'},
      {'label': 'Kota', 'key': 'kota'},
      {'label': 'Kode Pos', 'key': 'kodePos'},
    ],
    'Informasi PIC': [
      {'label': 'Nama PIC', 'key': 'namaPic'},
      {'label': 'No. HP PIC', 'key': 'phonePic'},
      {'label': 'Jabatan PIC', 'key': 'jabatanPic'},
    ],
    'Informasi Pajak (Optional)': [
      {'label': 'NPWP', 'key': 'npwp'},
      {'label': 'Alamat NPWP', 'key': 'alamatNpwp', 'maxLines': 2},
      {'label': 'Provinsi (NPWP)', 'key': 'provinsiNpwp'},
      {'label': 'Kota (NPWP)', 'key': 'kotaNpwp'},
      {'label': 'Kode Pos (NPWP)', 'key': 'kodePosNpwp'},
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
        ..._buildSections(['Informasi Perusahaan', 'Kontak Perusahaan', 'Informasi PIC']),
        _buildSectionWithTitle('Informasi Pembayaran :', 'Informasi Pembayaran', [
          _buildField('No. Rekening', controllers['noRekening']!, 'Informasi Pembayaran'),
        ]),
        const SizedBox(height: 16),
        _buildSections(['Informasi Pajak (Optional)']).first,
      ],
    );
  }

  Widget _buildTablet() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSections(['Informasi Perusahaan']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSections(['Kontak Perusahaan']).first),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSections(['Informasi PIC']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSectionWithTitle('Informasi Pembayaran :', 'Informasi Pembayaran', [
              _buildField('No. Rekening', controllers['noRekening']!, 'Informasi Pembayaran'),
            ])),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSections(['Informasi Pajak (Optional)']).first),
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
          crossAxisAlignment: CrossAxisAlignment.start, // <-- penting!
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter, // <-- supaya card nempel ke atas
                child: _buildSections(['Informasi Perusahaan']).first,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSections(['Kontak Perusahaan']).first,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSections(['Informasi PIC']).first,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSectionWithTitle(
                  'Informasi Pembayaran :',
                  'Informasi Pembayaran',
                  [
                    _buildField('No. Rekening', controllers['noRekening']!, 'Informasi Pembayaran'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSections(['Informasi Pajak (Optional)']).first,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: SizedBox(), // Kolom ketiga kosong untuk simetri
            ),
          ],
        )
        ,
      ],
    );
  }

  List<Widget> _buildSections(List<String> keys) {
    return keys.map((sectionKey) {
      final fields = sectionFields[sectionKey]!
          .map((field) => _buildField(
        field['label'],
        controllers[field['key']]!,
        sectionKey,
        maxLines: field['maxLines'] ?? 1,
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

  Widget _buildField(String label, TextEditingController controller, String sectionKey,
      {int maxLines = 1}) {
    final bool isEditing = editSection[sectionKey]!;

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
}