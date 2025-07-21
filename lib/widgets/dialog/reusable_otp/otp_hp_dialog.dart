// OTP Login Dialog
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/reguser/reguser_bloc.dart';
import '../../../models/reguser/reguser_model.dart';

class OtpHpDialog extends BaseDialog {
  final String hpno;
  const OtpHpDialog({super.key, required this.hpno});

  @override
  State<OtpHpDialog> createState() => OtpHpDialogState();
}

class OtpHpDialogState extends BaseDialogState<OtpHpDialog> {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return WillPopScope(
          onWillPop: () async => true, // ⬅️ Tidak dibatasi oleh login
          child: GestureDetector(
            onTap: !isMobile ? () => Navigator.of(context).pop() : null, // ⬅️ Selalu bisa tap luar untuk close di desktop
            child: Scaffold(
              backgroundColor: isMobile ? Colors.white : Colors.black.withOpacity(0.5),
              body: GestureDetector(
                onTap: () {}, // ⛔ Mencegah tap dalam menutup dialog
                child: isMobile
                    ? _buildMobileLayout(context, false) // ⬅️ isLoggedIn tidak diperlukan lagi
                    : _buildDesktopLayout(context, false),
              ),
            ),
          ),
        );
      },
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
                            'Verifikasi OTP',
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
                                  'Masukkan Kode Token Kamu!',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  'Kami sudah kirimkan kode token khusus ke email kamu.  Cek emailnya, lalu masukkan di bawah ini, ya!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 4),

                                // HP Number
                                Text(
                                  widget.hpno,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF91C050),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 10),

                                // Input Kode OTP
                                _buildOTPInputs(),

                                const SizedBox(height: 10),

                                // Tombol Masuk
                                buildAnimatedButton(
                                  text: 'Masuk',
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
                          'Verifikasi OTP',
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
                    padding: const EdgeInsets.all(32),
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

                        const SizedBox(height: 24),

                        const Text(
                          'Masukkan Kode Token Kamu!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Kami sudah kirimkan kode token khusus ke email kamu.  Cek emailnya, lalu masukkan di bawah ini, ya!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 4),

                        // HP Number
                        Text(
                          widget.hpno,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF91C050),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        // Input Kode OTP
                        _buildOTPInputs(),

                        const SizedBox(height: 10),

                        // Tombol Masuk
                        buildAnimatedButton(
                          text: 'Masuk',
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
                  borderRadius: BorderRadius.circular(5),
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

    RegUserModel? record = context.read<RegUserBloc>().state.record;
    record?.kodePin = otpCode;

    context.read<RegUserBloc>().add(
      ValidasiPinHPEvent(
          record: record!
      ),
    );

  }
}