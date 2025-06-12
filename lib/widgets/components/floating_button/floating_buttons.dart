import 'package:eassist_tools_app/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import '../../account/login/login_gmail/popup_dialog_login.dart';
import '../../account/register/register_client/popup_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'profile'
  ],
  hostedDomain: "", // biarkan kosong kecuali organisasi
  serverClientId: "217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com", // Penting!
);

class FloatingButtons extends StatefulWidget {
  final BoxConstraints constraints;
  const FloatingButtons({super.key, required this.constraints});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons>
    with TickerProviderStateMixin {
  late AnimationController _buttonsController;
  late Animation<double> _buttonsStaggerAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxWidth =>
      widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get sidePadding => widget.constraints.maxWidth > 1200 ? 64.0 : 30.0;
  double get innerPadding => isMobile ? 16.0 : 40.0;

  GoogleSignInAccount? _user;

  @override
  void initState() {
    super.initState();

    _buttonsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonsStaggerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonsController,
      curve: Curves.easeOutCubic,
    ));

    _startAnimations();

  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonsController.forward();
  }

  @override
  void dispose() {
    _buttonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.constraints.maxWidth < 768;
    final Size screenSize = MediaQuery.of(context).size;
    final Offset translateOffset = isMobile
        ? const Offset(0, -35)
        : const Offset(0, -80);
    final bool isExact1900x1200 = screenSize.width >= 1500.0;
    return Transform.translate(
      offset: translateOffset,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Center(
          child: Container(
            width: maxWidth,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.13),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: const Color(0xFF79AB43).withOpacity(0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: innerPadding,
                vertical: isMobile ? 17.0 : 20.0,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobileLocal = constraints.maxWidth < 768;
                  return Wrap(
                    spacing: isExact1900x1200
                        ? -10
                        : (isMobileLocal ? 10 : 16),
                    runSpacing: isMobileLocal ? 10 : 0,
                    alignment: isMobileLocal
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildAnimatedButton(
                        isLogin: true,
                        delay: const Duration(milliseconds: 0),
                        isMobile: isMobileLocal,
                      ),
                      _buildAnimatedButton(
                        isLogin: false,
                        delay: const Duration(milliseconds: 200),
                        isMobile: isMobileLocal,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required bool isLogin,
    required Duration delay,
    required bool isMobile,
  }) {
    return AnimatedBuilder(
      animation: _buttonsController,
      builder: (context, child) {
        // Ambil ukuran layar saat ini
        final Size screenSize = MediaQuery.of(context).size;
        final bool isExact1900x1200 = (screenSize.width >= 1500.0);

        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: _buttonsStaggerAnimation.value),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(30 * (1 - value), 0),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Padding(
                  // Jika layar tepat 1900×1200 → tambahkan padding kiri 20 px (misalnya)
                  padding: EdgeInsets.only(left: isExact1900x1200 ? 30.0 : 0.0),
                  child: EnhancedHoverButton(
                    onPressed: () async {
                      if (isLogin) {
                        await CustomPopupsLoginUser.showLoginUserDialog(context);
                      } else {
                        await CustomPopupsLoginUser.showRegisterClientDialog(context);
                      }
                    },
                    isLogin: isLogin,
                    delay: delay,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  Future<void> _handleSignIn() async {
    debugPrint("handle sign in");
    try {
      final user = await _googleSignIn.signIn();
      setState(() => _user = user);

      if (user != null) {
        final auth = await user.authentication;
        final idToken = auth.idToken;

        // Kirim ID Token ke backend kamu via HTTP POST
        print("ID Token: $idToken");
      }
    } catch (error) {
      print('Login gagal: $error');
    }
  }

  Future<void> _handleSignOut() async {
    debugPrint("handle sign out");
    try {
      await _googleSignIn.signOut();
      //await _googleSignIn.disconnect();
      setState(() => _user = null);
    } catch (error) {
      print('Logout gagal: $error');
    }
  }

}

class EnhancedHoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLogin;
  final Duration delay;

  const EnhancedHoverButton({
    super.key,
    required this.onPressed,
    required this.isLogin,
    this.delay = Duration.zero,
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