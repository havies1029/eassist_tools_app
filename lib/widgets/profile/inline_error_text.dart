import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InlineErrorText extends StatelessWidget {
  final String error;
  const InlineErrorText(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.red,
                fontWeight: FontWeight.w400,
                fontFamily: 'Satoshi',
              ),
            ),
          ),
        ],
      ),
    );
  }
}