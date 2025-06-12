
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../dialog/Reusable_OTP/reusable_otp_dialog.dart';
import '../../register/register_gmail/Popup.dart'; // Hanya yang ini
import 'Base_Dialog.dart';
import 'Auth_Api.dart'; // Pastikan AuthService.loginWithGmail menerima idToken
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';


import 'popup_dialog_login.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isHovering = false;
  bool _isGmailHovering = false;
  bool _isHoveringRegister = false;
  bool _isHoveringForgotPassword = false;
  bool _rememberLogin = false;

  String? _emailError;
  String? _passwordError;
  late final Widget _cachedGoogleButton;

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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return buildDialogLoginMobile();
    } else {
      return buildDialogLoginDesktop();
    }

  }

  Widget _buildMobileBody() {
    return Column(
      children: [
        buildTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        if (_emailError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _emailError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
        const SizedBox(height: 20),

        // ––––– Input Password (mobile) –––––
        Container(
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
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
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
                borderSide:
                const BorderSide(color: Color(0xFF79AB43), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
        if (_passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
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
          onPressed: () => _handleLogin(),
        ),
        const SizedBox(height: 20),

        _buildDivider(),
        const SizedBox(height: 20),


        _buildLoginOptions(),
        const SizedBox(height: 20),

        _buildRegisterLink(),
      ],
    );
  }

  Widget _buildLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ]
                : [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
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
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFF7BA05B),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 44),
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
                await CustomPopupsLoginUser.showRegisterUserDialog(context);
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

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    var hasError = false;
    if (email.isEmpty) {
      setState(() => _emailError = 'Email tidak boleh kosong');
      hasError = true;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => _emailError = 'Format email tidak valid');
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = 'Password tidak boleh kosong');
      hasError = true;
    } else if (password.length < 6) {
      setState(() => _passwordError = 'Password minimal 6 karakter');
      hasError = true;
    }

    if (hasError) return;

    debugPrint(
      '🔵 Tombol Masuk ditekan dengan email="$email" dan password(tersimpan)"',
    );

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

  void _handleForgotPassword() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur lupa kata sandi akan ditambahkan'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget buildDialogLoginMobile() {
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
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage:
                  const AssetImage('assets/images/jps_logo.png'),
                ),
                const SizedBox(height: 24),
                _buildMobileBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDialogLoginDesktop() {
    return buildDialogContainer(
      title: 'Login',
      body: Column(
        children: [
          buildLogo(),
          const SizedBox(height: 15),
          const Text(
            'Masukkan Email dan Password',
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

          // ––––– Input Email –––––
          buildTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          if (_emailError != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _emailError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          const SizedBox(height: 20),

          // ––––– Input Password –––––
          Container(
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
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
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
                  borderSide:
                  const BorderSide(color: Color(0xFF79AB43), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
          ),
          if (_passwordError != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
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
              onHover: (hovering) =>
                  setState(() => _isGmailHovering = hovering),
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
}


