import 'package:flutter/material.dart';

// IMPORT SEMUA SECTION YANG SUDAH DI‐SPLIT
import 'form_sections/rekan_contact_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_general_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_pajak_form_body.dart';
import 'form_sections/informasi_pic_section.dart';
import 'form_sections/informasi_pembayaran_section.dart';

class ProfileFormSection extends StatelessWidget {
  final Map<String, bool> editSection;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const ProfileFormSection({
    Key? key,
    required this.editSection,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 1) RekanGeneralFormBody (menggantikan posisi RekanPajakFormBody)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RekanGeneralFormBody(
                viewMode: 'tambah',
                recordId: '',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2) RekanContactFormBody (menggantikan posisi RekanGeneralFormBody)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RekanContactFormBody(
                viewMode: 'tambah',
                recordId: '',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3) Informasi PIC (tetap sama)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InformasiPICSection(
                isEditing: editSection['Informasi PIC'] ?? false,
                controllers: controllers,
                toggleEdit: toggleEdit,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 4) Informasi Pembayaran (tetap sama)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InformasiPembayaranSection(
                isEditing: editSection['Informasi Pembayaran'] ?? false,
                controller: controllers['noRekening']!,
                toggleEdit: toggleEdit,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 5) RekanPajakFormBody (menggantikan posisi RekanContactFormBody)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RekanPajakFormBody(
                viewMode: 'tambah',
                recordId: '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Baris pertama: 2 kolom (RekanGeneralFormBody | RekanContactFormBody)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RekanGeneralFormBody(
                      viewMode: 'tambah',
                      recordId: '',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RekanContactFormBody(
                      viewMode: 'tambah',
                      recordId: '',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Baris kedua: 2 kolom (Informasi PIC | Informasi Pembayaran)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InformasiPICSection(
                      isEditing: editSection['Informasi PIC'] ?? false,
                      controllers: controllers,
                      toggleEdit: toggleEdit,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InformasiPembayaranSection(
                      isEditing: editSection['Informasi Pembayaran'] ?? false,
                      controller: controllers['noRekening']!,
                      toggleEdit: toggleEdit,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Baris ketiga: 1 kolom (RekanPajakFormBody)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RekanPajakFormBody(
                      viewMode: 'tambah',
                      recordId: '',
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Baris pertama: 3 kolom (RekanGeneralFormBody | RekanContactFormBody | Informasi PIC)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RekanGeneralFormBody(
                        viewMode: 'tambah',
                        recordId: '',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RekanContactFormBody(
                        viewMode: 'tambah',
                        recordId: '',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InformasiPICSection(
                        isEditing: editSection['Informasi PIC'] ?? false,
                        controllers: controllers,
                        toggleEdit: toggleEdit,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Baris kedua: 2 kolom (Informasi Pembayaran | RekanPajakFormBody) + kolom kosong
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InformasiPembayaranSection(
                        isEditing: editSection['Informasi Pembayaran'] ?? false,
                        controller: controllers['noRekening']!,
                        toggleEdit: toggleEdit,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RekanPajakFormBody(
                        viewMode: 'tambah',
                        recordId: '',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: SizedBox()), // kolom ketiga kosong
            ],
          ),
        ],
      ),
    );
  }
}
