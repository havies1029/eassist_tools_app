import 'dart:math'; // untuk fungsi min()
import 'package:flutter/material.dart';
import '../../../pages/hero_user_page/hero_user_main.dart';
import '../../register/register_client/popup_client.dart';
import 'package:flutter/services.dart';

class ReusableOTPDialog extends StatefulWidget {
  final String email;
  final String title;
  final Future<void> Function(String code)? onSubmit;

  const ReusableOTPDialog({
    super.key,
    required this.email,
    this.title = 'Verifikasi Kode',
    this.onSubmit,
  });

  @override
  State<ReusableOTPDialog> createState() => _ReusableOTPDialogState();
}

class _ReusableOTPDialogState extends State<ReusableOTPDialog>
    with TickerProviderStateMixin {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  Future<void> _submitCode() async {
    FocusScope.of(context).unfocus();
    final code = _controllers.map((c) => c.text).join();

    if (code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode OTP belum lengkap!')),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      await widget.onSubmit?.call(code);
      if (!mounted) return;
      // Tutup dialog
      Navigator.of(context).pop();
      // Setelah dialog tertutup, langsung pindah ke HeroUserMain()
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const HeroUserMain()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verifikasi gagal: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Dialog(
            backgroundColor: Colors.transparent,
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
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: CustomPopupsClient.primaryGreen,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
              child: const Icon(Icons.close, size: 20, color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
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
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 30),
          const Text(
            'Masukkan Kode OTP Anda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Kode ini akan digunakan untuk verifikasi Anda dengan aman.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            widget.email.isEmpty ? 'email@example.com' : widget.email,
            style: const TextStyle(fontSize: 14, color: Colors.blue),
          ),
          const SizedBox(height: 30),
          _buildOTPFields(),
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
        // Baris utama: 6 kotak yang dibagi rata.
        return Row(
          children: List.generate(6, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AspectRatio(
                  aspectRatio: 1, // Kotak selalu persegi
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) {
                      // Hitung fontSize berdasarkan lebar kotak
                      final fontSize = boxConstraints.maxWidth * 0.5;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          // TextField dibungkus Center untuk memastikan vertikal ter‐center
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: fontSize.clamp(18.0, 40.0),
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                              isCollapsed: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                            onSubmitted: (_) {
                              if (index == 5) _submitCode();
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

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: isLoading ? null : _submitCode,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isLoading ? Colors.grey : CustomPopupsClient.primaryGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(121, 171, 67, 0.3),
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
              : const Text(
            'Verifikasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
