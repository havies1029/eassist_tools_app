import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/web_only.dart';

// Init Google Sign-In for Web once before rendering the button.
final Future<void> _googleSignInWebInit =
    GoogleSignInPlatform.instance.initWithParams(
  const SignInInitParameters(
    // Use the Web client ID from the Google Cloud Console.
    clientId:
        '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
    scopes: <String>['email', 'profile'],
  ),
);

Widget googleSigninButton() {
  return FutureBuilder<void>(
    future: _googleSignInWebInit,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          height: 50,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (snapshot.hasError) {
        debugPrint('Google Sign-In Web init failed: ${snapshot.error}');
        return const SizedBox.shrink();
      }

      return renderButton();
    },
  );
}
