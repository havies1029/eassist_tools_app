import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';
import 'package:eassist_tools_app/widgets/login/login_gmail/Base_Dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
    if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';

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
  bool _rememberLogin = true;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Dialog(
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
                      _buildMobileBody(state),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, listener: (BuildContext context, LoginState state) {  },
    );
  }

  Widget _buildMobileBody(LoginState state) {
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

          if (state is LoginFailure)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                state.error,
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

        Row(
          children: [
            Expanded(
              child: buildLinkLupaSandi(context),
            ),
            Text(
              '/',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            Expanded(
              child: buildLinkBelumPunyaUser(context),
            ),
          ],
        ),
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
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  Widget buildLinkLupaSandi(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringRegister = true),
            onExit: (_) => setState(() => _isHoveringRegister = false),
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                context
                    .read<AuthenticationBloc>()
                    .add(ForgotPasword(email: _emailController.text.trim()));
              },
              child: Text(
                'Lupa Kata Sandi',
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

  Widget buildLinkBelumPunyaUser(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringRegister = true),
            onExit: (_) => setState(() => _isHoveringRegister = false),
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                context.read<AuthenticationBloc>().add(RequireLoginUser());
              },
              child: Text(
                'no akun?',
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

    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
      email: email,
      password: password,
      rememberMe: _rememberLogin,
    ));
  }

}
