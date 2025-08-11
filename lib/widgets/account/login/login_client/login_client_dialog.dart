import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';

import '../../../../blocs/local_prefs/auth_local_cubit.dart';
import '../../../../main.dart' as HeroMainState;
import '../../../../pages/hero_client_page/hero_user_main.dart';
import '../login_gmail/popup_dialog_login.dart';

class LoginClientDialog extends BaseDialog {
  const LoginClientDialog({super.key});

  @override
  State<LoginClientDialog> createState() => LoginClientDialogState();
}

class LoginClientDialogState extends BaseDialogState<LoginClientDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isHovering = false;
  bool _isHoveringRegister = false;
  bool _isHoveringForgotPassword = false;
  bool _rememberLogin = true;
  bool _obscurePassword = true;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();

    final authLocal = context.read<AuthLocalCubit>().state;

    debugPrint('🟡 initState LoginClientDialog');
    debugPrint('↪️ isRedirectedFromLoginUser = ${HeroMainState.isRedirectedFromLoginUser}');
    debugPrint('📧 lastLoginEmail = ${authLocal.lastLoginEmail}');

    if (HeroMainState.isRedirectedFromLoginUser) {
      // 🔥 Isi field email hanya saat redirect
      final email = authLocal.lastLoginEmail?.trim();
      if (email != null && email.isNotEmpty) {
        _emailController.text = email;
        debugPrint('✅ Email diisi otomatis: $email');
      }

      // 🧹 Reset flag agar tidak bocor ke sesi berikutnya
      HeroMainState.isRedirectedFromLoginUser = false;
      debugPrint('🧹 isRedirectedFromLoginUser di-reset ke false');
    } else {
      // 🚫 Bukan dari redirect, kosongkan saja
      _emailController.text = '';
      debugPrint('🚫 Email tidak diisi otomatis');
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    context.read<AuthLocalCubit>().clearLastLoginEmail(); // GANTI INI

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoggedIn = context.select<AuthenticationBloc, bool>((state) {
          return state is AuthenticationAuthenticated || state is AuthenticationRequireLoginClient;
        });

        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;

            return WillPopScope(
              onWillPop: () async => isLoggedIn,
              child: GestureDetector(
                onTap: (isLoggedIn && !isMobile) ? () => Navigator.of(context).pop() : null,
                child: Scaffold(
                  backgroundColor: isMobile ? Colors.white : Colors.black.withOpacity(0.5),
                  body: GestureDetector(
                    onTap: () {},
                    child: isMobile ? _buildMobileLayout(context, isLoggedIn, state) : _buildDesktopLayout(context, isLoggedIn, state),
                  ),
                ),
              ),
            );
          },
        );
      },
      listener: (context, state) async {
        if (state is LoginPostAuthenticate) {
          Navigator.of(context).pop();
          final authState = context.read<AuthenticationBloc>().state;
          if (authState is! AuthenticationAuthenticated) {
            context.read<AuthenticationBloc>().add(AppStarted());
          }

          await Future.delayed(const Duration(milliseconds: 100));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HeroUserMain()),
          );
        }
      },
    );
  }

// 📱 Mobile Layout - Fullscreen dengan desain yang sama
  Widget _buildMobileLayout(BuildContext context, bool isLoggedIn, LoginState state) {
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
                            'Masuk Sebagai Klien',
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
                                  'Selamat Datang Kembali, Klien JPS!',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  'Silakan login menggunakan akun klien yang sudah terdaftar.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 32),

                                _buildLoginForm(context, true, state),
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
  Widget _buildDesktopLayout(BuildContext context, bool isLoggedIn, LoginState state) {
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
                          'Masuk Sebagai Klien',
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
                          'Selamat Datang Kembali, Klien JPS!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Silakan login menggunakan akun klien yang sudah terdaftar',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        _buildLoginForm(context, false, state),
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

  Widget _buildLoginForm(BuildContext context, bool isMobile, LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email TextField
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          scrollPadding: EdgeInsets.zero,
          textAlign: TextAlign.left,
          cursorColor: const Color(0xFF91C050),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15,
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.grey.shade50,
            constraints: const BoxConstraints(
              minHeight: 40, maxHeight: 40,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xFF91C050), width: 1.8),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red, width: 1.8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // disesuaikan agar pas dengan tinggi
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

        // Password TextField
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          maxLines: 1,
          scrollPadding: EdgeInsets.zero,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15,
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.grey.shade50,
            constraints: const BoxConstraints(
              minHeight: 40,
              maxHeight: 40,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xFF91C050), width: 1.8),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red, width: 1.8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade500,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),

        if (_passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              _passwordError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

        // Error dari state Bloc
        if (state is LoginFailure)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

        const SizedBox(height: 10),

        // Tombol Masuk
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              context.read<AuthLocalCubit>().clearLastLoginEmail(); // ⬅️ tambah ini
              _handleLogin(); // ⬅️ panggil logika login
            },
            splashColor: const Color(0xFF91C050).withOpacity(0.3), // warna gelombang
            highlightColor: Colors.transparent, // hilangkan highlight solid
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
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
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),
        _buildLoginOptions(context),
        const SizedBox(height: 5),

        // Hyperlink: Lupa sandi dan Belum punya user
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            if (isMobile) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLinkBelumPunyaUser(context),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: buildLinkBelumPunyaUser(context),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildLoginOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Kiri: Checkbox + label (expand ke kiri)
        Expanded(
          child: GestureDetector(
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
                    activeColor: const Color(0xFF91C050),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Simpan Login',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Kanan: Link lupa sandi (expand ke kanan dan align kanan)
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: buildLinkLupaSandi(context),
          ),
        ),
      ],
    );
  }

  Widget buildLinkLupaSandi(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringForgotPassword  = true),
            onExit: (_) => setState(() => _isHoveringForgotPassword  = false),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                context.read<AuthenticationBloc>().add(
                  ForgotPasword(email: _emailController.text.trim()),
                );
              },
              child: Text(
                'Lupa Kata Sandi',
                style: TextStyle(
                  color: _isHoveringForgotPassword  ? const Color(0xFF91C050) : Colors.blue.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Versi yang lebih sederhana menggunakan MediaQuery
  Widget buildLinkBelumPunyaUser(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Gunakan breakpoint sederhana - jika lebar kurang dari 280px, gunakan layout vertikal
          final shouldWrap = constraints.maxWidth < 280;

          if (shouldWrap) {
            // Layout vertikal (atas-bawah)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Belum menjadi klien?',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringRegister = true),
                  onExit: (_) => setState(() => _isHoveringRegister = false),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      context.read<AuthenticationBloc>().add(RequireLoginUser());
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      //   if (!context.mounted) return;
                      //   CustomPopupsLoginUser.showLoginClientDialog(context);
                      // });
                    },
                    child: Text(
                      'Masuk Sebagai Pengguna',
                      style: TextStyle(
                        color: _isHoveringRegister ? const Color(0xFF91C050) : Colors.blue.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Layout horizontal (samping)
            return Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Belum menjadi klien? ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHoveringRegister = true),
                    onExit: (_) => setState(() => _isHoveringRegister = false),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<AuthenticationBloc>().add(RequireLoginUser());
                      },
                      child: Flexible(
                        child: Text(
                          'Masuk Sebagai Pengguna',
                          style: TextStyle(
                            color: _isHoveringRegister ? const Color(0xFF91C050) : Colors.blue.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final authLocalCubit = context.read<AuthLocalCubit>();
    // authLocalCubit.clearLastLoginEmail();
    // authLocalCubit.clearGoogleDisplayName();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool hasError = false;

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

    // debugPrint(
    //   '🔵 Tombol Masuk ditekan dengan email="$email" dan password(tersimpan)"',
    // );
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
      email: email,
      password: password,
      rememberMe: _rememberLogin,
    ));
  }
}