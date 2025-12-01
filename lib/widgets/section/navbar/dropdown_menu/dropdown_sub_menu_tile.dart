import 'package:flutter/material.dart';
import 'sub_menu_item.dart';

/// Tile untuk setiap entri submenu
class DropdownSubMenuTile extends StatefulWidget {
  final SubMenuItem subItem;

  const DropdownSubMenuTile({
    super.key,
    required this.subItem,
  });

  @override
  _DropdownSubMenuTileState createState() => _DropdownSubMenuTileState();
}

class _DropdownSubMenuTileState extends State<DropdownSubMenuTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit:  (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF8BBD54).withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          leading: Icon(
            widget.subItem.icon,
            size: 16.0,
            color: _isHovered
                ? const Color(0xFF8BBD54)
                : const Color(0xFF79AB43).withOpacity(0.7),
          ),
          title: Text(
            widget.subItem.title,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: _isHovered
                  ? const Color(0xFF2D5016)
                  : Colors.black.withOpacity(0.8),
            ),
          ),
          onTap: widget.subItem.onTap,
        ),
      ),
    );
  }
}
