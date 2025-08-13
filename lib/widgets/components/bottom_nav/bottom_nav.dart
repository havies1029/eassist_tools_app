import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../pages/base/base_page.dart'; // Untuk PageType enum

class CustomBottomNavigationBar extends StatelessWidget {
  final PageType currentPage;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Colors.white;
    const inactiveColor = Colors.white70;
    const bgColor = Color(0xFF91DA2D); // Hijau solid seperti gambar

    return Container(
      height: 64,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem(
            context: context,
            pageType: PageType.home,
            icon: Icons.home,
            label: 'Beranda',
            isActive: currentPage == PageType.home,
          ),
          _buildTabItem(
            context: context,
            pageType: PageType.aset,
            icon: Icons.account_balance_wallet_outlined,
            label: 'Asetku',
            isActive: currentPage == PageType.aset,
          ),
          _buildTabItem(
            context: context,
            pageType: PageType.cs,
            icon: Icons.headset_mic_outlined,
            label: 'Bantuan',
            isActive: currentPage == PageType.cs,
          ),
          _buildTabItem(
            context: context,
            pageType: PageType.profile,
            icon: Icons.person_outline,
            label: 'Profil Anda',
            isActive: currentPage == PageType.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required BuildContext context,
    required PageType pageType,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          context.read<HomeBloc>().add(PushPageEvent(pageType));
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 80,
        height: 64,
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
            top: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}