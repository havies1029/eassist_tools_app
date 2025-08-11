import 'package:flutter/material.dart';
import 'package:eassist_tools_app/common/size_config.dart';

// ==== BRAND JPS (ABOUT PAGE) ====
const kBrandPrimaryColor = Color(0xFF79AB43); // hijau utama
const kBrandLightColor   = Color(0xFFD5F4B4); // hijau muda background
const kBrandAccentColor  = Color(0xFF91C050); // hijau tombol
const kBrandTextOnPrimary = Colors.white;     // teks di atas hijau
const kBrandTextOnGradient = Color(0xFF6B8F4F);     // teks di atas hijau
const kBrandTextOnSurface = Colors.black87;   // teks di atas background terang
const kBrandTextOnOpacity1 = Color.fromRGBO(0, 0, 0, 0.4);
const kBrandTextOnOpacity2 = Color.fromRGBO(0, 0, 0, 0.8);

// Overlay untuk hero image
const kBrandOverlayDark  = Color.fromARGB(160, 0, 0, 0); // ~62% hitam
const kBrandOverlayLight = Color.fromARGB(80, 0, 0, 0);  // ~31% hitam

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kStringNullError = "Please enter some text";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

enum ListStatus { initial, success, failure, loading }