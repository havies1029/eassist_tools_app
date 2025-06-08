

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnhancedHoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLogin;
  final Duration delay;

  const EnhancedHoverButton({
    super.key,
    required this.onPressed,
    required this.isLogin,
    this.delay = Duration.zero, required double height,
  });

  @override
  State<EnhancedHoverButton> createState() => _EnhancedHoverButtonState();
}

class _EnhancedHoverButtonState extends State<EnhancedHoverButton>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pressController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _backgroundAnimation;
  late Animation<Color?> _borderAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _pulseAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    if (widget.isLogin) {
      _backgroundAnimation = AlwaysStoppedAnimation(Colors.white);
      _borderAnimation = AlwaysStoppedAnimation(const Color(0xFF79AB43));
    } else {
      _backgroundAnimation = ColorTween(
        begin: const Color(0xFF79AB43),
        end: const Color(0xFF5D8B32),
      ).animate(_hoverController);

      _borderAnimation = ColorTween(
        begin: const Color(0xFF79AB43),
        end: const Color(0xFF5D8B32),
      ).animate(_hoverController);
    }

    _iconScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.elasticOut,
    ));

    _iconRotationAnimation = Tween<double>(
      begin: 0.0,
      end: widget.isLogin ? 0.1 : -0.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (!widget.isLogin) {
      Future.delayed(widget.delay + const Duration(milliseconds: 1000), () {
        if (mounted) _pulseController.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _hoverController,
        _pressController,
        _pulseController,
      ]),
      builder: (context, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          child: GestureDetector(
            onTapDown: (_) => _pressController.forward(),
            onTapUp: (_) => _pressController.reverse(),
            onTapCancel: () => _pressController.reverse(),
            onTap: widget.onPressed,
            child: Transform.scale(
              scale: _scaleAnimation.value *
                  _pulseAnimation.value *
                  (1.0 - _pressController.value * 0.05),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: _backgroundAnimation.value,
                  borderRadius: BorderRadius.circular(16.13),
                  border: Border.all(
                    color: _borderAnimation.value ?? Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: [
                    if (_isHovered || !widget.isLogin)
                      BoxShadow(
                        color: const Color(0xFF79AB43).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: _elevationAnimation.value + 4,
                        offset: Offset(0, _elevationAnimation.value / 2),
                      ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: _iconScaleAnimation.value,
                      child: Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: Icon(
                          widget.isLogin ? Icons.login : Icons.person_add,
                          color: widget.isLogin
                              ? const Color(0xFF79AB43)
                              : Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Text(
                        widget.isLogin ? 'Masuk' : 'Daftar Client',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Satoshi-Regular',
                          color: widget.isLogin
                              ? const Color(0xFF79AB43)
                              : Colors.white,
                          fontWeight:
                          _isHovered ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
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
      if (!widget.isLogin) _pulseController.stop();
    } else {
      _hoverController.reverse();
      if (!widget.isLogin && mounted) {
        _pulseController.repeat(reverse: true);
      }
    }
  }
}