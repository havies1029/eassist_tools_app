import 'package:flutter/material.dart';
import '../register/register_client/popup_client.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> with TickerProviderStateMixin {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isHovering = false;

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

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
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitReset() {
    setState(() {
      // Reset semua error message
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;
    });

    final oldPwd = _oldPasswordController.text.trim();
    final newPwd = _newPasswordController.text.trim();
    final confirmPwd = _confirmPasswordController.text.trim();

    bool hasError = false;

    // Validasi: Password Lama tidak boleh kosong
    if (oldPwd.isEmpty) {
      setState(() {
        _oldPasswordError = 'Password lama tidak boleh kosong';
      });
      hasError = true;
    }

    // Validasi: Password Baru tidak boleh kosong
    if (newPwd.isEmpty) {
      setState(() {
        _newPasswordError = 'Password baru tidak boleh kosong';
      });
      hasError = true;
    }

    // Validasi: Konfirmasi Password tidak boleh kosong
    if (confirmPwd.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Ketik ulang password baru tidak boleh kosong';
      });
      hasError = true;
    }

    // Jika sebelumnya tidak ada error kosong dan password baru tidak sama
    if (!hasError && newPwd != confirmPwd) {
      setState(() {
        _confirmPasswordError = 'Password baru dan konfirmasi tidak sama';
      });
      hasError = true;
    }

    if (hasError) {
      // Kalau ada error, jangan lanjut ke API
      return;
    }

    // TODO: Panggil fungsi untuk memperbarui password di sini, misalnya:
    // AuthService.updatePassword(oldPwd, newPwd);

    Navigator.of(context).pop(); // Tutup halaman setelah submit berhasil
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return Scaffold(
      backgroundColor: Colors.black54,
      // ←– Wrapping GestureDetector untuk mendeteksi tap di area gelap
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        behavior: HitTestBehavior.opaque, // Pastikan area kosong juga terdeteksi
        child: Center(
          // ←– Tambahkan GestureDetector di sini agar tap di dalam dialog tidak propagasi
          child: GestureDetector(
            onTap: () {
              // Block tap di dalam dialog agar tidak menutup
            },
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
          ),
        ),
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
              'Reset Password',
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
          const SizedBox(height: 15),

          const Text(
            'Masukkan Password kamu!', // sesuaikan teks header-nya
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87, // warna lebih gelap
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Yuk, isi data kamu dan jadi bagian dari klien eksklusif kami.', // sesuaikan teks subheader-nya
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54, // warna sedikit lebih terang
            ),
          ),

          const SizedBox(height: 35),
          // Password Lama
          _buildPasswordField(
            controller: _oldPasswordController,
            hintText: 'Masukkan Password Lama',
            obscureText: !_showOldPassword,
            onToggle: () => setState(() => _showOldPassword = !_showOldPassword),
          ),
          if (_oldPasswordError != null)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _oldPasswordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          const SizedBox(height: 20),

          // Password Baru
          _buildPasswordField(
            controller: _newPasswordController,
            hintText: 'Masukkan Password Baru',
            obscureText: !_showNewPassword,
            onToggle: () => setState(() => _showNewPassword = !_showNewPassword),
          ),
          if (_newPasswordError != null)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _newPasswordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          const SizedBox(height: 20),

          // Konfirmasi Password Baru
          _buildPasswordField(
            controller: _confirmPasswordController,
            hintText: 'Ketik Ulang Password Baru',
            obscureText: !_showConfirmPassword,
            onToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
          ),
          if (_confirmPasswordError != null)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _confirmPasswordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          const SizedBox(height: 40),

          _buildSubmitButton(),
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Container(
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
        keyboardType: TextInputType.visiblePassword,
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
            borderSide: const BorderSide(color: CustomPopupsClient.primaryGreen, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade600,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _isHovering
              ? const Color(0xFF6B9639)
              : CustomPopupsClient.primaryGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovering
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
            onTap: _submitReset,
            child: const Center(
              child: Text(
                'Submit',
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
