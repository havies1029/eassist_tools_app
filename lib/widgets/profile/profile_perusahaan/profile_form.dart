import 'package:flutter/material.dart';

// IMPORT SEMUA SECTION YANG SUDAH DI‐SPLIT
import '../../../pages/login/login_form.dart';
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
  // Boolean untuk masing‐masing form
  bool _isCheckedGeneral = false;
  bool _isCheckedContact = false;
  bool _isCheckedPIC = false;
  bool _isCheckedPembayaran = false;
  bool _isCheckedPajak = false;

  void _onGeneralChanged(bool? newValue) {
    setState(() {
      _isCheckedGeneral = newValue ?? false;
    });
  }

  void _onContactChanged(bool? newValue) {
    setState(() {
      _isCheckedContact = newValue ?? false;
    });
  }

  void _onPICChanged(bool? newValue) {
    setState(() {
      _isCheckedPIC = newValue ?? false;
    });
  }

  void _onPembayaranChanged(bool? newValue) {
    setState(() {
      _isCheckedPembayaran = newValue ?? false;
    });
  }

  void _onPajakChanged(bool? newValue) {
    setState(() {
      _isCheckedPajak = newValue ?? false;
    });
  }

  bool get _allChecked =>
      _isCheckedGeneral &&
          _isCheckedContact &&
          _isCheckedPIC &&
          _isCheckedPembayaran &&
          _isCheckedPajak;

  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierColor: Colors.black54, // background gelap di belakang dialog
      builder: (context) => PopupSuceedPage(
        message: 'Register sebagai Client telah sukses.\n'
            'Silakan mengecek password di email yang telah di daftarkan',
        onOk: () {
          // Setelah menekan OK, misalnya lanjut ke halaman lain:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginClientPage()),
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
          // --- 1) RekanGeneralFormBody ---
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
          const SizedBox(height: 8),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: GestureDetector(
              onTap: () => _onGeneralChanged(!_isCheckedGeneral),
              child: const Text(
                'Saya menyatakan bahwa data di form General sudah benar dan saya setuju untuk melanjutkan.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            value: _isCheckedGeneral,
            onChanged: _onGeneralChanged,
          ),

          const SizedBox(height: 24),

          // --- 2) RekanContactFormBody ---
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
          const SizedBox(height: 8),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: GestureDetector(
              onTap: () => _onContactChanged(!_isCheckedContact),
              child: const Text(
                'Saya menyatakan bahwa data di form Contact sudah benar dan saya setuju untuk melanjutkan.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            value: _isCheckedContact,
            onChanged: _onContactChanged,
          ),

          const SizedBox(height: 24),

          // --- 3) Informasi PIC ---
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
          const SizedBox(height: 8),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: GestureDetector(
              onTap: () => _onPICChanged(!_isCheckedPIC),
              child: const Text(
                'Saya menyatakan bahwa data di form PIC sudah benar dan saya setuju untuk melanjutkan.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            value: _isCheckedPIC,
            onChanged: _onPICChanged,
          ),

          const SizedBox(height: 24),

          // --- 4) Informasi Pembayaran ---
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InformasiPembayaranSection(
                isEditing:
                widget.editSection['Informasi Pembayaran'] ?? false,
                controller: widget.controllers['noRekening']!,
                toggleEdit: widget.toggleEdit,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: GestureDetector(
              onTap: () =>
                  _onPembayaranChanged(!_isCheckedPembayaran),
              child: const Text(
                'Saya menyatakan bahwa data di form Pembayaran sudah benar dan saya setuju untuk melanjutkan.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            value: _isCheckedPembayaran,
            onChanged: _onPembayaranChanged,
          ),

          const SizedBox(height: 24),

          // --- 5) RekanPajakFormBody ---
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
          const SizedBox(height: 8),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: GestureDetector(
              onTap: () => _onPajakChanged(!_isCheckedPajak),
              child: const Text(
                'Saya menyatakan bahwa data di form Pajak sudah benar dan saya setuju untuk melanjutkan.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            value: _isCheckedPajak,
            onChanged: _onPajakChanged,
          ),

          const SizedBox(height: 32),

          // --- 1 Button di Paling Bawah ---
          ElevatedButton(
            onPressed: _allChecked ? _showSuccessPopup : null,
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
              // Kolom RekanGeneral + Checkbox
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
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () =>
                            _onGeneralChanged(!_isCheckedGeneral),
                        child: const Text(
                          'Data General sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedGeneral,
                      onChanged: _onGeneralChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Kolom RekanContact + Checkbox
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
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () =>
                            _onContactChanged(!_isCheckedContact),
                        child: const Text(
                          'Data Contact sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedContact,
                      onChanged: _onContactChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Baris kedua: 2 kolom (Informasi PIC | Informasi Pembayaran)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom PIC + Checkbox
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
                          isEditing: widget.editSection['Informasi PIC'] ??
                              false,
                          controllers: widget.controllers,
                          toggleEdit: widget.toggleEdit,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () => _onPICChanged(!_isCheckedPIC),
                        child: const Text(
                          'Data PIC sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedPIC,
                      onChanged: _onPICChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Kolom Pembayaran + Checkbox
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
                          isEditing: widget.editSection[
                          'Informasi Pembayaran'] ??
                              false,
                          controller: widget.controllers['noRekening']!,
                          toggleEdit: widget.toggleEdit,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () =>
                            _onPembayaranChanged(!_isCheckedPembayaran),
                        child: const Text(
                          'Data Pembayaran sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedPembayaran,
                      onChanged: _onPembayaranChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Baris ketiga: 1 kolom (RekanPajakFormBody + Checkbox)
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
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () => _onPajakChanged(!_isCheckedPajak),
                        child: const Text(
                          'Data Pajak sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedPajak,
                      onChanged: _onPajakChanged,
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 32),

          // --- 1 Button di Paling Bawah ---
          ElevatedButton(
            onPressed: _allChecked ? _showSuccessPopup : null,
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
              // Kolom General + Checkbox
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
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () =>
                            _onGeneralChanged(!_isCheckedGeneral),
                        child: const Text(
                          'Data General sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedGeneral,
                      onChanged: _onGeneralChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Kolom Contact + Checkbox
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
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () =>
                            _onContactChanged(!_isCheckedContact),
                        child: const Text(
                          'Data Contact sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedContact,
                      onChanged: _onContactChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Kolom PIC + Checkbox
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
                            isEditing:
                            widget.editSection['Informasi PIC'] ?? false,
                            controllers: widget.controllers,
                            toggleEdit: widget.toggleEdit,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () => _onPICChanged(!_isCheckedPIC),
                        child: const Text(
                          'Data PIC sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedPIC,
                      onChanged: _onPICChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Baris kedua: 2 kolom (Pembayaran | Pajak)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom Pembayaran + Checkbox
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
                          child: InformasiPembayaranSection(
                            isEditing: widget.editSection[
                            'Informasi Pembayaran'] ??
                                false,
                            controller: widget.controllers['noRekening']!,
                            toggleEdit: widget.toggleEdit,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () =>
                            _onPembayaranChanged(!_isCheckedPembayaran),
                        child: const Text(
                          'Data Pembayaran sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedPembayaran,
                      onChanged: _onPembayaranChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Kolom Pajak + Checkbox
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
                          child: RekanPajakFormBody(
                            viewMode: 'tambah',
                            recordId: '',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: GestureDetector(
                        onTap: () => _onPajakChanged(!_isCheckedPajak),
                        child: const Text(
                          'Data Pajak sudah benar dan saya setuju.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      value: _isCheckedPajak,
                      onChanged: _onPajakChanged,
                    ),
                  ],
                ),
              ),

              const Expanded(child: SizedBox()),
            ],
          ),

          const SizedBox(height: 32),

          // --- 1 Button di Paling Bawah ---
          ElevatedButton(
            onPressed: _allChecked ? _showSuccessPopup : null,
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
