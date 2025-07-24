// ganti nama menjadi StatusPopup
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../pages/base/base_page.dart';
import '../../../pages/user_jps/user_jps_main.dart';
import '../../../pages/user_non_jps/user_non_jps_main.dart';

class StatusPopup extends StatefulWidget {
  final VoidCallback? onCancel;

  const StatusPopup({Key? key, this.onCancel}) : super(key: key);

  @override
  _StatusPopupState createState() => _StatusPopupState();
}

class _StatusPopupState extends State<StatusPopup>
    with TickerProviderStateMixin {
  bool _isHoveringYes = false;
  bool _isHoveringNo = false;

  late AnimationController _animationController;
  late AnimationController _overlayController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _overlayAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _overlayAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeInOut),
    );

    _overlayController.forward();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  void _closePopup() {
    _animationController.reverse().then((_) {
      _overlayController.reverse().then((_) {
        if (mounted) {
          Navigator.of(context).pop();
          if (widget.onCancel != null) {
            widget.onCancel!();
          }
        }
      });
    });
  }

  void _navigateTo(bool isJpsUser) {
    _animationController.reverse().then((_) {
      _overlayController.reverse().then((_) {
        if (mounted) {
          Navigator.of(context).pop();
          Future.microtask(() {
            if (isJpsUser) {
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              //   context.read<HomeBloc>().add(UserJPSPageActiveEvent());
              // });
              Future.microtask(() {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  // context.read<HomeBloc>().add(UserJPSPageActiveEvent());
                  context.read<HomeBloc>().add(PushPageEvent(PageType.userjps));
                });
              });
            } else {
              Future.microtask(() {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  // context.read<HomeBloc>().add(UserNonJPSPageActiveEvent());
                  context.read<HomeBloc>().add(PushPageEvent(PageType.usernonjps));
                });
              });
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              //   context.read<HomeBloc>().add(UserNonJPSPageActiveEvent());
              // });
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Responsive dialog sizing
    double dialogWidth;
    double dialogPadding;
    double fontSize;
    double buttonPadding;
    double buttonSpacing;

    if (screenWidth < 400) {
      dialogWidth = screenWidth * 0.9;
      dialogPadding = 16.0;
      fontSize = 18.0;
      buttonPadding = 16.0;
      buttonSpacing = 12.0;
    } else if (screenWidth < 600) {
      dialogWidth = screenWidth * 0.85;
      dialogPadding = 20.0;
      fontSize = 20.0;
      buttonPadding = 18.0;
      buttonSpacing = 15.0;
    } else if (screenWidth < 800) {
      dialogWidth = screenWidth * 0.7;
      dialogPadding = 25.0;
      fontSize = 22.0;
      buttonPadding = 20.0;
      buttonSpacing = 18.0;
    } else {
      dialogWidth = 480.0;
      dialogPadding = 30.0;
      fontSize = 22.0;
      buttonPadding = 20.0;
      buttonSpacing = 20.0;
    }

    return AnimatedBuilder(
      animation: _overlayAnimation,
      builder: (context, child) {
        return Material(
          color: Colors.black.withOpacity(0.5 * _overlayAnimation.value),
          child: GestureDetector(
            onTap: _closePopup, // Close when tapping outside
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () {}, // Prevent closing when tapping inside dialog
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_scaleAnimation, _fadeInAnimation]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _fadeInAnimation.value,
                            child: Container(
                              width: dialogWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: screenHeight * 0.1,
                              ),
                              constraints: BoxConstraints(
                                maxHeight: screenHeight * 0.8,
                                maxWidth: screenWidth * 0.95,
                                minWidth: 280,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(dialogPadding),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pilih Status Anda',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Satoshi-Regular',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenWidth < 400 ? 8 : 10),
                                    Text(
                                      'Apakah Anda pengguna layanan JPS?',
                                      style: TextStyle(
                                        fontSize: screenWidth < 400 ? 14 : 16,
                                        color: Colors.black54,
                                        fontFamily: 'Satoshi-Regular',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenWidth < 400 ? 20 : 30),
                                    // Always use column layout for better responsiveness
                                    Column(
                                      children: [
                                        _buildButton(
                                          isYes: false,
                                          buttonPadding: buttonPadding,
                                          screenWidth: screenWidth,
                                        ),
                                        SizedBox(height: buttonSpacing),
                                        _buildButton(
                                          isYes: true,
                                          buttonPadding: buttonPadding,
                                          screenWidth: screenWidth,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required bool isYes,
    required double buttonPadding,
    required double screenWidth,
  }) {
    final isHovering = isYes ? _isHoveringYes : _isHoveringNo;
    final baseColor = isYes ? Colors.green : Colors.orange;
    final hoverColor = isYes ? Colors.green.shade700 : Colors.orange.shade700;
    final icon = isYes ? Icons.check_circle : Icons.close;
    final text = isYes ? 'Ya, Pengguna JPS' : 'Tidak, saya bukan';

    // Responsive font sizes
    double buttonFontSize;
    double iconSize;

    if (screenWidth < 400) {
      buttonFontSize = 14.0;
      iconSize = 18.0;
    } else if (screenWidth < 600) {
      buttonFontSize = 15.0;
      iconSize = 20.0;
    } else {
      buttonFontSize = 16.0;
      iconSize = 22.0;
    }

    return MouseRegion(
      onEnter: (_) => setState(() {
        if (isYes) {
          _isHoveringYes = true;
        } else {
          _isHoveringNo = true;
        }
      }),
      onExit: (_) => setState(() {
        if (isYes) {
          _isHoveringYes = false;
        } else {
          _isHoveringNo = false;
        }
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovering ? 1.02 : 1.0),
        width: double.infinity, // Make button full width
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isHovering ? hoverColor : baseColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: buttonPadding,
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: isHovering ? 8 : 4,
            shadowColor: baseColor.withOpacity(0.3),
            minimumSize: Size(double.infinity, 50), // Minimum height
          ),
          onPressed: () => _navigateTo(isYes),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusPopupHelper {
  static void show(BuildContext context, {VoidCallback? onCancel}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Keep this false since we handle it manually
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => StatusPopup(onCancel: onCancel),
    );
  }
}