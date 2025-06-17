import 'package:flutter/material.dart';
import '../../dialog/PopUp/confirmation_dialog.dart';
import '../../dialog/PopUp/success_popup.dart';
import '../login/login_client/login_client_dialog.dart';

// Import semua form individu & perusahaan
import '../login/login_gmail/popup_dialog_login.dart';
import 'form_sections/rekan_general_idv.dart';
import 'form_sections/rekan_contact.dart'; //idv dan cmp
import 'form_sections/rekan_bank_idv.dart';

import 'form_sections/rekan_general_cmp.dart';
import 'form_sections/rekan_pajak.dart';
import 'form_sections/rekan_pic.dart';
import 'form_sections/rekan_bank_cmp.dart';

class ProfileFormSection extends StatefulWidget {
  final Map<String, bool> editSection;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;
  final String selectedChoice;

  const ProfileFormSection({
    Key? key,
    required this.editSection,
    required this.controllers,
    required this.toggleEdit,
    required this.selectedChoice,
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
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierColor: Colors.black54,
            builder: (context) => PopupSuceedPage(
              message: 'Register sebagai Client telah sukses.\nSilakan mengecek password di email yang telah didaftarkan.',
              onOk: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Jika ingin menutup dialog sebelumnya, tetap pakai ini
                await CustomPopupsLoginUser.showLoginClientDialog(context);

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
  bool _isEditingName = false;

  void _toggleEditName() {
    setState(() {
      if (_isEditingName) {
        // TODO: Simpan ke backend
      }
      _isEditingName = !_isEditingName;
    });
  }

  void _uploadPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur upload foto akan segera hadir')),
    );
  }

  Widget _buildProfilePicHeader(double width) {
    final controller = widget.controllers['namaUser'] ?? TextEditingController();

    final avatar = CircleAvatar(
      radius: 36,
      backgroundColor: const Color(0xFF8BC34A), // warna hijau muda
      child: const Icon(Icons.person, size: 36, color: Colors.white),
    );

    final nameField = _isEditingName
        ? TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        isDense: true,
      ),
    )
        : Text(
      controller.text.isEmpty ? 'Nama Anda' : controller.text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );

    final editButton = IconButton(
      icon: Icon(_isEditingName ? Icons.check : Icons.edit, size: 20),
      onPressed: _toggleEditName,
      tooltip: _isEditingName ? 'Simpan Nama' : 'Edit Nama',
    );

    final uploadButton = TextButton.icon(
      onPressed: _uploadPhoto,
      icon: const Icon(Icons.upload_file, size: 16),
      label: const Text('Upload Photo'),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFE6F9D5),
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: nameField),
                    editButton,
                  ],
                ),
                const SizedBox(height: 8),
                uploadButton,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= MOBILE =================
  Widget _buildMobile() {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfilePicHeader(width),
          ..._buildFormWidgets(),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }
  Widget _buildIndividualLayout(double width) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfilePicHeader(width),
          _buildRow([
            _buildCard(const RekanGeneralIdv(viewMode: 'tambah', recordId: '')),
            _buildCard(const RekanContact()),
          ]),
          const SizedBox(height: 16),
          _buildRow([
            _buildCard(const RekanBankIdv(viewMode: 'tambah', recordId: '')),
            const SizedBox(), // filler
          ]),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  // ================= TABLET =================
  Widget _buildTablet() {
    final width = MediaQuery.of(context).size.width;
    final widgets = _buildFormWidgets();
    if (widget.selectedChoice == 'Individual') {
      return _buildIndividualLayout(width);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfilePicHeader(width),
          _buildRow([_buildCard(RekanGeneralCmp()), _buildCard(RekanContact())]),
          const SizedBox(height: 16),
          _buildRow([
            _buildCard(RekanPIC(
              isEditing: widget.editSection['Informasi PIC'] ?? false,
              controllers: widget.controllers,
              toggleEdit: widget.toggleEdit,
            )),
            _buildCard(RekanBankCmp(viewMode: 'tambah', recordId: '')),
          ]),
          const SizedBox(height: 16),
          _buildRow([_buildCard(RekanPajak(viewMode: 'tambah', recordId: '')), const SizedBox()]),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  // ================= DESKTOP =================
  Widget _buildDesktop() {
    final width = MediaQuery.of(context).size.width;
    if (widget.selectedChoice == 'Individual') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfilePicHeader(width),
            _buildRow([
              _buildCardCenter(const RekanGeneralIdv(viewMode: 'tambah', recordId: '')),
              _buildCardCenter(const RekanContact()),
              _buildCardCenter(const RekanBankIdv(viewMode: 'tambah', recordId: '')),
            ]),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfilePicHeader(width),
          _buildRow([
            _buildCardCenter(RekanGeneralCmp()),
            _buildCardCenter(RekanContact()),
            _buildCardCenter(RekanPIC(
              isEditing: widget.editSection['Informasi PIC'] ?? false,
              controllers: widget.controllers,
              toggleEdit: widget.toggleEdit,
            )),
          ]),
          const SizedBox(height: 24),
          _buildRow([
            _buildCardCenter(RekanBankCmp(viewMode: 'tambah', recordId: '')),
            _buildCardCenter(RekanPajak(viewMode: 'tambah', recordId: '')),
            const SizedBox(),
          ]),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  // ================= FORMS =================
  List<Widget> _buildFormWidgets() {
    if (widget.selectedChoice == 'Individual') {
      return [
        _buildCard(const RekanGeneralIdv(viewMode: 'tambah', recordId: '')),
        const SizedBox(height: 16),
        _buildCard(const RekanContact()),
        const SizedBox(height: 16),
        _buildCard(const RekanBankIdv(viewMode: 'tambah', recordId: '')),
      ];
    } else {
      return [
        _buildCard(RekanGeneralCmp()),
        const SizedBox(height: 16),
        _buildCard(RekanContact()),
        const SizedBox(height: 16),
        _buildCard(RekanPIC(
          isEditing: widget.editSection['Informasi PIC'] ?? false,
          controllers: widget.controllers,
          toggleEdit: widget.toggleEdit,
        )),
        const SizedBox(height: 16),
        _buildCard(RekanBankCmp(viewMode: 'tambah', recordId: '')),
        const SizedBox(height: 16),
        _buildCard(RekanPajak(viewMode: 'tambah', recordId: '')),
      ];
    }
  }

  // ================= UTILITIES =================
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _showSuccessPopup,
      child: const Text('Lanjutkan Seluruh Form'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
      children: children.map((widget) => Expanded(child: widget)).toList(growable: false),
    );
  }
}