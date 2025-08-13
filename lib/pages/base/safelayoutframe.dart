import 'package:eassist_tools_app/widgets/components/top_bar/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../pages/base/base_page.dart'; // untuk PageType
import '../../widgets/components/bottom_nav/bottom_nav.dart';

class SafeLayoutFrame extends StatelessWidget {
  final Widget child;

  const SafeLayoutFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final PageType currentPage = context.watch<HomeBloc>().currentPage;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CF18), // Warna terang di atas
            Color(0xFF557D25), // Warna gelap di bawah
          ],
        ),
      ),
      child: Column(
        children: [
          TopNav(),
          Expanded(child: child),
          CustomBottomNavigationBar(currentPage: currentPage),
        ],
      ),
    );
  }
}