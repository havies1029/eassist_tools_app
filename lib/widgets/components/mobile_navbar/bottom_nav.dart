import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../pages/base/base_page.dart';
import '../../account/profile/profile_main_page.dart';

class NavBarIconWithCellBorder extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const NavBarIconWithCellBorder({
    super.key,
    required this.iconPath,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      color: isActive ? activeColor : inactiveColor,
    );
  }
}

class MobileBottomNavigationBar extends StatelessWidget {
  final PageType currentPage;
  static const bgColor = Color(0xFF121212);
  static const activeColor = Color(0xFFF2931B);
  static const inactiveColor = Color(0xFF848484);

  const MobileBottomNavigationBar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Per item dibungkus Expanded agar rata
          _buildTabItem(
            context: context,
            pageType: PageType.home,
            iconPath: 'assets/icons/beranda.svg',
            label: 'Beranda',
            isActive: currentPage == PageType.home,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            isLeft: true,   // Tab paling kiri
            isRight: false,
          ),
          _buildTabItem(
            context: context,
            pageType: PageType.about,
            iconPath: 'assets/icons/literasi.svg',
            label: 'Literasi',
            isActive: currentPage == PageType.about,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            isLeft: false,
            isRight: false,
          ),
          _buildTabItem(
            context: context,
            pageType: PageType.cs,
            iconPath: 'assets/icons/bantuan.svg',
            label: 'Bantuan',
            isActive: currentPage == PageType.cs,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            isLeft: false,
            isRight: false,
          ),
          _buildTabItem(
            context: context,
            pageType: PageType.profile,
            iconPath: 'assets/icons/profil_anda.svg',
            label: 'Profil Anda',
            isActive: currentPage == PageType.profile,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            isLeft: false,
            isRight: true, // Tab paling kanan
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required BuildContext context,
    required PageType pageType,
    required String iconPath,
    required String label,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
    bool isLeft = false,
    bool isRight = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          if (pageType == PageType.profile) {
            final blocState = context.read<MRekan1CrudBloc>().state;
            final mjnsclientId = blocState.record?.mjnsclientId.toString();
            if (mjnsclientId == "10" || mjnsclientId == "20") {
              await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  final isMobile = MediaQuery.of(context).size.width < 600;
                  final screenSize = MediaQuery.of(context).size;
                  return Dialog(
                    insetPadding: isMobile
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isMobile ? 0 : 16.13),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isMobile ? 0 : 16.13),
                      child: SizedBox(
                        width: isMobile ? screenSize.width : 1300,
                        height: isMobile ? screenSize.height : null,
                        child: ProfileMainPage(
                          userid: 123,
                          selectedChoice: mjnsclientId == "10" ? 'Individual' : 'Perusahaan',
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Data profil tidak tersedia.")),
              );
            }
          } else {
            if (!isActive) {
              context.read<HomeBloc>().add(PushPageEvent(pageType));
            }
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isActive
                    ? activeColor : inactiveColor,
                width: 3,
              ),
            ),
            // Ini yang baru, kasih border radius di ujung kiri/kanan tab
            borderRadius: isLeft
                ? const BorderRadius.only(topLeft: Radius.circular(16))
                : isRight
                ? const BorderRadius.only(topRight: Radius.circular(16))
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavBarIconWithCellBorder(
                iconPath: iconPath,
                isActive: isActive,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem {
  final PageType pageType;
  final String iconPath;
  final String label;

  const _NavBarItem({
    required this.pageType,
    required this.iconPath,
    required this.label,
  });
}
