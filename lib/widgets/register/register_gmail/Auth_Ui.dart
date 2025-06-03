import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import for SVG support
import '../../login/login_gmail/Popup.dart';
import '../../reset_password/reset_password_page.dart';
import 'Base_Dialog.dart';
import 'Popup.dart';
import 'Auth_Api.dart'; // Import service untuk API calls

// Register Dialog dengan opsi multiple (Email, Gmail, dll)
class GeneralRegisterDialog extends BaseDialog {
  const GeneralRegisterDialog({super.key});

  @override
  State<GeneralRegisterDialog> createState() => _GeneralRegisterDialogState();
}

class _GeneralRegisterDialogState extends BaseDialogState<GeneralRegisterDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _passwordError;

  bool _isHovering = false;
  bool _isHoveringLogin = false;
  bool _isHoveringGmail = false;
  bool _rememberRegister = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Latar hijau atas
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                color: const Color(0xFF79AB43),
              ),
            ),

            // Kotak Form di tengah
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

    // Default untuk Desktop/Web
    return buildDialogContainer(
      title: 'Register',
      body: _buildMobileBody(),
    );
  }

  Widget _buildMobileBody() {
    return Column(
      children: [
        buildLogo(),
        const SizedBox(height: 15),

        const Text(
          'Masukkan Email dan Password', // sesuaikan teks header-nya
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87, // warna lebih gelap
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Yuk, login dulu biar bisa akses semuanya!', // sesuaikan teks subheader-nya
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54, // warna sedikit lebih terang
          ),
        ),

        const SizedBox(height: 35),

        // Input Email
        buildTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),

        // Input Password - Gunakan buildTextField dengan obscureText
        buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        // Tampilkan pesan error jika password kosong
        if (_passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _passwordError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
        const SizedBox(height: 20),

        buildAnimatedButton(
          text: 'Masuk',
          isHovering: _isHovering,
          onHover: (hovering) => setState(() => _isHovering = hovering),
          onPressed: () => _validateAndRegister(),
        ),
        const SizedBox(height: 20),

        _buildDivider(),
        const SizedBox(height: 20),

        _buildIconButton(
          text: 'Masuk Menggunakan Gmail',
          iconPath: 'assets/icons/google-icon.svg',
          isHovering: _isHoveringGmail,
          onHover: (hovering) => setState(() => _isHoveringGmail = hovering),
          onPressed: () => _handleGmailRegister(),
        ),
        const SizedBox(height: 20),

        _buildRegisterOptions(),
        const SizedBox(height: 20),

        _buildLoginLink(),
      ],
    );
  }

  // Validasi sederhana sebelum memanggil API register
  void _validateAndRegister() {
    setState(() {
      _passwordError = null;
    });

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password tidak boleh kosong';
      });
      return;
    }

    // Jika lolos validasi, panggil fungsi register asli
    _handleRegister();
  }

  // Widget untuk checkbox simpan Register dan lupa kata sandi
  Widget _buildRegisterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Checkbox Simpan Register
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberRegister = !_rememberRegister;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberRegister,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberRegister = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF7BA05B),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Simpan Register',
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
          onEnter: (_) => setState(() => _isHoveringLogin = true),
          onExit: (_) => setState(() => _isHoveringLogin = false),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Tutup dialog register dulu
              showDialog(
                context: context,
                barrierColor: Colors.black54,
                builder: (_) => ResetPasswordPage(),
              );
            },
            child: Text(
              'Lupa Kata Sandi?',
              style: TextStyle(
                color: _isHoveringLogin ? const Color(0xFF7BA05B) : Colors.blue.shade600,
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

  Widget _buildLoginLink() {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sudah memiliki akun? ',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringLogin = true),
            onExit: (_) => setState(() => _isHoveringLogin = false),
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                await CustomPopupsLoginUser.showLoginDialog(context);
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: _isHoveringLogin ? const Color(0xFF7BA05B) : Colors.blue.shade600,
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

  // Fungsi yang akan disambungkan ke API
  void _handleRegister() {
    Navigator.of(context).pop();
    AuthService.Register(
      _emailController.text,
      rememberRegister: _rememberRegister,
    ).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Register berhasil!'),
            backgroundColor: CustomPopupsRegisterUser.primaryGreen,
          ),
        );
      }
    });
  }

  void _handleGmailRegister() {
    Navigator.of(context).pop();
    AuthService.RegisterWithGmail().then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Register dengan Gmail berhasil!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}

// Login Dialog
class LoginDialog extends BaseDialog {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends BaseDialogState<LoginDialog> {
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
            onPressed: () => _handleLogin(),
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
  void _handleLogin() {
    AuthService.Login(
      _nameController.text,
      _emailController.text,
      _selectedChoice,
    ).then((success) {
      if (success) {
        Navigator.of(context).pop();
        CustomPopupsRegisterUser.showRegisterDialog(context, email: _emailController.text);
      }
    });
  }
}

// OTP Register Dialog
class OTPRegisterDialog extends BaseDialog {
  final String email;

  const OTPRegisterDialog({super.key, required this.email});

  @override
  State<OTPRegisterDialog> createState() => _OTPRegisterDialogState();
}

class _OTPRegisterDialogState extends BaseDialogState<OTPRegisterDialog> {
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
      title: 'Register',
      body: Column(
        children: [
          buildLogo(),
          const SizedBox(height: 30),

          // Judul
          const Text(
            'Berikut Kode Register Anda',
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
            onPressed: () => _handleOTPRegister(),
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
  void _handleOTPRegister() {
    String otpCode = _codeControllers.map((controller) => controller.text).join();

    AuthService.verifyOTP(widget.email, otpCode).then((success) {
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Register berhasil!'),
            backgroundColor: CustomPopupsRegisterUser.primaryGreen,
          ),
        );
      }
    });
  }
}