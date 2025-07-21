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

const List<String> scopes = <String>[
  'email',
];
// Pastikan ini adalah Web Client ID
/*
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
    hostedDomain: '',
    clientId: '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
    serverClientId:
        '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
  );
  */

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
  clientId: kIsWeb ? '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com' : null,
  serverClientId: kIsWeb ? null : '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
);

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: ['email'],
//   // Jangan set clientId di Android, hanya di Web
//   clientId: kIsWeb
//       ? '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com'
//       : null,
// );


class CachedGoogleSigninButton extends StatelessWidget {
  const CachedGoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint('✅ Rendered CachedGoogleSigninButton sekali');
    return googleSigninButton();
  }
}

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

  // TAMBAHKAN DUA BARIS INI:
  bool _isHoveringLoginButton = false;
  bool _isLoginButtonPressed = false;

  String? _emailError;
  late final Widget _cachedGoogleButton;

  @override
  void initState() {
    super.initState();

    // Hanya panggil registerGoogleSigninButton() sekali
    //registerGoogleSigninButton();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {

      debugPrint('User email: ${account?.email}');
      debugPrint('User display name: ${account?.displayName}');
      AppData.googleDisplayName = account?.displayName;
      if (! context.mounted) return;
      // ignore: use_build_context_synchronously
      context.read<EmailVerificationBloc>().add(
        EmailVerificationTambahEvent(
          record: EmailVerificationModel(email: account?.email ?? '', requestFrom: 'google'),
        ),
      );

    });

    // _googleSignIn.signInSilently();

  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return LayoutBuilder(
  //       builder: (context, constraints) {
  //         final isMobile = constraints.maxWidth < 768;
  //
  //         return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
  //           builder: (context, state) {
  //             return Scaffold(
  //               backgroundColor: Colors.black.withOpacity(0.2), // semi-transparent overlay
  //               body: GestureDetector(
  //                 // Tidak menutup dialog saat klik luar
  //                 onTap: () {}, // tetap dibutuhkan untuk memblokir klik tembus
  //                 child: Center(
  //                   child: SingleChildScrollView(
  //                     child: Container(
  //                       margin: EdgeInsets.symmetric(
  //                         horizontal: isMobile ? 20 : 40,
  //                         vertical: 40,
  //                       ),
  //                       child: Material(
  //                         color: Colors.transparent,
  //                         child: Container(
  //                           width: isMobile ? double.infinity : null,
  //                           constraints: BoxConstraints(
  //                             maxWidth: isMobile
  //                                 ? MediaQuery.of(context).size.width - 40
  //                                 : 450,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(20),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black.withOpacity(0.1),
  //                                 blurRadius: 10,
  //                                 spreadRadius: 2,
  //                               ),
  //                             ],
  //                           ),
  //                           child: Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               // Header hijau TANPA tombol X
  //                               Container(
  //                                 decoration: const BoxDecoration(
  //                                   color: Color(0xFF91C050),
  //                                   borderRadius: BorderRadius.only(
  //                                     topLeft: Radius.circular(20),
  //                                     topRight: Radius.circular(20),
  //                                   ),
  //                                 ),
  //                                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //                                 child: Row(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   children: const [
  //                                     Text(
  //                                       'Login',
  //                                       style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w600,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //
  //                               // Body putih
  //                               Container(
  //                                 decoration: const BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.only(
  //                                     bottomLeft: Radius.circular(20),
  //                                     bottomRight: Radius.circular(20),
  //                                   ),
  //                                 ),
  //                                 padding: const EdgeInsets.all(32),
  //                                 child: Column(
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: [
  //                                     const CircleAvatar(
  //                                       radius: 40,
  //                                       backgroundColor: Colors.white,
  //                                       backgroundImage: AssetImage('assets/images/jps_logo.png'),
  //                                     ),
  //                                     const SizedBox(height: 24),
  //                                     const Text(
  //                                       'Masukkan Email',
  //                                       style: TextStyle(
  //                                         fontSize: 18,
  //                                         fontWeight: FontWeight.w600,
  //                                         color: Colors.black87,
  //                                       ),
  //                                     ),
  //                                     const SizedBox(height: 8),
  //                                     Text(
  //                                       'Yuk, login dulu biar bisa akses semuanya!',
  //                                       style: TextStyle(
  //                                         fontSize: 14,
  //                                         color: Colors.grey.shade600,
  //                                       ),
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                     const SizedBox(height: 32),
  //
  //                                     // FORM login
  //                                     _buildLoginForm(context, isMobile),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           listener: (context, state) {
  //             if (state.isLoaded) {
  //               // tambahkan aksi jika perlu ketika sukses verifikasi
  //             }
  //           },
  //         );
  //       },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final authState = context.watch<AuthenticationBloc>().state;
        final isLoggedIn = authState is AuthenticationAuthenticated;

        return WillPopScope(
          onWillPop: () async => isLoggedIn,
          child: BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: (isLoggedIn && !isMobile) ? () => Navigator.of(context).pop() : null,
                child: Scaffold(
                  backgroundColor: isMobile ? Colors.white : Colors.black.withOpacity(0.5),
                  body: GestureDetector(
                    onTap: () {},
                    child: isMobile ? _buildMobileLayout(context, isLoggedIn) : _buildDesktopLayout(context, isLoggedIn),
                  ),
                ),
              );
            },
            listener: (context, state) async {
              if (state.isLoaded && context.mounted) {
                Navigator.of(context).pop(); // ✅ Menutup dialog login

                final authState = context.read<AuthenticationBloc>().state;
                if (authState is! AuthenticationAuthenticated) {
                  context.read<AuthenticationBloc>().add(AppStarted());
                }

                await Future.delayed(const Duration(milliseconds: 100));
              }
            },
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
                            'Masuk Sebagai Pengguna',
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
                                  'Masukkan Email dan Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  'Yuk, login dulu biar bisa akses semuanya!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 32),

                                _buildLoginForm(context, true),
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
                                borderRadius: BorderRadius.circular(5),
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
                          'Masuk Sebagai Pengguna',
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
                      borderRadius: BorderRadius.all(Radius.circular(24)),
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

                        // Reduced spacing since logo is moved up
                        const SizedBox(height: 8),

                        const Text(
                          'Masukkan Email dan Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Yuk, login dulu biar bisa akses semuanya!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        _buildLoginForm(context, false),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isMobile) {

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
            constraints: BoxConstraints(maxHeight: 40),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

        // Tombol Masuk
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHoveringLoginButton = true),
          onExit: (_) => setState(() => _isHoveringLoginButton = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isLoginButtonPressed = true),
            onTapUp: (_) => setState(() => _isLoginButtonPressed = false),
            onTapCancel: () => setState(() => _isLoginButtonPressed = false),
            onTap: () => _handleLogin(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: _isLoginButtonPressed
                    ? const Color(0xFF6B8F4B)
                    : _isHoveringLoginButton
                    ? const Color(0xFF8BB467)
                    : const Color(0xFF91C050),
                borderRadius: BorderRadius.circular(5),
                boxShadow: _isLoginButtonPressed
                    ? [
                  BoxShadow(
                    color: const Color(0xFF91C050).withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : [
                  BoxShadow(
                    color: const Color(0xFF91C050).withOpacity(0.3),
                    blurRadius: _isHoveringLoginButton ? 12 : 8,
                    offset: Offset(0, _isHoveringLoginButton ? 6 : 4),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _isLoginButtonPressed ? 14.5 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                  child: const Text('Masuk'),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Divider "Atau"
        Row(
          children: [
            Expanded(child: Container(height: 1, color: Color(0xFF91C050))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Atau',
                style: TextStyle(
                  color: Color(0xFF91C050),
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: Color(0xFF91C050))),
          ],
        ),

        const SizedBox(height: 10),

        // Tombol Google
        AppData.kIsWeb
            ? const CachedGoogleSigninButton()
            : _buildIconButton(
          text: 'Daftar Menggunakan Gmail',
          iconPath: 'assets/icons/google-icon.svg',
          isHovering: _isHoveringGmail,
          onHover: (hovering) =>
              setState(() => _isHoveringGmail = hovering),
          onPressed: () => _handleGmailRegisterForMobile(context),
        ),


        const SizedBox(height: 15),
        _buildLoginOptions(context),
        const SizedBox(height: 5),
        _buildRegisterLink(context),
      ],
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

                      context.read<EmailVerificationBloc>().add(
                          FieldSimpanPasswordChangedEvent(
                              isSimpanPassword: _rememberLogin));
                    });
                  },
                  activeColor: const Color(0xFF91C050),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 12),
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
          height: 40,
          decoration: BoxDecoration(
            color: isHovering ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isHovering ? Colors.grey.shade400 : Colors.grey.shade300,
              width: 1,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFF91C050),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
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

  Widget _buildRegisterLink(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Text(
                  'Sudah menjadi klien? ',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringRegister = true),
                  onExit: (_) => setState(() => _isHoveringRegister = false),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      context.read<AuthenticationBloc>().add(
                        RequireLoginClient(
                            requiredFrom: "login_user", errorMsg: ""),
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
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    String? error;
    if (email.isEmpty) {
      error = 'Email tidak boleh kosong';
    } else if (!emailRegex.hasMatch(email)) {
      error = 'Format email tidak valid';
    }

    if (error != null) {
      setState(() => _emailError = error);
      return;
    }

    setState(() => _emailError = null); // Bersihkan error jika valid
    AppData.lastLoginEmail = email;
    final record = EmailVerificationModel(
      email: email,
      requestFrom: 'email',
    );

    context
        .read<EmailVerificationBloc>()
        .add(EmailVerificationTambahEvent(record: record));
  }

  void _handleGmailRegisterForMobile(BuildContext context) async {
    try {
      GoogleSignInAccount? user;

      if (kIsWeb) {
        user = await _googleSignIn.signIn();
      } else {
        user = await _googleSignIn.signInSilently();
        user ??= await _googleSignIn.signIn();
      }

      debugPrint('[GMAIL] Google Sign-In result: ${user?.email}');

      if (user != null && context.mounted) {
        // 🔒 Simpan email seperti login manual
        AppData.lastLoginEmail = user.email;
        AppData.googleDisplayName = user.displayName;
        // ⛳ Kirim ke EmailVerificationBloc
        context.read<EmailVerificationBloc>().add(
          EmailVerificationTambahEvent(
            record: EmailVerificationModel(
              email: user.email,
              requestFrom: 'google',
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('[GMAIL] ERROR: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Google gagal: $e')),
        );
      }
    }
  }
}