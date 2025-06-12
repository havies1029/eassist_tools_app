import 'package:flutter/material.dart';
import 'Auth_Ui.dart';

class CustomPopupsRegisterUser {
  static const Color primaryGreen = Color(0xFF79AB43);
  static const Color lightGreen = Color(0xFF8BC34A);

  // Popup untuk Register (dengan berbagai opsi)
  static Future<void> showRegisterDialog(BuildContext context, {String? email}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return email != null
            ? OTPRegisterDialog(email: email)
            : const GeneralRegisterDialog();
      },
    );
  }

  // Popup untuk Login
  static Future<void> showLoginDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const LoginDialog();
      },
    );
  }
  
}