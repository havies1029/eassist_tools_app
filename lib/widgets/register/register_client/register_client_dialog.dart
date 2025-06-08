import 'package:eassist_tools_app/widgets/register/register_client/popup_client.dart';
import 'package:flutter/material.dart';
import '../../../repositories/user/user_repository.dart';
import '../../dialog/Reusable_OTP/reusable_otp_dialog.dart';
import 'register_client_body.dart';

class dummyUserRepository extends UserRepository {
  // Override method sesuai kebutuhan
}

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedChoice = 'Pilihan';
  bool _isHovering = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  String? _nameError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _dropdownError;

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
    setState(() {
      _nameError = null;
      _phoneError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _dropdownError = null;
    });

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final choice = _selectedChoice;

    bool hasError = false;

    if (name.isEmpty) {
      _nameError = 'Nama Lengkap wajib diisi';
      hasError = true;
    } else if (name.length < 3) {
      _nameError = 'Nama minimal 3 karakter';
      hasError = true;
    } else if (!RegExp(r"^[a-zA-Z\s]+\$").hasMatch(name)) {
      _nameError = 'Nama hanya boleh berisi huruf dan spasi';
      hasError = true;
    }

    if (phone.isEmpty) {
      _phoneError = 'No. Telepon wajib diisi';
      hasError = true;
    } else if (!RegExp(r'^[0-9]+\$').hasMatch(phone)) {
      _phoneError = 'No. Telepon hanya berupa angka';
      hasError = true;
    }

    if (password.isEmpty) {
      _passwordError = 'Password wajib diisi';
      hasError = true;
    } else if (password.length < 6) {
      _passwordError = 'Password minimal 6 karakter';
      hasError = true;
    }

    if (confirmPassword.isEmpty) {
      _confirmPasswordError = 'Konfirmasi Password wajib diisi';
      hasError = true;
    } else if (confirmPassword != password) {
      _confirmPasswordError = 'Password dan Konfirmasi tidak cocok';
      hasError = true;
    }

    if (choice == 'Pilihan') {
      _dropdownError = 'Harap pilih tipe klien';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    Navigator.of(context).pop();

    final parentContext = context;

    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (ctx) {
        return ReusableOTPDialog(
          email: phone,
          selectedChoice: choice,
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
              'Masukkan Nama Lengkap dan No. Telp kamu!',
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
            RegisterFormBody(
              nameController: _nameController,
              phoneController: _phoneController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              selectedChoice: _selectedChoice,
              showPassword: _showPassword,
              showConfirmPassword: _showConfirmPassword,
              nameError: _nameError,
              phoneError: _phoneError,
              passwordError: _passwordError,
              confirmPasswordError: _confirmPasswordError,
              dropdownError: _dropdownError,
              onTogglePassword: () => setState(() => _showPassword = !_showPassword),
              onToggleConfirmPassword: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
              onDropdownChanged: (String? value) {
                setState(() {
                  _selectedChoice = value!;
                  _dropdownError = null;
                });
              },
            ),
            const SizedBox(height: 40),
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
