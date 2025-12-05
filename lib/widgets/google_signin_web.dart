// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as dart_js;
import 'package:js/js_util.dart' as js_util;

import 'package:flutter/material.dart';
import 'web_view_registry.dart'; // ⬅️ Ini wajib: conditional wrapper untuk platformViewRegistry

class GoogleSignInWeb extends StatefulWidget {
  final void Function(String idToken, Map<String, dynamic> user) onSuccess;

  const GoogleSignInWeb({super.key, required this.onSuccess});

  @override
  State<GoogleSignInWeb> createState() => _GoogleSignInWebState();
}

class _GoogleSignInWebState extends State<GoogleSignInWeb> {
  late html.DivElement _element;

  @override
  void initState() {
    super.initState();

    // 1. Buat div sebagai container tombol Google
    _element = html.DivElement()
      ..id = 'gsi_button_container'
      ..style.width = '300px'
      ..style.height = '50px';

    // 2. Register div ke Flutter WebView
    registerWebViewFactory('google-login-button', (int viewId) => _element);

    // 3. Inisialisasi Google SDK (dengan pengecekan)
    _tryInitGoogleSignIn();
  }

  void _tryInitGoogleSignIn() {
    if (_isGoogleSDKReady()) {
      debugPrint("✅ Google SDK siap. Menjalankan initialize...");

      dart_js.context.callMethod('google.accounts.id.initialize', [
        dart_js.JsObject.jsify({
          'client_id':
              '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
          // ignore: undefined_function
          'callback': js_util.allowInterop((response) {
            final idToken = response['credential'];
            final user = _decodeJwt(idToken);
            debugPrint("✅ Google Sign-In berhasil, token diterima.");
            widget.onSuccess(idToken, user);
          }),
        })
      ]);

      dart_js.context.callMethod('google.accounts.id.renderButton', [
        _element,
        dart_js.JsObject.jsify({
          'theme': 'outline',
          'size': 'large',
          'width': 300,
        }),
      ]);

      dart_js.context.callMethod('google.accounts.id.prompt');
    } else {
      debugPrint("⏳ Google SDK belum siap, retry dalam 500ms...");
      Future.delayed(const Duration(milliseconds: 500), _tryInitGoogleSignIn);
    }
  }

  bool _isGoogleSDKReady() {
    return dart_js.context.hasProperty('google') &&
        dart_js.context['google'].hasProperty('accounts') &&
        dart_js.context['google']['accounts'].hasProperty('id');
  }

  Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return {};
    final payload = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(payload));
    return json.decode(decoded);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 50,
      child: HtmlElementView(viewType: 'google-login-button'),
    );
  }
}
