import 'package:flutter/material.dart';
import '../../account/login/login_gmail/popup_dialog_login.dart';
import '../../account/register/register_client/popup_client.dart';
import 'decorations/EnhancedHoverButton.dart';

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
  double get maxWidth => widget.constraints.maxWidth > 1200
      ? 1200
      : widget.constraints.maxWidth * 0.9;
  double get sidePadding => isMobile ? 0.0 : (widget.constraints.maxWidth > 1200 ? 0.0 : 30.0);
  double get innerPadding => isMobile ? 10.0 : 40.0;
  double get _buttonHeight => isMobile ? 35.0 : 50.0;
  double get _boxRadius => 16.13;

  @override
  void initState() {
    super.initState();
    _buttonsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _buttonsStaggerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonsController, curve: Curves.easeOutCubic),
    );
    _startAnimations();
  }

  Future<void> _startAnimations() async {
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
    if (isMobile) {
      // Untuk mobile, gunakan Positioned untuk floating effect
      return Positioned(
        top: MediaQuery.of(context).padding.top + (130 * 3), // Adjust sesuai kebutuhan
        left: 25,
        right: 25,
        child: FractionallySizedBox(
          widthFactor: 0.8,      // Container akan 90% lebar layar
          child: _buildMobileFloatingLayout(),
        ),
      );
    } else {
      // Untuk desktop, tetap gunakan layout normal
      final Offset translateOffset = const Offset(0, -80);
      final bool isExact1900x1200 = MediaQuery.of(context).size.width >= 1500.0;

      return Transform.translate(
        offset: translateOffset,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sidePadding),
          child: _buildDesktopLayout(isExact1900x1200),
        ),
      );
    }
  }

  Widget _buildMobileFloatingLayout() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: _boxDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: innerPadding, vertical: 10.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildAnimatedButton(isLogin: true, delay: const Duration(milliseconds: 0)),
              _buildAnimatedButton(isLogin: false, delay: const Duration(milliseconds: 200)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(bool isExact1900x1200) {
    return Center(
      child: Container(
        width: maxWidth,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: _boxDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: innerPadding, vertical: 20.0),
          child: Wrap(
            spacing: isExact1900x1200 ? -10 : 16,
            runSpacing: 0,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildAnimatedButton(isLogin: true, delay: const Duration(milliseconds: 0), leftOffset: isExact1900x1200 ? 30 : 0),
              _buildAnimatedButton(isLogin: false, delay: const Duration(milliseconds: 200), leftOffset: isExact1900x1200 ? 30 : 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required bool isLogin,
    required Duration delay,
    double leftOffset = 0.0,
  }) {
    return AnimatedBuilder(
      animation: _buttonsController,
      builder: (context, child) {
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
                  padding: EdgeInsets.only(left: leftOffset),
                  child: EnhancedHoverButton(
                    onPressed: () async {
                      if (isLogin) {
                         CustomPopupsLoginUser.showLoginUserDialog(context);
                      } else {
                         CustomPopupsClient.showRegisterDialog(context);
                      }
                    },
                    isLogin: isLogin,
                    delay: delay,
                    height: _buttonHeight,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_boxRadius),
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
    );
  }
}