import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedInsuranceCard extends StatefulWidget {
  final String imagePath;
  final bool isMobile;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const AnimatedInsuranceCard({
    super.key,
    required this.imagePath,
    required this.isMobile,
    required this.onTap,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 20,
    this.padding,
    this.margin,
  });

  @override
  State<AnimatedInsuranceCard> createState() => _AnimatedInsuranceCardState();
}

class _AnimatedInsuranceCardState extends State<AnimatedInsuranceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _overlayAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _overlayAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
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

  void _onTap() {
    // Animate scale on tap like hover
    _hoverController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _hoverController.reverse();
      });
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Container(
          margin: widget.margin,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: widget.padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.3),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  child: Stack(
                    children: [
                      // Main image
                      Positioned.fill(
                        child: Image.asset(
                          widget.imagePath,
                          fit: widget.fit ?? BoxFit.cover,
                          width: widget.width,
                          height: widget.height,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error loading image: ${widget.imagePath}');
                            return Container(
                              width: widget.width,
                              height: widget.height,
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey[400],
                                    size: 50,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image not found',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Hover overlay effect
                      if (_overlayAnimation.value > 0)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(_overlayAnimation.value),
                          ),
                        ),
                      // Invisible tap area
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _onTap,
                            onHover: _onHover,
                            borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
                            child: Container(),
                          ),
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
}