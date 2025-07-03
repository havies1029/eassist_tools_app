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
    return Stack(
      children: [
        child,
        if (isMobile)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'chat');
              },
              child: const Icon(Icons.chat),
            ),
          )
      ],
    );
  }
}
