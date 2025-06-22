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
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) return _buildMobile();
            if (constraints.maxWidth < 1024) return _buildTablet();
            return _buildDesktop();
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicHeader() {
    final controller = widget.controllers['namaUser'] ?? TextEditingController();
    final nameField = _isEditingName
        ? TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2D3748),
      ),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4A5568)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2D3748), width: 2),
        ),
        isDense: true,
      ),
    )
        : Text(
      controller.text.isEmpty ? 'Nama Anda' : controller.text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2D3748),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
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
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: nameField),
                        IconButton(
                          icon: Icon(
                            _isEditingName ? Icons.check : Icons.edit,
                            size: 20,
                            color: const Color(0xFF4A5568),
                          ),
                          onPressed: _toggleEditName,
                          tooltip: _isEditingName ? 'Simpan Nama' : 'Edit Nama',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lengkapi profil Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCard(
          child: MRekanPicListListWidget(
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
            },
          ),
          title: 'Person In Charge',
        ),
        const SizedBox(height: 16),
        if (_showPicCrudForm)
          _buildCard(
            child: MRekanPicCrudFormBody(
              viewMode: _picFormMode,
              recordId: _selectedPicId ?? '',
            ),
            title: _picFormMode == 'tambah' ? 'Tambah PIC' : 'Edit PIC',
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _selectedPicId = null;
                _picFormMode = 'tambah';
                _showPicCrudForm = !_showPicCrudForm;
              });
            },
            icon: Icon(_showPicCrudForm ? Icons.close : Icons.add, size: 18),
            label: Text(_showPicCrudForm ? 'Tutup Form PIC' : 'Tambah PIC'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _showPicCrudForm ? const Color(0xFF718096) : const Color(0xFF4A5568),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfilePicHeader(),
          ..._buildFormWidgets(),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    if (widget.selectedChoice == 'Individual') {
      return _buildIndividualLayout();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildProfilePicHeader(),

          // Row 1: General Company + Contact
          _buildRow([
            _buildCard(
              child: RekanGeneralCmp(),
              title: 'Informasi Perusahaan',
            ),
            _buildCard(
              child: RekanContact(),
              title: 'Informasi Kontak',
            ),
          ]),

          const SizedBox(height: 20),

          // Row 2: PIC + Bank
          _buildRow([
            _buildPicSection(),
            _buildCard(
              child: RekanBankCmp(viewMode: 'tambah', recordId: ''),
              title: 'Informasi Bank Perusahaan',
            ),
          ]),

          const SizedBox(height: 20),

          // Row 3: Tax (centered)
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
                  title: 'Informasi Pajak',
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),

          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    if (widget.selectedChoice == 'Individual') {
      return _buildIndividualLayout();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          _buildProfilePicHeader(),

          // Row 1: General + Contact + PIC
          _buildRow([
            _buildCard(
              child: RekanGeneralCmp(),
              title: 'Informasi Perusahaan',
            ),
            _buildCard(
              child: RekanContact(),
              title: 'Informasi Kontak',
            ),
            _buildPicSection(),
          ]),

          const SizedBox(height: 24),

          // Row 2: Bank + Tax + Spacer
          _buildRow([
            _buildCard(
              child: RekanBankCmp(viewMode: 'tambah', recordId: ''),
              title: 'Informasi Bank Perusahaan',
            ),
            _buildCard(
              child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
              title: 'Informasi Pajak',
            ),
            const SizedBox(),
          ]),

          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildIndividualLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildProfilePicHeader(),

          // Row 1: General + Contact + Bank
          _buildRow([
            _buildCard(
              child: RekanGeneralIdv(viewMode: 'tambah', recordId: ''),
              title: 'Informasi Pribadi',
            ),
            _buildCard(
              child: RekanContact(),
              title: 'Informasi Kontak',
            ),
            _buildCard(
              child: RekanBankIdv(viewMode: 'tambah', recordId: ''),
              title: 'Informasi Bank',
            ),
          ]),

          const SizedBox(height: 20),

          // Row 2: Tax (centered)
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
                  title: 'Informasi Pajak',
                ),
              ),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
            ],
          ),

          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  List<Widget> _buildFormWidgets() {
    if (widget.selectedChoice == 'Individual') {
      return [
        _buildCard(
          child: RekanGeneralIdv(viewMode: 'tambah', recordId: ''),
          title: 'Informasi Pribadi',
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanContact(),
          title: 'Informasi Kontak',
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanBankIdv(viewMode: 'tambah', recordId: ''),
          title: 'Informasi Bank',
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
          title: 'Informasi Pajak',
        ),
      ];
    } else {
      return [
        _buildCard(
          child: RekanGeneralCmp(),
          title: 'Informasi Perusahaan',
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanContact(),
          title: 'Informasi Kontak',
        ),
        const SizedBox(height: 16),
        _buildPicSection(),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanBankCmp(viewMode: 'tambah', recordId: ''),
          title: 'Informasi Bank Perusahaan',
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
          title: 'Informasi Pajak',
        ),
      ];
    }
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showSuccessPopup,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D3748),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Lanjutkan Seluruh Form',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF7FAFC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 14,
                color: Color(0xFF2D3748),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map((widget) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: widget,
        ),
      ))
          .toList(),
    );
  }
}