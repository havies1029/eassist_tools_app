import 'package:flutter/material.dart';
import '../dropdown_menu/dropdown_expandable_item.dart';
import '../dropdown_menu/sub_menu_item.dart';

class HamburgerDropdownContent extends StatefulWidget {
  final VoidCallback onClose;
  final void Function(String title) onMenuTap;

  const HamburgerDropdownContent({
    Key? key,
    required this.onClose,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  _HamburgerDropdownContentState createState() =>
      _HamburgerDropdownContentState();
}

class _HamburgerDropdownContentState
    extends State<HamburgerDropdownContent> {
  int _expandedIndex = -1;

  final List<Map<String, dynamic>> _menus = [
    {
      'icon': Icons.assignment,
      'title': 'Simulasi Polis',
      'subs': [
        SubMenuItem(icon: Icons.add_circle_outline, title: 'Buat Polis Baru', onTap: () {}),
        SubMenuItem(icon: Icons.list_alt, title: 'Daftar Polis Aktif', onTap: () {}),
        SubMenuItem(icon: Icons.edit, title: 'Edit Polis', onTap: () {}),
        SubMenuItem(icon: Icons.history, title: 'Riwayat Polis', onTap: () {}),
      ],
    },
    {
      'icon': Icons.assessment,
      'title': 'Simulasi Asset',
      'subs': [
        SubMenuItem(icon: Icons.home, title: 'Properti', onTap: () {}),
        SubMenuItem(icon: Icons.directions_car, title: 'Kendaraan', onTap: () {}),
        SubMenuItem(icon: Icons.favorite, title: 'Kesehatan', onTap: () {}),
        SubMenuItem(icon: Icons.business, title: 'Bisnis', onTap: () {}),
      ],
    },
    {
      'icon': Icons.attach_money,
      'title': 'Tagihan Dan Pembayaran',
      'subs': [
        SubMenuItem(icon: Icons.receipt_long, title: 'Lihat Tagihan', onTap: () {}),
        SubMenuItem(icon: Icons.payment, title: 'Bayar Premi', onTap: () {}),
        SubMenuItem(icon: Icons.account_balance_wallet, title: 'Metode Pembayaran', onTap: () {}),
        SubMenuItem(icon: Icons.notifications, title: 'Pengingat Tagihan', onTap: () {}),
      ],
    },
    {
      'icon': Icons.check_circle,
      'title': 'Klaim',
      'subs': [
        SubMenuItem(icon: Icons.add_box, title: 'Ajukan Klaim', onTap: () {}),
        SubMenuItem(icon: Icons.track_changes, title: 'Status Klaim', onTap: () {}),
        SubMenuItem(icon: Icons.upload_file, title: 'Upload Dokumen', onTap: () {}),
        SubMenuItem(icon: Icons.help_outline, title: 'Panduan Klaim', onTap: () {}),
      ],
    },
    {
      'icon': Icons.people,
      'title': 'Customer Services',
      'subs': [
        SubMenuItem(icon: Icons.chat, title: 'Live Chat', onTap: () {}),
        SubMenuItem(icon: Icons.phone, title: 'Hubungi Kami', onTap: () {}),
        SubMenuItem(icon: Icons.email, title: 'Kirim Email', onTap: () {}),
        SubMenuItem(icon: Icons.location_on, title: 'Lokasi Kantor', onTap: () {}),
      ],
    },
    {
      'icon': Icons.info,
      'title': 'Tentang JPS',
      'subs': [
        SubMenuItem(icon: Icons.info_outline, title: 'Tentang JPS', onTap: () {}),
        SubMenuItem(icon: Icons.article_outlined, title: 'Artikel Asuransi', onTap: () {}),
        SubMenuItem(icon: Icons.reviews, title: 'Testimoni', onTap: () {}),
      ],
    },
    {
      'icon': Icons.layers,
      'title': 'Semua Page yang telah dibuat',
      'subs': [
        SubMenuItem(icon: Icons.business_outlined, title: 'Splash Screen', onTap: () {}),
        SubMenuItem(icon: Icons.home_outlined, title: 'Home Page', onTap: () {}),
        SubMenuItem(icon: Icons.supervised_user_circle_outlined, title: 'Hero User Page', onTap: () {}),
        SubMenuItem(icon: Icons.info_outline, title: 'About JPS', onTap: () {}),
        SubMenuItem(icon: Icons.article, title: 'Article Page', onTap: () {}),
        SubMenuItem(icon: Icons.record_voice_over, title: 'Testimoni', onTap: () {}),
        SubMenuItem(icon: Icons.login_outlined, title: 'Login Gmail', onTap: () {}),
        SubMenuItem(icon: Icons.person_outline, title: 'Login Client', onTap: () {}),
        SubMenuItem(icon: Icons.person_outline, title: 'Register Gmail', onTap: () {}),
        SubMenuItem(icon: Icons.person_pin_circle_outlined, title: 'Profile Individu', onTap: () {}),
        SubMenuItem(icon: Icons.business_outlined, title: 'Profile Perusahaan', onTap: () {}),
        SubMenuItem(icon: Icons.business_outlined, title: 'Rekan Contact', onTap: () {}),
        SubMenuItem(icon: Icons.business_outlined, title: 'Rekan General', onTap: () {}),
        SubMenuItem(icon: Icons.business_outlined, title: 'Rekan Pajak', onTap: () {}),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0,4))],
      ),
      child: Column(
        children: [
          // header…
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF79AB43), Color(0xFF8BBD54)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/jps_logo.png', height: 30),
                const SizedBox(width: 10),
                const Text('Menu JPS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Satoshi-Regular')),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: widget.onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // daftar menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _menus.length,
              itemBuilder: (ctx, i) {
                final m = _menus[i];
                return DropdownExpandableItem(
                  key: ValueKey(m['title']),
                  icon: m['icon'] as IconData,
                  title: m['title'] as String,
                  subItems: (m['subs'] as List<SubMenuItem>).map((sub) {
                    return SubMenuItem(icon: sub.icon, title: sub.title, onTap: () => widget.onMenuTap(sub.title));
                  }).toList(),
                  isExpanded: _expandedIndex == i,
                  onHeaderTap: () {
                    setState(() {
                      _expandedIndex = (_expandedIndex == i) ? -1 : i;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}