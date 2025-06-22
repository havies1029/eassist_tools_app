// OTP Login Dialog
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/reguser/reguser_bloc.dart';
import '../../../models/reguser/reguser_model.dart';

class OtpHpDialog extends BaseDialog {
  final String hpno;
  const OtpHpDialog({super.key, required this.hpno});

  @override
  State<OtpHpDialog> createState() => OtpHpDialogState();
}

class OtpHpDialogState extends BaseDialogState<OtpHpDialog> {
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

          // HP Number
          Text(
            widget.hpno,
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

          // Tombol Masuk
          buildAnimatedButton(
            text: 'Masuk',
            isHovering: _isHovering,
            onHover: (hovering) => setState(() => _isHovering = hovering),
            onPressed: () => _handleOTPLogin(),
          ),
        ],
      ),
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

    RegUserModel? record = context.read<RegUserBloc>().state.record;
    record?.kodePin = otpCode;

    context.read<RegUserBloc>().add(
      ValidasiPinHPEvent(
          record: record!
      ),
    );

  }
}