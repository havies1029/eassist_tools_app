

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedInsuranceCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
  final bool isMobile;
  final VoidCallback onTap;

  const AnimatedInsuranceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
    required this.isMobile,
    required this.onTap,
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: _elevationAnimation.value,
                  offset: Offset(0, _elevationAnimation.value * 0.3),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Subtle gradient overlay for text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),

                          // Title with better contrast
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.isMobile ? 16 : 20,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Satoshi-Regular',
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              child: Text(widget.title),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle with background for readability
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: widget.isMobile ? 11 : 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Satoshi-Regular',
                                height: 1.4,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              child: Text(
                                widget.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Spacer(),

                          // Arrow icon with enhanced visibility
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: _isHovered ? 0.125 : 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: widget.color.withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: widget.color,
                                size: widget.isMobile ? 16 : 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Invisible tap area
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: widget.onTap,
                          onHover: _onHover,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(),
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
}