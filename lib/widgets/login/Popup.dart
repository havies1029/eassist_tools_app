import 'package:flutter/material.dart';
import 'Auth_Ui.dart';

class CustomPopupsUser {
  static const Color primaryGreen = Color(0xFF79AB43);
  static const Color lightGreen = Color(0xFF8BC34A);

  // Popup untuk Login (dengan berbagai opsi)
  static Future<void> showLoginDialog(BuildContext context, {String? email}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return email != null
            ? OTPLoginDialog(email: email)
            : const GeneralLoginDialog();
      },
    );
  }

  // Popup untuk Register
  static Future<void> showRegisterDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const RegisterDialog();
      },
    );
  }
}