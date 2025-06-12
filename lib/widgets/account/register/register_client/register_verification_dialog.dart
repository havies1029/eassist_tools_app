import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../repositories/user/user_repository.dart';
import 'popup_client.dart';
import '../../profile/profile_perusahaan/profile_main_page.dart';
import '../../../../repositories/user/user_repository.dart';
import '../../profile/profile_individu/profile_individu_main_page.dart';

// Dummy repository (cocokkan dengan yang di RegisterDialog)
class dummyUserRepository extends UserRepository {
  // Override method sesuai kebutuhan
}

class LoginDialog extends StatefulWidget {
  final String email;
  final String title;
  final String selectedChoice;

  const LoginDialog({
    super.key,
    required this.email,
    this.title = 'Verifikasi',
    required this.selectedChoice,
  });

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> with TickerProviderStateMixin {
  static const int _codeLength = 6;

  late final List<TextEditingController> _codeControllers;
  late final List<FocusNode> _focusNodes;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  bool _isButtonHovering = false;

  @override
  void initState() {
    super.initState();
    // Buat controller dan focus node untuk masing-masing kotak OTP
    _codeControllers = List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes      = List.generate(_codeLength, (_) => FocusNode());

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
    for (final c in _codeControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _combinedCode => _codeControllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    // Responsif: jika layar < 450, pakai 90% lebar, else 400px
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, _) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: dialogWidth,
              decoration: BoxDecoration(
                color: Colors.white,
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
                  _buildBody(),
                ],
              ),
            ),
          ),
        );
      },
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
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
          const SizedBox(height: 20),
          Text(
            'Berikut Kode ${widget.title}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kode ini akan digunakan untuk verifikasi Anda dengan aman.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            widget.email.isEmpty ? 'email@example.com' : widget.email,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 25),
          _buildOTPFields(),
          const SizedBox(height: 30),
          _buildVerifyButton(),
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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CustomPopupsClient.primaryGreen,
          ),
          child: const Icon(Icons.lock_outline, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildOTPFields() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_codeLength, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(
                    builder: (_, boxConstraints) {
                      final calculatedFont = boxConstraints.maxWidth * 0.5;
                      final fontSize       = calculatedFont.clamp(18.0, 40.0);

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _codeControllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                              isCollapsed: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < _codeLength - 1) {
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                            onSubmitted: (_) {
                              if (index == _codeLength - 1) {
                                _submitCode();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildVerifyButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isButtonHovering = true),
      onExit: (_) => setState(() => _isButtonHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _isButtonHovering
              ? const Color(0xFF6B9639)
              : CustomPopupsClient.primaryGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: CustomPopupsClient.primaryGreen.withOpacity(_isButtonHovering ? 0.4 : 0.2),
              blurRadius: _isButtonHovering ? 15 : 5,
              offset: Offset(0, _isButtonHovering ? 8 : 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _submitCode,
            child: const Center(
              child: Text(
                'Verifikasi',
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

  void _submitCode() {
    final code = _combinedCode;

    // ===== VALIDASI KODE OTP: 6 digit angka =====
    if (code.length != 6 || !RegExp(r'^[0-9]{6}$').hasMatch(code)) {
      // Tampilkan SnackBar jika invalid, tetap biarkan dialog terbuka
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Kode OTP harus berupa 6 digit angka',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // 1) Tutup LoginDialog (OTP)
    Navigator.of(context).pop();

    // 2) Navigasi ke halaman profil berdasarkan pilihan
    if (widget.selectedChoice == 'Individual') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProfileIndividuMainPage(
            userid: 123,
            userRepository: dummyUserRepository(),
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProfileMainPage(
            userid: 123,
            userRepository: dummyUserRepository(),
          ),
        ),
      );
    }
  }
}
