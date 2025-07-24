import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/login/change_password_bloc.dart';
import 'package:eassist_tools_app/models/authentication/change_password_model.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with TickerProviderStateMixin {
  // Controllers
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  // Visibility toggle
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  // Hover state untuk tombol
  bool _isHovering = false;

  // Error messages
  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;
  late ChangePasswordBloc _changePasswordBloc;

  // Animasi
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _changePasswordBloc = context.read<ChangePasswordBloc>();
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
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;
    });

    final oldPwd = _oldPasswordController.text.trim();
    final newPwd = _newPasswordController.text.trim();
    final confirmPwd = _confirmPasswordController.text.trim();

    bool hasError = false;

    if (oldPwd.isEmpty) {
      setState(() => _oldPasswordError = 'Password lama tidak boleh kosong');
      hasError = true;
    }
    if (newPwd.isEmpty) {
      setState(() => _newPasswordError = 'Password baru tidak boleh kosong');
      hasError = true;
    }
    if (confirmPwd.isEmpty) {
      setState(() => _confirmPasswordError = 'Ketik ulang password baru tidak boleh kosong');
      hasError = true;
    } else if (!hasError && newPwd != confirmPwd) {
      setState(() => _confirmPasswordError = 'Password baru dan konfirmasi tidak sama');
      hasError = true;
    }

    if (hasError) return;

    final model = ChangePasswordModel(oldPassword: oldPwd, newPassword: newPwd);
    _changePasswordBloc.add(UserChangePasswordEvent(pswd: model));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state.isSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.hasFailure
                    ? "Password lama salah."
                    : "Password berhasil diubah.",
              ),
              backgroundColor: state.hasFailure ? Colors.red : Colors.green,
            ),
          );

          if (!state.hasFailure) Navigator.of(context).pop();

          _oldPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
          isMobile ? Colors.white : Colors.black.withOpacity(0.5),
          body: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: GestureDetector(
                onTap: () {}, // Blok klik luar
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context),
              ),
            ),
          ),
        );
      },
    );
  }


  // -------------------------------------------------
  // HEADER DIALOG
  // -------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF91C050),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
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
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // BODY DIALOG (Ringkas, semua field & button direfer ke metode di bawah)
  // -------------------------------------------------
  Widget _buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 8),
          const Text(
            'Masukkan Password kamu!',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            'Yuk, isi data kamu dan jadi bagian dari klien eksklusif kami.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),

          // Panggilan ke metode‐metode field di bagian terbawah:
          _buildOldPasswordField(),
          const SizedBox(height: 20),
          _buildNewPasswordField(),
          const SizedBox(height: 20),
          _buildConfirmPasswordField(),
          const SizedBox(height: 40),

          _buildSubmitButton(),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // LOGO DI BAGIAN ATAS BODY
  // -------------------------------------------------
  Widget _buildLogo() {
    return SizedBox(
      width: 129,
      height: 55,
      child: ClipRRect(
        child: const Image(
          image: AssetImage('assets/images/JPS.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // =================================================
  // SEMUA WIDGET INPUT FIELD & BUTTON =======================================
  // Letakkan di bagian paling bawah agar lebih mudah dicari & diberikan function
  // =================================================

  // Field untuk "Password Lama" beserta error‐nya
  Widget _buildOldPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPasswordField(
          controller: _oldPasswordController,
          hintText: 'Password Lama',
          obscureText: !_showOldPassword,
          onToggle: () => setState(() => _showOldPassword = !_showOldPassword),
        ),
        if (_oldPasswordError != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              _oldPasswordError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }
  Widget _buildMobileLayout(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: Stack(
          children: [
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              color: const Color(0xFF91C050),
            ),
            SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.08,
                      40,
                      screenWidth * 0.08,
                      32,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: _buildBody(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDesktopLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: dialogWidth,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
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
    );
  }

  // Field untuk "Password Baru" beserta error‐nya
  Widget _buildNewPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPasswordField(
          controller: _newPasswordController,
          hintText: 'Password Baru',
          obscureText: !_showNewPassword,
          onToggle: () => setState(() => _showNewPassword = !_showNewPassword),
        ),
        if (_newPasswordError != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              _newPasswordError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }

  // Field untuk "Konfirmasi Password Baru" beserta error‐nya
  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPasswordField(
          controller: _confirmPasswordController,
          hintText: 'Konfirmasi Passsword',
          obscureText: !_showConfirmPassword,
          onToggle: () =>
              setState(() => _showConfirmPassword = !_showConfirmPassword),
        ),
        if (_confirmPasswordError != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              _confirmPasswordError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }

  // Membuat TextField password dengan toggle visibility
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
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 15,
          ),
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade50,
          constraints: const BoxConstraints(maxHeight: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFF91C050), width: 1.8),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.red, width: 1.8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  // Tombol "Submit"
  Widget _buildSubmitButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: _submitReset,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovering
                ? const Color(0xFF8BB467)
                : const Color(0xFF91C050),
            borderRadius: BorderRadius.circular(5),
            boxShadow: _isHovering
                ? [
              BoxShadow(
                color: const Color(0xFF91C050).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ]
                : [
              BoxShadow(
                color: const Color(0xFF91C050).withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: const Center(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 150),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              child: Text('Submit'),
            ),
          ),
        ),
      ),
    );
  }
}