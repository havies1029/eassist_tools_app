import 'package:eassist_tools_app/widgets/account/login/login_client/login_client_dialog.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/login_user_dialog.dart';
import 'package:eassist_tools_app/widgets/dialog/forget_password/lupa_sandi_dialog.dart';
import 'package:eassist_tools_app/widgets/dialog/reusable_otp/otp_email_dialog.dart';
import 'package:eassist_tools_app/widgets/dialog/reusable_otp/otp_hp_dialog.dart';
import 'package:eassist_tools_app/widgets/account/register/register_client/register_client_dialog.dart';
// import 'package:eassist_tools_app/widgets/account/login/login_gmail/x_register_user_dialog.dart';
import 'package:flutter/material.dart';

class CustomPopupsLoginUser {
  static const Color primaryGreen = Color(0xFF79AB43);
  static const Color lightGreen = Color(0xFF8BC34A);

  // popup dialog login user
  static Future<bool> showLoginUserDialog(BuildContext context) async {
    debugPrint("showLoginDialog called");
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const LoginUserDialog();
      },
    );
    return result ?? true;
  }

  // popup dialog login client
  static Future<void> showLoginClientDialog(BuildContext context) async {
    debugPrint("showLoginDialog called");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const LoginClientDialog();
      },
    );
  }

  // Popup lupa sandi
  static Future<void> showForgotPasswordDialog(BuildContext context) async {
    debugPrint("showForgotPasswordDialog called");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const LupaSandiDialog();
      },
    );
  }

  // Popup untuk Request OTP Email
  static Future<void> showRequestOTPEmailDialog(BuildContext context, String email) async {
    debugPrint("showRequestOTPDialog called with email: $email");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return OtpEmailDialog(email: email);
      },
    );

  }

  // Popup untuk Request OTP Email
  static Future<void> showRequestOTPHPDialog(BuildContext context, String hpno) async {
    debugPrint("showRequestOTPDialog called with ho: $hpno");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return OtpHpDialog(hpno: hpno);
      },
    );
  }

  // Popup untuk Register Client
  static Future<void> showRegisterClientDialog(BuildContext context) async {
    debugPrint("showRegisterClientDialog called");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const RegisterClientDialog();
      },
    );
  }
// Popup untuk Register User

}