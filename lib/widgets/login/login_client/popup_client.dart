import 'package:flutter/material.dart';
import 'register_form_dialog.dart';
import 'login_verification_dialog.dart';

class CustomPopupsClient {
  static const Color primaryGreen = Color(0xFF79AB43);

  static Future<void> showRegisterDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const RegisterDialog(),
    );
  }

  static void showLoginDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LoginDialog(email: email),
    );
  }
}
