import 'package:flutter/material.dart';

/// Model untuk setiap submenu
class SubMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SubMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
