import 'package:flutter/material.dart';
import '../../../pages/hero_client_page/hero_user_main.dart';
import '../../register/register_client/popup_client.dart';
import 'login_client_body.dart';

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

    if (hasError) return;

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
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
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
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: LoginClientBody(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        emailErrorText: _emailErrorText,
                        passwordErrorText: _passwordErrorText,
                        onSubmit: _submitLogin,
                        isHoveringButton: _isHoveringButton,
                        onEnterHover: () => setState(() => _isHoveringButton = true),
                        onExitHover: () => setState(() => _isHoveringButton = false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
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
}
