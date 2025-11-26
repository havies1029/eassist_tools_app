import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'dropdown_sub_menu_tile.dart';
import 'sub_menu_item.dart';

class DropdownExpandableItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<SubMenuItem> subItems;

  /// Controlled from parent:
  final bool isExpanded;
  final VoidCallback onHeaderTap;

  const DropdownExpandableItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subItems,
    required this.isExpanded,
    required this.onHeaderTap,
  }) : super(key: key);

  @override
  _DropdownExpandableItemState createState() =>
      _DropdownExpandableItemState();
}

class _DropdownExpandableItemState extends State<DropdownExpandableItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    value: widget.isExpanded ? 1.0 : 0.0,
  );
  late final Animation<double> _expandAnim =
  CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  late final Animation<double> _rotateAnim = Tween(begin: 0.0, end: 0.5)
      .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  bool _isHovered = false;

  @override
  void didUpdateWidget(covariant DropdownExpandableItem old) {
    super.didUpdateWidget(old);
    if (widget.isExpanded != old.isExpanded) {
      widget.isExpanded ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit:  (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            decoration: BoxDecoration(
              color: _isHovered
                  ? const Color(0xFF79AB43).withOpacity(0.05)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: ListTile(
              dense: true,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              leading: Icon(widget.icon,
                  size: 18, color: const Color(0xFF79AB43)),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              trailing: RotationTransition(
                turns: _rotateAnim,
                child: Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Colors.grey.shade600),
              ),
              onTap: widget.onHeaderTap,
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnim,
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            child: Column(
              children: widget.subItems
                  .map((sub) => DropdownSubMenuTile(subItem: sub))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
