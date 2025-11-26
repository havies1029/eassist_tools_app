import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  hostedDomain: "",
  serverClientId: "217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com",
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
  double get innerPadding => isMobile ? 14.0 : 32.0;

  GoogleSignInAccount? _user;

  int _polisAktif = 2;
  double _totalPremi = 1350000;

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
    _loadDataFromAPI();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonsController.forward();
  }

  Future<void> _loadDataFromAPI() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _polisAktif = 5;
      _totalPremi = 2750000;
    });
  }

  String _formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    )}';
  }

  @override
  void dispose() {
    _buttonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -80),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Center(
          child: Container(
            width: maxWidth,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
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
                  return Wrap(
                    spacing: isMobile ? 10 : 32,
                    runSpacing: isMobile ? 12 : 20,
                    alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildAnimatedBadge(
                        icon: Icons.policy,
                        text: '$_polisAktif Polis Aktif',
                        backgroundColor: const Color(0xFF79AB43).withOpacity(0.25),
                        textColor: const Color(0xFF79AB43),
                        delay: const Duration(milliseconds: 0),
                        isMobile: isMobile,
                      ),
                      _buildAnimatedBadge(
                        icon: Icons.attach_money,
                        text: _formatCurrency(_totalPremi),
                        backgroundColor: const Color(0xFF79AB43).withOpacity(0.25),
                        textColor: const Color(0xFF79AB43),
                        delay: const Duration(milliseconds: 200),
                        isMobile: isMobile,
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

  Widget _buildAnimatedBadge({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required Duration delay,
    required bool isMobile,
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
                child: InfoBadge(
                  icon: icon,
                  text: text,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  isMobile: isMobile,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleSignIn() async {
    try {
      final user = await _googleSignIn.signIn();
      setState(() => _user = user);
      if (user != null) {
        final auth = await user.authentication;
        final idToken = auth.idToken;
        print("ID Token: $idToken");
      }
    } catch (error) {
      print('Login gagal: $error');
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      setState(() => _user = null);
    } catch (error) {
      print('Logout gagal: $error');
    }
  }
}

class InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isMobile;

  const InfoBadge({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10.0 : 16.0,
        vertical: isMobile ? 7.0 : 10.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(isMobile ? 12.0 : 16.0),
        border: Border.all(
          color: backgroundColor.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 4.0 : 6.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: textColor,
              size: isMobile ? 14.0 : 16.0,
            ),
          ),
          SizedBox(width: isMobile ? 6.0 : 8.0),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: isMobile ? 16.0 : 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
