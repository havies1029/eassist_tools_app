import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterUserDialog extends BaseDialog {
  const RegisterUserDialog({super.key});

  @override
  State<RegisterUserDialog> createState() => _RegisterUserDialogState();
}

class _RegisterUserDialogState extends BaseDialogState<RegisterUserDialog> {
  final _emailController = TextEditingController();
  bool _isHovering = false;
  bool _isHoveringGmail = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: buildDialogContainer(
        title: 'Register User',
        body: Column(
          children: [
            buildLogo(),
            const SizedBox(height: 30),

            // Input Email
            buildTextField(
              controller: _emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Tombol Daftar
            buildAnimatedButton(
              text: 'Daftar',
              isHovering: _isHovering,
              onHover: (hovering) => setState(() => _isHovering = hovering),
              backgroundColor: const Color(0xFF6B9639),
              onPressed: () => _handleRegister(context, _emailController.text),
            ),

            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 20),

            _buildIconButton(
              text: 'Daftar via Gmail',
              iconPath: 'assets/icons/google-icon.svg',
              isHovering: _isHoveringGmail,
              onHover: (hovering) => setState(() => _isHoveringGmail = hovering),
              onPressed: () => _handleGmailRegister(),
            ),

            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 20),

            _buildLoginLink(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  // Fungsi yang akan disambungkan ke API
  void _handleRegister(BuildContext context, String email) {
    EmailVerificationModel emailVerificationModel = EmailVerificationModel(
      email: email,
    );
    context.read<EmailVerificationBloc>().add(EmailVerificationTambahEvent(record: emailVerificationModel));
    Navigator.of(context).pop();
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

  void _handleGmailRegister() {
    Navigator.of(context).pop();
    /*
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
    */
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
            'Login as ? ',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),

          TextButton(
            onPressed: () {
              // Aksi ketika diklik, misalnya buka halaman baru
              debugPrint("Link diklik");
            },
            child: Text(
              'User',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              // Aksi ketika diklik, misalnya buka halaman baru
              debugPrint("Link diklik");
            },
            child: Text(
              'Member',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

        ],
      ),
    );
  }



}