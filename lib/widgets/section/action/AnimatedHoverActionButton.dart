
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedHoverActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isPrimary;
  final Duration delay;

  const AnimatedHoverActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.isPrimary = true,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedHoverActionButton> createState() => _AnimatedHoverActionButtonState();
}

class _AnimatedHoverActionButtonState extends State<AnimatedHoverActionButton>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pressController;
  late AnimationController _entryController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _entryAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 4.0,
      end: 12.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: widget.isPrimary ? const Color(0xFF79AB43) : Colors.white,
      end: widget.isPrimary ? const Color(0xFF5D8B32) : const Color(0xFF79AB43),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _iconRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _entryAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.elasticOut,
    ));

    // Start entry animation with delay
    Future.delayed(widget.delay, () {
      if (mounted) _entryController.forward();
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pressController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _pressController, _entryController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _entryAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: GestureDetector(
              onTapDown: (_) => _pressController.forward(),
              onTapUp: (_) => _pressController.reverse(),
              onTapCancel: () => _pressController.reverse(),
              onTap: widget.onPressed,
              child: Transform.scale(
                scale: _scaleAnimation.value * (1.0 - _pressController.value * 0.05),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    borderRadius: BorderRadius.circular(16.13),
                    border: widget.isPrimary
                        ? null
                        : Border.all(
                      color: _isHovered
                          ? const Color(0xFF79AB43)
                          : const Color(0xFF79AB43).withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF79AB43).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: _elevationAnimation.value,
                        offset: Offset(0, _elevationAnimation.value / 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: Icon(
                          widget.icon,
                          color: widget.isPrimary
                              ? Colors.white
                              : (_isHovered ? Colors.white : const Color(0xFF79AB43)),
                          size: 20.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Satoshi-Regular',
                          fontWeight: FontWeight.w600,
                          color: widget.isPrimary
                              ? Colors.white
                              : (_isHovered ? Colors.white : const Color(0xFF79AB43)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }
}