import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_perusahaan/profile_form.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_perusahaan/profile_pic.dart';

class ProfilePage extends StatefulWidget {
  final int userid;

  const ProfilePage({super.key, required this.userid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();

  // Simulasi data awal
  final Map<String, String> _data = {
    'nama': 'PT Garuda Indonesia',
    'tipe': 'Badan Usaha',
    'bentuk': 'BUMN',
    'klien': 'ID 00012',
    'bidangUsaha': 'Penerbangan & Logistik',
    'email': 'info@garuda-indonesia.co.id',
    'phone': '‪+62 21-2351-9090‬',
    'alamat': 'Jl. Medan Merdeka Selatan No. 13, Jakarta Pusat 10110',
    'provinsi': 'DKI Jakarta',
    'kota': 'Jakarta Pusat',
    'kodePos': '10110',
    'namaPic': 'Andi Saputra',
    'phonePic': '‪+62 812-3456-7890‬',
    'jabatanPic': 'Manajer Operasional',
    'npwp': '01.234.567.8-901.000',
    'alamatNpwp': 'Jl. Medan Merdeka Selatan No. 13, Jakarta Pusat',
    'provinsiNpwp': 'DKI Jakarta',
    'kotaNpwp': 'Jakarta Pusat',
    'kodePosNpwp': '10110',
    'namaUser': 'Nadya Septrijayani',
    'noRekening': '1234567890',
  };

  late final Map<String, TextEditingController> _controllers;

  final Map<String, bool> _editSection = {
    'Informasi Perusahaan': false,
    'Kontak Perusahaan': false,
    'Informasi PIC': false,
    'Informasi Pembayaran': false,
    'Informasi Pajak (Optional)': false,
  };

  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (var e in _data.entries) e.key: TextEditingController(text: e.value)
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _uploadPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur upload foto akan segera hadir')),
    );
  }

  void _toggleEditName() {
    setState(() {
      if (_isEditingName) {
        // TODO: Simpan ke backend
      }
      _isEditingName = !_isEditingName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(constraints.maxWidth < 600 ? 16 : 20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth < 1200 ? constraints.maxWidth : 1200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constraints.maxWidth < 600
                      ? Column(
                    children: [
                      ProfilePicSection(
                        namaUserController: _controllers['namaUser']!,
                        isEditing: _isEditingName,
                        onToggleEdit: _toggleEditName,
                        onUploadPhoto: _uploadPhoto,
                      )
                    ],
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ProfilePicSection(
                          namaUserController: _controllers['namaUser']!,
                          isEditing: _isEditingName,
                          onToggleEdit: _toggleEditName,
                          onUploadPhoto: _uploadPhoto,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  ProfileFormSection(
                    editSection: _editSection,
                    controllers: _controllers,
                    toggleEdit: (sectionKey) {
                      setState(() {
                        _editSection[sectionKey] = !_editSection[sectionKey]!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
