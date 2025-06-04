import 'package:flutter/material.dart';
import '../login/login_gmail/Popup.dart';
import '../register/register_client/popup_client.dart';

import 'floating_button/EnhancedHoverButton.dart';

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
                        await CustomPopupsLoginUser.showLoginDialog(context);
                      } else {
                        await CustomPopupsClient.showRegisterDialog(context);
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

}
