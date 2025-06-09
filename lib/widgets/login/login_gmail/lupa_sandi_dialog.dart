
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/widgets/login/login_gmail/Base_Dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';



class LupaSandiDialog extends BaseDialog {
  const LupaSandiDialog({super.key});

  @override
  State<LupaSandiDialog> createState() => LupaSandiDialogState();
}

class LupaSandiDialogState extends BaseDialogState<LupaSandiDialog> {
  final _emailController = TextEditingController();

  bool _isHovering = false;
  bool _isHoveringRegister = false;

  String? _emailError;


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            // Konten utama dialog
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        const AssetImage('assets/images/jps_logo.png'),
                  ),
                  const SizedBox(height: 24),
                  _buildMobileBody(),
                ],
              ),
            ),          
          ],
        ),
      ),
    );

  }


  Widget _buildMobileBody() {
    return Column(
      children: [
        buildTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        if (_emailError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _emailError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
        const SizedBox(height: 20),


        buildAnimatedButton(
          text: 'Reset Password',
          isHovering: _isHovering,
          onHover: (hovering) => setState(() => _isHovering = hovering),
          onPressed: () => _handleLogin(),
        ),
        const SizedBox(height: 20),

        _buildDivider(),
        const SizedBox(height: 20),


        _buildRegisterLink(context),
      ],
    );
  }
  

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringRegister = true),
            onExit: (_) => setState(() => _isHoveringRegister = false),
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                context.read<AuthenticationBloc>().add(RequireLoginClient());
              },
              child: Text(
                'Apabila sudah menjadi client : Login Client',
                style: TextStyle(
                  color: _isHoveringRegister
                      ? const Color(0xFF7BA05B)
                      : Colors.blue.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();

    setState(() {
      _emailError = null;
    });

    var hasError = false;
    if (email.isEmpty) {
      setState(() => _emailError = 'Email tidak boleh kosong');
      hasError = true;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => _emailError = 'Format email tidak valid');
      hasError = true;
    }

    if (hasError) return;


    // Simulasi delay sebelum menampilkan OTP
    final success = await Future.delayed(
      const Duration(milliseconds: 300),
      () => true,
    );

    
  }


}


