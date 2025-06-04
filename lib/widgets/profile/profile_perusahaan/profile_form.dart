import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../profile_perusahaan/form_sections/rekan_general_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_contact_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_pajak_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_pic_form_body.dart';
import '../profile_perusahaan/form_sections/rekan_bank_form_body.dart';

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
      builder: (context) => AlertDialog(
        title: const Text('Sukses'),
        content: const Text(
          'Register sebagai Client telah sukses.\nSilakan mengecek password di email yang telah didaftarkan.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Setelah dialog ditutup, navigasi ke halaman LoginClientPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginClientPage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
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

// Halaman LoginClientPage sebagai contoh (import sesuai file Anda)
class LoginClientPage extends StatelessWidget {
  const LoginClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Client'),
      ),
      body: const Center(
        child: Text('Halaman Login Client'),
      ),
    );
  }
}
