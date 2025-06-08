import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../register/register_gmail/Popup.dart'; // Hanya yang ini
import '../../dialog/Reusable_OTP/reusable_otp_dialog.dart';
import 'Base_Dialog.dart';
import 'Auth_Api.dart'; // Pastikan AuthService.loginWithGmail menerima idToken
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Popup.dart';

// Pastikan ini adalah Web Client ID
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  hostedDomain: '',
  serverClientId:
  '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
);

class GeneralLoginDialog extends BaseDialog {
  const GeneralLoginDialog({super.key});

  @override
  State<GeneralLoginDialog> createState() => _GeneralLoginDialogState();
}

class _GeneralLoginDialogState extends BaseDialogState<GeneralLoginDialog> {
  // ─────────────────────────────────────────────────────────────────────
  // 1) Controller, errorText, dan state hovering diletakkan di atas:
  final _emailController = TextEditingController();

  bool _isHovering = false;
  bool _isGmailHovering = false;
  bool _isHoveringRegister = false;
  bool _isHoveringForgotPassword = false;
  bool _rememberLogin = false;

  String? _emailError;
  late final Widget _cachedGoogleButton;
  // ─────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    if (AppData.kIsWeb) {
      // Hanya panggil registerGoogleSigninButton() sekali
      registerGoogleSigninButton();
      // Cache widget-nya supaya tidak dibuat ulang berulang kali
      _cachedGoogleButton = googleSigninButton();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      // Versi dialog mobile dengan tombol X hijau di kiri atas
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            // Konten utama dialog
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLogo(),
                  const SizedBox(height: 24),
                  _buildMobileBody(),
                ],
              ),
            ),
            // Tombol X di kiri atas
            Positioned(
              top: 12,
              left: 12,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    }

    // ======= DESKTOP =========
    return buildDialogContainer(
      title: 'Login',
      body: Column(
        children: [
          buildLogo(),
          const SizedBox(height: 15),
          const Text(
            'Masukkan Email',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Yuk, login dulu biar bisa akses semuanya!',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 35),

          // ────────────────────────────────────────────────────────────────────
          // Semua field dan tombol desktop dipisah di bawah
          ..._buildDesktopFieldsAndButtons(),
          // ────────────────────────────────────────────────────────────────────
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 2) Body untuk mobile, semua field & tombol ada di sini, modular:
  Widget _buildMobileBody() {
    return Column(
      children: [
        ..._buildMobileFields(),
        const SizedBox(height: 20),
        _buildLoginButton(
          text: 'Masuk',
          isHovering: _isHovering,
          onHover: (hovering) => setState(() => _isHovering = hovering),
          onPressed: () => _handleLogin(),
        ),
        const SizedBox(height: 20),
        _buildDivider(),
        const SizedBox(height: 20),
        // ––––– Selalu gunakan custom “Masuk Menggunakan Gmail” di mobile –––––
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

  // ─────────────────────────────────────────────────────────────────────────
  // 3) Kombinasi field + tombol untuk desktop:
  List<Widget> _buildDesktopFieldsAndButtons() {
    return [
      // Input Email
      _buildInputField(
        controller: _emailController,
        hintText: 'Email',
        keyboardType: TextInputType.emailAddress,
      ),
      if (_emailError != null) ...[
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _emailError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
      ],
      const SizedBox(height: 20),

      _buildLoginButton(
        text: 'Masuk',
        isHovering: _isHovering,
        onHover: (hovering) => setState(() => _isHovering = hovering),
        onPressed: () => _handleLogin(),
      ),
      const SizedBox(height: 20),

      _buildDivider(),
      const SizedBox(height: 20),

      // ––––– Gunakan widget Google Sign-In yang sudah di-cache –––––
      if (kIsWeb && MediaQuery.of(context).size.width > 600)
        _cachedGoogleButton
      else
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
    ];
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 4) List<Widget> field untuk mobile
  List<Widget> _buildMobileFields() {
    return [
      _buildInputField(
        controller: _emailController,
        hintText: 'Email',
        keyboardType: TextInputType.emailAddress,
      ),
      if (_emailError != null) ...[
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _emailError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
      ],
    ];
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 5) _buildInputField: desain tetap sama (rounded, shadow, padding, dst.)
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF79AB43), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 6) _buildLoginButton: untuk desktop & mobile (animasi hover, rounded, shadow)
  Widget _buildLoginButton({
    required String text,
    required bool isHovering,
    required Function(bool) onHover,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF6B9639),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isHovering
              ? [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 7) Divider bertuliskan “Atau”
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text('Atau', style: TextStyle(color: Colors.grey, fontSize: 14)),
        ),
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 8) Icon button khusus (Google Sign-In / tombol kustom)
  Widget _buildIconButton({
    required String text,
    required String iconPath,
    required bool isHovering,
    required Function(bool) onHover,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: MouseRegion(
        onEnter: (_) => onHover(true),
        onExit: (_) => onHover(false),
        child: GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isHovering ? Colors.grey.shade100 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovering ? Colors.grey.shade400 : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: isHovering
                  ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
                  : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                SvgPicture.asset(iconPath, width: 24, height: 24),
                const Spacer(),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF7BA05B),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 44),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 9) Opsi “Simpan Login” dan “Lupa Kata Sandi?”
  Widget _buildLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() => _rememberLogin = !_rememberLogin),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberLogin,
                  onChanged: (bool? value) =>
                      setState(() => _rememberLogin = value ?? false),
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

  // ─────────────────────────────────────────────────────────────────────────
  // 10) Link “Daftar” di bagian paling bawah
  Widget _buildRegisterLink() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Padding(
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
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 11) Logo (dipakai di desktop dan mobile)
  Widget buildLogo() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      backgroundImage: const AssetImage('assets/images/jps_logo.png'),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 12) Handler Login (desktop/mobile)
  void _handleLogin() async {
    final email = _emailController.text.trim();

    setState(() {
      _emailError = null;
    });

    if (email.isEmpty) {
      setState(() => _emailError = 'Email tidak boleh kosong');
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => _emailError = 'Format email tidak valid');
      return;
    }

    debugPrint('🔵 Tombol Masuk ditekan dengan email="$email"');

    // Simulasi delay sebelum menampilkan OTP
    final success = await Future.delayed(
      const Duration(milliseconds: 300),
          () => true,
    );

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ReusableOTPDialog(
        email: email,
        onSubmit: (code) async {
          final otpSuccess = await AuthService.verifyOTP(email, code);
          if (!otpSuccess) throw 'Kode OTP salah';
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 13) Handler Google Login
  void _handleGmailLogin() async {
    // Tutup dulu dialog ini
    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final user = await _googleSignIn.signIn();
      if (user == null) return;

      final auth = await user.authentication;
      final idToken = auth.idToken;
      // Kirim idToken ke backend
      final success = await AuthService.loginWithGmail();
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login dengan Gmail berhasil!'),
            backgroundColor: Color(0xFF7BA05B),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Google gagal, silakan coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 14) Handler Forgot Password
  void _handleForgotPassword() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur lupa kata sandi akan ditambahkan'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
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
            backgroundColor:
            _isHovering ? const Color(0xFF6B9639) : Colors.grey.shade400,
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
        CustomPopupsLoginUser.showLoginDialog(
          context,
          email: _emailController.text,
        );
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
  final List<TextEditingController> _codeControllers =
  List.generate(4, (index) => TextEditingController());
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
    String otpCode =
    _codeControllers.map((controller) => controller.text).join();

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
