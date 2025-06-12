import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../../../pages/hero_user_page/hero_user_main.dart';
import '../../../pages/hero_client_page/hero_user_main.dart';
import '../../../pages/profile/profile_main_page.dart';
import '../../account/profile/profile_individu/profile_individu_main_page.dart';
import '../../account/register/register_client/popup_client.dart';
import '../../account/register/register_client/register_form_dialog.dart';
// import '../../account/register/register_client/register_form_dialog.dart';

class ReusableOTPDialog extends StatefulWidget {
  final String email;
  final String title;
  /// Callback yang akan dipanggil saat verifikasi OTP
  final Future<void> Function(String code)? onSubmit;
  /// Callback untuk kirim ulang OTP (opsional)
  final Future<void> Function()? onResend;
  /// Pilihan dropdown yang dikirimkan dari register_form_dialog (opsional)
  final String? selectedChoice;

  const ReusableOTPDialog({
    super.key,
    required this.email,
    this.title = 'Verifikasi Kode',
    this.onSubmit,
    this.onResend,
    this.selectedChoice,
  });

  @override
  State<ReusableOTPDialog> createState() => _ReusableOTPDialogState();
}

class _ReusableOTPDialogState extends State<ReusableOTPDialog>
    with TickerProviderStateMixin {
  // ─────────────────────────────────────────────────────────────────────────────
  // 1) STATE / CONTROLLERS / FOCUS NODES
  // ─────────────────────────────────────────────────────────────────────────────

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  bool isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Timer "Kirim Ulang"
  Timer? _timer;
  int _secondsLeft = 60;
  bool _isResendEnabled = false;

  // ─────────────────────────────────────────────────────────────────────────────
  // 2) ANIMATIONS
  // ─────────────────────────────────────────────────────────────────────────────

  // Animasi scale saat dialog muncul
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  // Animasi shake saat error
  late final AnimationController _shakeController;
  late final Animation<Offset> _shakeAnimation;

  // ─────────────────────────────────────────────────────────────────────────────
  // 3) LIFECYCLE: initState() & dispose()
  // ─────────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    // Inisialisasi 6 kotak OTP
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    // Animasi scale (dialog masuk)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();

    // Animasi shake untuk row OTP
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.03, 0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    // Mulai timer untuk "Kirim Ulang"
    _startTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shakeController.dispose();

    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }

    _cancelTimer();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 4) TIMER HANDLERS
  // ─────────────────────────────────────────────────────────────────────────────

  void _startTimer() {
    _secondsLeft = 60;
    _isResendEnabled = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        setState(() {
          _isResendEnabled = true;
        });
        _cancelTimer();
      } else {
        setState(() {
          _secondsLeft -= 1;
        });
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 5) LOGIC HANDLERS: Verifikasi & Resend
  // ─────────────────────────────────────────────────────────────────────────────

  /// Handler untuk tombol "Kirim Ulang Kode OTP"
  Future<void> _handleResend() async {
    if (!_isResendEnabled) return;
    setState(() {
      _hasError = false;
      _errorMessage = '';
      isLoading = true;
      _isResendEnabled = false;
      _secondsLeft = 60;
    });

    try {
      if (widget.onResend != null) {
        await widget.onResend!();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fitur kirim ulang belum tersedia.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Gagal mengirim ulang: $e';
        });
        _shakeController.forward(from: 0);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _startTimer();
      }
    }
  }

  /// Handler untuk tombol "Verifikasi"
  Future<void> _submitCode() async {
    FocusScope.of(context).unfocus();
    final code = _controllers.map((c) => c.text).join();

    // Validasi panjang kode
    if (code.length < 6) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Kode OTP harus 6 digit';
      });
      _shakeController.forward(from: 0);
      return;
    }

    setState(() {
      _hasError = false;
      _errorMessage = '';
      isLoading = true;
    });

    try {
      // Panggil callback onSubmit jika disediakan
      if (widget.onSubmit != null) {
        await widget.onSubmit!(code);
      }
      // Jika verifikasi berhasil:
      if (!mounted) return;

      // 1) Tutup dialog
      Navigator.of(context).pop();

      // 2) Navigasi sesuai selectedChoice (jika ada), atau ke HeroUserMain
      if (widget.selectedChoice != null) {
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
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HeroUserMain()),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Verifikasi gagal: ${e.toString()}';
        });
        _shakeController.forward(from: 0);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 6) WIDGET BUILDERS: Semua fungsi build terpisah di bawah
  // ─────────────────────────────────────────────────────────────────────────────

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
          children: List.generate(6, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AspectRatio(
                  aspectRatio: 1, // Kotak selalu persegi
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) {
                      final fontSize = boxConstraints.maxWidth * 0.5;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade50,
                          border: Border.all(
                            color: _hasError
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                              // Tangani paste >1 digit
                              if (value.length > 1) {
                                final chars = value.split('');
                                for (int j = 0;
                                j < chars.length && (index + j) < 6;
                                j++) {
                                  _controllers[index + j].text = chars[j];
                                }
                                final next = index + value.length;
                                if (next < 6) {
                                  _focusNodes[next].requestFocus();
                                } else {
                                  _focusNodes[5].unfocus();
                                }
                                return;
                              }
                              // Pindah fokus jika ada karakter
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              }
                              // Pindah fokus jika dihapus
                              else if (value.isEmpty && index > 0) {
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

  Widget _buildResendSection() {
    if (_isResendEnabled) {
      return TextButton(
        onPressed: isLoading ? null : _handleResend,
        child: const Text(
          'Kirim Ulang Kode OTP',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      );
    } else {
      final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
      final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
      return Text(
        'Kirim ulang dalam $minutes:$seconds',
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      );
    }
  }

  Widget _buildVerifyButton() {
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
          const SizedBox(height: 25),
          const Text(
            'Masukkan Kode OTP Anda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Kami telah mengirim kode ke email Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            widget.email.isEmpty ? 'email@example.com' : widget.email,
            style: const TextStyle(fontSize: 14, color: Colors.blue),
          ),
          const SizedBox(height: 25),
          // Row OTP dengan animasi shake
          SlideTransition(
            position: _shakeAnimation,
            child: _buildOTPFields(),
          ),
          if (_hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          const SizedBox(height: 20),
          _buildResendSection(),
          const SizedBox(height: 20),
          _buildVerifyButton(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 7) BUILD METHOD
  // ─────────────────────────────────────────────────────────────────────────────

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
}
