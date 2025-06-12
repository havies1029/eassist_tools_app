import 'package:flutter/material.dart';

class ProfileMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  }) : super(key: key);

  @override
  _ProfileMenuItemState createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<ProfileMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = widget.isDestructive
        ? Colors.red.withOpacity(0.05)
        : const Color(0xFF79AB43).withOpacity(0.05);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit:  (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: _isHovered ? hoverColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          leading: Icon(
            widget.icon,
            size: 18.0,
            color: widget.isDestructive
                ? (_isHovered ? Colors.red : Colors.red.withOpacity(0.7))
                : const Color(0xFF79AB43),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: widget.isDestructive
                  ? (_isHovered ? Colors.red : Colors.red.withOpacity(0.8))
                  : Colors.black87,
            ),
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
