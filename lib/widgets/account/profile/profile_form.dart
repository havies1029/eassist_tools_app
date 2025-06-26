// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../blocs/gen_profile/mrekanpiccrud_bloc.dart';
import '../../../blocs/gen_profile/mrekanpiclist_bloc.dart';
import '../../../blocs/profile/profile_download_foto_bloc.dart';
import '../../../blocs/profile/profile_upload_foto_bloc.dart';
import 'form_sections/pic_form/rekan_pic_crud_body.dart';
import '../../../widgets/account/profile/form_sections/pic_form//rekan_pic_list_body.dart';
import '../../../pages/gen_profile/profile_picture.dart';
import '../../dialog/PopUp/confirmation_dialog.dart';
import '../../dialog/PopUp/success_popup.dart';
import '../../showdialoghapus_widget.dart';
import '../login/login_client/login_client_dialog.dart';

// Import semua form individu & perusahaan
import 'form_sections/rekan_general_idv.dart';
import 'form_sections/rekan_contact.dart';
import 'form_sections/rekan_bank.dart';
import 'form_sections/rekan_general_cmp.dart';
import 'form_sections/rekan_pajak.dart';

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

  // Mobile wizard state
  int _currentStep = 0;
  PageController _pageController = PageController();

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  // Get total steps based on selectedChoice
  int get _totalSteps {
    if (widget.selectedChoice == 'Individual') {
      return 3; // General, Contact, Bank, Pajak
    } else {
      return 4; // General, Contact, PIC, Bank, Pajak
    }
  }

  // Get step titles
  List<String> get _stepTitles {
    if (widget.selectedChoice == 'Individual') {
      return [
        'Mobile Informasi Klien',
        'Mobile Kontak Klien',
        'Mobile Identitas Rekening',
      ];
    } else {
      return [
        'Mobile Informasi Perusahaan',
        'Mobile Kontak Perusahaan',
        'Mobile Informasi PIC',
        'Mobile Bank Perusahaan',
      ];
    }
  }

  // Navigate to next step
  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Navigate to previous step
  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
    return BlocBuilder<MRekan1CrudBloc, MRekan1CrudState>(
      builder: (context, state) {
        final namaRekan = state.record?.rekanNama ?? 'Nama Anda';
        final controller = widget.controllers['namaUser'] ?? TextEditingController();

        if (controller.text.isEmpty) {
          controller.text = namaRekan;
        }

        // Buat nameField yang berbeda untuk mobile dan non-mobile
        final nameFieldMobile = _isEditingName
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
          textAlign: TextAlign.center, // Center untuk mobile
        )
            : Text(
          controller.text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
          textAlign: TextAlign.center, // Center untuk mobile
        );

        final nameFieldDesktop = _isEditingName
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
          controller.text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;

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
                    imageBytes = imageState.imageBytes;
                  }

                  return isMobile
                      ? SizedBox(
                    width: double.infinity, // Mempertahankan lebar penuh
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Center semua konten untuk mobile
                      children: [
                        // Profile Picture
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
                        const SizedBox(height: 16),
                        // Nama tepat di bawah foto profile, tanpa tombol centang
                        SizedBox(
                          width: double.infinity, // Memastikan nama tetap menggunakan lebar penuh
                          child: nameFieldMobile,
                        ),
                      ],
                    ),
                  )
                      : Row(
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
                        child: Row(
                          children: [
                            // Nama tepat di samping kanan gambar profil
                            Expanded(child: nameFieldDesktop),
                            // Tombol centang tetap di ujung kanan
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    size: 24,
                                    color: Color(0xFF4A5568),
                                  ),
                                  onPressed: _showSuccessPopup,
                                  tooltip: 'Lanjutkan Seluruh Form',
                                  padding: const EdgeInsets.all(12),
                                  constraints: const BoxConstraints(
                                    minWidth: 48,
                                    minHeight: 48,
                                  ),
                                ),
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
          },
        );
      },
    );
  }

  void refreshPicList() {
    context.read<MRekanPicListBloc>().add(FetchMRekanPicListEvent());
  }


  Widget _buildPicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCard(
          child: MRekanPicListListWidget(
            onEdit: (recordId) {
              if (recordId.isEmpty) return;

              context.read<MRekanPicCrudBloc>().add(MRekanPicCrudResetEvent()); // ⬅️ reset dulu

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
                    print('[🧨 DEBUG] Deleting ID: $id');
                    context.read<MRekanPicCrudBloc>().add(
                      MRekanPicCrudHapusEvent(recordId: id),
                    );
                  },
                ),
              ).then((result) {
                if (result == true) {
                  refreshPicList(); // ✅ refresh list setelah hapus
                }
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_showPicCrudForm)
          _buildCard(
            child: MRekanPicCrudFormBody(
              key: ValueKey('${_picFormMode}_${_selectedPicId ?? 'new'}'), // 💡 Pakai ValueKey unik
              viewMode: _picFormMode,
              recordId: _selectedPicId ?? '',
              onCancel: () {
                refreshPicList(); // ⏳ trigger dulu

                // Delay `setState` agar tombol tidak muncul sekejap
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _showPicCrudForm = false;
                    _selectedPicId = null;
                    _picFormMode = ''; // kosongkan juga mode
                  });
                });
              },
            ),
          ),
        const SizedBox(height: 12),
        BlocBuilder<MRekanPicListBloc, MRekanPicListState>(
          builder: (context, state) {
            final isMaxPIC = state.items.length >= 3;

            if (isMaxPIC) return const SizedBox.shrink(); // 🔒 Jangan tampilkan tombol sama sekali

            return SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (_showPicCrudForm && _picFormMode == 'tambah') {
                      _showPicCrudForm = false;
                    } else {
                      _picFormMode = 'tambah';
                      _selectedPicId = null;
                      _showPicCrudForm = true;
                    }
                  });
                },
                icon: Icon(_showPicCrudForm ? Icons.close : Icons.add, size: 18),
                label: Text(_showPicCrudForm ? 'Tutup Form PIC' : 'Tambah PIC'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showPicCrudForm
                      ? const Color(0xFF718096)
                      : const Color(0xFF4A5568),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Mobile Multi-Step Form Build
  Widget _buildMobile() {
    return Column(
      children: [
        // Header with back button and title
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF4A5568)),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _stepTitles[_currentStep],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ),
              // Progress indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  '${_currentStep + 1}/${_totalSteps}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A5568),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Progress bar
        Container(
          height: 4,
          color: const Color(0xFFF7FAFC),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 4,
              width: MediaQuery.of(context).size.width * ((_currentStep + 1) / _totalSteps),
              color: const Color(0xFF4A5568),
            ),
          ),
        ),

        // Form content
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentStep = index;
              });
            },
            children: _buildMobileSteps(),
          ),
        ),

        // Navigation buttons
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
          ),
          child: Row(
            children: [
              // Previous button
              if (_currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: _previousStep,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF4A5568)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chevron_left, color: Color(0xFF4A5568)),
                        Text(
                          'Sebelumnya',
                          style: TextStyle(
                            color: Color(0xFF4A5568),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (_currentStep > 0) const SizedBox(width: 12),

              // Next/Finish button
              Expanded(
                child: ElevatedButton(
                  onPressed: _currentStep == _totalSteps - 1
                      ? _showSuccessPopup
                      : _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5568),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentStep == _totalSteps - 1 ? 'Selesai' : 'Selanjutnya',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_currentStep < _totalSteps - 1)
                        const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build mobile steps based on selectedChoice
  List<Widget> _buildMobileSteps() {
    List<Widget> steps = [];

    if (widget.selectedChoice == 'Individual') {
      steps = [
        _buildMobileStepContent(RekanGeneralIdv(viewMode: 'tambah', recordId: '')),
        _buildMobileStepContent(RekanContact()),
        _buildMobileStepContent(RekanBank()),
        // _buildMobileStepContent(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
      ];
    } else {
      steps = [
        _buildMobileStepContent(RekanGeneralCmp()),
        _buildMobileStepContent(RekanContact()),
        _buildMobileStepContent(_buildPicSection()),
        _buildMobileStepContent(RekanBank()),
        // _buildMobileStepContent(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
      ];
    }

    return steps;
  }

  Widget _buildMobileStepContent(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile picture header only on first step
          if (_currentStep == 0) ...[
            _buildProfilePicHeader(),
            const SizedBox(height: 16),
          ],
          _buildCard(child: child),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildProfilePicHeader(),
          _buildMasonryLayout(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          _buildProfilePicHeader(),
          _buildMasonryLayout(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMasonryLayout() {
    List<Widget> cards = _getMasonryCards();

    return LayoutBuilder(
      builder: (context, constraints) {
        return MasonryGridView(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: cards,
        );
      },
    );
  }

  List<Widget> _getMasonryCards() {
    if (widget.selectedChoice == 'Individual') {
      return [
        _buildCard(
          child: RekanGeneralIdv(viewMode: 'tambah', recordId: ''),
        ),
        _buildCard(
          child: RekanContact(),
        ),
        _buildCard(
          child: RekanBank(),
        ),
        // _buildCard(
        // child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
        // ),
      ];
    } else {
      return [
        _buildCard(
          child: RekanGeneralCmp(),
        ),
        _buildCard(
          child: RekanContact(),
        ),
        _buildPicSection(),
        _buildCard(
          child: RekanBank(),
        ),
        // _buildCard(
        // child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
        // ),
      ];
    }
  }

  List<Widget> _buildFormWidgets() {
    if (widget.selectedChoice == 'Individual') {
      return [
        _buildCard(
          child: RekanGeneralIdv(viewMode: 'tambah', recordId: ''),
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanContact(),
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanBank(),
        ),
        const SizedBox(height: 16),
        // _buildCard(
        // child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
        // ),
      ];
    } else {
      return [
        _buildCard(
          child: RekanGeneralCmp(),
        ),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanContact(),
        ),
        const SizedBox(height: 16),
        _buildPicSection(),
        const SizedBox(height: 16),
        _buildCard(
          child: RekanBank(),
        ),
        const SizedBox(height: 16),
        // _buildCard(
        // child: MRekanPajakFormBody(viewMode: 'tambah', recordId: ''),
        // ),
      ];
    }
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Padding(
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
    );
  }
}

// Custom Masonry Grid Widget
class MasonryGridView extends StatelessWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<Widget> children;

  const MasonryGridView({
    Key? key,
    required this.crossAxisCount,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;

        // Create columns
        List<List<Widget>> columns = List.generate(crossAxisCount, (index) => <Widget>[]);
        List<double> columnHeights = List.generate(crossAxisCount, (index) => 0.0);

        // Distribute widgets to columns
        for (int i = 0; i < children.length; i++) {
          // Find the shortest column
          int shortestColumnIndex = 0;
          for (int j = 1; j < columnHeights.length; j++) {
            if (columnHeights[j] < columnHeights[shortestColumnIndex]) {
              shortestColumnIndex = j;
            }
          }

          // Add widget to the shortest column
          columns[shortestColumnIndex].add(children[i]);

          // Estimate height (this is a rough approximation)
          columnHeights[shortestColumnIndex] += _estimateWidgetHeight(children[i]) + mainAxisSpacing;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columns.asMap().entries.map((entry) {
            int columnIndex = entry.key;
            List<Widget> columnChildren = entry.value;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: columnIndex < crossAxisCount - 1 ? crossAxisSpacing : 0,
                ),
                child: Column(
                  children: columnChildren
                      .asMap()
                      .entries
                      .map((childEntry) {
                    int childIndex = childEntry.key;
                    Widget child = childEntry.value;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: childIndex < columnChildren.length - 1 ? mainAxisSpacing : 0,
                      ),
                      child: child,
                    );
                  }).toList(),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  double _estimateWidgetHeight(Widget widget) {
    // This is a rough estimation. In a real implementation, you might want to
    // measure the actual height or use a more sophisticated approach
    if (widget.toString().contains('_buildPicSection')) {
      return 400.0; // PIC section is usually taller
    } else if (widget.toString().contains('RekanGeneralCmp') ||
        widget.toString().contains('RekanGeneralIdv')) {
      return 350.0; // General forms are medium height
    } else if (widget.toString().contains('RekanContact')) {
      return 300.0; // Contact form is medium height
    } else if (widget.toString().contains('Bank')) {
      return 280.0; // Bank forms are shorter
    } else if (widget.toString().contains('Pajak')) {
      return 250.0; // Tax form is shortest
    }
    return 300.0; // Default height
  }
}