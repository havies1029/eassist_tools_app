// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../blocs/gen_profile/mrekanpiccrud_bloc.dart';
import '../../../blocs/profile/profile_download_foto_bloc.dart';
import '../../../blocs/profile/profile_upload_foto_bloc.dart';
import '../../../pages/gen_profile/m_rekan_pic_crud_body.dart';
import '../../../pages/gen_profile/m_rekan_pic_list_body.dart';
import '../../../pages/gen_profile/profile_picture.dart';
import '../../dialog/PopUp/confirmation_dialog.dart';
import '../../dialog/PopUp/success_popup.dart';
import '../../showdialoghapus_widget.dart';
import '../login/login_client/login_client_dialog.dart';

// Import semua form individu & perusahaan
import '../login/login_gmail/popup_dialog_login.dart';
import 'form_sections/rekan_general_idv.dart';
import 'form_sections/rekan_contact.dart';
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
  bool _isEditingName = false;
  bool _showPicCrudForm = false;
  String? _selectedPicId;
  String _picFormMode = 'tambah';

  void loadData() {
    context.read<ProfileDownloadFotoBloc>().add(LoadSecureImage());
    context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
  }

  void _toggleEditName() {
    setState(() => _isEditingName = !_isEditingName);
  }

  void _togglePicCrudForm() {
    setState(() => _showPicCrudForm = !_showPicCrudForm);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _showSuccessPopup() {
    final state = context.read<MRekan1CrudBloc>().state;
    final mrekanId = state.record?.mrekan1Id ?? "";

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => ConfirmationDialog(
        mrekanId: mrekanId,
        onConfirm: () {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierColor: Colors.black54,
            builder: (context) => PopupSuceedPage(
              message: 'Terimakasih telah menjadi bagian dari JPS',
              onOk: () async {
                context.go('/hero_user');
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

  Widget _buildProfilePicHeader(double width) {
    final controller = widget.controllers['namaUser'] ?? TextEditingController();
    final nameField = _isEditingName
        ? TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: const InputDecoration(border: UnderlineInputBorder(), isDense: true),
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: BlocBuilder<ProfileDownloadFotoBloc, ProfileDownloadFotoState>(
        builder: (context, imageState) {
          Uint8List? imageBytes;
          if (imageState is ProfileDownloadFotoLoaded) {
            imageBytes = imageState.imageBytes as Uint8List?;
          }

          return Row(
            children: [
              ProfilePicture(
                imageUrl: 'https://www.jayaproteksindo.co.id/image/Logo.png',
                radius: 60,
                blocImageBytes: imageBytes,
                onImageSelected: (bytes, fileName) async {
                  context.read<ProfileUploadFotoBloc>().add(
                    UploadProfilePicture(bytes, fileName),
                  );
                },
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: nameField),
                    editButton,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  // Widget khusus untuk section PIC dengan ukuran sama seperti form lain
  Widget _buildPicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCard(
          MRekanPicListListWidget(
            onEdit: (recordId) {
              setState(() {
                _selectedPicId = recordId;
                _picFormMode = 'ubah';
                _showPicCrudForm = true;
              });
            },
              onDelete: (recordId) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ShowDialogHapusWidget(
                    recordId: recordId,
                    onHapusFunction: (id) {
                      context.read<MRekanPicCrudBloc>().add(
                        MRekanPicCrudHapusEvent(recordId: id),
                      );
                    },
                  ),
                );
              }

          ),
        ),
        const SizedBox(height: 8),
        if (_showPicCrudForm)
          _buildCard(MRekanPicCrudFormBody(
            viewMode: _picFormMode,
            recordId: _selectedPicId ?? '',
          )),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _selectedPicId = null;
              _picFormMode = 'tambah';
              _showPicCrudForm = !_showPicCrudForm;
            });
          },
          icon: const Icon(Icons.add),
          label: Text(_showPicCrudForm ? 'Tutup Form PIC' : 'Tambah PIC'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8BC34A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }


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

  Widget _buildTablet() {
    final width = MediaQuery.of(context).size.width;
    if (widget.selectedChoice == 'Individual') return _buildIndividualLayout(width);

    // Layout 2 kolom untuk tablet - company
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfilePicHeader(width),
          // Baris pertama: General Company + Contact
          _buildRow([
            _buildCard(RekanGeneralCmp()),
            _buildCard(RekanContact())
          ]),
          const SizedBox(height: 16),
          // Baris kedua: PIC + Bank Company
          _buildRow([
            _buildPicSection(),
            _buildCard(RekanBankCmp(viewMode: 'tambah', recordId: ''))
          ]),
          const SizedBox(height: 16),
          // Baris ketiga: Pajak (full width)
          Row(
            children: [
              Expanded(
                child: _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
              ),
              const Expanded(child: SizedBox()), // Spacer untuk balance
            ],
          ),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    final width = MediaQuery.of(context).size.width;
    if (widget.selectedChoice == 'Individual') {
      return _buildIndividualLayout(width);
    }

    // Layout 3 kolom untuk desktop - company
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfilePicHeader(width),
          // Baris pertama: General Company + Contact + PIC
          _buildRow([
            _buildCard(RekanGeneralCmp()),
            _buildCard(RekanContact()),
            _buildPicSection(),
          ]),
          const SizedBox(height: 24),
          // Baris kedua: Bank Company + Pajak + spacer
          _buildRow([
            _buildCard(RekanBankCmp(viewMode: 'tambah', recordId: '')),
            _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
            const SizedBox(), // Spacer untuk balance
          ]),
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

          // Baris 1: General, Kontak, Bank
          _buildRow([
            _buildCard(RekanGeneralIdv(viewMode: 'tambah', recordId: '')),
            _buildCard(RekanContact()),
            _buildCard(RekanBankIdv(viewMode: 'tambah', recordId: '')),
          ]),

          const SizedBox(height: 16),

          // Baris 2: Pajak (hanya 1 kolom kecil, seukuran lainnya)
          _buildRow([
            _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
            const SizedBox(), // Spacer
            const SizedBox(), // Spacer
          ]),

          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }



  List<Widget> _buildFormWidgets() {
    if (widget.selectedChoice == 'Individual') {
      return [
        _buildCard(RekanGeneralIdv(viewMode: 'tambah', recordId: '')),
        const SizedBox(height: 16),
        _buildCard(RekanContact()),
        const SizedBox(height: 16),
        _buildCard(RekanBankIdv(viewMode: 'tambah', recordId: '')),
      ];
    } else {
      return [
        _buildCard(RekanGeneralCmp()),
        const SizedBox(height: 16),
        _buildCard(RekanContact()),
        const SizedBox(height: 16),
        // PIC section terpisah untuk mobile
        _buildPicSection(),
        const SizedBox(height: 16),
        _buildCard(RekanBankCmp(viewMode: 'tambah', recordId: '')),
        const SizedBox(height: 16),
        _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
      ];
    }
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _showSuccessPopup,
      child: const Text('Lanjutkan Seluruh Form'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.black),
          child: child,
        ),
      ),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((widget) => Expanded(child: widget)).toList(growable: false),
    );
  }
}

