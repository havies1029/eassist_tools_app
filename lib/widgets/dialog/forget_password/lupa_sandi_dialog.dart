import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LupaSandiDialog extends BaseDialog {
  const LupaSandiDialog({super.key});

  @override
  State<LupaSandiDialog> createState() => LupaSandiDialogState();
}

class LupaSandiDialogState extends BaseDialogState<LupaSandiDialog> {
  final _emailController = TextEditingController();

  bool _isHovering = false;
  bool _isHoveringRegister = false;

  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final isMobile = constraints.maxWidth < 768;
  //
  //       return SingleChildScrollView(
  //         child: Dialog(
  //           insetPadding: EdgeInsets.symmetric(
  //               horizontal: isMobile ? 20 : 40,
  //               vertical: 40
  //           ),
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //           child: Container(
  //             width: isMobile ? double.infinity : null,
  //             constraints: BoxConstraints(
  //               maxWidth: isMobile
  //                   ? MediaQuery.of(context).size.width - 40
  //                   : 450,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Header hijau dengan tombol close dan judul
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     color: Color(0xFF91C050),
  //                     borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(20),
  //                       topRight: Radius.circular(20),
  //                     ),
  //                   ),
  //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //                   child: Row(
  //                     children: [
  //                       // GestureDetector(
  //                       //   onTap: () => Navigator.of(context).pop(),
  //                       //   child: Container(
  //                       //     width: 28,
  //                       //     height: 28,
  //                       //     decoration: BoxDecoration(
  //                       //       color: Colors.white.withOpacity(0.2),
  //                       //       shape: BoxShape.circle,
  //                       //     ),
  //                       //     // child: const Icon(
  //                       //     //   Icons.close,
  //                       //     //   size: 18,
  //                       //     //   color: Colors.white,
  //                       //     // ),
  //                       //   ),
  //                       // ),
  //                       // const SizedBox(width: 16),
  //                       const Text(
  //                         'Reset Password',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 // Body putih
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.only(
  //                       bottomLeft: Radius.circular(20),
  //                       bottomRight: Radius.circular(20),
  //                     ),
  //                   ),
  //                   padding: const EdgeInsets.all(32),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       // Logo
  //                       const CircleAvatar(
  //                         radius: 40,
  //                         backgroundColor: Colors.white,
  //                         backgroundImage: AssetImage('assets/images/jps_logo.png'),
  //                       ),
  //                       const SizedBox(height: 24),
  //
  //                       // Judul dan subtitle
  //                       const Text(
  //                         'Lupa Kata Sandi?',
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.black87,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Text(
  //                         'Masukkan email Anda untuk mendapatkan link reset password',
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           color: Colors.grey.shade600,
  //                         ),
  //                         textAlign: TextAlign.center,
  //
  //                       ),
  //                       const SizedBox(height: 32),
  //
  //                       _buildResetForm(context, isMobile),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationAuthenticated) {
          // ✅ 1. Tutup dialog saat user berhasil login/reset berhasil
          Navigator.of(context).pop();

          // ✅ 2. Delay opsional (untuk transisi mulus)
          await Future.delayed(const Duration(milliseconds: 100));
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          final authState = context.watch<AuthenticationBloc>().state;
          final isLoggedIn = authState is AuthenticationAuthenticated;

          return WillPopScope(
            onWillPop: () async => isLoggedIn,
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
      ),
    );
  }

// 📱 Mobile Layout - Fullscreen dengan desain yang lebih clean
  Widget _buildMobileLayout(BuildContext context, bool isLoggedIn) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Stack(
            children: [
              Container(
                height: screenHeight * 0.4,
                width: double.infinity,
                color: const Color(0xFF91C050),
              ),
              SafeArea(
                child: Column(
                  children: [
                    // ✅ Header atas
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                            'Ubah Kata Sandi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ✅ Content
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.08,
                        40,
                        screenWidth * 0.08,
                        32,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 129,
                                  height: 55,
                                  child: ClipRRect(
                                    child: const Image(
                                      image: AssetImage('assets/images/JPS.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                const Text(
                                  'Lupa Kata Sandi?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  'Masukkan alamat email yang terdaftar. Kami akan\n'
                                      'mengirimkan tautan untuk mengatur ulang kata sandi Anda.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 32),

                                _buildResetForm(context, true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              constraints: const BoxConstraints(maxWidth: 420),
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
                          const Color(0xFF91C050),
                          const Color(0xFF6B8F4F),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
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
                          'Ubah Kata Sandi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 129,
                          height: 55,
                          child: ClipRRect(
                            child: const Image(
                              image: AssetImage('assets/images/JPS.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Masukkan alamat email yang terdaftar. Kami akan\n'
                              'mengirimkan tautan untuk mengatur ulang kata sandi Anda.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        _buildResetForm(context, false),
                      ],
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

  Widget _buildResetForm(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email TextField
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 15,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade500,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFF91C050),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14.5),
            ),
          ),
        ),

        if (_emailError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              _emailError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

        const SizedBox(height: 10),

        // Tombol Reset
        GestureDetector(
          onTap: () => _handleReset(),
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF91C050),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF91C050).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Kirim',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Info text
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue.shade600,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Link reset password akan dikirim ke email Anda. Periksa folder inbox dan spam.',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),
        _buildFooterLinks(context),
      ],
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Teks "Ingat Password?"
          Center(
            child: Text(
              'Sudah Ingat Password?',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Baris link
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Masuk sebagai Klien
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveringRegister = true),
                onExit: (_) => setState(() => _isHoveringRegister = false),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<AuthenticationBloc>().add(
                      RequireLoginClient(requiredFrom: "lupa_sandi", errorMsg: ""),
                    );
                  },
                  child: Text(
                    'Masuk Sebagai Klien',
                    style: TextStyle(
                      color: _isHoveringRegister
                          ? const Color(0xFF91C050)
                          : Colors.blue.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Masuk sebagai Pengguna
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<AuthenticationBloc>().add(RequireLoginUser());
                  },
                  child: Text(
                    'Masuk sebagai Pengguna',
                    style: TextStyle(
                      color: _isHovering
                          ? const Color(0xFF91C050)
                          : Colors.blue.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleReset() async {
    final email = _emailController.text.trim();

    setState(() {
      _emailError = null;
    });

    var hasError = false;
    if (email.isEmpty) {
      setState(() => _emailError = 'Email tidak boleh kosong');
      hasError = true;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => _emailError = 'Format email tidak valid');
      hasError = true;
    }

    if (hasError) return;

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Link reset password telah dikirim ke email Anda'),
          backgroundColor: const Color(0xFF91C050),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    }

    // Simulasi delay sebelum menampilkan success
    final success = await Future.delayed(
      const Duration(milliseconds: 300),
          () => true,
    );

    // Optional: Auto close after success
    if (mounted && success) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}