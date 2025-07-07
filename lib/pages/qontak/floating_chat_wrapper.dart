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
    final viewInsets = MediaQuery.of(context).viewInsets;
    final bottomPadding = viewInsets.bottom;

    return Stack(
      children: [
        child,

        if (isMobile)
        // FAB yang naik kalau keyboard muncul
          Positioned(
            right: 16,
            bottom: bottomPadding > 0 ? bottomPadding + 16 : 16,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'chat');
                },
                child: const Icon(Icons.chat),
              ),
            ),
          ),
      ],
    );
  }
}
