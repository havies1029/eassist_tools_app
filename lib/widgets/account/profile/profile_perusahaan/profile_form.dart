import 'package:flutter/material.dart';
import '../../../dialog/PopUp/confirmation_dialog.dart';
import '../../../dialog/PopUp/success_popup.dart';
import '../../../account/login/login_client/login_client_dialog.dart';
import 'form_sections/rekan_general_form_body.dart';
import 'form_sections/rekan_contact_form_body.dart';
import 'form_sections/rekan_pajak_form_body.dart';
import 'form_sections/rekan_pic_form_body.dart';
import 'form_sections/rekan_bank_form_body.dart';

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
    // Pindahkan implementasi dialog sesuai kebutuhan Anda
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => ConfirmationDialog(
        onConfirm: () {
          // Ketika tombol "Setuju & Lanjutkan" ditekan:
          Navigator.of(context).pop(); // Tutup ConfirmationDialog

          // 2) Lalu munculkan PopupSuceedPage
          showDialog(
            context: context,
            barrierColor: Colors.black54,
            builder: (context) => PopupSuceedPage(
              message: 'Register sebagai Client telah sukses.\n'
                  'Silakan mengecek password di email yang telah didaftarkan.',
              onOk: () {
                // Ketika tombol "OK" di PopupSuceedPage ditekan:
                Navigator.of(context).pop(); // Tutup PopupSuceedPage

                // 3) Navigasi ke halaman LoginClientPage
                //    Jika LoginClientPage punya parameter, boleh ditambahkan di sini:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginClientPage(
                      // contoh: passing parameter ke constructor
                      // email: 'user@example.com',
                    ),
                  ),
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
    final width = MediaQuery.of(context).size.width;
    if (width < 768) return _buildMobile();
    if (width < 1024) return _buildTablet();
    return _buildDesktop();
  }

  Widget _buildMobile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Semua card form bertumpuk
          _buildCard(RekanGeneralFormBody(viewMode: 'tambah', recordId: '')),
          const SizedBox(height: 16),
          _buildCard(RekanContactFormBody(viewMode: 'tambah', recordId: '')),
          const SizedBox(height: 16),
          _buildCard(
            RekanPICFormBody(
              isEditing: widget.editSection['Informasi PIC'] ?? false,
              controllers: widget.controllers,
              toggleEdit: widget.toggleEdit,
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(RekanBankFormBody(viewMode: 'tambah', recordId: '')),
          const SizedBox(height: 16),
          _buildCard(RekanPajakFormBody(viewMode: 'tambah', recordId: '')),
          const SizedBox(height: 32),

          // Tombol di paling bawah (mobile)
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
          // Baris pertama: 2 kolom (RekanGeneral | RekanContact)
          _buildRow([
            _buildCard(RekanGeneralFormBody(viewMode: 'tambah', recordId: '')),
            _buildCard(RekanContactFormBody(viewMode: 'tambah', recordId: '')),
          ]),
          const SizedBox(height: 16),

          // Baris kedua: 2 kolom (PIC | Bank)
          _buildRow([
            _buildCard(
              RekanPICFormBody(
                isEditing: widget.editSection['Informasi PIC'] ?? false,
                controllers: widget.controllers,
                toggleEdit: widget.toggleEdit,
              ),
            ),
            _buildCard(RekanBankFormBody(viewMode: 'tambah', recordId: '')),
          ]),
          const SizedBox(height: 16),

          // Baris ketiga: 1 kolom (Pajak)
          _buildRow([
            _buildCard(RekanPajakFormBody(viewMode: 'tambah', recordId: '')),
            const SizedBox(), // filler
          ]),
          const SizedBox(height: 32),

          // Tombol di paling bawah (tablet)
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
          // Baris pertama: 3 kolom (General | Contact | PIC)
          _buildRow([
            _buildCardCenter(RekanGeneralFormBody(viewMode: 'tambah', recordId: '')),
            _buildCardCenter(RekanContactFormBody(viewMode: 'tambah', recordId: '')),
            _buildCardCenter(
              RekanPICFormBody(
                isEditing: widget.editSection['Informasi PIC'] ?? false,
                controllers: widget.controllers,
                toggleEdit: widget.toggleEdit,
              ),
            ),
          ]),
          const SizedBox(height: 24),

          // Baris kedua: 2 kolom (Bank | Pajak) + filler
          _buildRow([
            _buildCardCenter(RekanBankFormBody(viewMode: 'tambah', recordId: '')),
            _buildCardCenter(RekanPajakFormBody(viewMode: 'tambah', recordId: '')),
            const SizedBox(),
          ]),
          const SizedBox(height: 32),

          // Tombol di paling bawah (desktop)
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

  Widget _buildCard(Widget child) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 14,
            color: Colors.black,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildCardCenter(Widget child) {
    return Align(
      alignment: Alignment.topCenter,
      child: _buildCard(child),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map((widget) => Expanded(child: widget))
          .toList(growable: false),
    );
  }
}

