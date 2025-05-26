import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  clientId: "217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com",
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
  double get maxWidth => widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get sidePadding => widget.constraints.maxWidth > 1200 ? 64.0 : 32.0;
  double get innerPadding => isMobile ? 16.0 : 40.0;

  GoogleSignInAccount? _user;

  late AnimationController _cardsController;
  late AnimationController _numberController;
  late List<AnimationController> _hoverControllers;

  late Animation<double> _cardsStaggerAnimation;
  late List<Animation<double>> _numberAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _elevationAnimations;

  final List<StatisticData> _statistics = [
    StatisticData(
      title: 'Nasabah',
      value: 3200,
      suffix: '+',
      color: const Color(0xFF79AB43),
      delay: 0,
    ),
    StatisticData(
      title: 'Klaim Sukses Diproses',
      value: 1500,
      suffix: '+',
      color: const Color(0xFF79AB43),
      delay: 200,
    ),
    StatisticData(
      title: 'Mitra Kesehatan Aktif',
      value: 3200,
      suffix: '+',
      color: const Color(0xFF79AB43),
      delay: 400,
    ),
    StatisticData(
      title: 'Total Pertanggungan Dana',
      value: 12,
      suffix: ' Miliar+',
      prefix: 'Rp ',
      color: const Color(0xFF79AB43),
      delay: 600,
    ),
  ];

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

    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _numberController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _hoverControllers = List.generate(
      _statistics.length,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );

    _cardsStaggerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardsController,
      curve: Curves.easeOutCubic,
    ));

    _numberAnimations = _statistics.map((stat) {
      return Tween<double>(
        begin: 0.0,
        end: stat.value.toDouble(),
      ).animate(CurvedAnimation(
        parent: _numberController,
        curve: Interval(
          stat.delay / 1000,
          (stat.delay + 800) / 2000,
          curve: Curves.easeOutCubic,
        ),
      ));
    }).toList();

    _scaleAnimations = _hoverControllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.02,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    _elevationAnimations = _hoverControllers.map((controller) {
      return Tween<double>(
        begin: 8.0,
        end: 16.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonsController.forward();
    _cardsController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _numberController.forward();
  }

  @override
  void dispose() {
    _buttonsController.dispose();
    _cardsController.dispose();
    _numberController.dispose();
    for (var controller in _hoverControllers) {
      controller.dispose();
    }
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -70),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Center(
          child: Container(
            width: maxWidth,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: AnimatedBuilder(
              animation: _cardsController,
              builder: (context, child) {
                return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF8FBF5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
        padding: EdgeInsets.all(innerPadding),
        child: Row(
          children: _statistics.asMap().entries.map((entry) {
            return Expanded(
              child: _buildStatisticCard(entry.value, entry.key),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: _statistics.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildStatisticCard(entry.value, entry.key, isMobileCard: true),
        );
      }).toList(),
    );
  }

  Widget _buildStatisticCard(StatisticData stat, int index, {bool isMobileCard = false}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (stat.delay)),
      tween: Tween(begin: 0.0, end: _cardsStaggerAnimation.value),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: MouseRegion(
              onEnter: (_) => _hoverControllers[index].forward(),
              onExit: (_) => _hoverControllers[index].reverse(),
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _hoverControllers[index],
                  _numberController,
                ]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimations[index].value,
                    child: Container(
                      width: isMobileCard ? double.infinity : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20.0 : 16.0,
                        vertical: isMobile ? 20.0 : 24.0,
                      ),
                      decoration: BoxDecoration(
                        color: isMobileCard ? Colors.white : Colors.transparent,
                        borderRadius: isMobileCard ? BorderRadius.circular(16.0) : null,
                        boxShadow: isMobileCard
                            ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: _elevationAnimations[index].value,
                            offset: Offset(0, _elevationAnimations[index].value / 2),
                          ),
                          BoxShadow(
                            color: stat.color.withOpacity(0.1),
                            blurRadius: _elevationAnimations[index].value * 2,
                            offset: Offset(0, _elevationAnimations[index].value),
                          ),
                        ]
                            : null,
                      ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 1. TITLE DI ATAS
                            Text(
                              stat.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Satoshi-Regular',
                                color: Colors.grey[600],
                                fontSize: isMobile ? 13.0 : 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8.0),

                            // 2. ANGKA DI BAWAH
                            AnimatedBuilder(
                              animation: _numberAnimations[index],
                              builder: (context, child) {
                                return ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [stat.color, stat.color.withOpacity(0.8)],
                                  ).createShader(bounds),
                                  child: Text(
                                    '${stat.prefix ?? ''}${_numberAnimations[index].value.toInt()}${stat.suffix}',
                                    style: TextStyle(
                                      fontFamily: 'Satoshi-Bold',
                                      fontSize: isMobile ? 24.0 : 28.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticData {
  final String title;
  final int value;
  final String suffix;
  final String? prefix;
  final Color color;
  final int delay;

  StatisticData({
    required this.title,
    required this.value,
    required this.suffix,
    this.prefix,
    required this.color,
    required this.delay,
  });
}
