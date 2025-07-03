// OTP Login Dialog
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpEmailDialog extends BaseDialog {
  final String email;

  const OtpEmailDialog({super.key, required this.email});

  @override
  State<OtpEmailDialog> createState() => OtpEmailDialogState();
}

class OtpEmailDialogState extends BaseDialogState<OtpEmailDialog> {
  final List<TextEditingController> _codeControllers =
  List.generate(6, (index) => TextEditingController()); // Changed to 6
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode()); // Changed to 6
  bool _isHovering = false;

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
      builder: (context, state) {
        return buildDialogContainer(
          title: 'Login',
          body: Column(
            children: [
              buildLogo(),
              const SizedBox(height: 30),

              // Judul
              const Text(
                'Berikut Kode Login Anda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Deskripsi
              const Text(
                'Kode ini akan digunakan untuk masuk dengan aman menggunakan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),

              // Email
              Text(
                widget.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),

              // Input Kode OTP
              _buildOTPInputs(),
              const SizedBox(height: 40),

              if (state.hasFailure)
                Text(
                  state.errors[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),

              // Tombol Masuk
              buildAnimatedButton(
                text: 'Verifikasi OTP',
                isHovering: _isHovering,
                onHover: (hovering) => setState(() => _isHovering = hovering),
                onPressed: () => _handleOTPLogin(),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, EmailVerificationState state) {
        if (state.isLoaded && !state.hasFailure) {
          if (state.token.isNotEmpty) {
            //Navigator.of(context).pop();
          }
        } else if (state.errors.isNotEmpty) {
          // debugPrint("OTP Login Failed: ${state.errors}");
        }
      },
    );
  }

  Widget _buildOTPInputs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions
        double availableWidth = constraints.maxWidth > 0 ? constraints.maxWidth : MediaQuery.of(context).size.width * 0.8;
        double spacing = 8.0;
        double totalSpacing = spacing * 5; // 5 spaces between 6 boxes
        double boxWidth = (availableWidth - totalSpacing) / 6;

        // Set minimum and maximum box sizes
        boxWidth = boxWidth.clamp(40.0, 55.0);
        double boxHeight = boxWidth;

        // Adjust font size based on box size
        double fontSize = boxWidth * 0.4; // 40% of box width
        fontSize = fontSize.clamp(16.0, 24.0);

        return Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) { // Changed to 6
              return Container(
                width: boxWidth,
                height: boxHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _focusNodes[index].hasFocus
                        ? Colors.blue.shade300
                        : Colors.grey.shade300,
                    width: _focusNodes[index].hasFocus ? 2.0 : 1.0,
                  ),
                  color: _focusNodes[index].hasFocus
                      ? Colors.blue.shade50
                      : Colors.grey.shade50,
                ),
                child: TextField(
                  controller: _codeControllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) { // Changed condition to < 5
                      _focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                    setState(() {}); // Refresh to update border colors
                  },
                  onTap: () {
                    setState(() {}); // Refresh to update border colors
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // Fungsi yang akan disambungkan ke API
  void _handleOTPLogin() {
    String otpCode =
    _codeControllers.map((controller) => controller.text).join();

    // Validasi apakah semua kotak sudah diisi
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi semua kode OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    //Navigator.of(context).pop();

    context.read<EmailVerificationBloc>().add(
      ValidasiPinEmailEvent(
        record: EmailVerificationModel(email: widget.email, pin: otpCode),
      ),
    );
  }
}