// floating_chat_wrapper.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FloatingChatWrapper extends StatelessWidget {
  final Widget child;
  const FloatingChatWrapper({super.key, required this.child});

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;      // Keyboard
    final viewPadding = MediaQuery.of(context).viewPadding;    // System nav bar (bottom)
    final keyboardVisible = viewInsets.bottom > 0;
    final systemBottomPadding = viewPadding.bottom;

    final double bottomOffset = keyboardVisible
        ? viewInsets.bottom + 16 // Naik kalau keyboard muncul
        : systemBottomPadding > 0
        ? systemBottomPadding + 16 // Tambahkan jarak dari soft key
        : 16; // Default padding

    return Stack(
      children: [
        child,

        if (isMobile)
          Positioned(
            right: 16,
            bottom: bottomOffset,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'chat');
              },
              child: const Icon(Icons.chat),
            ),
          ),
      ],
    );
  }
}
