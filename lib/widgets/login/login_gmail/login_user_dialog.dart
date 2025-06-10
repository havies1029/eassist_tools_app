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
    return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      AppData.kIsWeb
                          ? _cachedGoogleButton
                          : _buildMobileBody(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, EmailVerificationState state) {
        if (state.isLoaded){

          /*
          if (context.read<AuthenticationBloc>().state is AuthenticationRequirePinEmailVerification) {            
            Navigator.of(context).pop();
          }
          */


          //Navigator.of(context).pop();
        }
      },
    );
  }

  Widget _buildMobileBody(BuildContext context) {
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
        buildAnimatedButton(
          text: 'Masuk',
          isHovering: _isHovering,
          onHover: (hovering) => setState(() => _isHovering = hovering),
          onPressed: () => _handleLogin(),
        ),
        const SizedBox(height: 20),
        _buildDivider(),
        const SizedBox(height: 20),
        _buildDivider(),
        const SizedBox(height: 20),
        _buildIconButton(
          text: 'Daftar Menggunakan Gmail',
          iconPath: 'assets/icons/google-icon.svg',
          isHovering: _isHoveringGmail,
          onHover: (hovering) => setState(() => _isHoveringGmail = hovering),
          onPressed: () => _handleGmailRegister(),
        ),
        const SizedBox(height: 20),
        _buildLoginOptions(context),
        const SizedBox(height: 20),
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

  Widget _buildRegisterLink(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
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
                //await CustomPopupsLoginUser.showRegisterUserDialog(context);

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
      ),
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
