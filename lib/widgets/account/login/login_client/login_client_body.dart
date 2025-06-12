import 'package:flutter/material.dart';
import '../../register/register_client/popup_client.dart';

class LoginClientBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? emailErrorText;
  final String? passwordErrorText;
  final VoidCallback onSubmit;
  final bool isHoveringButton;
  final VoidCallback onEnterHover;
  final VoidCallback onExitHover;

  const LoginClientBody({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.emailErrorText,
    required this.passwordErrorText,
    required this.onSubmit,
    required this.isHoveringButton,
    required this.onEnterHover,
    required this.onExitHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 15),
          const Text(
            'Masukkan alamat Gmail dan Password kamu!',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Yuk, isi data kamu dan jadi bagian dari klien eksklusif kami.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 35),
          _buildTextField(
            controller: emailController,
            hintText: 'Masukkan Email',
            keyboardType: TextInputType.emailAddress,
            errorText: emailErrorText,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: passwordController,
            hintText: 'Masukkan Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            errorText: passwordErrorText,
          ),
          const SizedBox(height: 40),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/jps_logo.png',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    bool obscureText = false,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
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
                borderSide: const BorderSide(
                    color: CustomPopupsClient.primaryGreen, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 5),
          Text(
            errorText,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildLoginButton() {
    return MouseRegion(
      onEnter: (_) => onEnterHover(),
      onExit: (_) => onExitHover(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isHoveringButton
              ? const Color(0xFF6B9639)
              : CustomPopupsClient.primaryGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isHoveringButton
              ? [
            BoxShadow(
              color: CustomPopupsClient.primaryGreen.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ]
              : [
            BoxShadow(
              color: CustomPopupsClient.primaryGreen.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onSubmit,
            child: const Center(
              child: Text(
                'Masuk',
                style: TextStyle(
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
}
