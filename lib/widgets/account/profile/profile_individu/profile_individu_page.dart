import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_individu/profile_individu_form.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_individu/profile_individu_pic.dart';

class ProfileIndividuPage extends StatefulWidget {
  final int userid;

  const ProfileIndividuPage({super.key, required this.userid});

  @override
  State<ProfileIndividuPage> createState() => _ProfileIndividuPageState();
}

class _ProfileIndividuPageState extends State<ProfileIndividuPage> {
  final _scrollController = ScrollController();

  final Map<String, String> _data = {
    'nama': 'Nadya Septrijayani',
    'tipe': 'Individu',
    'klien': 'ID 00182',
    'gender': 'Perempuan [Optional]',
    'email': 'youremail@gmail.com',
    'phone': '+62 236-8239-1101',
    'alamat': 'Jl. Raya Hankam Munjul, Jakarta Timur.',
    'provinsi': '[Optional]',
    'kota': '[Optional]',
    'kodePos': '[Optional]',
    'npwp': '01.234.567.8-999.000',
    'pekerjaan': 'HUMAS',
    'namaUser': 'Nadya Septrijayani',
    'noRekening': '-',
  };

  late final Map<String, TextEditingController> _controllers;

  final Map<String, bool> _editSection = {
    'Informasi Klien': false,
    'Kontak Klien': false,
    'Identitas dan Rekening': false,
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
                      ProfileIndividuPicSection(
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
                        child: ProfileIndividuPicSection(
                          namaUserController: _controllers['namaUser']!,
                          isEditing: _isEditingName,
                          onToggleEdit: _toggleEditName,
                          onUploadPhoto: _uploadPhoto,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  ProfileIndividuFormSection(
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