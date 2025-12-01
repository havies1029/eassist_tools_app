import 'package:flutter/material.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

class ProfileMainPage extends StatefulWidget {
  final int userid;
  final UserRepository userRepository;

  const ProfileMainPage({
    super.key,
    required this.userid,
    required this.userRepository,
  });

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  final _scrollController = ScrollController();

  // Static data with controller mappings
  static const Map<String, String> _staticData = {
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

  // Controllers map for easier management
  late final Map<String, TextEditingController> _controllers;

  final Map<String, bool> _editSection = {
    'Informasi Perusahaan': false,
    'Kontak Perusahaan': false,
    'Informasi PIC': false,
    'Informasi Pembayaran': false,
    'Informasi Pajak (Optional)': false,
  };

  bool _isEditingName = false;

  // Section field definitions
  static const Map<String, List<Map<String, dynamic>>> _sectionFields = {
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
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = Map.fromEntries(
        _staticData.entries.map((e) => MapEntry(e.key, TextEditingController(text: e.value)))
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.all(constraints.maxWidth < 600 ? 16 : 20),
              child: DefaultTextStyle(
                style: const TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.black),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth < 1200 ? constraints.maxWidth : 1200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(constraints),
                        const SizedBox(height: 24),
                        _buildProfileSections(constraints),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    return constraints.maxWidth < 600
        ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [_buildProfileHeader()])
        : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: _buildProfileHeader())]);
  }

  Widget _buildProfileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            image: const DecorationImage(
              image: AssetImage('assets/profile_placeholder.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameEditor(),
              const SizedBox(height: 5),
              _buildUploadButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton() {
    return InkWell(
      onTap: _uploadPhoto,
      borderRadius: BorderRadius.circular(110),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0x00dfffc6).withOpacity(1),
          borderRadius: BorderRadius.circular(110),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Upload Photo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: 'Satoshi',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildNameEditor() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _isEditingName
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF8BC34A), width: 1.5),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8BC34A).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _controllers['namaUser']!,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                fontFamily: 'Satoshi',
              ),
            ),
          )
              : Text(
            _controllers['namaUser']!.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(width: 12),
        _buildEditButton(_isEditingName, _toggleEditName),
      ],
    );
  }

  Widget _buildEditButton(bool isEditing, VoidCallback onTap, {double size = 45}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(size == 45 ? 6 : 4),
          color: Colors.white,
        ),
        child: Icon(
          isEditing ? Icons.check : Icons.edit,
          size: size == 45 ? 25 : 20,
          color: isEditing ? const Color(0xFF8BC34A) : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildProfileSections(BoxConstraints constraints) {
    final bool isTablet = constraints.maxWidth < 1024 && constraints.maxWidth >= 768;
    final bool isMobile = constraints.maxWidth < 768;

    if (isMobile) {
      return _buildMobileLayout();
    } else if (isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        ..._buildSectionsFromConfig(['Informasi Perusahaan', 'Kontak Perusahaan', 'Informasi PIC']),
        _buildSectionWithTitle('Informasi Pembayaran :', 'Informasi Pembayaran', [_buildPaymentSection()]),
        const SizedBox(height: 16),
        _buildSectionsFromConfig(['Informasi Pajak (Optional)']).first,
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSectionsFromConfig(['Informasi Perusahaan']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSectionsFromConfig(['Kontak Perusahaan']).first),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSectionsFromConfig(['Informasi PIC']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSectionWithTitle('Informasi Pembayaran :', 'Informasi Pembayaran', [_buildPaymentSection()])),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSectionsFromConfig(['Informasi Pajak (Optional)']).first),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSectionsFromConfig(['Informasi Perusahaan']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSectionsFromConfig(['Kontak Perusahaan']).first),
            const SizedBox(width: 16),
            Expanded(child: _buildSectionsFromConfig(['Informasi PIC']).first),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSectionWithTitle('Informasi Pembayaran :', 'Informasi Pembayaran', [_buildPaymentSection()])),
            const SizedBox(width: 16),
            Expanded(child: _buildSectionsFromConfig(['Informasi Pajak (Optional)']).first),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildSectionsFromConfig(List<String> sectionKeys) {
    return sectionKeys.map((sectionKey) {
      final fields = _sectionFields[sectionKey]!.map((fieldConfig) {
        return _buildField(
          fieldConfig['label'],
          _controllers[fieldConfig['key']]!,
          sectionKey,
          maxLines: fieldConfig['maxLines'] ?? 1,
        );
      }).toList();

      return Column(
        children: [
          _buildSectionWithTitle('$sectionKey :', sectionKey, fields),
          if (sectionKey != sectionKeys.last) const SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget _buildSectionWithTitle(String title, String sectionKey, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Satoshi',
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _buildEditButton(
              _editSection[sectionKey]!,
                  () => setState(() => _editSection[sectionKey] = !_editSection[sectionKey]!),
              size: 30,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildSectionCard(children),
      ],
    );
  }

  void _uploadPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Upload photo functionality will be implemented with database')),
    );
  }

  void _toggleEditName() {
    setState(() {
      if (_isEditingName) {
        // TODO: Save name logic here when database is ready
      }
      _isEditingName = !_isEditingName;
    });
  }

  Widget _buildSectionCard(List<Widget> children) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
    );
  }

  Widget _buildField(String label, TextEditingController controller, String sectionKey,
      {int maxLines = 1, bool showOptional = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            child: _editSection[sectionKey]!
                ? TextFormField(
              controller: controller,
              maxLines: maxLines,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 14, color: Colors.black87, fontFamily: 'Satoshi'),
            )
                : Text(
              controller.text.isNotEmpty ? controller.text : (showOptional ? '[Optional]' : ''),
              style: TextStyle(
                fontSize: 16,
                color: controller.text.isNotEmpty ? Colors.black87 : Colors.grey,
                fontFamily: 'Satoshi',
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rekening Bank',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: 'Satoshi',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: _addBankAccount,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 14),
                ),
              ),
              ...[
                {'color': Colors.red, 'text': 'MC'},
                {'color': Colors.blue, 'text': 'OP'},
                {'color': Colors.blue[800]!, 'text': 'BCA'},
                {'color': Colors.blue[900]!, 'text': 'VISA'},
              ].map((item) => _buildPaymentIcon(item['color'] as Color, item['text'] as String)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildField('No. Rekening', _controllers['noRekening']!, 'Informasi Pembayaran'),
      ],
    );
  }

  void _addBankAccount() {
    setState(() => _editSection['Informasi Pembayaran'] = !_editSection['Informasi Pembayaran']!);
  }

  Widget _buildPaymentIcon(Color color, String text) {
    return Container(
      width: 35,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satoshi',
          ),
        ),
      ),
    );
  }
}