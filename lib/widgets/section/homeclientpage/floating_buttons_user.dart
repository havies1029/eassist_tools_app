import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//====================[ GLOBAL STYLE CONSTANTS ]=====================//
const _primaryColor = Color(0xFF79AB43);
const _white = Colors.white;
const _shadowColor = Colors.black;
const _fontFamily = 'Satoshi-Regular';

TextStyle badgeTextStyle(bool isMobile, Color textColor) => TextStyle(
  fontFamily: _fontFamily,
  color: textColor,
  fontWeight: FontWeight.w500,
  fontSize: isMobile ? 16.0 : 24.0,
);

//====================[ GOOGLE SIGN IN CONFIG ]=====================//
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  hostedDomain: "",
  serverClientId: "217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com",
);

//====================[ MAIN WIDGET CLASS ]=====================//
class FloatingButtons extends StatefulWidget {
  final BoxConstraints constraints;
  const FloatingButtons({super.key, required this.constraints});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> with TickerProviderStateMixin {
  late AnimationController _buttonsController;
  late Animation<double> _buttonsStaggerAnimation;

  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxWidth => widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get sidePadding => isMobile ? 5 : (widget.constraints.maxWidth > 1200 ? 64.0 : 32.0);
  double get innerPadding => isMobile ? 10.0 : 40.0;

  GoogleSignInAccount? _user;

  //====================[ HARDCODED API DATA ]=====================//
  int _polisAktif = 2; // TODO: Ganti dengan data dari API
  double _totalPremi = 1350000; // TODO: Ganti dengan data dari API

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
    _loadDataFromAPI();
  }

  @override
  void dispose() {
    _buttonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isExact1900x1200 = screenSize.width >= 1500.0;
    final translateOffset = isMobile ? const Offset(0, 0) : const Offset(0, -80);

    return Transform.translate(
      offset: translateOffset,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: _buildResponsiveBadgeWrap(isExact1900x1200),
      ),
    );
  }

  Widget _buildResponsiveBadgeWrap(bool isExact1900x1200) {
    return Align(
      alignment: isMobile ? Alignment.centerLeft : Alignment.center,
      child: Container(
        width: isMobile ? null : double.infinity,
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: isMobile ? const EdgeInsets.symmetric(horizontal: 25, vertical: 20.0) : const EdgeInsets.symmetric(vertical: 20.0),
        decoration: _boxDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: innerPadding,
            vertical: isMobile ? 10.0 : 20.0,
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: isMobile ? 10 : (isExact1900x1200 ? -10 : 16),
            runSpacing: isMobile ? 10 : 0,
            children: [
              _buildAnimatedBadge(Icons.policy, '$_polisAktif Polis Aktif', isMobile, const Duration(milliseconds: 0)),
              _buildAnimatedBadge(Icons.attach_money, _formatCurrency(_totalPremi), isMobile, const Duration(milliseconds: 200)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBadge(IconData icon, String text, bool isMobile, Duration delay) {
    final screenSize = MediaQuery.of(context).size;
    final isExact1900x1200 = screenSize.width >= 1500.0;

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
              padding: EdgeInsets.only(left: isExact1900x1200 ? 30.0 : 0.0),
              child: InfoBadge(
                icon: icon,
                text: text,
                backgroundColor: _primaryColor.withOpacity(0.25),
                textColor: _primaryColor,
                isMobile: isMobile,
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: _white,
      borderRadius: BorderRadius.circular(16.13),
      boxShadow: [
        BoxShadow(
          color: _shadowColor.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: _primaryColor.withOpacity(0.1),
          blurRadius: 40,
          offset: const Offset(0, 16),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  //====================[ API / AUTH METHODS ]=====================//

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonsController.forward();
  }

  Future<void> _loadDataFromAPI() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi fetch
    setState(() {
      _polisAktif = 5;
      _totalPremi = 2750000;
    });
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

//====================[ REUSABLE BADGE ]=====================//
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
        vertical: isMobile ? 0.0 : 10.0,
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
              color: _white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: textColor, size: isMobile ? 14.0 : 16.0),
          ),
          SizedBox(width: isMobile ? 6.0 : 8.0),
          Text(text, style: badgeTextStyle(isMobile, textColor)),
        ],
      ),
    );
  }
}