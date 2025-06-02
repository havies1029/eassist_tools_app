import 'package:flutter/material.dart';
import '../../../pages/hero_user_page/hero_user_main.dart';
import '../../register/register_client/popup_client.dart';
import '../hero_user/hero_user_main.dart'; // Pastikan path ini sesuai dengan lokasi HeroUserPage/HeroUserMain Anda

class LoginClientPage extends StatefulWidget {
  const LoginClientPage({Key? key}) : super(key: key);

  @override
  _LoginClientPageState createState() => _LoginClientPageState();
}

class _LoginClientPageState extends State<LoginClientPage>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailErrorText;
  String? _passwordErrorText;

  bool _isHoveringButton = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Reset error messages
    setState(() {
      _emailErrorText = null;
      _passwordErrorText = null;
    });

    bool hasError = false;

    if (email.isEmpty) {
      setState(() {
        _emailErrorText = 'Email tidak boleh kosong';
      });
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordErrorText = 'Password tidak boleh kosong';
      });
      hasError = true;
    }

    if (hasError) {
      // Jika ada error, jangan lanjut
      return;
    }

    // Jika validasi sukses, tutup dialog lalu navigasi ke HeroUserPage
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HeroUserMain()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(32),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: dialogWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  _buildBody(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: CustomPopupsClient.primaryGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              'Login Klien',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
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
          const SizedBox(height: 30),
          _buildTextField(
            controller: _emailController,
            hintText: 'Masukkan Email',
            keyboardType: TextInputType.emailAddress,
            errorText: _emailErrorText,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            hintText: 'Masukkan Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            errorText: _passwordErrorText,
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
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
      onEnter: (_) => setState(() => _isHoveringButton = true),
      onExit: (_) => setState(() => _isHoveringButton = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _isHoveringButton
              ? const Color(0xFF6B9639)
              : CustomPopupsClient.primaryGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHoveringButton
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
            onTap: _submitLogin,
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
