import 'package:flutter/material.dart';
import '../../dialog/Reusable_OTP/reusable_otp_dialog.dart';
import 'register_client_dialog.dart';

class CustomPopupsClient {
  static const Color primaryGreen = Color(0xFF79AB43);

  /// Menampilkan form pendaftaran (RegisterDialog)
  static Future<void> showRegisterDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => RegisterDialog(),
    );
  }

  /// Menampilkan dialog OTP (LoginDialog) setelah registrasi.
  ///
  /// - [email]: nilai yang akan ditampilkan di dalam LoginDialog
  /// - [selectedChoice]: 'Individual' atau 'Perusahaan', diteruskan ke LoginDialog
  static Future<void> showLoginDialog(
      BuildContext context, {
        required String email,
        required String selectedChoice,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false, // paksa user menyelesaikan OTP terlebih dahulu
      builder: (_) => ReusableOTPDialog(
        email: email,
        selectedChoice: selectedChoice,
      ),
    );
  }
}
