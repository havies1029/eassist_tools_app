// OTP Login Dialog
import 'package:eassist_tools_app/blocs/reguser/reguser_bloc.dart';
import 'package:eassist_tools_app/models/reguser/reguser_model.dart';
import 'package:eassist_tools_app/widgets/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpHpDialog extends BaseDialog {
  final String hpno;

  const OtpHpDialog({super.key, required this.hpno});

  @override
  State<OtpHpDialog> createState() => OtpHpDialogState();
}

class OtpHpDialogState extends BaseDialogState<OtpHpDialog> {
  final List<TextEditingController> _codeControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
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
    return BlocConsumer<RegUserBloc, RegUserState>(
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

              if (state.hasFailure)
                Text(
                  state.errors[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
        
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
      }, listener: (BuildContext context, RegUserState state) { 
          if (state.errors.isNotEmpty) {
            debugPrint("OTP Login Failed: ${state.errors}");          
          }
       },
    );
  }

  Widget _buildOTPInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade50,
            ),
            child: TextField(
              controller: _codeControllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < 3) {
                  _focusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              },
            ));
      }),
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