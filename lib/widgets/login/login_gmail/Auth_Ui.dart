import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import for SVG support
import '../../register/register_gmail/Popup.dart';
import '../login_client/ReusableOTPDialog.dart';
import 'Base_Dialog.dart';
import 'Popup.dart';
import 'Auth_Api.dart'; // Import service untuk API calls

// Login Dialog dengan opsi multiple (Email, Gmail, dll)
class GeneralLoginDialog extends BaseDialog {
  const GeneralLoginDialog({super.key});

  @override
  State<GeneralLoginDialog> createState() => _GeneralLoginDialogState();
}

class _GeneralLoginDialogState extends BaseDialogState<GeneralLoginDialog> {
  final _emailController = TextEditingController();
  bool _isHovering = false;
  bool _isGmailHovering = false;
  bool _isEmailHovering = false;
  bool _isHoveringRegister = false;
  bool _isHoveringForgotPassword = false;
  bool _rememberLogin = false; // State untuk checkbox simpan login

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      // 👉 Tampilan Mobile dengan latar hijau-putih
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background hijau di bagian atas
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                color: const Color(0xFF79AB43),
              ),
            ),

            // Konten di tengah
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo JPS
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage('assets/images/jps_logo.png'), // atau sesuai logo kamu
                      ),
                      const SizedBox(height: 24),
                      _buildMobileBody(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 👉 Desktop default
    return buildDialogContainer(
      title: 'Login',
      body: Column(
        children: [
          buildLogo(),
          const SizedBox(height: 30),
          buildTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          buildAnimatedButton(
            text: 'Masuk',
            isHovering: _isHovering,
            onHover: (hovering) => setState(() => _isHovering = hovering),
            onPressed: () => _handleLogin(),
          ),
          const SizedBox(height: 20),
          _buildDivider(),
          const SizedBox(height: 20),
          _buildIconButton(
            text: 'Masuk Menggunakan Gmail',
            iconPath: 'assets/icons/google-icon.svg',
            isHovering: _isGmailHovering,
            onHover: (hovering) => setState(() => _isGmailHovering = hovering),
            onPressed: () => _handleGmailLogin(),
          ),
          const SizedBox(height: 20),
          _buildLoginOptions(),
          const SizedBox(height: 20),
          _buildRegisterLink(),
        ],
      ),
    );

  }

  Widget _buildMobileBody() {
    return Column(
      children: [
        buildTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),

        buildAnimatedButton(
          text: 'Masuk',
          isHovering: _isHovering,
          onHover: (hovering) => setState(() => _isHovering = hovering),
          onPressed: () => _handleLogin(),
        ),
        const SizedBox(height: 20),

        _buildDivider(),
        const SizedBox(height: 20),

        _buildIconButton(
          text: 'Masuk Menggunakan Gmail',
          iconPath: 'assets/icons/google-icon.svg',
          isHovering: _isGmailHovering,
          onHover: (hovering) => setState(() => _isGmailHovering = hovering),
          onPressed: () => _handleGmailLogin(),
        ),
        const SizedBox(height: 20),

        _buildLoginOptions(),
        const SizedBox(height: 20),

        _buildRegisterLink(),
      ],
    );
  }


  // Widget untuk checkbox simpan login dan lupa kata sandi
  Widget _buildLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Checkbox Simpan Login
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberLogin = !_rememberLogin;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberLogin,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberLogin = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF7BA05B),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Simpan Login',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Lupa Kata Sandi
        MouseRegion(
          onEnter: (_) => setState(() => _isHoveringForgotPassword = true),
          onExit: (_) => setState(() => _isHoveringForgotPassword = false),
          child: GestureDetector(
            onTap: () => _handleForgotPassword(),
            child: Text(
              'Lupa Kata Sandi?',
              style: TextStyle(
                color: _isHoveringForgotPassword
                    ? const Color(0xFF7BA05B)
                    : Colors.blue.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String text,
    required String iconPath,
    required bool isHovering,
    required Function(bool) onHover,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: isHovering ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovering ? Colors.grey.shade400 : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: isHovering
                ? [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))]
                : [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 2))],
          ),
          child: Row(
            children: [
              // Icon container
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              // Text centered in remaining space
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: const Color(0xFF7BA05B), // Light green color
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Empty space to balance the icon on the left
              const SizedBox(width: 44), // 20 (padding) + 24 (icon width)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('Atau', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
        ),
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tidak memiliki akun? ',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringRegister = true),
            onExit: (_) => setState(() => _isHoveringRegister = false),
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                await CustomPopupsRegisterUser.showRegisterDialog(context);
              },
              child: Text(
                'Daftar',
                style: TextStyle(
                  color: _isHoveringRegister
                      ? const Color(0xFF7BA05B)
                      : Colors.blue.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _handleLogin() {
  //   final email = _emailController.text.trim();
  //
  //   if (email.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Email tidak boleh kosong'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   // ✅ Tutup dialog login terlebih dahulu
  //   Navigator.of(context).pop();
  //
  //   // ✅ Tunggu 200ms sebelum membuka OTP dialog
  //   Future.delayed(const Duration(milliseconds: 200), () {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false, // kamu bisa atur true jika mau
  //       builder: (_) => OTPLoginDialog(email: email),
  //     );
  //   });
  // }

  void _handleLogin() async {
    debugPrint('🔵 Tombol Masuk ditekan');

    // Contoh dummy async verifikasi login (misal panggil AuthService.login)
    final success = await Future.delayed(
      const Duration(milliseconds: 300),
          () => true,
    );

    if (!mounted) return;

    debugPrint('🟢 Memanggil OTP Dialog');

    showDialog(
      context: context,
      builder: (_) => ReusableOTPDialog(
        email: 'you@example.com',
        onSubmit: (code) async {
          final success = await AuthService.verifyOTP('you@example.com', code);
          if (!success) throw 'Kode OTP salah';
        },
      ),
    );

  }


  void _handleGmailLogin() {
    Navigator.of(context).pop();
    AuthService.loginWithGmail().then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login dengan Gmail berhasil!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _handleEmailLogin() {
    Navigator.of(context).pop();
    AuthService.loginWithEmail().then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login dengan Email berhasil!'),
            backgroundColor: CustomPopupsLoginUser.primaryGreen,
          ),
        );
      }
    });
  }

  void _handleForgotPassword() {
    // Implementasi untuk lupa kata sandi
    Navigator.of(context).pop();
    // Bisa menampilkan dialog baru untuk reset password
    // atau navigate ke halaman forgot password
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur lupa kata sandi akan ditambahkan'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

// Register Dialog
class RegisterDialog extends BaseDialog {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends BaseDialogState<RegisterDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedChoice = 'Pilihan';
  bool _isHovering = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildDialogContainer(
      title: 'Daftar Klien',
      body: Column(
        children: [
          buildLogo(),
          const SizedBox(height: 30),

          // Input Nama
          buildTextField(
            controller: _nameController,
            hintText: 'Nama Lengkap',
          ),
          const SizedBox(height: 20),

          // Input Email
          buildTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Dropdown
          _buildDropdown(),
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
  }

  Widget _buildDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChoice,
          hint: const Text('Pilihan'),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['Pilihan', 'Individual', 'Perusahaan', 'Organisasi']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedChoice = newValue!;
            });
          },
        ),
      ),
    );
  }

  // Fungsi yang akan disambungkan ke API
  void _handleRegister() {
    AuthService.register(
      _nameController.text,
      _emailController.text,
      _selectedChoice,
    ).then((success) {
      if (success) {
        Navigator.of(context).pop();
        CustomPopupsLoginUser.showLoginDialog(context, email: _emailController.text);
      }
    });
  }
}

// OTP Login Dialog
class OTPLoginDialog extends BaseDialog {
  final String email;

  const OTPLoginDialog({super.key, required this.email});

  @override
  State<OTPLoginDialog> createState() => _OTPLoginDialogState();
}

class _OTPLoginDialogState extends BaseDialogState<OTPLoginDialog> {
  final List<TextEditingController> _codeControllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
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
    return buildDialogContainer(
      title: 'Login',
      body: Column(
        children: [
          buildLogo(),
          const SizedBox(height: 30),

          // Judul
          const Text(
            'Berikut Kode Login Anda',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          // Deskripsi
          const Text(
            'Kode ini akan digunakan untuk masuk dengan aman menggunakan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 5),

          // Email
          Text(
            widget.email.isEmpty ? 'deandra1005@gmail.com' : widget.email,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),

          // Input Kode OTP
          _buildOTPInputs(),
          const SizedBox(height: 40),

          // Tombol Masuk
          buildAnimatedButton(
            text: 'Masuk',
            isHovering: _isHovering,
            onHover: (hovering) => setState(() => _isHovering = hovering),
            onPressed: () => _handleOTPLogin(),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.grey.shade50,
          ),
          child: TextField(
            controller: _codeControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  // Fungsi yang akan disambungkan ke API
  void _handleOTPLogin() {
    String otpCode = _codeControllers.map((controller) => controller.text).join();

    AuthService.verifyOTP(widget.email, otpCode).then((success) {
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: CustomPopupsLoginUser.primaryGreen,
          ),
        );
      }
    });
  }
}