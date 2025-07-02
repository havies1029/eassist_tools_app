import 'package:eassist_tools_app/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/google_signin_button_stub.dart'
if (dart.library.js_interop) 'package:eassist_tools_app/widgets/google_signin_button_web.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
import '../../account/login/login_gmail/popup_dialog_login.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'decorations/EnhancedHoverButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  double get sidePadding => isMobile ? 0.0 : (widget.constraints.maxWidth > 1200 ? 0.0 : 30.0);
  double get innerPadding => isMobile ? 10.0 : 40.0;
  double get _buttonHeight => isMobile ? 30.0 : 50.0;
  double get _boxRadius => 16.13;

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
    final double width = widget.constraints.maxWidth;
    final double computedMaxWidth = width > 1200 ? 1200 : width * 0.95;
    final double horizontalPadding = width > 1200
        ? 95
        : width > 992
        ? 64
        : width > 768
        ? 48
        : 24;
    final double bottomMargin = 30;

    return Transform.translate(
      offset: isMobile ? Offset.zero : const Offset(0, -80),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Align(
          alignment: isMobile ? Alignment.centerLeft : Alignment.center,
          child: Container(
            width: isMobile ? null : computedMaxWidth,
            constraints: BoxConstraints(maxWidth: computedMaxWidth),
            margin: isMobile
                ? const EdgeInsets.fromLTRB(6, 2, 12, 10)
                : EdgeInsets.only(bottom: bottomMargin),
            decoration: BoxDecoration(
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
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8.0 : innerPadding,
                vertical: isMobile ? 6.0 : 20.0,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobileLocal = constraints.maxWidth < 768;
                  return Wrap(
                    spacing: isMobileLocal ? 8 : 16,
                    runSpacing: isMobileLocal ? 8 : 0,
                    alignment: WrapAlignment.start,
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
    double leftOffset = 0.0,
  }) {
    return AnimatedBuilder(
      animation: _buttonsController,
      builder: (context, child) {
        final Size screenSize = MediaQuery.of(context).size;
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
                      final state = context.read<AuthenticationBloc>().state;
                      if (state is AuthenticationAuthenticated &&
                          state.user.custType == "C") {
                        await CustomPopupsLoginUser.showLoginUserDialog(context);
                      } else {
                        if (isLogin) {
                          await CustomPopupsLoginUser.showLoginUserDialog(context);
                        } else {
                          await CustomPopupsLoginUser.showRegisterClientDialog(context);
                        }
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
}