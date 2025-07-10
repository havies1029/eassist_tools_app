// OTP Login Dialog
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication_bloc.dart';

class OtpEmailDialog extends BaseDialog {
  final String email;

  const OtpEmailDialog({super.key, required this.email});

  @override
  State<OtpEmailDialog> createState() => OtpEmailDialogState();
}

class OtpEmailDialogState extends BaseDialogState<OtpEmailDialog> {
  final List<TextEditingController> _codeControllers =
  List.generate(6, (index) => TextEditingController()); // Changed to 6
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode()); // Changed to 6
  bool _isHovering = false;

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;

            return WillPopScope(
              onWillPop: () async {
                // Hanya tutup dialog ini, tidak semua
                return Navigator.of(context).canPop();
              },
              child: GestureDetector(
                onTap: () {
                  // Tutup dialog ini saja
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                child: Scaffold(
                  backgroundColor: isMobile ? Colors.white : Colors.black.withOpacity(0.5),
                  body: GestureDetector(
                    onTap: () {}, // ⛔ Cegah tap dalam menutup
                    child: isMobile
                        ? _buildMobileLayout(context, true, state)
                        : _buildDesktopLayout(context, true, state),
                  ),
                ),
              ),
            );
          },
        );
      },
      listener: (BuildContext context, EmailVerificationState state) {
        if (state.isLoaded && !state.hasFailure) {
          if (state.token.isNotEmpty) {
            // Biarkan yang memanggil memutuskan kapan ditutup
          }
        } else if (state.errors.isNotEmpty) {
          // Tampilkan error (jika perlu)
        }
      },
    );
  }


// 📱 Mobile Layout - Fullscreen dengan desain yang lebih clean
  Widget _buildMobileLayout(BuildContext context, bool isLoggedIn, EmailVerificationState state) {
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
            // ✅ Header dengan design yang lebih modern
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
                    'Verifikasi OTP',
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
                      minHeight: screenHeight * 0.65,
                    ),
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.08,
                      40,
                      screenWidth * 0.08,
                      32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo dengan shadow yang lebih soft
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

                        // Title dengan hierarchy yang jelas
                        const Text(
                          'Berikut Kode Login Anda',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        // Deskripsi
                        Text(
                          'Kode ini akan digunakan untuk masuk dengan aman menggunakan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 4),

                        // Email
                        Text(
                          widget.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF7BA05B),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 40),

                        // Input Kode OTP
                        _buildOTPInputs(),

                        const SizedBox(height: 32),

                        // Error message
                        if (state.hasFailure)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.red.shade200,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              state.errors[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                        if (state.hasFailure) const SizedBox(height: 24),

                        // Tombol Verifikasi
                        buildAnimatedButton(
                          text: 'Verifikasi OTP',
                          isHovering: _isHovering,
                          onHover: (hovering) => setState(() => _isHovering = hovering),
                          onPressed: () => _handleOTPLogin(),
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
  Widget _buildDesktopLayout(BuildContext context, bool isLoggedIn, EmailVerificationState state) {
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
                          'Verifikasi OTP',
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
                          'Berikut Kode Login Anda',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Kode ini akan digunakan untuk masuk dengan aman menggunakan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 4),

                        // Email
                        Text(
                          widget.email,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7BA05B),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        // Input Kode OTP
                        _buildOTPInputs(),

                        const SizedBox(height: 24),

                        // Error message
                        if (state.hasFailure)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.red.shade200,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              state.errors[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                        if (state.hasFailure) const SizedBox(height: 20),

                        // Tombol Verifikasi
                        buildAnimatedButton(
                          text: 'Verifikasi OTP',
                          isHovering: _isHovering,
                          onHover: (hovering) => setState(() => _isHovering = hovering),
                          onPressed: () => _handleOTPLogin(),
                        ),
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

  Widget _buildOTPInputs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions
        double availableWidth = constraints.maxWidth > 0 ? constraints.maxWidth : MediaQuery.of(context).size.width * 0.8;
        double spacing = 8.0;
        double totalSpacing = spacing * 5; // 5 spaces between 6 boxes
        double boxWidth = (availableWidth - totalSpacing) / 6;

        // Set minimum and maximum box sizes
        boxWidth = boxWidth.clamp(40.0, 55.0);
        double boxHeight = boxWidth;

        // Adjust font size based on box size
        double fontSize = boxWidth * 0.4; // 40% of box width
        fontSize = fontSize.clamp(16.0, 24.0);

        return Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) { // Changed to 6
              return Container(
                width: boxWidth,
                height: boxHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _focusNodes[index].hasFocus
                        ? Colors.blue.shade300
                        : Colors.grey.shade300,
                    width: _focusNodes[index].hasFocus ? 2.0 : 1.0,
                  ),
                  color: _focusNodes[index].hasFocus
                      ? Colors.blue.shade50
                      : Colors.grey.shade50,
                ),
                child: TextField(
                  controller: _codeControllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) { // Changed condition to < 5
                      _focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                    setState(() {}); // Refresh to update border colors
                  },
                  onTap: () {
                    setState(() {}); // Refresh to update border colors
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // Fungsi yang akan disambungkan ke API
  void _handleOTPLogin() {
    String otpCode =
    _codeControllers.map((controller) => controller.text).join();

    // Validasi apakah semua kotak sudah diisi
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi semua kode OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    //Navigator.of(context).pop();

    context.read<EmailVerificationBloc>().add(
      ValidasiPinEmailEvent(
        record: EmailVerificationModel(email: widget.email, pin: otpCode),
      ),
    );
  }
}