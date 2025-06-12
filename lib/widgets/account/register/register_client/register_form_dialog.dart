import 'package:eassist_tools_app/widgets/account/register/register_client/popup_client.dart';
import 'register_verification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../repositories/user/user_repository.dart';
import '../../../dialog/Reusable_OTP/reusable_otp_dialog.dart';
// import '../../login/login_gmail/Login_Page.dart';

// Dummy repository (bisa diganti implementasi sungguhan)
class dummyUserRepository extends UserRepository {
  // Override method sesuai kebutuhan
}

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> with TickerProviderStateMixin {
  final _nameController            = TextEditingController();
  final _phoneController           = TextEditingController();
  final _passwordController        = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedChoice      = 'Pilihan';
  bool _isHovering            = false;
  bool _showPassword          = false;
  bool _showConfirmPassword   = false;

  late AnimationController _animationController;
  late Animation<double>   _scaleAnimation;

  // Pesan error per field
  String? _nameError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _dropdownError;

  // Dummy repository
  final _repo = dummyUserRepository();

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
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitRegistration() {
    // 1. Reset semua pesan error
    setState(() {
      _nameError            = null;
      _phoneError           = null;
      _passwordError        = null;
      _confirmPasswordError = null;
      _dropdownError        = null;
    });

    final name            = _nameController.text.trim();
    final phone           = _phoneController.text.trim();
    final password        = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final choice          = _selectedChoice; // 'Pilihan', 'Individual', atau 'Perusahaan'

    bool hasError = false;

    // ===== VALIDASI NAMA LENGKAP =====
    if (name.isEmpty) {
      _nameError = 'Nama Lengkap wajib diisi';
      hasError   = true;
    } else if (name.length < 3) {
      _nameError = 'Nama minimal 3 karakter';
      hasError   = true;
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
      _nameError = 'Nama hanya boleh berisi huruf dan spasi';
      hasError   = true;
    }

    // ===== VALIDASI NO. TELEPON =====
    if (phone.isEmpty) {
      _phoneError = 'No. Telepon wajib diisi';
      hasError    = true;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      _phoneError = 'No. Telepon hanya berupa angka';
      hasError    = true;
    }

    // ===== VALIDASI PASSWORD =====
    if (password.isEmpty) {
      _passwordError = 'Password wajib diisi';
      hasError       = true;
    } else if (password.length < 6) {
      _passwordError = 'Password minimal 6 karakter';
      hasError       = true;
    }

    // ===== VALIDASI KONFIRMASI PASSWORD =====
    if (confirmPassword.isEmpty) {
      _confirmPasswordError = 'Konfirmasi Password wajib diisi';
      hasError             = true;
    } else if (confirmPassword != password) {
      _confirmPasswordError = 'Password dan Konfirmasi tidak cocok';
      hasError             = true;
    }

    // ===== VALIDASI DROPDOWN =====
    if (choice == 'Pilihan') {
      _dropdownError = 'Harap pilih tipe klien';
      hasError       = true;
    }

    if (hasError) {
      // Jika ada error, tampilkan kembali form dengan border merah & pesan
      setState(() {});
      return;
    }

    // 2. Tutup dialog pendaftaran
    Navigator.of(context).pop();

    // Simpan context parent untuk navigasi setelah OTP
    final parentContext = context;

    // 3. Buka LoginDialog (OTP)
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (ctx) {
        return LoginDialog(
          email: phone,               // Menggunakan nomor telepon sebagai placeholder email di OTP dialog
          selectedChoice: choice,     // Kirim pilihan dropdown
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, _) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 400,
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
          const Text(
            'Daftar Klien',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildLogo(),
            const SizedBox(height: 20),

            const Text(
              'Masukkan Nama Lengkap dan No. Telp kamu!', // sesuaikan teks header-nya
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

            // Nama Lengkap
            _buildTextField(
              controller: _nameController,
              hintText: 'Nama Lengkap',
              keyboardType: TextInputType.text,
              errorText: _nameError,
            ),

            const SizedBox(height: 20),

            // No. Telepon
            _buildTextField(
              controller: _phoneController,
              hintText: 'No. Telepon',
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              errorText: _phoneError,
            ),

            const SizedBox(height: 20),

            // Password
            _buildPasswordField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: !_showPassword,
              onToggle: () => setState(() => _showPassword = !_showPassword),
              errorText: _passwordError,
            ),
            const SizedBox(height: 20),

            // Konfirmasi Password
            _buildPasswordField(
              controller: _confirmPasswordController,
              hintText: 'Konfirmasi Password',
              obscureText: !_showConfirmPassword,
              onToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
              errorText: _confirmPasswordError,
            ),
            const SizedBox(height: 20),

            // Dropdown + pesan error
            _buildDropdown(),
            if (_dropdownError != null) ...[
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _dropdownError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ],
            const SizedBox(height: 40),

            // Tombol Daftar
            _buildSubmitButton(),
          ],
        ),
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

  /// TextField biasa dengan dukungan errorText
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? errorText,
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
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : CustomPopupsClient.primaryGreen,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          errorText: errorText,
        ),
      ),
    );
  }

  /// TextField untuk password dengan dukungan errorText
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    String? errorText,
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
            borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : CustomPopupsClient.primaryGreen,
              width: 2,
            ),
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
          errorText: errorText,
        ),
      ),
    );
  }

  /// Dropdown dengan border yang berubah saat error
  Widget _buildDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: _dropdownError != null ? Colors.red : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedChoice,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ['Pilihan', 'Individual', 'Perusahaan']
              .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedChoice = newValue!;
              _dropdownError   = null;
            });
          },
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
          color: _isHovering ? const Color(0xFF6B9639) : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovering
              ? [
            BoxShadow(
              color: CustomPopupsClient.primaryGreen.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _submitRegistration,
            child: const Center(
              child: Text(
                'Daftar',
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
