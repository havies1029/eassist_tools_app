import 'package:eassist_tools_app/blocs/reguser/reguser_bloc.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_data.dart';
import '../../../../models/reguser/reguser_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjnsclient_widget.dart';
class RegisterClientDialog extends BaseDialog {
  const RegisterClientDialog({super.key});

  @override
  State<RegisterClientDialog> createState() => _RegisterClientDialogState();
}

class _RegisterClientDialogState extends BaseDialogState<RegisterClientDialog> {
  final _nameController = TextEditingController();
  final hpController = TextEditingController();
  final pswdController = TextEditingController();
  final confirmPswdController = TextEditingController();
  ComboMJnsclientModel? fieldComboJnsClient;
  String _selectedChoice = '';
  bool _isHovering = false;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  @override
  void dispose() {
    _nameController.dispose();
    hpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        // Assume isLoggedIn logic - adjust based on your auth state
        final isLoggedIn = true; // You can replace this with your actual auth check

        return WillPopScope(
          onWillPop: () async => true, // Allow back navigation for registration
          child: GestureDetector(
            onTap: (isLoggedIn && !isMobile) ? () => Navigator.of(context).pop() : null,
            child: Scaffold(
              backgroundColor: isMobile ? Colors.white : Colors.black.withOpacity(0.5),
              body: GestureDetector(
                onTap: () {},
                child: isMobile ? _buildMobileLayout(context, isLoggedIn) : _buildDesktopLayout(context, isLoggedIn),
              ),
            ),
          ),
        );
      },
    );
  }

// 📱 Mobile Layout - Fullscreen dengan desain yang konsisten
  Widget _buildMobileLayout(BuildContext context, bool isLoggedIn) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF7BA05B),
            const Color(0xFF7BA05B).withOpacity(0.8),
            Colors.white,
          ],
          stops: const [0.0, 0.3, 0.4],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ✅ Header dengan design yang konsisten
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Row(
                children: [
                  if (isLoggedIn)
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (isLoggedIn) const SizedBox(width: 16),
                  const Text(
                    'Daftar Klien',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Content Area dengan proper spacing
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.7,
                    ),
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.08,
                      40,
                      screenWidth * 0.08,
                      32,
                    ),
                    child: Column(
                      children: [
                        // Logo dengan shadow yang soft
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7BA05B).withOpacity(0.15),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/jps_logo.png'),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Welcome text dengan hierarchy yang jelas
                        const Text(
                          'Buat Akun Baru',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Lengkapi data diri untuk membuat akun klien',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 40),

                        // Form Registration
                        BlocConsumer<RegUserBloc, RegUserState>(
                          builder: (context, state) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Input Nama
                                  buildTextField(
                                    controller: _nameController,
                                    hintText: 'Nama Lengkap',
                                  ),
                                  const SizedBox(height: 20),

                                  // Input HP dengan styling yang konsisten
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 1,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: hpController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.only(left: 16, right: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                '+62',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 1,
                                                height: 20,
                                                color: Colors.grey.shade300,
                                              ),
                                            ],
                                          ),
                                        ),
                                        hintText: '8xxxxxxx',
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 16,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 18,
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Nomor HP wajib diisi';
                                        }
                                        if (!RegExp(r'^8[0-9]{8,12}$').hasMatch(value)) {
                                          return 'Format nomor harus diawali 8 dan panjang 9-13 digit';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        if (hpController.text.isEmpty) {
                                          hpController.text = '8';
                                          hpController.selection = TextSelection.fromPosition(
                                            TextPosition(offset: hpController.text.length),
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Input Password
                                  buildTextField(
                                    controller: pswdController,
                                    hintText: 'Password',
                                    keyboardType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    obscureText: !_passwordVisible,
                                    onToggleVisibility: () {
                                      setState(() => _passwordVisible = !_passwordVisible);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  buildTextField(
                                    controller: confirmPswdController,
                                    hintText: 'Confirm Password',
                                    keyboardType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    obscureText: !_confirmPasswordVisible,
                                    onToggleVisibility: () {
                                      setState(() => _confirmPasswordVisible = !_confirmPasswordVisible);
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  // Dropdown Jenis Client
                                  buildFieldJenisClient(),
                                  const SizedBox(height: 40),

                                  // Tombol Daftar
                                  buildAnimatedButton(
                                    text: 'Daftar',
                                    isHovering: _isHovering,
                                    onHover: (hovering) => setState(() => _isHovering = hovering),
                                    backgroundColor: _isHovering ? const Color(0xFF6B9639) : Colors.grey.shade400,
                                    onPressed: () => _handleRegister(),
                                  ),
                                ],
                              ),
                            );
                          },
                          listener: (context, state) {
                            // Handle state changes if needed
                          },
                        ),

                        const SizedBox(height: 24),

                        // Decorative element
                        Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// 🖥️ Desktop Layout - Dialog dengan design yang konsisten
  Widget _buildDesktopLayout(BuildContext context, bool isLoggedIn) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480), // Slightly wider for form
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Header dengan gradient yang halus
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF7BA05B),
                          const Color(0xFF6B8F4F),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Row(
                      children: [
                        if (isLoggedIn)
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (isLoggedIn) const SizedBox(width: 16),
                        const Text(
                          'Daftar Klien',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✅ Body dengan spacing yang proporsional
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.all(32),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo dengan subtle shadow
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF7BA05B).withOpacity(0.12),
                                  blurRadius: 16,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/images/jps_logo.png'),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            'Buat Akun Baru',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Lengkapi data diri untuk membuat akun klien',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 32),

                          // Form Registration
                          BlocConsumer<RegUserBloc, RegUserState>(
                            builder: (context, state) {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // Input Nama
                                    buildTextField(
                                      controller: _nameController,
                                      hintText: 'Nama Lengkap',
                                    ),
                                    const SizedBox(height: 20),

                                    // Input HP dengan styling yang konsisten
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1,
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: hpController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          prefixIcon: Container(
                                            padding: const EdgeInsets.only(left: 16, right: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  '+62',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  width: 1,
                                                  height: 16,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ],
                                            ),
                                          ),
                                          hintText: '8xxxxxxx',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16,
                                          ),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Nomor HP wajib diisi';
                                          }
                                          if (!RegExp(r'^8[0-9]{8,12}$').hasMatch(value)) {
                                            return 'Format nomor harus diawali 8 dan panjang 9-13 digit';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          if (hpController.text.isEmpty) {
                                            hpController.text = '8';
                                            hpController.selection = TextSelection.fromPosition(
                                              TextPosition(offset: hpController.text.length),
                                            );
                                          }
                                        },
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Input Password
                                    buildTextField(
                                      controller: pswdController,
                                      hintText: 'Password',
                                      keyboardType: TextInputType.visiblePassword,
                                      isPassword: true,
                                      obscureText: !_passwordVisible,
                                      onToggleVisibility: () {
                                        setState(() => _passwordVisible = !_passwordVisible);
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    buildTextField(
                                      controller: confirmPswdController,
                                      hintText: 'Confirm Password',
                                      keyboardType: TextInputType.visiblePassword,
                                      isPassword: true,
                                      obscureText: !_confirmPasswordVisible,
                                      onToggleVisibility: () {
                                        setState(() => _confirmPasswordVisible = !_confirmPasswordVisible);
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    // Dropdown Jenis Client
                                    buildFieldJenisClient(),
                                    const SizedBox(height: 40),

                                    // Tombol Daftar
                                    buildAnimatedButton(
                                      text: 'Daftar',
                                      isHovering: _isHovering,
                                      onHover: (hovering) => setState(() => _isHovering = hovering),
                                      backgroundColor: _isHovering ? const Color(0xFF6B9639) : Colors.grey.shade400,
                                      onPressed: () => _handleRegister(),
                                    ),
                                  ],
                                ),
                              );
                            },
                            listener: (context, state) {
                              // Handle state changes if needed
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildDropdown() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.shade300),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         value: _selectedChoice,
  //         hint: const Text('Pilihan'),
  //         isExpanded: true,
  //         icon: const Icon(Icons.keyboard_arrow_down),
  //         items: ['Pilihan', 'Individual', 'Perusahaan', 'Organisasi']
  //             .map((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value),
  //           );
  //         }).toList(),
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             _selectedChoice = newValue!;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget buildFieldJenisClient() {
    return buildFieldComboMJnsclient(
      labelText: 'Jenis Client',
      initItem: fieldComboJnsClient,
      onChangedCallback: (value) {
        if (value != null) {
          //fieldComboJnsClient = value;
          _selectedChoice = value.mjnsclientId;
          debugPrint("fieldComboJnsClient: $_selectedChoice}");
        }
      },
      onSaveCallback: (value) {},
    );
  }

  // Fungsi yang akan disambungkan ke API
  // Fungsi yang akan disambungkan ke API
  void _handleRegister() {

    debugPrint("AppData.userToken.token : ${AppData.userToken}");


    if (_formKey.currentState!.validate()) {
      if (pswdController.text != confirmPswdController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password tidak cocok'))
        );
        return;
      }

      final fullPhone = '62${hpController.text}';

      RegUserModel record = RegUserModel(
        userNama: AppData.user.username ?? "",
        personalNama: _nameController.text,
        telepon: fullPhone,
        password: pswdController.text,
        jnsClientId: _selectedChoice,
        email: AppData.user.email ?? "",
      );

      context.read<RegUserBloc>().add(
          RegUserTambahEvent(record: record)
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Isi semua field dengan benar'))
      );
    }


  }
}