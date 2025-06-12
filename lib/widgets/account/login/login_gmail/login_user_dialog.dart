import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Base_Dialog.dart';
// Pastikan AuthService.loginWithGmail menerima idToken
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Pastikan ini adalah Web Client ID
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  hostedDomain: '',
  serverClientId:
  '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
);

class LoginUserDialog extends BaseDialog {
  const LoginUserDialog({super.key});

  @override
  State<LoginUserDialog> createState() => LoginUserDialogState();
}

class LoginUserDialogState extends BaseDialogState<LoginUserDialog> {
  final _emailController = TextEditingController();

  bool _isHovering = false;
  bool _isGmailHovering = false;
  bool _isHoveringRegister = false;
  bool _isHoveringForgotPassword = false;
  bool _rememberLogin = true;
  bool _isHoveringGmail = false;

  String? _emailError;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
          builder: (context, state) {
            return GestureDetector(
              // Tutup dialog ketika tap area di luar dialog
              onTap: () => Navigator.of(context).pop(),
              child: Scaffold(
                backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent background
                body: GestureDetector(
                  // Mencegah dialog tertutup ketika tap di dalam dialog
                  onTap: () {},
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: isMobile ? 20 : 40,
                            vertical: 40
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: isMobile ? double.infinity : null,
                            constraints: BoxConstraints(
                              maxWidth: isMobile
                                  ? MediaQuery.of(context).size.width - 40
                                  : 450,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Header hijau dengan tombol close dan judul
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF7BA05B),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Body putih
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Logo
                                      const CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage('assets/images/jps_logo.png'),
                                      ),
                                      const SizedBox(height: 24),

                                      // Judul dan subtitle
                                      const Text(
                                        'Masukkan Email',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Yuk, login dulu biar bisa akses semuanya!',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 32),

                                      _buildLoginForm(context, isMobile),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state.isLoaded) {
              // bisa tambahkan aksi jika dibutuhkan
            }
          },
        );
      },
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email TextField
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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

        const SizedBox(height: 24),

        // Tombol Masuk
        GestureDetector(
          onTap: () => _handleLogin(),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF7BA05B),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7BA05B).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Divider "Atau"
        Row(
          children: [
            Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Atau',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
          ],
        ),

        const SizedBox(height: 24),

        // Tombol Google
        AppData.kIsWeb
            ? _cachedGoogleButton
            : _buildGoogleButton(),

        const SizedBox(height: 24),
        _buildLoginOptions(context),
        const SizedBox(height: 16),
        _buildRegisterLink(context),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return GestureDetector(
      onTap: () => _handleGmailRegister(),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/google-icon.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            const Text(
              'Login dengan Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginOptions(BuildContext context) {
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

                      context
                          .read<EmailVerificationBloc>()
                          .add(FieldSimpanPasswordChangedEvent(isSimpanPassword: _rememberLogin));
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
      ],
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Apabila sudah menjadi client : ',
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
              context.read<AuthenticationBloc>().add(RequireLoginClient());
            },
            child: Text(
              'Login Client',
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
    );
  }

  void _handleLogin() {
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

    if (!hasError) {
      EmailVerificationModel record = EmailVerificationModel(
        email: email,
      );

      context
          .read<EmailVerificationBloc>()
          .add(EmailVerificationTambahEvent(record: record));
    }
  }

  void _handleGmailRegister() {
    Navigator.of(context).pop();
  }
}