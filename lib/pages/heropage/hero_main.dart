import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:shared_preferences/shared_preferences.dart';    // ← import SharedPreferences
import '../../repositories/user/user_repository.dart';
import '../../widgets/section/action_section.dart';
import '../../widgets/section/carousel_section.dart';
import '../../widgets/section/client_section.dart';
import '../../widgets/section/feature_section.dart';
import '../../widgets/section/floating_buttons.dart';
import '../../widgets/section/footer_section.dart';
import '../../widgets/section/navbar/navbar_widget.dart';
import 'hero_section_heropage.dart';
import '../../widgets/section/testimonial_section.dart';

// **Pastikan method showLoginDialog mengembalikan Future<void>**
//    (di CustomPopupsLoginUser)
import 'package:eassist_tools_app/widgets/login/login_gmail/Popup.dart';

class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class HeroMain extends StatelessWidget {
  const HeroMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF79AB43),
        scaffoldBackgroundColor: const Color(0xFFD5F4B4),
        fontFamily: 'Satoshi-Regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 16.0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const HeroPage(),
    );
  }
}

// Ubah HeroPage jadi StatefulWidget
class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  static const String _kShownLoginDialogKey = 'hasShownLoginDialog';

  @override
  void initState() {
    super.initState();
    _checkAndShowLoginDialog();
  }

  /// Cek SharedPreferences; jika belum pernah tampil, maka tampilkan dialog
  Future<void> _checkAndShowLoginDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool(_kShownLoginDialogKey) ?? false;

    if (!hasShown) {
      // Tampilkan dialog setelah frame pertama dirender,
      // lalu simpan flag hanya setelah dialog ditutup oleh user.
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await CustomPopupsLoginUser.showLoginDialog(context);
        // Baru setelah user menutup popup, set supaya tidak muncul lagi
        await prefs.setBool(_kShownLoginDialogKey, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 768;
          return Stack(
            children: [
              // Layer 1: Background (Image untuk non-mobile, hijau untuk mobile)
              Positioned.fill(
                child: isMobile
                    ? Container(
                  color: const Color(0xFF79AB43),
                )
                    : Image.asset(
                  'assets/images/bg-home.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 3),
                  cacheWidth: 1440,
                  cacheHeight: 800,
                ),
              ),

              // Layer 2: Konten scrollable
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88), // ruang untuk navbar
                  child: Column(
                    children: [
                      HeroSection(constraints: constraints),
                      FloatingButtons(constraints: constraints),
                      ActionSection(constraints: constraints),
                      CarouselSection(constraints: constraints),
                      FeatureSection(constraints: constraints),
                      TestimonialSection(constraints: constraints),
                      ClientSection(constraints: constraints),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Navbar overlay di atas semua
              const _FixedNavbarOverlay(),
            ],
          );
        },
      ),
    );
  }
}

class _FixedNavbarOverlay extends StatelessWidget {
  const _FixedNavbarOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none, // agar pop-up bisa muncul di luar batas
        children: [
          Material(
            color: Colors.transparent,
            elevation: 20,
            child: NavbarWidget(
              hideProfile: true,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
