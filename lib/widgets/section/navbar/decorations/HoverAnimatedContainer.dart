

// Custom Widgets for Animation and Interactivity
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HoverAnimatedContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const HoverAnimatedContainer({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  State<HoverAnimatedContainer> createState() => _HoverAnimatedContainerState();
}

class _HoverAnimatedContainerState extends State<HoverAnimatedContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFEEF7DD) : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.child,
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final bool isRounded;

  const HoverButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = Colors.transparent,
    this.textColor = const Color(0xFF79AB43),
    this.isRounded = false,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.isRounded ? 30.0 : 4.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.95)
                : widget.color,
            borderRadius: radius,
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: radius,
            child: DefaultTextStyle(
              style: TextStyle(
                color: widget.textColor,
                fontFamily: 'Satoshi-Regular',
                fontWeight: FontWeight.w500,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class HoverActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isOutlined;
  final bool isRounded;
  final TextStyle? textStyle;

  const HoverActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.textStyle,
    this.isOutlined = false,
    this.isRounded = false,
  });

  @override
  State<HoverActionButton> createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: widget.isOutlined
              ? Colors.transparent
              : _isHovered
              ? const Color(0xFF8BBD54)
              : const Color(0xFF79AB43),
          border: widget.isOutlined
              ? Border.all(
            color: _isHovered
                ? const Color(0xFF8BBD54)
                : const Color(0xFF79AB43),
            width: 2.0,
          )
              : null,
          borderRadius: BorderRadius.circular(widget.isRounded ? 16.56 : 4.0),
          boxShadow: widget.isOutlined ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(widget.isRounded ? 16.56 : 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.isOutlined
                    ? const Color(0xFF79AB43)
                    : Colors.white,
                size: 27.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  color: widget.isOutlined
                      ? const Color(0xFF79AB43)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 27.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}