import 'package:flutter/material.dart';

// IMPORT SEMUA SECTION YANG SUDAH DI‐SPLIT
import '../../../pages/login/login_form.dart';
import '../../PopUp/ConfirmationDialog.dart';
import '../../PopUp/Popup_Succeed.dart';
import '../../login/login_client/LoginClientPage.dart';
import 'form_sections/rekan_contact_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_general_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_pajak_form_body.dart';
import 'form_sections/informasi_pic_section.dart';
import 'form_sections/informasi_pembayaran_section.dart';

class ProfileFormSection extends StatefulWidget {
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
  _ProfileFormSectionState createState() => _ProfileFormSectionState();
}

class _ProfileFormSectionState extends State<ProfileFormSection> {
  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => ConfirmationDialog(
        onConfirm: () {
          // Tutup dialog konfirmasi
          Navigator.of(context).pop();

          // Setelah dialog konfirmasi ditutup, tampilkan PopupSuceedPage
          showDialog(
            context: context,
            barrierColor: Colors.black54,
            builder: (context) => PopupSuceedPage(
              message: 'Register sebagai Client telah sukses.\n'
                  'Silakan mengecek password di email yang telah di daftarkan',
              onOk: () {
                // Lanjut ke halaman LoginClientPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginClientPage()),
                );
              },
            ),
          );
        },
      ),
    );
  }

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
          // 1) RekanGeneralFormBody
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

          // 2) RekanContactFormBody
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

          // 3) Informasi PIC
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InformasiPICSection(
                isEditing: widget.editSection['Informasi PIC'] ?? false,
                controllers: widget.controllers,
                toggleEdit: widget.toggleEdit,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 4) Informasi Pembayaran
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InformasiPembayaranSection(
                isEditing: widget.editSection['Informasi Pembayaran'] ?? false,
                controller: widget.controllers['noRekening']!,
                toggleEdit: widget.toggleEdit,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 5) RekanPajakFormBody
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
          const SizedBox(height: 32),

          // 1 Button di Paling Bawah (langsung aktif)
          ElevatedButton(
            onPressed: _showSuccessPopup,
            child: const Text('Lanjutkan Seluruh Form'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 24),
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
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
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
                  ],
                ),
              ),
            ],
          ),

          // Baris kedua: 2 kolom (Informasi PIC | Informasi Pembayaran)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InformasiPICSection(
                          isEditing: widget.editSection['Informasi PIC'] ?? false,
                          controllers: widget.controllers,
                          toggleEdit: widget.toggleEdit,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InformasiPembayaranSection(
                          isEditing: widget.editSection['Informasi Pembayaran'] ?? false,
                          controller: widget.controllers['noRekening']!,
                          toggleEdit: widget.toggleEdit,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),

          // Baris ketiga: 1 kolom (RekanPajakFormBody)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),

          const SizedBox(height: 32),

          // 1 Button di Paling Bawah (langsung aktif)
          ElevatedButton(
            onPressed: _showSuccessPopup,
            child: const Text('Lanjutkan Seluruh Form'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Baris pertama: 3 kolom (RekanGeneral | RekanContact | PIC)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Align(
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InformasiPICSection(
                            isEditing: widget.editSection['Informasi PIC'] ?? false,
                            controllers: widget.controllers,
                            toggleEdit: widget.toggleEdit,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
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
                        isEditing: widget.editSection['Informasi Pembayaran'] ?? false,
                        controller: widget.controllers['noRekening']!,
                        toggleEdit: widget.toggleEdit,
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
              const Expanded(child: SizedBox()),
            ],
          ),

          const SizedBox(height: 32),

          // 1 Button di Paling Bawah (langsung aktif)
          ElevatedButton(
            onPressed: _showSuccessPopup,
            child: const Text('Lanjutkan Seluruh Form'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
