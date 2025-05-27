import 'package:eassist_tools_app/widgets/profile/profile_individu/profile_individu_main_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../pages/about_jps/about_main.dart';
import '../../pages/hero_user_page/hero_user_main.dart';
import '../../pages/heropage/hero_main.dart';
import '../../pages/profile/profile_main_page.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/login/Register_Client_Page.dart';
import '../login/Popup.dart';



class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class NavbarWidget extends StatefulWidget {
  final BoxConstraints constraints;
  const NavbarWidget({super.key, required this.constraints});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  bool _isMenuOpen = false;
  bool _isProfileMenuOpen = false;
  final GlobalKey _menuButtonKey = GlobalKey();
  final GlobalKey _profileButtonKey = GlobalKey();

  // Overlay entries untuk dropdown menus
  OverlayEntry? _menuOverlayEntry;
  OverlayEntry? _profileOverlayEntry;

  @override
  void dispose() {
    _removeOverlays();
    super.dispose();
  }

  void _removeOverlays() {
    _menuOverlayEntry?.remove();
    _menuOverlayEntry = null;
    _profileOverlayEntry?.remove();
    _profileOverlayEntry = null;
  }

  void _toggleHamburgerMenu() {
    if (_isMenuOpen) {
      _closeHamburgerMenu();
    } else {
      _openHamburgerMenu();
    }
  }

  void _toggleProfileMenu() {
    if (_isProfileMenuOpen) {
      _closeProfileMenu();
    } else {
      _openProfileMenu();
    }
  }

  void _openHamburgerMenu() {
    if (_isProfileMenuOpen) {
      _closeProfileMenu();
    }

    setState(() => _isMenuOpen = true);

    final RenderBox? renderBox = _menuButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _menuOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Barrier untuk menutup menu ketika tap di luar
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeHamburgerMenu,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Menu dropdown
          Positioned(
            top: offset.dy + size.height + 8,
            right: MediaQuery.of(context).size.width - offset.dx - size.width,
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.circular(12),
              shadowColor: Colors.black.withOpacity(0.2),
              child: _buildHamburgerDropdownContent(),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_menuOverlayEntry!);
  }

  void _openProfileMenu() {
    if (_isMenuOpen) {
      _closeHamburgerMenu();
    }

    setState(() => _isProfileMenuOpen = true);

    final RenderBox? renderBox = _profileButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _profileOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Barrier untuk menutup menu ketika tap di luar
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeProfileMenu,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Profile dropdown
          Positioned(
            top: offset.dy + size.height + 8,
            right: MediaQuery.of(context).size.width - offset.dx - size.width, // Adjust positioning
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.circular(12),
              shadowColor: Colors.black.withOpacity(0.2),
              child: _buildProfileDropdownContent(),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_profileOverlayEntry!);
  }

  void _closeHamburgerMenu() {
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
      _menuOverlayEntry?.remove();
      _menuOverlayEntry = null;
    }
  }

  void _closeProfileMenu() {
    if (_isProfileMenuOpen) {
      setState(() => _isProfileMenuOpen = false);
      _profileOverlayEntry?.remove();
      _profileOverlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildNavBar(widget.constraints);
  }

  Widget _buildNavBar(BoxConstraints constraints) {
    double maxWidth = constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: SizedBox(
        width: maxWidth,
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HeroMain()),
                );
              },
              child: Image.asset(
                'assets/images/jps_logo.png',
                height: 60.0,
              ),
            ),

            const Spacer(),

            // Profile Section
            _buildProfileSection(),

            const SizedBox(width: 16),

            // Hamburger Menu Icon
            Container(
              key: _menuButtonKey,
              decoration: BoxDecoration(
                color: _isMenuOpen
                    ? const Color(0xFF79AB43).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: AnimatedRotation(
                  turns: _isMenuOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isMenuOpen ? Icons.close : Icons.menu,
                    color: const Color(0xFF79AB43),
                    size: 24,
                  ),
                ),
                onPressed: _toggleHamburgerMenu,
                tooltip: _isMenuOpen ? 'Close menu' : 'Open navigation menu',
                splashRadius: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProfileSection() {
    return Container(
      key: _profileButtonKey,
      decoration: BoxDecoration(
        color: _isProfileMenuOpen
            ? const Color(0xFF79AB43).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: _toggleProfileMenu,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Picture dengan Status Indicator
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF79AB43),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/profile_placeholder.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF79AB43).withOpacity(0.2),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF79AB43),
                              size: 24,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Status Indicator Hijau
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // Nama User
              const Text(
                'Nadya Septrijayani',
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5016),
                ),
              ),

              const SizedBox(width: 8),

              // Dropdown Arrow
              AnimatedRotation(
                turns: _isProfileMenuOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF79AB43),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDropdownContent() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header dengan Profile Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF79AB43),
                  Color(0xFF8BBD54),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                // Profile Picture
                Stack(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17.5),
                        child: Image.asset(
                          'assets/images/profile_placeholder.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white.withOpacity(0.3),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Status Indicator
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nadya Septrijayani',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Satoshi-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontFamily: 'Satoshi-Regular',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: _closeProfileMenu,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Menu Items
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                _buildProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'Profil',
                  onTap: () => _handleProfileMenuTap('Profil'),
                ),
                _buildProfileMenuItem(
                  icon: Icons.lock_reset,
                  title: 'Reset Password',
                  onTap: () => _handleProfileMenuTap('Reset Password'),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE5E5E5),
                  indent: 16,
                  endIndent: 16,
                ),
                _buildProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => _handleProfileMenuTap('Logout'),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isHovered
                  ? (isDestructive
                  ? Colors.red.withOpacity(0.05)
                  : const Color(0xFF79AB43).withOpacity(0.05))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              leading: Icon(
                icon,
                color: isDestructive
                    ? (isHovered ? Colors.red : Colors.red.withOpacity(0.7))
                    : const Color(0xFF79AB43),
                size: 18.0,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: isDestructive
                      ? (isHovered ? Colors.red : Colors.red.withOpacity(0.8))
                      : Colors.black87,
                ),
              ),
              onTap: onTap,
            ),
          ),
        );
      },
    );
  }

  void _handleProfileMenuTap(String menu) async {
    final dummyUserRepository = DummyUserRepository();

    switch (menu) {
      case 'Profil':
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              width: 1300,
              child: ProfileMainPage(
                userid: 123, // ganti sesuai session
                userRepository: dummyUserRepository,
              ),
            ),
          ),
        );
        break;

      case 'Reset Password':
        // await CustomPopups.showRegisterDialog(context);
        break;

      case 'Logout':
      // Tambahkan kode logout di sini
        break;
    }

    // Tutup menu dropdown setelah aksi selesai
    _closeProfileMenu();
  }

  Widget _buildHamburgerDropdownContent() {
    return Container(
      width: 320,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF79AB43),
                  Color(0xFF8BBD54),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/jps_logo.png',
                  height: 30,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Menu JPS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Satoshi-Regular',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: _closeHamburgerMenu,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                DropdownExpandableItem(
                  icon: Icons.assignment,
                  title: 'Simulasi Polis',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.add_circle_outline,
                      title: 'Buat Polis Baru',
                      onTap: () => _handleMenuTap('Buat Polis Baru'),
                    ),
                    SubMenuItem(
                      icon: Icons.list_alt,
                      title: 'Daftar Polis Aktif',
                      onTap: () => _handleMenuTap('Daftar Polis Aktif'),
                    ),
                    SubMenuItem(
                      icon: Icons.edit,
                      title: 'Edit Polis',
                      onTap: () => _handleMenuTap('Edit Polis'),
                    ),
                    SubMenuItem(
                      icon: Icons.history,
                      title: 'Riwayat Polis',
                      onTap: () => _handleMenuTap('Riwayat Polis'),
                    ),
                  ],
                ),
                DropdownExpandableItem(
                  icon: Icons.assessment,
                  title: 'Simulasi Asset',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.home,
                      title: 'Properti',
                      onTap: () => _handleMenuTap('Properti'),
                    ),
                    SubMenuItem(
                      icon: Icons.directions_car,
                      title: 'Kendaraan',
                      onTap: () => _handleMenuTap('Kendaraan'),
                    ),
                    SubMenuItem(
                      icon: Icons.favorite,
                      title: 'Kesehatan',
                      onTap: () => _handleMenuTap('Kesehatan'),
                    ),
                    SubMenuItem(
                      icon: Icons.business,
                      title: 'Bisnis',
                      onTap: () => _handleMenuTap('Bisnis'),
                    ),
                  ],
                ),
                DropdownExpandableItem(
                  icon: Icons.attach_money,
                  title: 'Tagihan Dan Pembayaran',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.receipt_long,
                      title: 'Lihat Tagihan',
                      onTap: () => _handleMenuTap('Lihat Tagihan'),
                    ),
                    SubMenuItem(
                      icon: Icons.payment,
                      title: 'Bayar Premi',
                      onTap: () => _handleMenuTap('Bayar Premi'),
                    ),
                    SubMenuItem(
                      icon: Icons.account_balance_wallet,
                      title: 'Metode Pembayaran',
                      onTap: () => _handleMenuTap('Metode Pembayaran'),
                    ),
                    SubMenuItem(
                      icon: Icons.notifications,
                      title: 'Pengingat Tagihan',
                      onTap: () => _handleMenuTap('Pengingat Tagihan'),
                    ),
                  ],
                ),
                DropdownExpandableItem(
                  icon: Icons.check_circle,
                  title: 'Klaim',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.add_box,
                      title: 'Ajukan Klaim',
                      onTap: () => _handleMenuTap('Ajukan Klaim'),
                    ),
                    SubMenuItem(
                      icon: Icons.track_changes,
                      title: 'Status Klaim',
                      onTap: () => _handleMenuTap('Status Klaim'),
                    ),
                    SubMenuItem(
                      icon: Icons.upload_file,
                      title: 'Upload Dokumen',
                      onTap: () => _handleMenuTap('Upload Dokumen'),
                    ),
                    SubMenuItem(
                      icon: Icons.help_outline,
                      title: 'Panduan Klaim',
                      onTap: () => _handleMenuTap('Panduan Klaim'),
                    ),
                  ],
                ),
                DropdownExpandableItem(
                  icon: Icons.people,
                  title: 'Customer Services',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.chat,
                      title: 'Live Chat',
                      onTap: () => _handleMenuTap('Live Chat'),
                    ),
                    SubMenuItem(
                      icon: Icons.phone,
                      title: 'Hubungi Kami',
                      onTap: () => _handleMenuTap('Hubungi Kami'),
                    ),
                    SubMenuItem(
                      icon: Icons.email,
                      title: 'Kirim Email',
                      onTap: () => _handleMenuTap('Kirim Email'),
                    ),
                    SubMenuItem(
                      icon: Icons.location_on,
                      title: 'Lokasi Kantor',
                      onTap: () => _handleMenuTap('Lokasi Kantor'),
                    ),
                  ],
                ),
                DropdownExpandableItem(
                  icon: Icons.info,
                  title: 'Tentang JPS',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.info_outline,
                      title: 'Tentang JPS',
                      onTap: () => _handleMenuTap('Tentang JPS'),
                    ),
                    SubMenuItem(
                      icon: Icons.article_outlined,
                      title: 'Artikel Asuransi',
                      onTap: () => _handleMenuTap('Artikel Asuransi'),
                    ),
                    SubMenuItem(
                      icon: Icons.reviews,
                      title: 'Testimoni',
                      onTap: () => _handleMenuTap('Testimoni'),
                    ),
                  ],
                ),
                DropdownExpandableItem(
                  icon: Icons.layers, // ikon utama kategori
                  title: 'Semua Page yang telah dibuat',
                  subItems: [
                    SubMenuItem(
                      icon: Icons.home_outlined,
                      title: 'Home Page',
                      onTap: () => _handleMenuTap('Home Page'),
                    ),
                    SubMenuItem(
                      icon: Icons.supervised_user_circle_outlined,
                      title: 'Hero User Page',
                      onTap: () => _handleMenuTap('Hero User Page'),
                    ),
                    SubMenuItem(
                      icon: Icons.info_outline,
                      title: 'About JPS',
                      onTap: () => _handleMenuTap('About JPS'),
                    ),
                    SubMenuItem(
                      icon: Icons.login_outlined,
                      title: 'Login Gmail',
                      onTap: () => _handleMenuTap('Login Gmail'),
                    ),
                    SubMenuItem(
                      icon: Icons.person_outline,
                      title: 'Login Client',
                      onTap: () => _handleMenuTap('Login Client'),
                    ),
                    SubMenuItem(
                      icon: Icons.person_pin_circle_outlined,
                      title: 'Profile Individu',
                      onTap: () => _handleMenuTap('Profile Individu'),
                    ),
                    SubMenuItem(
                      icon: Icons.business_outlined,
                      title: 'Profile Perusahaan',
                      onTap: () => _handleMenuTap('Profile Perusahaan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleMenuTap(String title) async {
    final dummyUserRepository = DummyUserRepository();
    if (title == 'Tentang JPS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutMain()),
      );
    }else if (title == 'Tentang JPS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutMain()),
      );
    }else if (title == 'Home Page') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HeroMain()),
      );
    }else if (title == 'Hero User Page') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HeroUserMain()),
      );
    }else if (title == 'About JPS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutMain()),
      );
    }else if (title == 'Login Gmail') {
      await CustomPopupsUser.showLoginDialog(context); // misal fungsi static
    }else if (title == 'Login Client') {
      await CustomPopupsClient.showRegisterDialog(context);
    }else if (title == 'Profile Individu') {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: 1200,
            child: ProfileIndividuMainPage(
              userid: 123,
              userRepository: dummyUserRepository,
            ),
          ),
        ),
      );
    } else if (title == 'Profile Perusahaan') {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: 1200,
            child: ProfileMainPage(
              userid: 123,
              userRepository: dummyUserRepository,
            ),
          ),
        ),
      );
    }
  }
}

// Model untuk submenu items
class SubMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SubMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

// Widget untuk dropdown expandable item
class DropdownExpandableItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<SubMenuItem> subItems;

  const DropdownExpandableItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subItems,
  });

  @override
  State<DropdownExpandableItem> createState() => _DropdownExpandableItemState();
}

class _DropdownExpandableItemState extends State<DropdownExpandableItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: _isHovered
                  ? const Color(0xFF79AB43).withOpacity(0.05)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              leading: Icon(
                widget.icon,
                color: const Color(0xFF79AB43),
                size: 18.0,
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              trailing: AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value * 2 * pi,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade600,
                      size: 16,
                    ),
                  );
                },
              ),
              onTap: _toggleExpanded,
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: widget.subItems.map((subItem) {
                return DropdownSubMenuTile(subItem: subItem);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget untuk dropdown sub menu tile
class DropdownSubMenuTile extends StatefulWidget {
  final SubMenuItem subItem;

  const DropdownSubMenuTile({
    super.key,
    required this.subItem,
  });

  @override
  State<DropdownSubMenuTile> createState() => _DropdownSubMenuTileState();
}

class _DropdownSubMenuTileState extends State<DropdownSubMenuTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF8BBD54).withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          leading: Icon(
            widget.subItem.icon,
            size: 16.0,
            color: _isHovered
                ? const Color(0xFF8BBD54)
                : const Color(0xFF79AB43).withOpacity(0.7),
          ),
          title: Text(
            widget.subItem.title,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: _isHovered
                  ? const Color(0xFF2D5016)
                  : Colors.black.withOpacity(0.8),
            ),
          ),
          onTap: widget.subItem.onTap,
        ),
      ),
    );
  }
}

// Custom painter for curved border
class CircularBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapPercentage;

  CircularBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gapPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double startAngle = -0.5 * pi + (pi * gapPercentage / 2);
    final double endAngle = 2 * pi - (pi * gapPercentage / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      endAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom Widgets for Animation and Interactivity
class HoverAnimatedContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const HoverAnimatedContainer({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  State<HoverAnimatedContainer> createState() => _HoverAnimatedContainerState();
}

class _HoverAnimatedContainerState extends State<HoverAnimatedContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFEEF7DD) : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.child,
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final bool isRounded;

  const HoverButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = Colors.transparent,
    this.textColor = const Color(0xFF79AB43),
    this.isRounded = false,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.isRounded ? 30.0 : 4.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.95)
                : widget.color,
            borderRadius: radius,
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: radius,
            child: DefaultTextStyle(
              style: TextStyle(
                color: widget.textColor,
                fontFamily: 'Satoshi-Regular',
                fontWeight: FontWeight.w500,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class HoverActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isOutlined;
  final bool isRounded;
  final TextStyle? textStyle;

  const HoverActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.textStyle,
    this.isOutlined = false,
    this.isRounded = false,
  });

  @override
  State<HoverActionButton> createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: widget.isOutlined
              ? Colors.transparent
              : _isHovered
              ? const Color(0xFF8BBD54)
              : const Color(0xFF79AB43),
          border: widget.isOutlined
              ? Border.all(
            color: _isHovered
                ? const Color(0xFF8BBD54)
                : const Color(0xFF79AB43),
            width: 2.0,
          )
              : null,
          borderRadius: BorderRadius.circular(widget.isRounded ? 16.56 : 4.0),
          boxShadow: widget.isOutlined ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(widget.isRounded ? 16.56 : 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.isOutlined
                    ? const Color(0xFF79AB43)
                    : Colors.white,
                size: 27.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Satoshi-Regular',
                  color: widget.isOutlined
                      ? const Color(0xFF79AB43)
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 27.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
